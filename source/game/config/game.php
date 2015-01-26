<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
date_default_timezone_set('Asia/ShangHai');
$config['size_limit'] = intval(ini_get('upload_max_filesize')) * 1024;
$config['turntable_image_path'] = 'assets/turntable/';
$config['spot_image_path'] = 'assets/spot/images/';
$config['statistic_path'] = FCPATH . '../files/statistic/';
$config['page_size'] = 20;
