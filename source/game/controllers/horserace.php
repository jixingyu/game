<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Horserace
 *
 * @author  Xy Ji
 */
class Horserace extends Front_Controller
{
    public $type = 1;
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
    	$data = array('title' => '赛马');

        $this->load->view('horserace', $data);
    }

    public function start()
    {
        $this->load->driver('cache', array('adapter' => 'file'));

        $config = $this->getConfig();

        $this->load->model('game_log_model');

        $this->cacheid = 'horserace' . $this->uid;

        $isRandom = 1;
        $prize = false;
        $prizeArr = array(1,2,3);

        $userData = $this->cache->get($this->cacheid);
        if (empty($userData)) {
            $userData = $this->userData($config, $prizeArr);
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
                        break;
                    }
                }
            }
        }
        if ($prize === false) {
            foreach ($prizeArr as $key) {
                if (!empty($config['max'][$key])) {
                    $max = $config['max'][$key];
                    if ($userData['todayPrizeCount'][$key] >= $max) {
                        $prize = 0;
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
            'type' => 1,
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

    private function getConfig()
    {
        $config = $this->cache->get('horserace_config');
        if (empty($config)) {
            $this->load->model('horserace_model');
            $config = $this->horserace_model->get_one(array());
            foreach (array('multiple', 'exclude_prob') as $value) {
                $config[$value] = json_decode($config[$value], true);
            }
            $this->cache->save('horserace_config', $config);
        }
        return $config;
    }

    private function userData($config, $prizeArr)
    {
        $userData = array();
        $userData['total'] = $this->game_log_model->get_count(array(
            'uid' => $this->uid,
            'type' => $this->type
        ));
        $lastLose = $this->game_log_model->get_one(array(
            'uid' => $this->uid,
            'type' => $this->type,
            'prize =' => 0,
        ), 1, 0, 'create_time');
        if (!empty($lastLose)) {
        	$lastLoseIndex = $this->game_log_model->get_count(array(
	            'uid' => $this->uid,
	            'type' => $this->type,
	            'id <=' => $lastLose[0]['id'],
	        ));
        } else {
        	$lastLoseIndex = 0;
        }

        if ($userData['total'] == $lastLoseIndex) {
	        $lastWin = $this->game_log_model->get_one(array(
	            'uid' => $this->uid,
	            'type' => $this->type,
	            'prize >' => 0,
	        ), 1, 0, 'create_time');
	        if (!empty($lastWin)) {
	        	$lastWinIndex = $this->game_log_model->get_count(array(
		            'uid' => $this->uid,
		            'type' => $this->type,
		            'id <=' => $lastWin[0]['id'],
		        ));
	        } else {
	        	$lastWinIndex = 0;
	        }
	        $userData['continuousWinNum']  = 0;
	        $userData['continuousLoseNum'] = $userData['total'] - $lastWinIndex;
        } else {
	        $userData['continuousWinNum']  = $userData['total'] - $lastLoseIndex;
	        $userData['continuousLoseNum'] = 0;
        }



        return $userData;
    }
}
