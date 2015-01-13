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
) ENGINE=MyISAM AUTO_INCREMENT=331 DEFAULT CHARSET=utf8;

/*Data for the table `horserace_log` */

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
  `description` varchar(2000) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable` */

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`,`description`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"iphone6\",\"2\":\"\\u4e00\\u7b49\\u5956\",\"3\":\"\\u4e8c\\u7b49\\u5956\",\"4\":\"\\u4e09\\u7b49\\u5956\",\"5\":\"\\u56db\\u7b49\\u5956\",\"6\":\"\\u4e94\\u7b49\\u5956\",\"7\":\"\\u516d\\u7b49\\u5956\",\"8\":\"\\u4e03\\u7b49\\u5956\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"1\",\"5\":\"1\",\"6\":\"1\",\"7\":\"1\",\"8\":\"30\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','assets/turntable/turntable91.png','测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试');

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
) ENGINE=MyISAM AUTO_INCREMENT=1916 DEFAULT CHARSET=utf8;

/*Data for the table `turntable_log` */

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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
