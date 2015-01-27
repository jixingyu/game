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
    public $uid;

    public function __construct()
    {
        parent::__construct();
        $this->load->library(array('session'));
                $this->uid = 1;//TODO
        // if ($this->checkLogin) {
        //     if ($this->router->method == 'index') {
        //         //进入游戏 用户认证
        //         $this->uid = 1;//TODO
        //     }
        //     if (!$this->uid) {
        //         $this->response(false, 101);
        //     }
        // }
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

