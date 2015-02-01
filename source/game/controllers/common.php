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

    public function time()
    {
    	$this->response(array('time' => time()));
    }
}
