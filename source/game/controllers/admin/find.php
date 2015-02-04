<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Find
 *
 * @author  Xy Ji
 */
class Find extends Admin_Controller
{
    private $imageWidth = 360;
    private $imageHeight = 211;
    public function __construct()
    {
        parent::__construct();
        $this->load->model(array(
            'find_model', 'find_log_model', 'find_image_model'
        ));
    }

    public function index()
    {
        $jsonKeyArr = array('mission');
        $config = $this->find_model->get_one(array());
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
                $this->find_model->update($post, array());
                $data['status'] = 1;
            }
        }
        $this->load->view('admin/find', $data);
    }

    public function image()
    {
        $offset = intval($this->input->get('o'));
        $data   = array(
            'images' => array(),
        );

        $count = $this->find_image_model->get_count();
        if ($count) {
            $limit = $this->config->item('page_size');
            $data['images'] = $this->find_image_model->get_list(array(), $limit, $offset);

            $this->load->library('pagination');

            $this->pagination->initialize_admin(array(
                'base_url'    => preg_replace('/(.*)(\?|&)o=.*/', '$1', site_url($this->input->server('REQUEST_URI'))),
                'total_rows'  => $count,
                'per_page'    => $limit,
                'page_query_string'    => true,
                'query_string_segment' => 'o'
            ));
        }

        $this->load->view('admin/find_imagelist', $data);
    }

    public function editImage($id = 0)
    {
        $data = array(
            'image' => array(),
            'status' => 0,
        );

        if ($id) {
            $data['image'] = $findImage = $this->find_image_model->get_one(array('id' => $id));
            $data['image']['image_ori'] = site_url($this->config->item('find_image_path') . $findImage['image_ori']);
            $data['image']['image_mod'] = site_url($this->config->item('find_image_path') . $findImage['image_mod']);
            $data['image']['coordinate'] = json_decode($findImage['coordinate'], true);
        }
        if (empty($data['image']['coordinate'])) {
            $data['image']['coordinate'] = array(
                array('x' => '', 'y' => ''),
                array('x' => '', 'y' => ''),
                array('x' => '', 'y' => ''),
                array('x' => '', 'y' => ''),
                array('x' => '', 'y' => ''),
            );
        }
        $post = $this->input->post();
        if (!empty($post)) {
            $data['image']['title'] = $post['title'];

            if (count($post['coordinatex']) != 5 || count($post['coordinatey']) != 5) {
                $data['error'] = '请填写坐标';
            } else {
                foreach ($post['coordinatex'] as $key => $value) {
                    if (empty($value)) {
                        $data['error'] = '请填写坐标';
                    }
                    $post['coordinate'][$key]['x'] = $value;
                }
                foreach ($post['coordinatey'] as $key => $value) {
                    if (empty($value)) {
                        $data['error'] = '请填写坐标';
                    }
                    $post['coordinate'][$key]['y'] = $value;
                }
                foreach ($post['radius'] as $key => $value) {
                    if (!empty($value)) {
                        $post['coordinate'][$key]['r'] = $value;
                    }
                }
                $data['image']['coordinate'] = $post['coordinate'];
                $post['coordinate'] = json_encode($post['coordinate']);
            }

            if (empty($data['error'])) {
                $this->load->library('upload');
                $currentTime = time();

                $upConfig = array(
                    'file_name'     => $currentTime . 'o.' . pathinfo($_FILES['up_image_ori']['name'], PATHINFO_EXTENSION),
                    'upload_path'   => FCPATH . $this->config->item('find_image_path'),
                    'allowed_types' => 'png|jpg|jpeg',
                    'max_size'      => $this->config->item('size_limit'),
                    'overwrite'     => true,
                );

                if (!empty($findImage['image_ori']) && $_FILES['up_image_ori']['error'] == 4) {
                    $uploaded = true;
                } else {
                    $this->upload->initialize($upConfig);
                    $uploaded = $this->upload->do_upload('up_image_ori');
                }

                if (!$uploaded) {
                    $data['error'] = '上传图片出错：' . $this->upload->display_errors();
                } else {
                    if ($_FILES['up_image_ori']['error'] != 4) {
                        $imageOri = $this->upload->data();
                        if ($imageOri['image_width'] != $this->imageWidth || $imageOri['image_height'] != $this->imageHeight) {
                            unlink($upConfig['upload_path'] . $imageOri['file_name']);
                            $data['error'] = '请上传规定格式的图片：' . $this->imageWidth . '*' . $this->imageHeight;
                        }
                    }
                    if (empty($data['error'])) {
                        if (!empty($findImage['image_mod']) && $_FILES['up_image_mod']['error'] == 4) {
                            $uploaded = true;
                        } else {
                            $upConfig['file_name'] = $currentTime . 'm.' . pathinfo($_FILES['up_image_mod']['name'], PATHINFO_EXTENSION);
                            $this->upload->initialize($upConfig);
                            $uploaded = $this->upload->do_upload('up_image_mod');
                        }
                        if (!$uploaded) {
                            if ($_FILES['up_image_ori']['error'] != 4) {
                                unlink($upConfig['upload_path'] . $imageOri['file_name']);
                            }
                            $data['error'] = '上传图片出错：' . $this->upload->display_errors();
                        } else {
                            if ($_FILES['up_image_mod']['error'] != 4) {
                                $imageMod = $this->upload->data();
                                if ($imageMod['image_width'] != $this->imageWidth || $imageMod['image_height'] != $this->imageHeight) {
                                    unlink($upConfig['upload_path'] . $imageMod['file_name']);
                                    if ($_FILES['up_image_ori']['error'] != 4) {
                                        unlink($upConfig['upload_path'] . $imageOri['file_name']);
                                    }
                                    $data['error'] = '请上传规定格式的图片：' . $this->imageWidth . '*' . $this->imageHeight;
                                } else {
                                    $post['image_mod'] = $imageMod['file_name'];
                                    $data['image']['image_mod'] = site_url($this->config->item('find_image_path') . $imageMod['file_name']);
                                }
                            }
                            if (empty($data['error'])) {
                                if ($_FILES['up_image_ori']['error'] != 4) {
                                    $post['image_ori'] = $imageOri['file_name'];
                                    $data['image']['image_ori'] = site_url($this->config->item('find_image_path') . $imageOri['file_name']);
                                }

                                unset($post['coordinatex'], $post['coordinatey'], $post['radius']);
                                if ($id) {
                                    if (isset($post['image_ori']) && file_exists($upConfig['upload_path'] . $findImage['image_ori'])) {
                                        unlink($upConfig['upload_path'] . $findImage['image_ori']);
                                    }
                                    if (isset($post['image_mod']) && file_exists($upConfig['upload_path'] . $findImage['image_mod'])) {
                                        unlink($upConfig['upload_path'] . $findImage['image_mod']);
                                    }
                                    $this->find_image_model->update($post, array('id' => $id));
                                } else {
                                    $data['image']['id'] = $this->find_image_model->insert($post);
                                }

                                $data['status'] = 1;
                            }
                        }
                    }
                }
            }
        }
        $this->load->view('admin/find_image', $data);
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
            $count = $this->find_log_model->get_count(array(
                'create_time >=' => $start,
                'create_time <=' => $end,
            ));
            if ($count) {
                $limit = $this->config->item('page_size');
                $data['logs'] = $this->find_log_model->get_list(array(
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

        $this->load->view('admin/find_statistic', $data);
    }
}
