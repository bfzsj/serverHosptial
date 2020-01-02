/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : appointment

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2020-01-02 16:04:26
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appointment
-- ----------------------------
INSERT INTO `appointment` VALUES ('2', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '6', '14:00', '2020-01-02 12:23:42');
INSERT INTO `appointment` VALUES ('3', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '5', '14:00', '2020-01-02 13:23:55');
INSERT INTO `appointment` VALUES ('4', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '4', '10:00', '2020-01-02 15:23:17');
INSERT INTO `appointment` VALUES ('5', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '4', '15:00', '2020-01-02 15:31:59');
INSERT INTO `appointment` VALUES ('6', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '3', '09:00', '2020-01-03 09:37:03');
INSERT INTO `appointment` VALUES ('7', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '3', '10:00', '2020-01-03 10:38:40');
INSERT INTO `appointment` VALUES ('8', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '3', '11:00', '2020-01-03 11:02:30');
INSERT INTO `appointment` VALUES ('9', 'okNWP1q33S4GMoDP1zfuvW5kEAWA', '1', '2020', '1', '3', '12:00', '2020-01-03 12:03:32');

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
  PRIMARY KEY (`exid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES ('1', 'user1.jpg', '李医生', '34', '医生', '口腔治疗');

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
CREATE DEFINER=`root`@`localhost` EVENT `event_auto_del_memorydata` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-02 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL autodel()
;;
DELIMITER ;
