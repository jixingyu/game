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

    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $config = $this->getConfig();
    	$data = array(
            'bgcolor' => '3C9600',
            'title' => '转盘',
            'image' => $config['image'],
            'isLogin' => empty($this->user) ? 0 : 1,
            'consumePoints' => $config['consume_points'],
            'freeNum' => $config['free_num'],
            'desc' => str_replace("\r", '###', str_replace("\n", '###', str_replace(array("\r\n",'"'), array('###','\"'), $config['description']))),
        );
        if (!empty($this->user)) {
            $this->load->model('turntable_play_model');
            $playData = $this->turntable_play_model->get_one(array(
                'uid' => $this->user['uid'],
            ));
            if (!empty($playData)) {
                if ($playData['update_time'] < strtotime(date('Ymd'))) {
                    $data['todayNum'] = 0;
                } else {
                    $data['todayNum'] = $playData['today_num'];
                }
            } else {
                $data['todayNum'] = 0;
            }
        } else {
            $data['todayNum'] = 0;
        }

        $this->view('turntable', $data);
    }

    public function lottery()
    {
        $config = $this->getConfig();

        if (empty($this->user)) {
            $this->guestLottery($config);
        }
        $this->load->model(array('turntable_log_model', 'turntable_play_model'));

        $isRandom = 1;
        $award = '';
        $prize = false;
        $prizeArr = array(1,2,3,4,5,6,7,8);

        $today = strtotime(date('Ymd'));

        $playData = $this->turntable_play_model->get_one(array(
            'uid' => $this->user['uid'],
        ));
        if (empty($playData)) {
            $playData = array(
                'range'     => array(),
                'prize_num' => array(),
                'today_num' => 0,
            );
            $first = true;
            foreach ($prizeArr as $key) {
                $playData['range'][$key] = 1;
                $playData['prize_num'][$key] = 0;
            }
        } else {
            if ($playData['update_time'] < $today) {
                $playData['prize_num'] = array();
                $playData['today_num'] = 0;
                foreach ($prizeArr as $key) {
                    $playData['prize_num'][$key] = 0;
                    $playData['range'][$key] = 1;
                }
            } else {
                $playData['range'] = json_decode($playData['range'], true);
                $playData['prize_num'] = json_decode($playData['prize_num'], true);
                foreach ($prizeArr as $key) {
                    $playData['range'][$key] = $playData['range'][$key] + 1;
                }
            }
            $first = false;
        }

        $playData['today_num']++;
        if ($playData['today_num'] >= $config['free_num']) {
            //TODO 消耗积分
            $points = -$config['consume_points'];
        } else {
            $points = 0;
        }

        // 每百次中二等奖 , 每千次中一等奖
        if (!$first) {
            foreach ($prizeArr as $key) {
                if (!empty($config['range'][$key])) {
                    if ($playData['prize_num'][$key] < $config['max'][$key] && ($playData['range'][$key] % $config['range'][$key]) == 0) {
                        $prize = $key;
                        $playData['range'][$key] = 0;
                        $playData['prize_num'][$key]++;
                        $isRandom = 0;
                        if (is_numeric($config['awards'][$key])) {
                            $points += $config['awards'][$key];
                            $award = $config['awards'][$key] . '积分';
                        } else {
                            $award = $config['awards'][$key];
                        }
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
                if (!empty($config['max'][$key]) && $playData['prize_num'][$key] >= $config['max'][$key]) {
                    $luckRange += $value;
                } else {
                    if (($rand > $luckRange) && ($rand <= $luckRange + $value)) {
                        $prize = $key;
                        $playData['prize_num'][$key]++;
                        if (is_numeric($config['awards'][$key])) {
                            $points += $config['awards'][$key];
                            $award = $config['awards'][$key] . '积分';
                        } else {
                            $award = $config['awards'][$key];
                        }
                        break;
                    }
                    $luckRange += $value;
                }
            }
        }
        $prize = $prize ?: 0;

        $currentTime = time();
        // log
        $this->turntable_log_model->insert(array(
            'uid' => $this->user['uid'],
            'prize' => $prize,
            'award' => $award,
            'create_time' => $currentTime,
            'is_random' => $isRandom,
        ));
        $playData['update_time'] = $currentTime;
        $playData['range'] = json_encode($playData['range']);
        $playData['prize_num'] = json_encode($playData['prize_num']);
        if ($first) {
            $playData['uid'] = $this->user['uid'];
            $playData['create_time'] = $currentTime;
            $this->turntable_play_model->insert($playData);
        } else {
            unset($playData['uid'], $playData['create_time']);
            $this->turntable_play_model->update($playData, array('uid' => $this->user['uid']));
        }

        // 计算积分 remote $points TODO

        $angle = 0;
        foreach (array(1,2,0,3,4,0,5,6,0,7,8,0) as $value) {
            if ($prize == $value) {
                $angle += mt_rand(5, $config['angle'][$value] - 5);
                break;
            } else {
                $angle += $config['angle'][$value];
            }
        }

        // 0：谢谢参与
    	$this->response(array(
    		'award' => $award,
            'angle' => $angle,
		));
    }

    private function guestLottery($config)
    {
        $award = '';
        $prize = false;
        $rand = mt_rand(1, 1000);
        $probArr = $config['prob'];
        $luckRange = 0;
        foreach ($probArr as $key => $value) {
            $value = $value * 10;
            if ($rand > $luckRange && $rand <= $luckRange + $value) {
                $prize = $key;
                if (is_numeric($config['awards'][$key])) {
                    $award = $config['awards'][$key] . '积分';
                } else {
                    $award = $config['awards'][$key];
                }
                break;
            }
            $luckRange += $value;
        }
        $prize = $prize ?: 0;

        $angle = 0;
        foreach (array(1,2,0,3,4,0,5,6,0,7,8,0) as $value) {
            if ($prize == $value) {
                $angle += mt_rand(5, $config['angle'][$value] - 5);
                break;
            } else {
                $angle += $config['angle'][$value];
            }
        }
        // 0：谢谢参与 1：一等奖，2：二等奖，3：鼓励奖
        $this->response(array(
            'award' => $award,
            'angle' => $angle,
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
}
