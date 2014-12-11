<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Horse race
 *
 * @author  Xy Ji
 */
class Horserace extends Front_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
    	$data = array('title' => '赛马');

        $this->load->view('horserace', $data);
    }
}
