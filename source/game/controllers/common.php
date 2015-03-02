<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Common
 *
 * @author  Xy Ji
 */
class Common extends Front_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        
    }

    public function time()
    {
    	$this->response(array('time' => time()));
    }

    public function test()
    {
        $this->load->library('szstage');
        $pwd=strtoupper(md5('app017858'));
        var_dump($this->szstage->modify_game_points($this->user,10000));exit;
    }
}
