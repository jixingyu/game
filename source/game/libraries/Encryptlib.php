<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 *
 * User Libraries For Front
 */
class Encryptlib
{
	private $key = 'ce6b6ace734a49cf';
	/**
	 * 加密
	 * @param string $string
	 */
	function encrypt($string)
	{
	    return mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $this->key, $string, MCRYPT_MODE_ECB);
	}

	/**
	 * 解密
	 * @param string $string
	 */
	function decrypt($string)
	{
	    return trim(mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $this->key, $string, MCRYPT_MODE_ECB));
	}
}