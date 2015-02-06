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
            'find_model', 'find_log_model', 'find_tag_model', 'find_image_model'
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
    public function tag()
    {
        $offset = intval($this->input->get('o'));
        $data   = array(
            'tags' => array(),
        );

        $count = $this->find_tag_model->get_count();
        if ($count) {
            $limit = $this->config->item('page_size');
            $data['tags'] = $this->find_tag_model->get_list(array(), $limit, $offset);

            $this->load->library('pagination');

            $this->pagination->initialize_admin(array(
                'base_url'    => preg_replace('/(.*)(\?|&)o=.*/', '$1', site_url($this->input->server('REQUEST_URI'))),
                'total_rows'  => $count,
                'per_page'    => $limit,
                'page_query_string'    => true,
                'query_string_segment' => 'o'
            ));
        }

        $this->load->view('admin/find_taglist', $data);
    }

    public function editTag($id = 0)
    {
        $data = array(
            'tag' => array(
                'name' => '',
            ),
            'status' => 0,
        );

        if ($id) {
            $data['tag'] = $this->find_tag_model->get_one(array('id' => $id));
        }

        $post = $this->input->post();
        if (!empty($post)) {
            $data['tag']['name'] = $post['name'];

            if (empty($post['name'])) {
                $data['error'] = '请填写标签名';
            }

            if (empty($data['error'])) {
                if ($id) {
                    $this->find_tag_model->update($post, array('id' => $id));
                } else {
                    $data['tag']['id'] = $this->find_tag_model->insert($post);
                }

                $data['status'] = 1;
            }
        }
        $this->load->view('admin/find_tag', $data);
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
            'taglist' => $this->find_tag_model->get_list();
            'status' => 0,
        );

        if ($id) {
            $data['image'] = $findImage =$this->find_image_model->get_one(array('id' => $id));
            if (!empty($data['image']['tag'])) {
                $imageTag = explode(',', $data['image']['tag']);
                foreach ($data['taglist'] as $key => $value) {
                    if (in_array($value['id'], $imageTag)) {
                        $data['taglist'][$key]['checked'] = true;
                    }
                }
            }
        }

        $post = $this->input->post();
        if (!empty($post)) {
            $data['image']['title'] = $post['title'];

            if (empty($post['tag'])) {
                $data['error'] = '请选择标签';
            }
            if (empty($data['error']) && !$id && $_FILES['up_image']['error'] == 4) {
                $data['error'] = '请上传图片';
            }

            if (empty($data['error'])) {
                $currentTime = time();
                if ($_FILES['up_image']['error'] != 4) {
                    $this->load->library('upload');

                    $upConfig = array(
                        'file_name'     => $currentTime . pathinfo($_FILES['up_image_ori']['name'], PATHINFO_EXTENSION),
                        'upload_path'   => FCPATH . $this->config->item('find_image_path'),
                        'allowed_types' => 'png|jpg|jpeg',
                        'max_size'      => $this->config->item('size_limit'),
                        'overwrite'     => true,
                    );

                    $this->upload->initialize($upConfig);
                    $uploaded = $this->upload->do_upload('up_image');

                    if (!$uploaded) {
                        $data['error'] = '上传图片出错：' . $this->upload->display_errors();
                    } else {
                        $imagedata = $this->upload->data();
                        $wh = $this->config->item('find_image_wh');
                        if (!in_array($imagedata['image_width'] . '*' . $imagedata['image_height'], $wh)) {
                            unlink($upConfig['upload_path'] . $imagedata['file_name']);
                            $data['error'] = '请上传规定格式的图片：' . implode(',', $wh);
                        }
                        if (empty($data['error']) && $id && file_exists($upConfig['upload_path'] . $findImage['image'])) {
                                unlink($upConfig['upload_path'] . $findImage['image']);
                            }
                        }
                    }
                }
                if ($id) {
                    $this->find_image_model->update($post, array('id' => $id));
                } else {
                    $data['image']['id'] = $this->find_image_model->insert($post);
                }

                $data['status'] = 1;
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
