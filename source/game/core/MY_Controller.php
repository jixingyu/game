<?php

/**
 * The base controller which is used by the Front and the Admin controllers
 */
class Base_Controller extends CI_Controller
{

    public function __construct()
    {

        parent::__construct();

        $this->load->helper('url');

    }//end __construct()

}//end Base_Controller

class Front_Controller extends Base_Controller
{
    private $meta = array();
    private $title = '';

    public function __construct()
    {
        parent::__construct();
        // $this->uid = 1;//TODO
        //load libraries
        // $this->load->library(array('session','user_lib'));
        // $this->load->model('category_model');
        // $this->load->model('user_conversation_model');
        // $this->lang->load('common');
        // $this->load->helper('html');
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
    }
}

// Api_Controller
require(APPPATH.'/libraries/REST_Controller.php');
class Api_Controller extends REST_Controller
{
    public function __construct()
    {

        parent::__construct();

        $this->load->library(array('session','user_lib'));

    }
}
