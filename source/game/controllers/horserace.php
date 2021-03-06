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
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $config = $this->getConfig();
    	$data = array(
            'title' => '赛马',
            'chip'  => $config['chip'],
        );

        $this->view('horserace', $data);
    }

    public function start()
    {
        $config = $this->getConfig();

        $this->load->model(array('horserace_log_model', 'horserace_play_model'));

        $playRank = array(1,2,3);
        $rank = array(1,2,3,4,5,6,7,8);
        $rankPoints = array();
        $postR = explode(',', $this->input->post('rank'));
        $postP = explode(',', $this->input->post('rankPoints'));
        foreach ($playRank as $rankK) {
            if (!empty($postR[$rankK - 1])) {
                $rankList[$rankK] = intval($postR[$rankK - 1]);
                $rankPoints[$rankK] = abs(intval($postP[$rankK - 1]));
            }
        }
        if (empty($rankList)) {
            $this->response('Bad Request', 404);
        }

        $isRandom = 1;
        $points = -array_sum($rankPoints);
        $updPlayData = array();
        $playData = $this->horserace_play_model->get_one(array(
            'uid' => $this->user['uid'],
        ));
        if (empty($playData)) {
            $updPlayData = $playData = array(
                'cont_win_num'   => 0,
                'force_lose_num' => 0,
                'lose_num'       => 0,
                'lose_points'    => 0,
            );
            $first = true;
        } else {
            $first = false;
        }

        // 连赢
        if ($playData['cont_win_num'] == $config['cont_win_num'] && $playData['force_lose_num'] < $config['force_lose_num']) {
            // force lose
            $len = count($playRank);
            $tmp = array();

            for ($i = 1; $i <= $len; $i++) {
                if (isset($rankList[$i]) && !in_array($rankList[$i], $tmp)) {
                    $rankId = $rankList[$i];
                    unset($rank[$rankId - 1]);

                    $randomKey = array_rand($rank, 1);
                    unset($rank[$randomKey]);
                    $rank[$rankId - 1] = $rankId;
                    $tmp[] = $randomKey + 1;
                } else {
                    $randomKey = array_rand($rank, 1);
                    unset($rank[$randomKey]);
                    $tmp[] = $randomKey + 1;
                }
            }
            shuffle($rank);
            $rank = array_merge($tmp, $rank);
            $isRandom = 0;

            if ($playData['force_lose_num'] + 1 == $config['force_lose_num']) {
                $updPlayData['force_lose_num'] = 0;
                $updPlayData['cont_win_num'] = 0;
            } else {
                $updPlayData['force_lose_num'] = $playData['force_lose_num'] + 1;
            }

            $updPlayData['lose_num'] = $playData['lose_num'] + 1;
            $updPlayData['lose_points'] = $playData['lose_points'] - $points;
        } elseif (($playData['lose_num'] >= $config['lose_num'] || $playData['lose_points'] >= $config['lose_points'])) {
            $tmp = array_keys($rankPoints);
            shuffle($tmp);
            foreach ($tmp as $rankK) {
                if ($rankPoints[$rankK] <= $config['force_win_points']) {
                    // force win
                    $result = $this->randRank($playRank, $config, $rank, $rankList, $rankPoints, $rankK);
                    $rank = $result['rank'];
                    $isRandom = 0;
                    $updPlayData['cont_win_num'] = $playData['cont_win_num'] + 1;
                    $updPlayData['lose_num'] = 0;
                    $updPlayData['lose_points'] = 0;
                    $points += $result['win'];
                    break;
                }
            }
        }
        if ($isRandom) {
            $result = $this->randRank($playRank, $config, $rank, $rankList, $rankPoints);
            $rank = $result['rank'];
            if ($result['win']) {
                $updPlayData['cont_win_num'] = $playData['cont_win_num'] + 1;
                $points += $result['win'];
            } else {
                $updPlayData['cont_win_num'] = 0;
                $updPlayData['lose_num'] = $playData['lose_num'] + 1;
                $updPlayData['lose_points'] = $playData['lose_points'] - $points;
            }
        }

        // 计算积分 remote $points TODO
        $this->load->library('szstage');
        if (!$this->szstage->modify_game_points($this->user, $points)) {
            $this->response(false, 201);
        }

        // log
        $currentTime = time();
        $this->horserace_log_model->insert(array(
            'uid' => $this->user['uid'],
            'rank1' => isset($rankList[1]) ? $rankList[1] : 0,
            'rank2' => isset($rankList[2]) ? $rankList[2] : 0,
            'rank3' => isset($rankList[3]) ? $rankList[3] : 0,
            'rank' => json_encode($rank),
            'create_time' => $currentTime,
            'is_random' => $isRandom,
        ));
        $updPlayData['update_time'] = $currentTime;
        if ($first) {
            $updPlayData['uid'] = $this->user['uid'];
            $updPlayData['create_time'] = $currentTime;
            $this->horserace_play_model->insert($updPlayData);
        } else {
            $this->horserace_play_model->update($updPlayData, array('uid' => $this->user['uid']));
        }

        // 0：谢谢参与
    	$this->response(array(
    		'rank'  => $rank
		));
    }

    private function randRank($playRank, $config, $rank, $rankList, $rankPoints, $rankK = false)
    {
        $len = count($rank);
        $tmp = array();
        $win = 0;
        if ($rankK) {
            $id = $rankList[$rankK];
            unset($rank[$id - 1]);
        }

        for ($i = 1; $i < $len; $i++) {
            $randomKey = array_rand($rank, 1);
            if ($i == $rankK) {
                $tmp[] = $id;
                $win += $rankPoints[$i] * ($config['multiple'][$i] + 2);
            } elseif (isset($rankList[$i]) && $rankList[$i] == $randomKey + 1 &&
                $this->prob($config['exclude_prob'][$i])) {
                unset($rank[$randomKey]);
                $randomKey2 = array_rand($rank, 1);
                unset($rank[$randomKey2]);
                $rank[$randomKey] = $randomKey + 1;
                $tmp[] = $randomKey2 + 1;
            } else {
                if (isset($rankList[$i]) && $rankList[$i] == $randomKey + 1) {
                    $win += $rankPoints[$i] * ($config['multiple'][$i] + 2);
                }
                unset($rank[$randomKey]);
                $tmp[] = $randomKey + 1;
            }
        }
        shuffle($rank);
        $rank = array_merge($tmp, $rank);
        return array('rank' => $rank, 'win' => $win);
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

    private function prob($prob)
    {
        $rand = mt_rand(1, 100);
        if ($rand <= $prob) {
            return true;
        } else {
            return false;
        }
    }
}
