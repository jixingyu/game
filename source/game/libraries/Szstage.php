<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Szstage
{
    private $CI;
    private $marginTime = 60;

    private $server = 'http://api.sz-stage.com:82/';
    private $signInUrl = 'Platform/SignIn';
    private $reSignUrl = 'Platform/ReSign';
    private $platformId = 'bctest';
    private $platformPwd = 'bo23E%asn_23*v';

    public function __construct()
    {
        $this->CI =& get_instance();
        // $this->CI->load->database();
        // $this->CI->load->model('admin_member_model');

    }

    public function signin()
    {
        return $this->curl_post($this->signInUrl, array(
            'PlatformId' => $this->platformId,
            'Password'   => $this->platformPwd,
        ));
    }

    public function resign($token)
    {
        return $this->curl_post($this->reSignUrl, array(
            'Token' => $token,
        ));
    }

    public function token()
    {
        $token = $this->CI->cache->get('szstage_token');
        if (empty($token)) {
            $data = $this->signin();
            if (!empty($data)) {
                $token = json_decode($data, true);
                if ($token['ReturnCode'] == 1) {
                    $this->CI->cache->save('szstage_token', array(
                        'token' => $token['Token'],
                        'expire' => strtotime($token['ExpiresTime']) - $this->marginTime,
                    ), 86400);
                    return $token['Token'];
                }
            }
        } else {
            if ($token['expire'] < time()) {
                $resignToken = $this->resign($token['Token']);
                if ($resignToken['ReturnCode'] == 1) {
                    $this->CI->cache->save('szstage_token', array(
                        'token' => $token['Token'],
                        'expire' => strtotime($resignToken['ExpiresTime']) - $this->marginTime,
                    ), 86400);
                    return $token['token'];
                }
            } else {
                return $token['token'];
            }
        }
        return false;
    }

    public function curl_post($section = '', $params = array(), $timeout = '')
    {
        $url = $this->server . $section;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0)");
        curl_setopt($ch, CURLOPT_POST, 1);
        if (!empty($params)) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($params));
        }
        if (!empty($timeout)) {
            curl_setopt($ch, CURLOPT_TIMEOUT, intval($timeout));
        }
        $data = curl_exec($ch);
        curl_close($ch);

        return empty($data) ? null : $data;
    }
}
