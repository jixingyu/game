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
        $this->load->model(array('turntable_log_model', 'turntable_play_model'));

        $isRandom = 1;
        $prize = false;
        $prizeArr = array(1,2,3,4,5,6,7,8);

        $today = strtotime(date('Ymd'));

        $playData = $this->turntable_play_model->get_one(array(
            'uid' => $this->uid,
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
            $consumePoints = $config['consume_points'];
        } else {
            $consumePoints = 0;
        }
        $points = -$consumePoints;

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
            'uid' => $this->uid,
            'prize' => $prize,
            'consume_points' => $consumePoints,
            'create_time' => $currentTime,
            'is_random' => $isRandom,
        ));
        $playData['update_time'] = $currentTime;
        $playData['range'] = json_encode($playData['range']);
        $playData['prize_num'] = json_encode($playData['prize_num']);
        if ($first) {
            $playData['uid'] = $this->uid;
            $playData['create_time'] = $currentTime;
            $this->turntable_play_model->insert($playData);
        } else {
            unset($playData['uid'], $playData['create_time']);
            $this->turntable_play_model->update($playData, array('uid' => $this->uid));
        }

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

    // private function playData($today, $config, $prizeArr)
    // {
    //     $playData = array();
    //     $playData['today'] = $today;
    //     $playData['todayNum'] = $this->turntable_log_model->get_count(array(
    //         'uid' => $this->uid,
    //         'create_time >=' => $today,
    //     ));
    //     $playData['total'] = $this->turntable_log_model->get_count(array(
    //         'uid' => $this->uid,
    //     ));

    //     $todayPrizeCount = $this->turntable_log_model->prize_count(array(
    //         'uid' => $this->uid,
    //         'prize >' => 0,
    //         'create_time >=' => $today,
    //     ), 'prize');
    //     if (!empty($todayPrizeCount)) {
    //         foreach ($todayPrizeCount as $key => $value) {
    //             $tmpPrize = $value['prize'];
    //             $playData['todayPrizeCount'][$tmpPrize] = $value['cnt'];
    //         }
    //     }

    //     foreach ($prizeArr as $key) {
    //         if (!empty($config['range'][$key])) {
    //             $lastIndex = 'lastIndex' . $key;
    //             $lastPrize = $this->turntable_log_model->get_list(array(
    //                 'uid' => $this->uid,
    //                 'prize' => $key,
    //             ), 1, 0, 'id');
    //             if (!empty($lastPrize)) {
    //                 $playData[$lastIndex] = $this->turntable_log_model->get_count(array(
    //                     'uid' => $this->uid,
    //                     'id <=' => $lastPrize[0]['id'],
    //                 ));
    //             } else {
    //                 $playData[$lastIndex] = 0;
    //             }
    //         }

    //         if (!isset($playData['todayPrizeCount'][$key])) {
    //             $playData['todayPrizeCount'][$key] = 0;
    //         }
    //     }

    //     return $playData;
    // }
}
