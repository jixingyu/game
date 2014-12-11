<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * CodeIgniter Download Helpers
 *
 * @package		CodeIgniter
 * @subpackage	Helpers
 * @category	Helpers
 * @author		EllisLab Dev Team
 * @link		http://codeigniter.com/user_guide/helpers/download_helper.html
 */

// ------------------------------------------------------------------------

if ( ! function_exists('go_dashboard'))
{
	function go_dashboard()
	{
	    redirect('admin/dashboard');
	}
}