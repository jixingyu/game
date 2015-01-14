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
        $config = $this->getConfig();
    	$data = array(
            'title'  => '找茬',
            'config' => json_encode($config),
        );

        $this->load->view('spot', $data);
    }

    private function getConfig()
    {
        $config = $this->cache->get('spot_config');
        if (empty($config)) {
            $this->load->model('spot_model');
            $config = $this->spot_model->get_one(array());
 
            $config['mission'] = json_decode($config['mission'], true);

            $this->cache->save('spot_config', $config);
        }
        return $config;
    }

    public function play()
    {
        $config = $this->getConfig();
        $post = $this->input->post();
        $this->load->model(array('spot_log_model'));
        $currentTime = time();
        if ($post['status'] == 0) {
            // begin
            $this->spot_log_model->insert(array(
                'uid'             => $this->uid,
                'reminder_times'  => 0,
                'added_time'      => 0,
                'consume_points'  => 0,
                'create_time'     => $currentTime,
                'update_time'     => $currentTime,
                'level'           => 0,
                'award'           => '',
            ));
            $this->response();
        } else {
            if (empty($post['i'])) {
                $this->response(false, 404);
            }
            $post['r'] = isset($post['r']) ? intval($post['r']) : 0;
            $post['t'] = isset($post['t']) ? intval($post['t']) : 0;
            $consumePoints = ($post['r'] - $config['free_reminder']) * $config['reminder_points']
                    + $post['t'] / $config['time_chunk'] * $config['time_chunk_points'];
            if (!empty($post['p'])) {
                $this->spot_log_model->set('level', '`level`+1', false);
            }
            $this->spot_log_model->set('reminder_times', '`reminder_times`+' . $post['r'], false);
            $this->spot_log_model->set('added_time', '`added_time`+' . $post['t'], false);
            $this->spot_log_model->set('consume_points', '`consume_points`+' . $consumePoints, false);
            $this->spot_log_model->update(array('update_time' => $currentTime), array(
                'id'  => $post['i'],
                'uid' => $this->uid,
            ));
            $this->response(array('c' => $consumePoints));
        }
    }
}
