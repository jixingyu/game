<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Szstage
{
    private $CI;
    private $marginTime = 60;

    private $server = 'http://api.sz-stage.com:82/';
    private $platformId = 'bctest';
    private $platformPwd = 'bo23E%asn_23*v';
    private $platformKey = 'bc11A23';

    public function __construct()
    {
        $this->CI =& get_instance();
    }

    public function signin()
    {
        return $this->curl_post('Platform/SignIn', array(
            'PlatformId' => $this->platformId,
            'Password'   => $this->platformPwd,
        ));
    }

    public function resign($token)
    {
        return $this->curl_post('Platform/ReSign', array(
            'Token' => $token,
        ));
    }

    public function token()
    {
        $token = $this->CI->cache->get('szstage_token');
        if (empty($token) || $token['expire'] <= 0) {
            $token = $this->signin();
            if (!empty($token)) {
                $this->CI->cache->save('szstage_token', array(
                    'token' => $token['Token'],
                    'expire' => strtotime($token['ExpiresTime']) - $this->marginTime,
                ), 86400);
                return $token['Token'];
            }
        } else {
            if ($token['expire'] < time()) {
                $resignToken = $this->resign($token['Token']);
                $this->CI->cache->save('szstage_token', array(
                    'token' => $token['Token'],
                    'expire' => strtotime($resignToken['ExpiresTime']) - $this->marginTime,
                ), 86400);
                return $token['token'];
            } else {
                return $token['token'];
            }
        }
        return false;
    }

    public function get_user($mobile, $pwd)
    {
        $para = $this->_signature(array(
            'PlatformId' => $this->platformId,
            'Mobile'     => $mobile,
            'PwdMd5'     => $pwd,
        ));
        return $this->curl_post('User/GetWithGameByMobile', $para);
    }

    public function modify_game_points($user, $points)
    {
        if ($points == 0) {
            return true;
        }
        $token = $this->token();
        if (empty($token)) {
            return false;
        }
        $para = $this->_signature(array(
            'Token'      => $token,
            'UserId'     => $user['uid'],
            'PwdMd5'     => $user['PwdMd5'],
            'Points'     => $points,
        ));
        return $this->curl_post('Points/ModifyGamePoints', $para);
    }

    public function get_by_mobile($mobile, $pwd)
    {
        $para = $this->_signature(array(
            'PlatformId' => $this->platformId,
            'Mobile'     => $mobile,
            'PwdMd5'     => $pwd,
        ));
        return $this->curl_post('User/GetByMobile', $para);
    }

    private function _signature($para)
    {
        $temp = $para;
        $temp['platformKey'] = $this->platformKey;
        sort($temp);
        $para['Signature'] = strtoupper(sha1(implode('', $temp)));
        return $para;
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

        if (empty($data)) {
            return false;
        } else {
            $data = json_decode($data, true);
            if ($data['ReturnCode'] == 1) {
                return $data;
            } else {
                return false;
            }
        }
    }
}
