<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Spot
 *
 * @author  Xy Ji
 */
class Spot extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(array(
            'spot_model', 'spot_log_model'
        ));
    }

    public function index()
    {
        $jsonKeyArr = array('mission');
        $config = $this->spot_model->get_one(array());
        foreach ($jsonKeyArr as $value) {
            $config[$value] = json_decode($config[$value], true);
        }
        $data = array(
            'config' => $config,
            'status' => 0,
        );
        $post = $this->input->post();
        if (!empty($post)) {
        	$mission = array();
        	if (!empty($post['mlevel'])) {
            	foreach ($post['mlevel'] as $key => $level) {
            		if (!empty($level) && !empty($post['mpoints'][$key])) {
            			$mission[] = array(
            				'level' => $level,
            				'points' => $post['mpoints'][$key],
        				);
            		}
            	}
        	}
        	unset($post['mlevel'], $post['mpoints']);
            foreach ($post as $key => $value) {
                $post[$key] = trim($value);
            }
            if (!empty($mission)) {
            	$data['config']['mission'] = $post['mission'] = $mission;
            }

            $data['config'] = array_merge($data['config'], $post);
            if (empty($data['error'])) {
                foreach ($jsonKeyArr as $jsonKey) {
                    $post[$jsonKey] = json_encode($post[$jsonKey]);
                }
                $this->spot_model->update($post, array());
                $data['status'] = 1;
            }
        }
        $this->load->view('admin/spot', $data);
    }

    public function statistic()
    {
        $offset  = intval($this->input->get('o'));
        $start   = $this->input->get('start');
        $end     = $this->input->get('end');

        $start   = $start ? strtotime($start) : strtotime(date('Ymd'));
        $end     = $end ? strtotime($end) : strtotime(date('Ymd'));

        $data    = array(
            'start' => date('Y-m-d', $start),
            'end' => date('Y-m-d', $end),
            'logs' => array(),
        );

        if ($start > $end) {
            $data['error'] = '开始时间不能超过结束时间';
        } else {
            $count = $this->spot_log_model->get_count(array(
                'create_time >=' => $start,
                'create_time <=' => $end,
            ));
            if ($count) {
                $limit = $this->config->item('page_size');
                $data['logs'] = $this->spot_log_model->get_list(array(
                    'create_time >=' => $start,
                    'create_time <=' => $end,
                ), $limit, $offset);

                $this->load->library('pagination');

                $this->pagination->initialize_admin(array(
                    'base_url'    => preg_replace('/(.*)(\?|&)o=.*/', '$1', site_url($this->input->server('REQUEST_URI'))),
                    'total_rows'  => $count,
                    'per_page'    => $limit,
                    'page_query_string'    => true,
                    'query_string_segment' => 'o'
                ));
            }
        }

        $this->load->view('admin/spot_statistic', $data);
    }
}
