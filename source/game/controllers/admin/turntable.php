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
            'turntable_model',
        ));
    }

    public function index()
    {
        $jsonKeyArr = array('range', 'points', 'prob', 'max', 'angle');
    	$config = $this->turntable_model->get_one(array());
        foreach ($jsonKeyArr as $value) {
            $config[$value] = json_decode($config[$value], true);
        }
        $data = array(
        	'config' => $config,
        	'status' => 0,
    	);
        $post = $this->input->post();
        if (!empty($post)) {
        	foreach ($post as $key => $value) {
        		$value = trim($value);
        		if (empty($value)) {
        			$data['error'] = '请填写所有配置';
        			break;
        		} else {
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
        	}
        	$data['config'] = array_merge($data['config'], $post);
            if (empty($data['error'])) {
                $probTotal = 0;
                foreach ($post['prob'] as $key => $value) {
                    $probTotal += $value;
                }
                if ($probTotal > 100) {
                    $data['error'] = '初始几率设定出错';
                } else {
                    $this->load->library('upload');

                    $upConfig = array(
                        'file_name'     => 'turntable.' . pathinfo($_FILES['upImage']['name'], PATHINFO_EXTENSION),
                        'upload_path'   => FCPATH . $this->config->item('turntable_image_path'),
                        'allowed_types' => 'png',
                        'max_size'      => $this->config->item('size_limit'),
                        'overwrite'     => true,
                    );

                    $this->upload->initialize($upConfig);

                    $uploaded = $this->upload->do_upload('upImage');

                    if (!$uploaded) {
                        $data['error'] = '上传图片出错：' . $this->upload->display_errors();
                    } else {
                        foreach ($jsonKeyArr as $jsonKey) {
                            $post[$jsonKey] = json_encode($post[$jsonKey]);
                        }
                        $image = $this->upload->data();
                        $data['config']['image'] = $post['image'] = site_url($this->config->item('turntable_image_path') . $image['file_name']);
                        $this->turntable_model->update($post, array());
                        $data['status'] = 1;
                    }
                }
            }
        }
        $this->load->view('admin/turntable', $data);
    }
}
