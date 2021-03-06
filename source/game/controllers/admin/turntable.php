<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Turntable
 *
 * @author  Xy Ji
 */
class Turntable extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model(array(
            'turntable_model', 'turntable_log_model'
        ));
    }

    public function index()
    {
        $jsonKeyArr = array('range', 'awards', 'prob', 'max', 'angle');
    	$config = $this->turntable_model->get_one(array());
        foreach ($jsonKeyArr as $value) {
            $config[$value] = json_decode($config[$value], true);
        }
        $config['image'] = site_url($config['image']);
        $data = array(
            'prizeArr' => array(1,2,3,4,5,6,7,8),
        	'config' => $config,
        	'status' => 0,
    	);
        $post = $this->input->post();
        if (!empty($post)) {
            $angleTotal = 0;
            foreach ($data['prizeArr'] as $key) {
                $angleTotal += $post['angle' . $key];
                if ($post['angle' . $key] < 10) {
                    $data['error'] = '角度设定出错，角度不能小于10度';
                }
            }
            if ($angleTotal >= 360) {
                $data['error'] = '角度设定出错';
            }
            $post['angle0'] = intval((360 - $angleTotal) / 4);
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
            if (empty($data['error'])) {
                $probTotal = 0;
                foreach ($post['prob'] as $key => $value) {
                    $probTotal += $value;
                }
                if ($probTotal >= 100) {
                    $data['error'] = '初始几率设定出错';
                } else {
                    if ($_FILES['upImage']['error'] == 4) {
                        $uploaded = true;
                    } else {
                        $this->load->library('upload');

                        $upConfig = array(
                            'file_name'     => 'turntable' . rand(1,100) . '.' . pathinfo($_FILES['upImage']['name'], PATHINFO_EXTENSION),
                            'upload_path'   => FCPATH . $this->config->item('turntable_image_path'),
                            'allowed_types' => 'png|jpg',
                            'max_size'      => $this->config->item('size_limit'),
                            'overwrite'     => true,
                        );

                        $this->upload->initialize($upConfig);

                        $uploaded = $this->upload->do_upload('upImage');
                    }

                    if (!$uploaded) {
                        $data['error'] = '上传图片出错：' . $this->upload->display_errors();
                    } else {
                        if ($_FILES['upImage']['error'] != 4) {
                            $image = $this->upload->data();
                            $post['image'] = $this->config->item('turntable_image_path') . $image['file_name'];
                            $data['config']['image'] = site_url($this->config->item('turntable_image_path') . $image['file_name']);
                            if (file_exists(FCPATH . $config['image']) && $config['image'] != $post['image']) {
                                unlink(FCPATH . $config['image']);
                            }
                        }
                        foreach ($jsonKeyArr as $jsonKey) {
                            $post[$jsonKey] = json_encode($post[$jsonKey]);
                        }
                        $this->turntable_model->update($post, array());
                        $data['status'] = 1;
                        $this->cache->delete('turntable_config');
                    }
                }
            }
        }
        $this->load->view('admin/turntable', $data);
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
            $count = $this->turntable_log_model->get_count(array(
                'create_time >=' => $start,
                'create_time <=' => $end,
            ));
            if ($count) {
                $limit = $this->config->item('page_size');
                $data['logs'] = $this->turntable_log_model->get_list(array(
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

        $this->load->view('admin/turntable_statistic', $data);
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
