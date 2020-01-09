/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : appointment

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2020-01-09 18:43:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_wx_id` varchar(64) DEFAULT NULL,
  `doctorid` int(11) DEFAULT NULL COMMENT '医生ID',
  `year` int(6) DEFAULT NULL COMMENT '开始时间',
  `month` int(6) DEFAULT NULL COMMENT '结束时间',
  `day` int(6) DEFAULT NULL COMMENT '预约状态',
  `time` varchar(32) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appointment
-- ----------------------------
INSERT INTO `appointment` VALUES ('11', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '10', '14:00', '2020-01-10 14:02:15');
INSERT INTO `appointment` VALUES ('12', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '12', '10:00', '2020-01-12 10:28:58');
INSERT INTO `appointment` VALUES ('13', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '9', '10:00', '2020-01-09 10:31:47');

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `exid` int(11) NOT NULL AUTO_INCREMENT,
  `pic` varchar(32) DEFAULT NULL COMMENT '头像',
  `name` varchar(32) DEFAULT NULL COMMENT '专家名称',
  `focuson` varchar(32) DEFAULT NULL COMMENT '关注人数',
  `pos` varchar(32) DEFAULT NULL COMMENT '职位',
  `goodat` varchar(32) DEFAULT NULL COMMENT '擅长',
  `hospital` varchar(32) DEFAULT NULL,
  `disc` varchar(32) DEFAULT NULL,
  `reserve` int(6) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`exid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES ('1', 'user1.jpg', '李医生', '34', '医生', '口腔治疗', '北大附属医院', '302', '4', '李医生从事口腔正畸多年，有丰富的临床工作经验，对成人口腔正畸有很深的研究。擅长各种复杂类型成人正畸、儿童正畸等。累积正畸案例上万，有非常良好的患者口碑');
INSERT INTO `doctor` VALUES ('4', '默认头像.jpg', '124', '0', '2', '2', '2', '2', '0', '2');
INSERT INTO `doctor` VALUES ('6', '默认头像.jpg', '3', '0', '3', '3', '3', '3', '0', '3');

-- ----------------------------
-- Table structure for username
-- ----------------------------
DROP TABLE IF EXISTS `username`;
CREATE TABLE `username` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `imgUrl` varchar(255) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL,
  `wx_open_id` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of username
-- ----------------------------
INSERT INTO `username` VALUES ('1', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqUklXQeBObDaBsxxwIch8BQ1mlHlG8icX6NCOdeCVPhFM7lOtqdXdOHJN6uYpKeRNbC8QdUZceuAg/132', '桓木', '123456', '123', 'okNWP1q33S4GMoDP1zfuvW5kEAWA');

-- ----------------------------
-- Procedure structure for autodel
-- ----------------------------
DROP PROCEDURE IF EXISTS `autodel`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `autodel`()
BEGIN
     delete From appointment where DATE(create_time) <= DATE(DATE_SUB(NOW(),INTERVAL 1 day));
     END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for event_auto_del_memorydata
-- ----------------------------
DROP EVENT IF EXISTS `event_auto_del_memorydata`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `event_auto_del_memorydata` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-02 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL autodel()
;;
DELIMITER ;
