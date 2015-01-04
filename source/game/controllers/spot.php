<?php
defined('BASEPATH') OR exit('No direct script access allowed');
/**
 *
 * Spot
 *
 * @author  Xy Ji
 */
class Spot extends Front_Controller
{
    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        $config = $this->getConfig();
    	$data = array(
            'title' => '找茬',
            'initial_time' => $config['initial_time'],
        );

        $this->load->view('spot', $data);
    }

    private function getConfig()
    {
        $config = $this->cache->get('spot_config');
        if (empty($config)) {
            $this->load->model('spot_model');
            $config = $this->spot_model->get_one(array());
 
            $config['mission'] = json_decode($config['mission'], true);

            $this->cache->save('spot_config', $config);
        }
        return $config;
    }
}
