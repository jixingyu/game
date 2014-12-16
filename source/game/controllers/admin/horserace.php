<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Horserace
 *
 * @author  Xy Ji
 */
class Horserace extends Admin_Controller
{
    protected $type = 2;
    public function __construct()
    {
        parent::__construct();
        $this->load->model(array(
            'horserace_model', 'game_log_model'
        ));
    }

    public function index()
    {
        $jsonKeyArr = array('multiple', 'exclude_prob');
        $config = $this->horserace_model->get_one(array());
        foreach ($jsonKeyArr as $value) {
            $config[$value] = json_decode($config[$value], true);
        }
        $data = array(
            'prizeArr' => array(1,2,3),
            'config' => $config,
            'status' => 0,
        );
        $post = $this->input->post();
        if (!empty($post)) {
            foreach ($post as $key => $value) {
                $value = trim($value);

                $match = false;
                foreach ($jsonKeyArr as $jsonKey) {
                    if (!isset($post[$jsonKey])) {
                        $post[$jsonKey] = array();
                    }
                    if (0 === strpos($key, $jsonKey)) {
                        $match = true;
                        $prizeKey = substr($key, strlen($jsonKey));
                        $post[$jsonKey][$prizeKey] = $value;
                        unset($post[$key]);
                        break;
                    }
                }
                if (!$match) {
                    $post[$key] = $value;
                }
            }

            $data['config'] = array_merge($data['config'], $post);
            foreach ($post['exclude_prob'] as $key => $value) {
                if ($value >= 100) {
                    $data['error'] = '排除概率设定出错';
                }
            }
            if (empty($data['error'])) {
                foreach ($jsonKeyArr as $jsonKey) {
                    $post[$jsonKey] = json_encode($post[$jsonKey]);
                }
                $this->horserace_model->update($post, array());
                $data['status'] = 1;
            }
        }
        $this->load->view('admin/horserace', $data);
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
            $count = $this->game_log_model->get_count(array(
                'type' => $this->type,
                'create_time >=' => $start,
                'create_time <=' => $end,
            ));
            if ($count) {
                $limit = $this->config->item('page_size');
                $data['logs'] = $this->game_log_model->get_list(array(
                    'type' => $this->type,
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

        $this->load->view('admin/horserace_statistic', $data);
    }

    public function down()
    {
        // $statisticPath = $this->config->item('statistic_path');
        // force_download($filePath, NULL);
        // output_csv(array(
        //     array('a','b'),
        //     array(1,2)
        // ));
    }
}
