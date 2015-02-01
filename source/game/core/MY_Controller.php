<?php

/**
 * The base controller which is used by the Front and the Admin controllers
 */
class Base_Controller extends CI_Controller
{

    public function __construct()
    {

        parent::__construct();

        $this->load->driver('cache', array('adapter' => 'file'));
        $this->load->helper('url');

    }//end __construct()

}//end Base_Controller

class Front_Controller extends Base_Controller
{
    private $meta = array();
    private $title = '';
    public $checkLogin = true;
    public $user;

    public function __construct()
    {
        parent::__construct();
        $this->load->library(array('session', 'userlib'));

        if ($this->router->method == 'index') {
            //进入游戏 用户认证
            // if ($this->checkLogin) {
            // }
            $data='4wJJzJIciCrpGza2MXE+B6Qj9M7KjLhGR2w6aIlxUbU2h6/t3xDvJ7GFqRADBLLJ';
            $this->load->library('Encryptlib');
            $data = json_decode($this->encryptlib->decrypt(base64_decode($data)), true);
            // TODO
            // if (empty($data['mobile']) || empty($data['pwd']) || empty($data['time'])) {
            //     $this->response(false, 101);
            // } elseif ($data['time'] - time() > 60) {
            //     $this->response(false, 101);
            // }
            // $mobile = '13888888882';
            // $pwd = 'app017858';
            $this->user = $this->userlib->login($data['mobile'], $data['pwd']);
            if (empty($this->user)) {
                $this->response(false, 101);
            }
        } else {
            $this->user = $this->userlib->get_user();
        }
        if (empty($this->user) && $this->checkLogin) {
            $this->response(false, 102);
        }
    }

    public function view($view, $vars = array(), $string = false)
    {
        if ($string) {
            $result = $this->load->view($view, $vars, true);
            return $result;
        } else {
            $vars['nickname'] = empty($this->user) ? '' : $this->user['name'];
            $vars['points'] = empty($this->user) ? '' : $this->user['points'];
            $this->load->view($view, $vars);
        }
    }

    public function response($data = false, $code = 0)
    {
        if (false === $data) {
            echo json_encode(array(
                'code' => $code,
            ));
        } else {
            echo json_encode(array(
                'code' => $code,
                'data' => $data,
            ));
        }
        exit;
    }

}

class Admin_Controller extends Base_Controller
{
    public function __construct()
    {
        parent::__construct();

        $this->load->library('auth');
        $this->auth->is_logged_in(uri_string());
        $this->curUser = $this->auth->get_current_user();
        $this->load->vars(array(
            'username' => $this->curUser['username']
        ));
        $this->load->helper('admin');
    }
}

