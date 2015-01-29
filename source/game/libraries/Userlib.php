<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 *
 * User Libraries For Front
 */
class Userlib
{
    public $CI;

    public function __construct()
    {
        $this->CI =& get_instance();
    }

    /**
     * get current user
     *
     * @return bool
     */
    public function get_user()
    {
        $user = $this->CI->session->userdata('user');

        return $user;
    }

    /**
     * Require auth; while user not logged in, start login process
     *
     * @return bool
     */
    public function login($mobile, $pwd)
    {
        $this->CI->load->library('szstage');
        $pwdmd5 = strtoupper(md5($pwd));
        $loginData = $this->CI->szstage->get_user($mobile, $pwdmd5);

        if (!empty($loginData)) {
            $user = array(
                'uid'  => $loginData['UserId'],
                'name' => $loginData['Name'],
                'points' => $loginData['GamePoints'],
                'PwdMd5' => $pwdmd5,
            );
            $this->CI->session->set_userdata(array(
                'user' => $user,
            ));
            return $user;
        } else {
            return false;
        }
    }

    /**
     * Logout
     *
     * @return void
     */
    public function logout()
    {
        $this->CI->session->unset_userdata('user');
        $this->CI->session->sess_destroy();
        return;
    }
}
