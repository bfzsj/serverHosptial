/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : appointment

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2019-11-07 13:53:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for appointment
-- ----------------------------
DROP TABLE IF EXISTS `appointment`;
CREATE TABLE `appointment` (
  `id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL COMMENT '角色ID',
  `doctorid` int(11) DEFAULT NULL COMMENT '医生ID',
  `startTime` varchar(32) DEFAULT NULL COMMENT '开始时间',
  `endTime` varchar(32) DEFAULT NULL COMMENT '结束时间',
  `status` varchar(32) DEFAULT NULL COMMENT '预约状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appointment
-- ----------------------------

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor` (
  `exid` int(11) NOT NULL,
  `pic` varchar(32) DEFAULT NULL COMMENT '头像',
  `name` varchar(32) DEFAULT NULL COMMENT '专家名称',
  `foucson` varchar(32) DEFAULT NULL COMMENT '关注人数',
  `pos` varchar(32) DEFAULT NULL COMMENT '职位',
  `goodat` varchar(32) DEFAULT NULL COMMENT '擅长',
  PRIMARY KEY (`exid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doctor
-- ----------------------------

-- ----------------------------
-- Table structure for username
-- ----------------------------
DROP TABLE IF EXISTS `username`;
CREATE TABLE `username` (
  `id` int(32) NOT NULL,
  `username` varchar(32) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `phone` varchar(11) DEFAULT NULL,
  `wx_open_id` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of username
-- ----------------------------
