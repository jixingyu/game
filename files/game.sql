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
) ENGINE=MyISAM AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;

/*Data for the table `horserace_log` */

insert  into `horserace_log`(`id`,`uid`,`rank1`,`rank2`,`rank3`,`rank`,`create_time`,`is_random`) values (149,1,8,0,0,'[3,2,7,1,6,5,8,4]',1418890077,1),(148,1,8,0,0,'[3,7,2,6,1,4,5,8]',1418890075,1),(147,1,8,0,0,'[7,4,1,5,3,2,6,8]',1418890071,1),(146,1,8,0,0,'[3,8,7,2,1,6,4,5]',1418887705,1),(145,1,8,0,0,'[4,7,1,2,3,8,6,5]',1418887704,1),(144,1,8,0,0,'[1,5,2,4,7,3,8,6]',1418887702,1),(143,1,8,0,0,'[4,6,8,3,5,7,1,2]',1418887701,1),(142,1,8,0,0,'[2,7,8,1,4,3,5,6]',1418887695,1),(141,1,8,0,0,'[4,2,6,7,5,8,1,3]',1418887450,1),(140,1,8,0,0,'[2,8,1,6,5,3,4,7]',1418887449,1),(139,1,8,0,0,'[1,4,2,8,3,6,5,7]',1418887445,1),(138,1,8,0,0,'[3,2,8,1,5,7,6,4]',1418887445,1),(137,1,8,0,0,'[4,2,7,3,6,1,8,5]',1418887442,1),(136,1,8,0,0,'[7,6,3,1,4,5,2,8]',1418887407,1),(135,1,8,0,0,'[1,7,3,4,8,6,5,2]',1418887405,1),(134,1,8,0,0,'[1,8,5,7,6,4,2,3]',1418887392,1),(133,1,8,0,0,'[6,8,3,2,7,5,1,4]',1418887391,1),(132,1,8,0,0,'[6,3,4,8,1,7,5,2]',1418887390,1),(131,1,8,0,0,'[2,8,4,5,3,7,6,1]',1418887243,1),(130,1,8,0,0,'[1,6,2,4,3,7,8,5]',1418887242,1),(129,1,8,0,0,'[1,7,6,5,3,8,4,2]',1418887241,1),(128,1,8,0,0,'[5,2,6,3,8,4,7,1]',1418887240,1),(127,1,8,0,0,'[7,1,3,5,4,8,2,6]',1418887239,1),(126,1,8,0,0,'[4,6,5,3,2,8,7,1]',1418887238,1),(125,1,8,0,0,'[5,2,8,1,6,4,7,3]',1418887237,1),(124,1,8,0,0,'[5,7,6,2,3,1,8,4]',1418887236,1),(123,1,8,0,0,'[7,8,4,2,6,3,1,5]',1418887235,1),(122,1,8,0,0,'[6,3,4,5,7,8,2,1]',1418887234,1),(121,1,8,0,0,'[4,3,8,1,2,6,7,5]',1418887233,1),(120,1,8,0,0,'[4,6,3,5,8,7,2,1]',1418887231,1),(119,1,8,0,0,'[1,8,7,2,3,6,5,4]',1418887230,1),(118,1,8,0,0,'[3,2,1,6,8,4,7,5]',1418887229,1),(117,1,8,0,0,'[1,2,5,8,6,4,7,3]',1418887228,1),(116,1,8,0,0,'[7,2,8,6,1,5,3,4]',1418887227,1),(115,1,8,0,0,'[7,8,4,5,3,6,1,2]',1418887226,1),(114,1,8,0,0,'[3,6,7,2,4,8,5,1]',1418887225,1),(113,1,8,0,0,'[3,7,6,4,1,5,8,2]',1418887224,1),(112,1,8,0,0,'[6,1,5,7,3,8,2,4]',1418887223,1),(111,1,8,0,0,'[4,8,7,1,2,6,3,5]',1418887222,1),(110,1,8,0,0,'[7,5,8,4,2,1,3,6]',1418887220,1),(109,1,8,0,0,'[7,2,4,5,3,6,8,1]',1418887219,1),(108,1,8,0,0,'[2,8,4,7,5,6,1,3]',1418887218,1),(107,1,8,0,0,'[5,7,2,4,6,1,3,8]',1418887217,1),(106,1,8,0,0,'[6,4,2,3,5,8,7,1]',1418887216,1),(105,1,8,0,0,'[6,8,7,1,2,5,4,3]',1418887208,1),(104,1,8,0,0,'[3,4,5,2,6,7,8,1]',1418887198,1),(103,1,8,0,0,'[2,4,1,8,3,5,6,7]',1418887171,1);

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

insert  into `horserace_play`(`uid`,`cont_win_num`,`force_lose_num`,`lose_num`,`lose_points`,`create_time`,`update_time`) values (1,0,0,47,4700,1418887171,1418890077);

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
  `image` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `turntable` */

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"10000\",\"2\":\"1000\",\"3\":\"200\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','assets/turntable/turntable10.png');

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
) ENGINE=MyISAM AUTO_INCREMENT=1863 DEFAULT CHARSET=utf8;

/*Data for the table `turntable_log` */

insert  into `turntable_log`(`id`,`uid`,`prize`,`award`,`create_time`,`is_random`) values (1862,1,0,'100',1418885713,1),(1861,1,0,'100',1418884670,1),(1860,1,0,'100',1418883693,1),(1859,1,0,'100',1418883678,1),(1858,1,0,'100',1418883586,1),(1857,1,3,'100',1418883575,1),(1856,1,0,'100',1418883352,1),(1855,1,0,'100',1418883349,1),(1854,1,0,'100',1418883322,1),(1853,1,0,'100',1418883239,1),(1852,1,0,'100',1418883176,1),(1851,1,0,'100',1418883112,1),(1850,1,0,'100',1418883109,1),(1849,1,0,'100',1418883097,1),(1848,1,0,'100',1418883084,1),(1847,1,0,'100',1418883053,1),(1846,1,0,'100',1418882603,1),(1845,1,3,'100',1418882584,1),(1844,1,0,'100',1418882533,1),(1843,1,0,'100',1418882495,1),(1842,1,0,'100',1418882489,1),(1841,1,0,'100',1418882408,1),(1840,1,0,'100',1418882375,1),(1839,1,0,'100',1418882369,1),(1838,1,0,'100',1418882356,1),(1837,1,0,'100',1418882352,1),(1836,1,0,'100',1418882155,1),(1835,1,3,'100',1418882151,1),(1834,1,0,'100',1418876340,1),(1833,1,0,'100',1418872461,1),(1832,1,0,'100',1418872457,1),(1831,1,3,'100',1418872366,1),(1830,1,2,'100',1418872365,0),(1829,1,0,'100',1418872365,1),(1828,1,0,'100',1418872365,1),(1827,1,0,'100',1418872365,1),(1826,1,0,'100',1418872365,1),(1825,1,0,'100',1418872365,1),(1824,1,0,'100',1418872364,1),(1823,1,0,'100',1418872364,1),(1822,1,0,'100',1418872357,1),(1821,1,0,'100',1418872356,1),(1820,1,3,'100',1418872356,1),(1819,1,0,'100',1418872356,1),(1818,1,0,'100',1418872356,1),(1817,1,0,'100',1418872356,1),(1816,1,0,'100',1418872356,1),(1815,1,0,'100',1418872356,1),(1814,1,0,'100',1418872355,1),(1813,1,0,'100',1418872355,1),(1812,1,0,'100',1418872355,1),(1811,1,0,'100',1418872355,1),(1810,1,0,'100',1418872355,1),(1809,1,0,'100',1418872355,1),(1808,1,0,'100',1418872354,1),(1807,1,3,'100',1418872354,1),(1806,1,0,'100',1418872354,1),(1805,1,0,'100',1418872354,1),(1804,1,3,'100',1418872354,1),(1803,1,0,'100',1418872354,1),(1802,1,0,'100',1418872353,1),(1801,1,0,'100',1418872353,1),(1800,1,0,'100',1418872353,1),(1799,1,0,'100',1418872353,1),(1798,1,0,'100',1418872353,1),(1797,1,0,'100',1418872353,1),(1796,1,3,'100',1418872352,1),(1795,1,0,'100',1418872352,1),(1794,1,0,'100',1418872352,1),(1793,1,0,'100',1418872352,1),(1792,1,0,'100',1418872352,1),(1791,1,0,'100',1418872352,1),(1790,1,0,'100',1418872351,1),(1789,1,0,'100',1418872351,1),(1788,1,0,'100',1418872351,1),(1787,1,0,'100',1418872351,1),(1786,1,0,'100',1418872351,1),(1785,1,0,'100',1418872351,1),(1784,1,0,'100',1418872351,1),(1783,1,0,'100',1418872350,1),(1782,1,0,'100',1418872350,1),(1781,1,0,'100',1418872350,1),(1780,1,0,'100',1418872350,1),(1779,1,0,'100',1418872350,1),(1778,1,3,'100',1418872350,1),(1777,1,2,'100',1418872350,1),(1776,1,3,'100',1418872349,1),(1775,1,0,'100',1418872349,1),(1774,1,0,'100',1418872349,1),(1773,1,3,'100',1418872349,1),(1772,1,0,'100',1418872349,1),(1771,1,0,'100',1418872349,1),(1770,1,0,'100',1418872348,1),(1769,1,0,'100',1418872348,1),(1768,1,0,'100',1418872348,1),(1767,1,0,'100',1418872348,1),(1766,1,3,'100',1418872348,1),(1765,1,0,'100',1418872348,1),(1764,1,0,'100',1418872348,1),(1763,1,0,'100',1418872347,1),(1762,1,0,'100',1418872347,1),(1761,1,0,'100',1418872347,1),(1760,1,0,'100',1418872347,1),(1759,1,0,'100',1418872347,1),(1758,1,0,'100',1418872347,1),(1757,1,0,'100',1418872346,1),(1756,1,0,'100',1418872346,1),(1755,1,0,'100',1418872346,1),(1754,1,0,'100',1418872346,1),(1753,1,0,'100',1418872346,1),(1752,1,0,'100',1418872346,1),(1751,1,0,'100',1418872346,1),(1750,1,0,'100',1418872345,1),(1749,1,0,'100',1418872345,1),(1748,1,0,'100',1418872345,1),(1747,1,0,'100',1418872345,1),(1746,1,0,'100',1418872345,1),(1745,1,0,'100',1418872345,1),(1744,1,0,'100',1418872345,1),(1743,1,0,'100',1418872344,1),(1742,1,0,'100',1418872344,1),(1741,1,1,'100',1418872344,1),(1740,1,0,'100',1418872344,1),(1739,1,0,'100',1418872344,1),(1738,1,0,'100',1418872344,1),(1737,1,0,'100',1418872344,1),(1736,1,0,'100',1418872343,1),(1735,1,0,'100',1418872343,1),(1734,1,0,'100',1418872343,1),(1733,1,3,'100',1418872343,1),(1732,1,3,'0',1418872343,1),(1731,1,0,'0',1418872343,1);

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

insert  into `turntable_play`(`uid`,`range`,`prize_num`,`today_num`,`create_time`,`update_time`) values (1,'{\"1\":132,\"2\":32,\"3\":132,\"4\":132,\"5\":132,\"6\":132,\"7\":132,\"8\":132}','{\"1\":1,\"2\":2,\"3\":14,\"4\":0,\"5\":0,\"6\":0,\"7\":0,\"8\":0}',132,1418872343,1418885713);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
