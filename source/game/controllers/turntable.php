<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Turntable
 *
 * @author  Xy Ji
 */
class Turntable extends Front_Controller
{
    public $checkLogin = false;
    public $type = 1;

    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
    	$data = array(
            'title' => '转盘',
            'isLogin' => $this->uid ? 1 : 0,
        );

        $this->load->view('turntable', $data);
    }

    public function lottery()
    {
        $this->load->driver('cache', array('adapter' => 'file'));

        $config = $this->getConfig();

        if (empty($this->uid)) {
            $this->guestLottery($config);
        }
        $this->load->model('game_log_model');

        $this->cacheid = 'turntable' . $this->uid;

        $isRandom = 1;
        $prize = false;
        $prizeArr = array(1,2,3,4,5,6,7,8);

        $today = strtotime(date('Ymd'));
        $userData = $this->cache->get($this->cacheid);
        if (empty($userData) || $userData['today'] != $today) {
            $userData = $this->userData($today, $config, $prizeArr);
        }
        if (empty($userData)) {
            $this->response('server error!', 500);
        }

        $userData['total']++;
        // 每百次中二等奖 , 每千次中一等奖
        if ($userData['total'] != 0) {
            foreach ($prizeArr as $key) {
                if (!empty($config['range'][$key])) {
                    $range = $config['range'][$key];
                    $lastIndex = 'lastIndex' . $key;
                    if (($userData['total'] % $range == 0) &&
                        ($userData[$lastIndex] <= ($userData['total'] - $range))) {
                        $prize = $key;
                        $isRandom = 0;
                        break;
                    }
                }
            }
        }

        if ($prize === false) {
            $rand = mt_rand(1, 1000);
            $probArr = $config['prob'];
            $luckRange = 0;
            foreach ($probArr as $key => $value) {
                $value = intval($value * 10);
                if ($value == 0) {
                    continue;
                }
                if (!empty($config['max'][$key]) && $userData['todayPrizeCount'][$key] >= $config['max'][$key]) {
                    $luckRange += $value;
                } else {
                    if (($rand > $luckRange) && ($rand <= $luckRange + $value)) {
                        $prize = $key;
                        break;
                    }
                    $luckRange += $value;
                }
            }
        }
        $prize = $prize ?: 0;

        if ($userData['todayNum'] >= $config['free_num']) {
            //TODO 消耗积分
            $consumePoints = $config['consume_points'];
        } else {
            $consumePoints = 0;
        }

        // log
        $this->game_log_model->insert(array(
            'uid' => $this->uid,
            'type' => $this->type,
            'prize' => $prize,
            'consume_points' => $consumePoints,
            'create_time' => time(),
            'is_random' => $isRandom,
        ));

        // cache
        $userData['todayNum']++;
        $points = -$consumePoints;
        if ($prize > 0) {
            $userData['todayPrizeCount'][$prize]++;
        }

        foreach ($prizeArr as $key) {
            if (!empty($config['range'][$key]) && $prize == $key) {
                $lastIndex = 'lastIndex' . $key;
                $userData[$lastIndex] = $userData['total'];
                if (is_numeric($config['awards'][$key])) {
                    $points = $config['awards'][$key];
                }
                break;
            }
        }

        $this->cache->save($this->cacheid, $userData);
        // 计算积分 remote $points TODO

        $angle = 0;
        foreach (array(1,2,0,3,4,0,5,6,0,7,8,0) as $value) {
            if ($prize == $value) {
                $angle += mt_rand(1, $config['angle'][$value] - 1);
                break;
            } else {
                $angle += $config['angle'][$value];
            }
        }

        // 0：谢谢参与
    	$this->response(array(
    		'prize' => $prize,
            'angle' => $angle,
            'limit' => $config['free_num'],
		));
    }

    private function guestLottery($config)
    {
        $prize = false;
        $rand = mt_rand(1, 1000);
        $probArr = $config['prob'];
        $luckRange = 0;
        foreach ($probArr as $key => $value) {
            $value = $value * 10;
            if ($rand > $luckRange && $rand <= $luckRange + $value) {
                $prize = $key;
                break;
            }
            $luckRange += $value;
        }
        $prize = $prize ?: 0;

        $angle = 0;
        for ($i = 0; $i < $prize; $i++) {
            $angle += $config['angle'][$i];
        }
        $angle += mt_rand(1, $config['angle'][$i] - 1);
        // 0：谢谢参与 1：一等奖，2：二等奖，3：鼓励奖
        $this->response(array(
            'prize' => $prize,
            'angle' => $angle,
            'limit' => $config['free_num'],
        ));
    }

    private function getConfig()
    {
        $config = $this->cache->get('turntable_config');
        if (empty($config)) {
            $this->load->model('turntable_model');
            $config = $this->turntable_model->get_one(array());
            foreach (array('range', 'awards', 'prob', 'max', 'angle') as $value) {
                $config[$value] = json_decode($config[$value], true);
            }
            $this->cache->save('turntable_config', $config);
        }
        return $config;
    }

    private function userData($today, $config, $prizeArr)
    {
        $userData = array();
        $userData['today'] = $today;
        $userData['todayNum'] = $this->game_log_model->get_count(array(
            'uid' => $this->uid,
            'type' => $this->type,
            'create_time >=' => $today,
        ));
        $userData['total'] = $this->game_log_model->get_count(array(
            'uid' => $this->uid,
            'type' => $this->type
        ));

        $todayPrizeCount = $this->game_log_model->prize_count(array(
            'uid' => $this->uid,
            'type' => $this->type,
            'prize >' => 0,
            'create_time >=' => $today,
        ), 'prize');
        if (!empty($todayPrizeCount)) {
            foreach ($todayPrizeCount as $key => $value) {
                $tmpPrize = $value['prize'];
                $userData['todayPrizeCount'][$tmpPrize] = $value['cnt'];
            }
        }

        foreach ($prizeArr as $key) {
            if (!empty($config['range'][$key])) {
                $lastIndex = 'lastIndex' . $key;
                $lastPrize = $this->game_log_model->get_list(array(
                    'uid' => $this->uid,
                    'type' => $this->type,
                    'prize' => $key,
                ), 1, 0, 'id');
                if (!empty($lastPrize)) {
                    $userData[$lastIndex] = $this->game_log_model->get_count(array(
                        'uid' => $this->uid,
                        'type' => $this->type,
                        'id <=' => $lastPrize[0]['id'],
                    ));
                } else {
                    $userData[$lastIndex] = 0;
                }
            }

            if (!isset($userData['todayPrizeCount'][$key])) {
                $userData['todayPrizeCount'][$key] = 0;
            }
        }

        return $userData;
    }
}
