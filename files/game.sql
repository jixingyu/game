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
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8;

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

insert  into `turntable`(`free_num`,`consume_points`,`range`,`awards`,`prob`,`max`,`angle`,`image`) values (3,100,'{\"1\":\"1000\",\"2\":\"100\",\"3\":\"\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"10000\",\"2\":\"1000\",\"3\":\"200\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"0.1\",\"2\":\"0.9\",\"3\":\"10\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"10\",\"2\":\"50\",\"3\":\"500\",\"4\":\"\",\"5\":\"\",\"6\":\"\",\"7\":\"\",\"8\":\"\"}','{\"1\":\"30\",\"2\":\"30\",\"3\":\"30\",\"4\":\"30\",\"5\":\"30\",\"6\":\"30\",\"7\":\"30\",\"8\":\"30\",\"0\":\"30\"}','');

/*Table structure for table `turntable_log` */

DROP TABLE IF EXISTS `turntable_log`;

CREATE TABLE `turntable_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `prize` tinyint(1) unsigned NOT NULL,
  `consume_points` int(3) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `is_random` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1834 DEFAULT CHARSET=utf8;

/*Data for the table `turntable_log` */

insert  into `turntable_log`(`id`,`uid`,`prize`,`consume_points`,`create_time`,`is_random`) values (1833,1,0,100,1418872461,1),(1832,1,0,100,1418872457,1),(1831,1,3,100,1418872366,1),(1830,1,2,100,1418872365,0),(1829,1,0,100,1418872365,1),(1828,1,0,100,1418872365,1),(1827,1,0,100,1418872365,1),(1826,1,0,100,1418872365,1),(1825,1,0,100,1418872365,1),(1824,1,0,100,1418872364,1),(1823,1,0,100,1418872364,1),(1822,1,0,100,1418872357,1),(1821,1,0,100,1418872356,1),(1820,1,3,100,1418872356,1),(1819,1,0,100,1418872356,1),(1818,1,0,100,1418872356,1),(1817,1,0,100,1418872356,1),(1816,1,0,100,1418872356,1),(1815,1,0,100,1418872356,1),(1814,1,0,100,1418872355,1),(1813,1,0,100,1418872355,1),(1812,1,0,100,1418872355,1),(1811,1,0,100,1418872355,1),(1810,1,0,100,1418872355,1),(1809,1,0,100,1418872355,1),(1808,1,0,100,1418872354,1),(1807,1,3,100,1418872354,1),(1806,1,0,100,1418872354,1),(1805,1,0,100,1418872354,1),(1804,1,3,100,1418872354,1),(1803,1,0,100,1418872354,1),(1802,1,0,100,1418872353,1),(1801,1,0,100,1418872353,1),(1800,1,0,100,1418872353,1),(1799,1,0,100,1418872353,1),(1798,1,0,100,1418872353,1),(1797,1,0,100,1418872353,1),(1796,1,3,100,1418872352,1),(1795,1,0,100,1418872352,1),(1794,1,0,100,1418872352,1),(1793,1,0,100,1418872352,1),(1792,1,0,100,1418872352,1),(1791,1,0,100,1418872352,1),(1790,1,0,100,1418872351,1),(1789,1,0,100,1418872351,1),(1788,1,0,100,1418872351,1),(1787,1,0,100,1418872351,1),(1786,1,0,100,1418872351,1),(1785,1,0,100,1418872351,1),(1784,1,0,100,1418872351,1),(1783,1,0,100,1418872350,1),(1782,1,0,100,1418872350,1),(1781,1,0,100,1418872350,1),(1780,1,0,100,1418872350,1),(1779,1,0,100,1418872350,1),(1778,1,3,100,1418872350,1),(1777,1,2,100,1418872350,1),(1776,1,3,100,1418872349,1),(1775,1,0,100,1418872349,1),(1774,1,0,100,1418872349,1),(1773,1,3,100,1418872349,1),(1772,1,0,100,1418872349,1),(1771,1,0,100,1418872349,1),(1770,1,0,100,1418872348,1),(1769,1,0,100,1418872348,1),(1768,1,0,100,1418872348,1),(1767,1,0,100,1418872348,1),(1766,1,3,100,1418872348,1),(1765,1,0,100,1418872348,1),(1764,1,0,100,1418872348,1),(1763,1,0,100,1418872347,1),(1762,1,0,100,1418872347,1),(1761,1,0,100,1418872347,1),(1760,1,0,100,1418872347,1),(1759,1,0,100,1418872347,1),(1758,1,0,100,1418872347,1),(1757,1,0,100,1418872346,1),(1756,1,0,100,1418872346,1),(1755,1,0,100,1418872346,1),(1754,1,0,100,1418872346,1),(1753,1,0,100,1418872346,1),(1752,1,0,100,1418872346,1),(1751,1,0,100,1418872346,1),(1750,1,0,100,1418872345,1),(1749,1,0,100,1418872345,1),(1748,1,0,100,1418872345,1),(1747,1,0,100,1418872345,1),(1746,1,0,100,1418872345,1),(1745,1,0,100,1418872345,1),(1744,1,0,100,1418872345,1),(1743,1,0,100,1418872344,1),(1742,1,0,100,1418872344,1),(1741,1,1,100,1418872344,1),(1740,1,0,100,1418872344,1),(1739,1,0,100,1418872344,1),(1738,1,0,100,1418872344,1),(1737,1,0,100,1418872344,1),(1736,1,0,100,1418872343,1),(1735,1,0,100,1418872343,1),(1734,1,0,100,1418872343,1),(1733,1,3,100,1418872343,1),(1732,1,3,0,1418872343,1),(1731,1,0,0,1418872343,1);

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

insert  into `turntable_play`(`uid`,`range`,`prize_num`,`today_num`,`create_time`,`update_time`) values (1,'{\"1\":103,\"2\":3,\"3\":103,\"4\":103,\"5\":103,\"6\":103,\"7\":103,\"8\":103}','{\"1\":1,\"2\":2,\"3\":11,\"4\":0,\"5\":0,\"6\":0,\"7\":0,\"8\":0}',103,1418872343,1418872461);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
