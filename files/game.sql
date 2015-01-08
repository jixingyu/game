/*
SQLyog v10.2 
MySQL - 5.6.17 : Database - game
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`game` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `game`;

/*Table structure for table `admin_member` */

DROP TABLE IF EXISTS `admin_member`;

CREATE TABLE `admin_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `u_username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin_member` */

insert  into `admin_member`(`uid`,`username`,`password`) values (1,'admin','2cd20a9777fa019d63dc8e918fa8ee33799992f9');

/*Table structure for table `carrace` */

DROP TABLE IF EXISTS `carrace`;

CREATE TABLE `carrace` (
  `chip` int(3) unsigned NOT NULL,
  `multiple` varchar(255) NOT NULL,
  `exclude_prob` varchar(255) NOT NULL,
  `cont_win_num` int(3) unsigned NOT NULL,
  `force_lose_num` int(3) unsigned NOT NULL,
  `lose_num` int(3) unsigned NOT NULL,
  `lose_points` int(3) unsigned NOT NULL,
  `force_win_points` int(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `carrace` */

insert  into `carrace`(`chip`,`multiple`,`exclude_prob`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`force_win_points`) values (200,'{\"1\":\"6\",\"2\":\"3\",\"3\":\"1\"}','{\"1\":\"99\",\"2\":\"88\",\"3\":\"77\"}',3,5,50,5000,500);

/*Table structure for table `carrace_log` */

DROP TABLE IF EXISTS `carrace_log`;

CREATE TABLE `carrace_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `rank1` int(1) unsigned NOT NULL,
  `rank2` int(1) unsigned NOT NULL,
  `rank3` int(1) unsigned NOT NULL,
  `rank` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

/*Data for the table `carrace_log` */

insert  into `carrace_log`(`id`,`uid`,`rank1`,`rank2`,`rank3`,`rank`,`create_time`,`is_random`) values (149,1,8,0,0,'[3,2,7,1,6,5,8,4]',1418890077,1),(148,1,8,0,0,'[3,7,2,6,1,4,5,8]',1418890075,1),(147,1,8,0,0,'[7,4,1,5,3,2,6,8]',1418890071,1),(146,1,8,0,0,'[3,8,7,2,1,6,4,5]',1418887705,1),(145,1,8,0,0,'[4,7,1,2,3,8,6,5]',1418887704,1),(144,1,8,0,0,'[1,5,2,4,7,3,8,6]',1418887702,1),(143,1,8,0,0,'[4,6,8,3,5,7,1,2]',1418887701,1),(142,1,8,0,0,'[2,7,8,1,4,3,5,6]',1418887695,1),(141,1,8,0,0,'[4,2,6,7,5,8,1,3]',1418887450,1),(140,1,8,0,0,'[2,8,1,6,5,3,4,7]',1418887449,1),(139,1,8,0,0,'[1,4,2,8,3,6,5,7]',1418887445,1),(138,1,8,0,0,'[3,2,8,1,5,7,6,4]',1418887445,1),(137,1,8,0,0,'[4,2,7,3,6,1,8,5]',1418887442,1),(136,1,8,0,0,'[7,6,3,1,4,5,2,8]',1418887407,1),(135,1,8,0,0,'[1,7,3,4,8,6,5,2]',1418887405,1),(134,1,8,0,0,'[1,8,5,7,6,4,2,3]',1418887392,1),(133,1,8,0,0,'[6,8,3,2,7,5,1,4]',1418887391,1),(132,1,8,0,0,'[6,3,4,8,1,7,5,2]',1418887390,1),(131,1,8,0,0,'[2,8,4,5,3,7,6,1]',1418887243,1),(130,1,8,0,0,'[1,6,2,4,3,7,8,5]',1418887242,1),(129,1,8,0,0,'[1,7,6,5,3,8,4,2]',1418887241,1),(128,1,8,0,0,'[5,2,6,3,8,4,7,1]',1418887240,1),(127,1,8,0,0,'[7,1,3,5,4,8,2,6]',1418887239,1),(126,1,8,0,0,'[4,6,5,3,2,8,7,1]',1418887238,1),(125,1,8,0,0,'[5,2,8,1,6,4,7,3]',1418887237,1),(124,1,8,0,0,'[5,7,6,2,3,1,8,4]',1418887236,1),(123,1,8,0,0,'[7,8,4,2,6,3,1,5]',1418887235,1),(122,1,8,0,0,'[6,3,4,5,7,8,2,1]',1418887234,1),(121,1,8,0,0,'[4,3,8,1,2,6,7,5]',1418887233,1),(120,1,8,0,0,'[4,6,3,5,8,7,2,1]',1418887231,1),(119,1,8,0,0,'[1,8,7,2,3,6,5,4]',1418887230,1),(118,1,8,0,0,'[3,2,1,6,8,4,7,5]',1418887229,1),(117,1,8,0,0,'[1,2,5,8,6,4,7,3]',1418887228,1),(116,1,8,0,0,'[7,2,8,6,1,5,3,4]',1418887227,1),(115,1,8,0,0,'[7,8,4,5,3,6,1,2]',1418887226,1),(114,1,8,0,0,'[3,6,7,2,4,8,5,1]',1418887225,1),(113,1,8,0,0,'[3,7,6,4,1,5,8,2]',1418887224,1),(112,1,8,0,0,'[6,1,5,7,3,8,2,4]',1418887223,1),(111,1,8,0,0,'[4,8,7,1,2,6,3,5]',1418887222,1),(110,1,8,0,0,'[7,5,8,4,2,1,3,6]',1418887220,1),(109,1,8,0,0,'[7,2,4,5,3,6,8,1]',1418887219,1),(108,1,8,0,0,'[2,8,4,7,5,6,1,3]',1418887218,1),(107,1,8,0,0,'[5,7,2,4,6,1,3,8]',1418887217,1),(106,1,8,0,0,'[6,4,2,3,5,8,7,1]',1418887216,1),(105,1,8,0,0,'[6,8,7,1,2,5,4,3]',1418887208,1),(104,1,8,0,0,'[3,4,5,2,6,7,8,1]',1418887198,1),(103,1,8,0,0,'[2,4,1,8,3,5,6,7]',1418887171,1),(150,1,8,0,0,'[6,7,4,3,5,2,1,8]',1418955499,1),(151,1,8,0,0,'[4,2,6,3,8,5,1,7]',1418955528,1),(152,1,8,0,0,'[7,3,4,8,2,6,5,1]',1418955531,1);

/*Table structure for table `carrace_play` */

DROP TABLE IF EXISTS `carrace_play`;

CREATE TABLE `carrace_play` (
  `uid` int(10) unsigned NOT NULL,
  `cont_win_num` tinyint(1) NOT NULL,
  `force_lose_num` tinyint(1) NOT NULL,
  `lose_num` int(10) unsigned NOT NULL,
  `lose_points` int(10) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `carrace_play` */

insert  into `carrace_play`(`uid`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`create_time`,`update_time`) values (1,0,0,50,5000,1418887171,1418955531);

/*Table structure for table `find` */

DROP TABLE IF EXISTS `find`;

CREATE TABLE `find` (
  `time_right` tinyint(1) unsigned NOT NULL,
  `time_finish_mission` tinyint(1) unsigned NOT NULL,
  `time_prop_min` tinyint(1) unsigned NOT NULL,
  `time_prop_max` tinyint(1) unsigned NOT NULL,
  `time_wrong` tinyint(1) unsigned NOT NULL,
  `quick_points` int(1) unsigned NOT NULL,
  `quick_free` tinyint(1) unsigned NOT NULL,
  `quick_max` tinyint(1) unsigned NOT NULL,
  `time_points` int(1) unsigned NOT NULL,
  `time_seconds` tinyint(1) unsigned NOT NULL,
  `time_max` tinyint(1) unsigned NOT NULL,
  `mission` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `find` */

/*Table structure for table `horserace` */

DROP TABLE IF EXISTS `horserace`;

CREATE TABLE `horserace` (
  `chip` int(3) unsigned NOT NULL,
  `multiple` varchar(255) NOT NULL,
  `exclude_prob` varchar(255) NOT NULL,
  `cont_win_num` int(3) unsigned NOT NULL,
  `force_lose_num` int(3) unsigned NOT NULL,
  `lose_num` int(3) unsigned NOT NULL,
  `lose_points` int(3) unsigned NOT NULL,
  `force_win_points` int(3) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `horserace` */

insert  into `horserace`(`chip`,`multiple`,`exclude_prob`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`force_win_points`) values (100,'{\"1\":\"6\",\"2\":\"3\",\"3\":\"1\"}','{\"1\":\"99\",\"2\":\"88\",\"3\":\"77\"}',3,5,50,5000,500);

/*Table structure for table `horserace_log` */

DROP TABLE IF EXISTS `horserace_log`;

CREATE TABLE `horserace_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `rank1` int(1) unsigned NOT NULL,
  `rank2` int(1) unsigned NOT NULL,
  `rank3` int(1) unsigned NOT NULL,
  `rank` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=306 DEFAULT CHARSET=utf8;

/*Data for the table `horserace_log` */

insert  into `horserace_log`(`id`,`uid`,`rank1`,`rank2`,`rank3`,`rank`,`create_time`,`is_random`) values (149,1,8,0,0,'[3,2,7,1,6,5,8,4]',1418890077,1),(148,1,8,0,0,'[3,7,2,6,1,4,5,8]',1418890075,1),(147,1,8,0,0,'[7,4,1,5,3,2,6,8]',1418890071,1),(146,1,8,0,0,'[3,8,7,2,1,6,4,5]',1418887705,1),(145,1,8,0,0,'[4,7,1,2,3,8,6,5]',1418887704,1),(144,1,8,0,0,'[1,5,2,4,7,3,8,6]',1418887702,1),(143,1,8,0,0,'[4,6,8,3,5,7,1,2]',1418887701,1),(142,1,8,0,0,'[2,7,8,1,4,3,5,6]',1418887695,1),(141,1,8,0,0,'[4,2,6,7,5,8,1,3]',1418887450,1),(140,1,8,0,0,'[2,8,1,6,5,3,4,7]',1418887449,1),(139,1,8,0,0,'[1,4,2,8,3,6,5,7]',1418887445,1),(138,1,8,0,0,'[3,2,8,1,5,7,6,4]',1418887445,1),(137,1,8,0,0,'[4,2,7,3,6,1,8,5]',1418887442,1),(136,1,8,0,0,'[7,6,3,1,4,5,2,8]',1418887407,1),(135,1,8,0,0,'[1,7,3,4,8,6,5,2]',1418887405,1),(134,1,8,0,0,'[1,8,5,7,6,4,2,3]',1418887392,1),(133,1,8,0,0,'[6,8,3,2,7,5,1,4]',1418887391,1),(132,1,8,0,0,'[6,3,4,8,1,7,5,2]',1418887390,1),(131,1,8,0,0,'[2,8,4,5,3,7,6,1]',1418887243,1),(130,1,8,0,0,'[1,6,2,4,3,7,8,5]',1418887242,1),(129,1,8,0,0,'[1,7,6,5,3,8,4,2]',1418887241,1),(128,1,8,0,0,'[5,2,6,3,8,4,7,1]',1418887240,1),(127,1,8,0,0,'[7,1,3,5,4,8,2,6]',1418887239,1),(126,1,8,0,0,'[4,6,5,3,2,8,7,1]',1418887238,1),(125,1,8,0,0,'[5,2,8,1,6,4,7,3]',1418887237,1),(124,1,8,0,0,'[5,7,6,2,3,1,8,4]',1418887236,1),(123,1,8,0,0,'[7,8,4,2,6,3,1,5]',1418887235,1),(122,1,8,0,0,'[6,3,4,5,7,8,2,1]',1418887234,1),(121,1,8,0,0,'[4,3,8,1,2,6,7,5]',1418887233,1),(120,1,8,0,0,'[4,6,3,5,8,7,2,1]',1418887231,1),(119,1,8,0,0,'[1,8,7,2,3,6,5,4]',1418887230,1),(118,1,8,0,0,'[3,2,1,6,8,4,7,5]',1418887229,1),(117,1,8,0,0,'[1,2,5,8,6,4,7,3]',1418887228,1),(116,1,8,0,0,'[7,2,8,6,1,5,3,4]',1418887227,1),(115,1,8,0,0,'[7,8,4,5,3,6,1,2]',1418887226,1),(114,1,8,0,0,'[3,6,7,2,4,8,5,1]',1418887225,1),(113,1,8,0,0,'[3,7,6,4,1,5,8,2]',1418887224,1),(112,1,8,0,0,'[6,1,5,7,3,8,2,4]',1418887223,1),(111,1,8,0,0,'[4,8,7,1,2,6,3,5]',1418887222,1),(110,1,8,0,0,'[7,5,8,4,2,1,3,6]',1418887220,1),(109,1,8,0,0,'[7,2,4,5,3,6,8,1]',1418887219,1),(108,1,8,0,0,'[2,8,4,7,5,6,1,3]',1418887218,1),(107,1,8,0,0,'[5,7,2,4,6,1,3,8]',1418887217,1),(106,1,8,0,0,'[6,4,2,3,5,8,7,1]',1418887216,1),(105,1,8,0,0,'[6,8,7,1,2,5,4,3]',1418887208,1),(104,1,8,0,0,'[3,4,5,2,6,7,8,1]',1418887198,1),(103,1,8,0,0,'[2,4,1,8,3,5,6,7]',1418887171,1),(150,1,8,0,0,'[4,2,1,8,3,7,5,6]',1419491598,1),(151,1,8,0,0,'[2,3,4,1,7,5,6,8]',1419491660,1),(152,1,8,0,0,'[3,4,8,6,2,5,1,7]',1419491680,1),(153,1,8,0,0,'[8,2,7,6,5,3,1,4]',1419491685,0),(154,1,8,0,0,'[8,6,4,7,1,2,5,3]',1419491840,0),(155,1,8,0,0,'[8,7,1,3,5,6,2,4]',1419491856,0),(156,1,8,0,0,'[3,8,5,2,6,4,7,1]',1419491869,0),(157,1,8,0,0,'[1,4,2,5,7,6,3,8]',1419491877,0),(158,1,8,0,0,'[7,4,5,8,2,6,3,1]',1419491879,0),(159,1,8,0,0,'[2,6,7,3,8,1,5,4]',1419491942,0),(160,1,8,0,0,'[3,5,1,7,4,6,8,2]',1419491945,0),(161,1,8,0,0,'[8,1,2,4,7,5,3,6]',1419491978,0),(162,1,8,0,0,'[8,1,6,7,5,4,3,2]',1419491997,0),(163,1,8,0,0,'[8,5,4,7,6,3,2,1]',1419492012,0),(164,1,8,0,0,'[3,6,7,8,5,4,1,2]',1419493692,0),(165,1,8,0,0,'[6,7,4,5,3,8,2,1]',1419494062,0),(166,1,8,0,0,'[1,4,8,6,3,7,5,2]',1419494090,0),(167,1,8,0,0,'[1,5,4,3,6,2,7,8]',1419494160,0),(168,1,6,0,0,'[5,6,7,8,4,1,3,2]',1419494223,0),(169,1,6,0,0,'[6,1,8,4,3,5,2,7]',1419494244,0),(170,1,6,0,0,'[6,5,4,1,7,8,2,3]',1419494254,0),(171,1,6,0,0,'[6,2,4,3,1,7,8,5]',1419494256,0),(172,1,6,0,0,'[5,6,3,1,4,7,2,8]',1419494257,0),(173,1,6,0,0,'[1,8,7,5,4,2,6,3]',1419494263,0),(174,1,6,0,0,'[8,2,6,5,4,1,7,3]',1419494667,0),(175,1,6,0,0,'[1,8,5,4,2,6,7,3]',1419494682,0),(176,1,6,0,0,'[3,6,1,7,2,5,4,8]',1419494702,0),(177,1,6,0,0,'[6,5,2,3,1,8,4,7]',1419494976,0),(178,1,6,0,0,'[6,4,1,5,8,3,7,2]',1419495005,0),(179,1,6,0,0,'[6,1,7,8,3,5,2,4]',1419495017,0),(180,1,6,0,0,'[3,6,5,1,4,2,8,7]',1419495145,0),(181,1,6,0,0,'[8,2,3,1,4,6,5,7]',1419495252,0),(182,1,6,0,0,'[3,4,6,7,8,1,5,2]',1419495268,0),(183,1,6,0,0,'[4,2,7,5,8,6,3,1]',1419495455,0),(184,1,6,0,0,'[7,6,5,1,2,3,8,4]',1419495512,0),(185,1,6,0,0,'[6,1,5,2,8,4,7,3]',1419495526,0),(186,1,6,0,0,'[6,3,8,7,5,2,1,4]',1419495535,0),(187,1,6,0,0,'[6,5,2,8,1,4,7,3]',1419495566,0),(188,1,6,0,0,'[4,8,3,6,5,7,1,2]',1419495598,0),(189,1,6,0,0,'[3,8,7,2,6,5,1,4]',1419495614,0),(190,1,6,0,0,'[4,3,2,1,7,5,6,8]',1419495626,0),(191,1,6,0,0,'[1,7,3,5,8,2,4,6]',1419495643,0),(192,1,6,0,0,'[7,3,8,6,2,4,1,5]',1419495655,0),(193,1,6,0,0,'[6,2,4,5,1,3,8,7]',1419495672,0),(194,1,6,0,0,'[6,4,5,8,3,7,2,1]',1419495681,0),(195,1,6,0,0,'[6,7,3,1,2,8,4,5]',1419495699,0),(196,1,6,0,0,'[4,1,6,5,7,3,2,8]',1419495705,0),(197,1,6,0,0,'[4,3,1,7,6,2,8,5]',1419495720,0),(198,1,6,0,0,'[5,8,7,3,6,2,1,4]',1419495727,0),(199,1,6,0,0,'[8,4,2,6,7,1,3,5]',1419495738,0),(200,1,6,0,0,'[4,7,8,3,6,1,2,5]',1419495753,0),(201,1,6,0,0,'[6,5,8,7,1,4,2,3]',1419495764,0),(202,1,6,0,0,'[6,7,1,4,5,2,8,3]',1419495774,0),(203,1,6,0,0,'[6,5,7,3,8,1,4,2]',1419495904,0),(204,1,6,0,0,'[1,8,4,2,6,7,5,3]',1419495926,0),(205,1,6,0,0,'[4,7,1,2,8,5,6,3]',1419495980,0),(206,1,6,0,0,'[4,2,3,8,6,1,7,5]',1419495986,0),(207,1,6,0,0,'[5,8,3,6,4,2,1,7]',1419495998,0),(208,1,6,0,0,'[4,6,7,5,8,1,3,2]',1419496216,0),(209,1,6,0,0,'[6,1,7,5,2,8,4,3]',1419496231,0),(210,1,6,0,0,'[6,8,3,5,2,4,1,7]',1419496550,0),(211,1,6,0,0,'[6,3,2,5,1,4,7,8]',1419496563,0),(212,1,6,0,0,'[2,4,5,6,7,8,3,1]',1419496587,0),(213,1,6,0,0,'[2,7,1,5,8,3,6,4]',1419496592,0),(214,1,6,0,0,'[8,5,6,1,4,7,3,2]',1419496608,0),(215,1,6,0,0,'[1,5,3,6,4,7,2,8]',1419496612,0),(216,1,6,0,0,'[2,3,4,5,7,8,6,1]',1419496624,0),(217,1,6,0,0,'[6,4,2,5,8,3,1,7]',1419496635,0),(218,1,6,0,0,'[6,3,8,4,5,1,7,2]',1419496675,0),(219,1,6,0,0,'[6,5,8,7,2,3,1,4]',1419496679,0),(220,1,6,0,0,'[5,3,4,2,8,7,1,6]',1419496689,0),(221,1,6,0,0,'[7,4,1,8,5,3,2,6]',1419496730,0),(222,1,6,0,0,'[4,7,3,8,5,1,2,6]',1419496745,0),(223,1,6,0,0,'[4,7,8,2,6,5,3,1]',1419496755,0),(224,1,6,0,0,'[4,5,8,6,2,1,3,7]',1419496779,0),(225,1,6,0,0,'[6,5,2,3,4,8,7,1]',1419496804,0),(226,1,6,0,0,'[6,4,8,7,5,2,1,3]',1419496816,0),(227,1,6,0,0,'[6,8,5,7,2,4,1,3]',1419496834,0),(228,1,6,0,0,'[3,6,8,1,4,5,2,7]',1419496903,0),(229,1,6,0,0,'[8,5,1,6,2,7,4,3]',1419496909,0),(230,1,6,0,0,'[8,3,7,2,5,4,1,6]',1419496931,0),(231,1,6,0,0,'[1,4,6,7,5,2,8,3]',1419496947,0),(232,1,6,0,0,'[4,6,5,7,8,1,2,3]',1419496949,0),(233,1,6,0,0,'[6,4,3,7,2,8,5,1]',1419496960,0),(234,1,6,0,0,'[6,3,8,1,5,4,7,2]',1419497144,0),(235,1,6,0,0,'[6,5,7,8,4,1,3,2]',1419497152,0),(236,1,6,0,0,'[4,7,2,1,8,6,5,3]',1419497156,0),(237,1,6,0,0,'[8,6,7,2,1,4,3,5]',1419497168,0),(238,1,6,0,0,'[3,1,2,8,7,5,6,4]',1419497238,0),(239,1,6,0,0,'[8,4,2,1,5,6,7,3]',1419497305,0),(240,1,6,0,0,'[3,6,4,7,5,1,8,2]',1419497339,0),(241,1,6,0,0,'[6,3,1,7,4,2,8,5]',1419497357,0),(242,1,6,0,0,'[6,3,8,7,1,4,2,5]',1419497574,0),(243,1,6,0,0,'[6,3,5,8,2,4,7,1]',1419497937,0),(244,1,6,0,0,'[3,4,2,6,8,5,1,7]',1419497978,0),(245,1,6,0,0,'[8,3,1,4,7,6,5,2]',1419498166,0),(246,1,6,0,0,'[5,1,4,6,2,7,3,8]',1419498170,0),(247,1,6,0,0,'[8,4,7,2,1,6,3,5]',1419498380,0),(248,1,6,0,0,'[3,2,6,4,1,7,5,8]',1419498871,0),(249,1,6,0,0,'[6,5,2,3,8,7,1,4]',1419498878,0),(250,1,6,0,0,'[6,8,4,5,2,3,7,1]',1419498898,0),(251,1,6,0,0,'[6,3,5,8,2,7,4,1]',1419498930,0),(252,1,6,0,0,'[7,8,1,3,2,4,6,5]',1419498935,0),(253,1,6,0,0,'[5,1,2,8,6,7,3,4]',1419498946,0),(254,1,6,0,0,'[1,3,4,5,8,2,6,7]',1419498975,0),(255,1,6,0,0,'[2,1,6,5,7,4,8,3]',1419498997,0),(256,1,6,0,0,'[4,8,6,7,2,1,5,3]',1419499011,0),(257,1,6,0,0,'[6,3,5,8,1,2,7,4]',1419499139,0),(258,1,6,0,0,'[6,5,4,3,8,2,7,1]',1419499205,0),(259,1,6,0,0,'[6,7,5,4,8,3,2,1]',1419499208,0),(260,1,6,0,0,'[7,8,2,1,3,5,6,4]',1419499220,0),(261,1,6,0,0,'[8,7,1,4,3,5,6,2]',1420360778,0),(262,1,6,0,0,'[5,1,7,3,6,4,8,2]',1420360794,0),(263,1,6,0,0,'[2,6,5,1,4,7,8,3]',1420360806,0),(264,1,6,0,0,'[2,8,5,7,4,3,1,6]',1420360906,0),(265,1,6,0,0,'[6,2,1,4,8,7,5,3]',1420360928,0),(266,1,6,0,0,'[6,7,2,1,3,5,8,4]',1420360978,0),(267,1,6,0,0,'[6,1,2,7,8,5,3,4]',1420361027,0),(268,1,6,0,0,'[4,3,6,2,5,8,1,7]',1420361048,0),(269,1,6,0,0,'[3,6,2,5,1,7,8,4]',1420361049,0),(270,1,6,0,0,'[5,2,3,7,8,6,1,4]',1420361091,0),(271,1,6,0,0,'[2,5,8,7,3,6,1,4]',1420361114,0),(272,1,6,0,0,'[4,2,5,7,6,3,8,1]',1420361257,0),(273,1,6,0,0,'[6,5,8,3,2,1,7,4]',1420361304,0),(274,1,6,0,0,'[6,5,2,4,1,8,3,7]',1420361316,0),(275,1,6,0,0,'[6,4,3,8,2,7,1,5]',1420361525,0),(276,1,6,0,0,'[8,3,4,2,7,1,5,6]',1420361535,0),(277,1,6,0,0,'[3,8,6,7,1,5,4,2]',1420361545,0),(278,1,6,0,0,'[3,4,2,5,1,6,7,8]',1420361730,0),(279,1,6,0,0,'[1,2,8,3,6,4,5,7]',1420361735,0),(280,1,6,0,0,'[2,7,3,6,4,1,8,5]',1420362225,0),(281,1,6,0,0,'[6,7,8,5,4,1,3,2]',1420362232,0),(282,1,6,0,0,'[6,2,4,8,7,5,3,1]',1420362527,0),(283,1,6,0,0,'[6,1,2,3,4,7,8,5]',1420362532,0),(284,1,6,0,0,'[3,4,7,5,6,1,2,8]',1420362538,0),(285,1,6,0,0,'[4,6,2,3,7,5,1,8]',1420362543,0),(286,1,6,0,0,'[3,5,7,8,1,4,2,6]',1420362548,0),(287,1,6,0,0,'[3,1,7,6,4,8,5,2]',1420362554,0),(288,1,6,0,0,'[1,2,5,4,8,3,6,7]',1420362559,0),(289,1,6,0,0,'[6,2,8,3,4,1,7,5]',1420362564,0),(290,1,6,0,0,'[6,4,3,8,2,7,5,1]',1420362569,0),(291,1,6,0,0,'[6,3,5,1,4,7,2,8]',1420362575,0),(292,1,6,0,0,'[7,1,4,6,3,8,5,2]',1420362588,0),(293,1,6,0,0,'[3,4,6,1,2,7,8,5]',1420362675,0),(294,1,6,0,0,'[7,3,2,8,4,5,1,6]',1420362680,0),(295,1,6,0,0,'[3,7,8,1,4,2,5,6]',1420362685,0),(296,1,6,0,0,'[7,4,2,1,6,8,3,5]',1420362691,0),(297,1,6,0,0,'[6,4,3,2,7,1,5,8]',1420362956,0),(298,1,6,0,0,'[6,1,4,3,8,5,2,7]',1420363101,0),(299,1,6,0,0,'[6,4,7,3,8,2,5,1]',1420363118,0),(300,1,6,0,0,'[5,2,4,3,1,7,8,6]',1420363211,0),(301,1,6,0,0,'[5,2,4,7,6,3,1,8]',1420363240,0),(302,1,6,0,0,'[7,3,4,6,1,5,8,2]',1420363242,0),(303,1,6,0,0,'[7,4,8,1,3,6,2,5]',1420363249,0),(304,1,6,0,0,'[7,6,5,1,4,3,2,8]',1420363253,0),(305,1,6,0,0,'[6,2,4,7,8,3,1,5]',1420363669,0);

/*Table structure for table `horserace_play` */

DROP TABLE IF EXISTS `horserace_play`;

CREATE TABLE `horserace_play` (
  `uid` int(10) unsigned NOT NULL,
  `cont_win_num` tinyint(1) NOT NULL,
  `force_lose_num` tinyint(1) NOT NULL,
  `lose_num` int(10) unsigned NOT NULL,
  `lose_points` int(10) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `horserace_play` */

insert  into `horserace_play`(`uid`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`create_time`,`update_time`) values (1,1,0,0,14500,1418887171,1420363669);

/*Table structure for table `spot` */

DROP TABLE IF EXISTS `spot`;

CREATE TABLE `spot` (
  `initial_time` int(3) unsigned NOT NULL,
  `free_reminder` tinyint(1) unsigned NOT NULL,
  `reminder_points` int(3) unsigned NOT NULL,
  `max_reminder` tinyint(1) unsigned NOT NULL,
  `right_add_time` tinyint(1) unsigned NOT NULL,
  `wrong_sub_time` tinyint(1) unsigned NOT NULL,
  `time_chunk` tinyint(2) unsigned NOT NULL,
  `time_chunk_points` int(3) unsigned NOT NULL,
  `max_time_chunk` tinyint(1) unsigned NOT NULL,
  `mission` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `spot` */

insert  into `spot`(`initial_time`,`free_reminder`,`reminder_points`,`max_reminder`,`right_add_time`,`wrong_sub_time`,`time_chunk`,`time_chunk_points`,`max_time_chunk`,`mission`) values (120,3,100,5,1,5,10,100,5,'[{\"level\":\"10\",\"points\":\"500\"}]');

/*Table structure for table `spot_log` */

DROP TABLE IF EXISTS `spot_log`;

CREATE TABLE `spot_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `reminder_times` int(1) unsigned NOT NULL,
  `added_time` int(1) unsigned NOT NULL,
  `consume_points` int(3) unsigned NOT NULL,
  `added_points` int(3) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `update_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

/*Data for the table `spot_log` */

/*Table structure for table `turntable` */

DROP TABLE IF EXISTS `turntable`;

CREATE TABLE `turntable` (
  `free_num` tinyint(1) unsigned NOT NULL,
  `consume_points` int(3) unsigned NOT NULL,
  `range` varchar(255) NOT NULL,
  `awards` varchar(255) NOT NULL,
  `prob` varchar(255) NOT NULL,
  `max` varchar(255) NOT NULL,
  `angle` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` varchar(1000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable` */

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`,`description`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"10000\",\"2\":\"1000\",\"3\":\"200\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','assets/turntable/turntable91.png','每\"天免费转盘次数3次  每天免费转盘次数3次\r\n每天免费转盘次数3次  每天免费转盘次数3次\r\n每天免费转盘次数3次  每天免费转盘次数3次\r\n每天免费转盘次数3次  每天免费转盘次数3次\r\n每天免费转盘次数3次  每天免费转盘次数3次\r\n每天免费转盘次数3次  每天免费转盘次数3次');

/*Table structure for table `turntable_log` */

DROP TABLE IF EXISTS `turntable_log`;

CREATE TABLE `turntable_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `prize` tinyint(1) unsigned NOT NULL,
  `award` varchar(255) NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1906 DEFAULT CHARSET=utf8;

/*Data for the table `turntable_log` */

insert  into `turntable_log`(`id`,`uid`,`prize`,`award`,`create_time`,`is_random`) values (1862,1,0,'100',1418885713,1),(1861,1,0,'100',1418884670,1),(1860,1,0,'100',1418883693,1),(1859,1,0,'100',1418883678,1),(1858,1,0,'100',1418883586,1),(1857,1,3,'100',1418883575,1),(1856,1,0,'100',1418883352,1),(1855,1,0,'100',1418883349,1),(1854,1,0,'100',1418883322,1),(1853,1,0,'100',1418883239,1),(1852,1,0,'100',1418883176,1),(1851,1,0,'100',1418883112,1),(1850,1,0,'100',1418883109,1),(1849,1,0,'100',1418883097,1),(1848,1,0,'100',1418883084,1),(1847,1,0,'100',1418883053,1),(1846,1,0,'100',1418882603,1),(1845,1,3,'100',1418882584,1),(1844,1,0,'100',1418882533,1),(1843,1,0,'100',1418882495,1),(1842,1,0,'100',1418882489,1),(1841,1,0,'100',1418882408,1),(1840,1,0,'100',1418882375,1),(1839,1,0,'100',1418882369,1),(1838,1,0,'100',1418882356,1),(1837,1,0,'100',1418882352,1),(1836,1,0,'100',1418882155,1),(1835,1,3,'100',1418882151,1),(1834,1,0,'100',1418876340,1),(1833,1,0,'100',1418872461,1),(1832,1,0,'100',1418872457,1),(1831,1,3,'100',1418872366,1),(1830,1,2,'100',1418872365,0),(1829,1,0,'100',1418872365,1),(1828,1,0,'100',1418872365,1),(1827,1,0,'100',1418872365,1),(1826,1,0,'100',1418872365,1),(1825,1,0,'100',1418872365,1),(1824,1,0,'100',1418872364,1),(1823,1,0,'100',1418872364,1),(1822,1,0,'100',1418872357,1),(1821,1,0,'100',1418872356,1),(1820,1,3,'100',1418872356,1),(1819,1,0,'100',1418872356,1),(1818,1,0,'100',1418872356,1),(1817,1,0,'100',1418872356,1),(1816,1,0,'100',1418872356,1),(1815,1,0,'100',1418872356,1),(1814,1,0,'100',1418872355,1),(1813,1,0,'100',1418872355,1),(1812,1,0,'100',1418872355,1),(1811,1,0,'100',1418872355,1),(1810,1,0,'100',1418872355,1),(1809,1,0,'100',1418872355,1),(1808,1,0,'100',1418872354,1),(1807,1,3,'100',1418872354,1),(1806,1,0,'100',1418872354,1),(1805,1,0,'100',1418872354,1),(1804,1,3,'100',1418872354,1),(1803,1,0,'100',1418872354,1),(1802,1,0,'100',1418872353,1),(1801,1,0,'100',1418872353,1),(1800,1,0,'100',1418872353,1),(1799,1,0,'100',1418872353,1),(1798,1,0,'100',1418872353,1),(1797,1,0,'100',1418872353,1),(1796,1,3,'100',1418872352,1),(1795,1,0,'100',1418872352,1),(1794,1,0,'100',1418872352,1),(1793,1,0,'100',1418872352,1),(1792,1,0,'100',1418872352,1),(1791,1,0,'100',1418872352,1),(1790,1,0,'100',1418872351,1),(1789,1,0,'100',1418872351,1),(1788,1,0,'100',1418872351,1),(1787,1,0,'100',1418872351,1),(1786,1,0,'100',1418872351,1),(1785,1,0,'100',1418872351,1),(1784,1,0,'100',1418872351,1),(1783,1,0,'100',1418872350,1),(1782,1,0,'100',1418872350,1),(1781,1,0,'100',1418872350,1),(1780,1,0,'100',1418872350,1),(1779,1,0,'100',1418872350,1),(1778,1,3,'100',1418872350,1),(1777,1,2,'100',1418872350,1),(1776,1,3,'100',1418872349,1),(1775,1,0,'100',1418872349,1),(1774,1,0,'100',1418872349,1),(1773,1,3,'100',1418872349,1),(1772,1,0,'100',1418872349,1),(1771,1,0,'100',1418872349,1),(1770,1,0,'100',1418872348,1),(1769,1,0,'100',1418872348,1),(1768,1,0,'100',1418872348,1),(1767,1,0,'100',1418872348,1),(1766,1,3,'100',1418872348,1),(1765,1,0,'100',1418872348,1),(1764,1,0,'100',1418872348,1),(1763,1,0,'100',1418872347,1),(1762,1,0,'100',1418872347,1),(1761,1,0,'100',1418872347,1),(1760,1,0,'100',1418872347,1),(1759,1,0,'100',1418872347,1),(1758,1,0,'100',1418872347,1),(1757,1,0,'100',1418872346,1),(1756,1,0,'100',1418872346,1),(1755,1,0,'100',1418872346,1),(1754,1,0,'100',1418872346,1),(1753,1,0,'100',1418872346,1),(1752,1,0,'100',1418872346,1),(1751,1,0,'100',1418872346,1),(1750,1,0,'100',1418872345,1),(1749,1,0,'100',1418872345,1),(1748,1,0,'100',1418872345,1),(1747,1,0,'100',1418872345,1),(1746,1,0,'100',1418872345,1),(1745,1,0,'100',1418872345,1),(1744,1,0,'100',1418872345,1),(1743,1,0,'100',1418872344,1),(1742,1,0,'100',1418872344,1),(1741,1,1,'100',1418872344,1),(1740,1,0,'100',1418872344,1),(1739,1,0,'100',1418872344,1),(1738,1,0,'100',1418872344,1),(1737,1,0,'100',1418872344,1),(1736,1,0,'100',1418872343,1),(1735,1,0,'100',1418872343,1),(1734,1,0,'100',1418872343,1),(1733,1,3,'100',1418872343,1),(1732,1,3,'0',1418872343,1),(1731,1,0,'0',1418872343,1),(1863,1,3,'200积分',1420354073,1),(1864,1,0,'',1420354214,1),(1865,1,0,'',1420354305,1),(1866,1,0,'',1420354330,1),(1867,1,0,'',1420354351,1),(1868,1,0,'',1420354389,1),(1869,1,0,'',1420354446,1),(1870,1,0,'',1420354582,1),(1871,1,0,'',1420354616,1),(1872,1,0,'',1420354633,1),(1873,1,0,'',1420354663,1),(1874,1,0,'',1420354814,1),(1875,1,0,'',1420354830,1),(1876,1,3,'200积分',1420355002,1),(1877,1,0,'',1420355014,1),(1878,1,0,'',1420355079,1),(1879,1,0,'',1420355096,1),(1880,1,0,'',1420355161,1),(1881,1,0,'',1420440131,1),(1882,1,0,'',1420440238,1),(1883,1,3,'200积分',1420440302,1),(1884,1,0,'',1420440311,1),(1885,1,0,'',1420440490,1),(1886,1,3,'200积分',1420441642,1),(1887,1,3,'200积分',1420441644,1),(1888,1,0,'',1420441646,1),(1889,1,0,'',1420441647,1),(1890,1,0,'',1420441652,1),(1891,1,0,'',1420441655,1),(1892,1,0,'',1420441656,1),(1893,1,0,'',1420441658,1),(1894,1,0,'',1420441664,1),(1895,1,0,'',1420441670,1),(1896,1,0,'',1420441672,1),(1897,1,0,'',1420441674,1),(1898,1,0,'',1420441676,1),(1899,1,0,'',1420441683,1),(1900,1,0,'',1420441684,1),(1901,1,0,'',1420441686,1),(1902,1,0,'',1420441704,1),(1903,1,0,'',1420441705,1),(1904,1,0,'',1420441707,1),(1905,1,0,'',1420620446,1);

/*Table structure for table `turntable_play` */

DROP TABLE IF EXISTS `turntable_play`;

CREATE TABLE `turntable_play` (
  `uid` int(10) unsigned NOT NULL,
  `range` varchar(255) NOT NULL,
  `prize_num` varchar(255) NOT NULL,
  `today_num` int(3) unsigned NOT NULL,
  `create_time` int(3) unsigned NOT NULL,
  `update_time` int(3) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable_play` */

insert  into `turntable_play`(`uid`,`range`,`prize_num`,`today_num`,`create_time`,`update_time`) values (1,'\"\\\"11111111669\\\\\\\\\\\\\\\"2\\\\\\\\\\\\\\\":32,\\\\\\\\\\\\\\\"3\\\\\\\\\\\\\\\":132,\\\\\\\\\\\\\\\"4\\\\\\\\\\\\\\\":132,\\\\\\\\\\\\\\\"5\\\\\\\\\\\\\\\":132,\\\\\\\\\\\\\\\"6\\\\\\\\\\\\\\\":132,\\\\\\\\\\\\\\\"7\\\\\\\\\\\\\\\":132,\\\\\\\\\\\\\\\"8\\\\\\\\\\\\\\\":132}\\\\\\\"\\\"\"','{\"1\":0,\"2\":0,\"3\":0,\"4\":0,\"5\":0,\"6\":0,\"7\":0,\"8\":0}',1,1418872343,1420620446);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
