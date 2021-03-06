<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Spot
 *
 * @author  Xy Ji
 */
class Spot extends Front_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
    	$data = array(
            'title'  => '找茬',
        );

        $this->view('spot', $data);
    }

    public function config()
    {
        $config = $this->getConfig();
        $this->response(array(
            'i'    => $config['initial_time'],
            'fr'   => $config['free_reminder'],
            'rp'   => $config['reminder_points'],
            'mr'   => $config['max_reminder'],
            'at'   => $config['right_add_time'],
            'st'   => $config['wrong_sub_time'],
            't'    => $config['time_chunk'],
            'tp'   => $config['time_chunk_points'],
            'mt'   => $config['max_time_chunk'],
            'desc' => $config['description'],
        ));
    }

    private function getConfig()
    {
        $config = $this->cache->get('spot_config');
        if (empty($config)) {
            $this->load->model('spot_model');
            $config = $this->spot_model->get_one(array());

            $this->cache->save('spot_config', $config);
        }
        return $config;
    }

    public function begin()
    {
        $this->load->model(array('spot_log_model'));
        $currentTime = time();
        $id = $this->spot_log_model->insert(array(
            'uid'             => $this->user['uid'],
            'level'           => 0,
            'award'           => '',
            'create_time'     => $currentTime,
            'update_time'     => $currentTime,
        ));
        $this->response(array('i' => $id));
    }

    public function finish()
    {
        $this->load->model(array('spot_log_model'));
        $post = $this->input->post();
        if (empty($post['i'])) {
            $this->response(false, 404);
        }
        $logId = intval($post['i']);
        $log = $this->spot_log_model->get_one(array('id' => $logId, 'uid' => $this->user['uid']));
        if (empty($log)) {
            $this->response(false, 404);
        }
        $updAward = $log['award'];

        $level = intval($post['level']);
        $config = $this->getConfig();
        $mission = json_decode($config['mission'], true);
        foreach ($mission as $m) {
            if ($level == $m['level']) {
                $award = $m['points'];
                if (!empty($log['award'])) {
                    $updAward = json_decode($updAward, true);
                    $updAward[] = $award;
                } else {
                    $updAward = array($award);
                }
                $updAward = json_encode($updAward);
                // 计算积分 remote $points TODO
                $this->load->library('szstage');
                if (!$this->szstage->modify_game_points($this->user, $award)) {
                    $this->response(false, 201);
                }

                break;
            }
        }

        $this->spot_log_model->update(array(
            'level'           => $level,
            'award'           => $updAward,
            'update_time'     => time(),
        ), array('id' => $logId));
        if (isset($award)) {
            $this->response(array('points' => $award));
        } else {
            $this->response();
        }
    }

    public function prompt()
    {
        $this->consume(0);
    }

    public function timer()
    {
        $this->consume(1);
    }

    private function consume($type)
    {
        $config = $this->getConfig();
        $this->load->model(array('spot_log_model', 'spot_consume_log_model'));
        $post = $this->input->post();
        if (empty($post['i'])) {
            $this->response(false, 404);
        }
        $logId = intval($post['i']);
        $log = $this->spot_log_model->get_one(array('id' => $logId, 'uid' => $this->user['uid']));
        if (empty($log)) {
            $this->response(false, 404);
        }
        if ($type == 0) {
            $consumePoints = $config['reminder_points'];
        } else {
            $consumePoints = $config['time_chunk_points'];
        }
        $this->load->library('szstage');
        if (!$this->szstage->modify_game_points($this->user, -$consumePoints)) {
            $this->response(false, 201);
        }

        $this->spot_consume_log_model->insert(array(
            'log_id'      => $logId,
            'type'        => $type,
            'points'      => $consumePoints,
            'create_time' => time(),
        ));

        $this->response(array('c' => $consumePoints));
    }

    public function images()
    {
        $this->load->model('spot_image_model');
        $images = $this->spot_image_model->get_images(20);
        $this->response($images);
    }
}
