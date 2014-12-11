<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 *
 * Dashboard
 *
 * @author  Xy Ji
 */
class Dashboard extends Admin_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $this->load->view('admin/dashboard');
    }
}
