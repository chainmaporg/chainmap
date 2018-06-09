/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : chainmap

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-06-06 15:16:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `company`
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `company_info` text NOT NULL,
  `company_email` varchar(255) NOT NULL,
  `company_phone` varchar(20) NOT NULL,
  `company_site` varchar(255) NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------

-- ----------------------------
-- Table structure for `job_board`
-- ----------------------------
DROP TABLE IF EXISTS `job_board`;
CREATE TABLE `job_board` (
  `job_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `job_description` text NOT NULL,
  `job_location` varchar(255) NOT NULL,
  `job_qualifications` text NOT NULL,
  `job_length` tinyint(1) NOT NULL COMMENT '0 => not assigned, 1 => Full Time, 2 => Part-Tiime, 3 => Contract',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 => Not deleted, 1 => Deleted',
  `is_reviewer_required` tinyint(1) NOT NULL COMMENT '0 => reviewer not required. 1 => Company requires the reviewer.',
  `posting_date` datetime NOT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_board
-- ----------------------------

-- ----------------------------
-- Table structure for `job_history`
-- ----------------------------
DROP TABLE IF EXISTS `job_history`;
CREATE TABLE `job_history` (
  `job_id` int(11) NOT NULL,
  `developer_id` int(11) NOT NULL,
  `job_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 => No Action. 1 => Employer accepts applicant. 2 => Developer Starts job. 3 => Developer Stops Job. 4 => Job reviewed. 5 => Job Accepted by employer. 6 => paid',
  `job_reviewed_by` int(11) NOT NULL,
  `application_acceptance_date` datetime NOT NULL,
  `job_starting_date` datetime NOT NULL,
  `job_stoping_date` datetime NOT NULL,
  `job_reviewing_date` datetime NOT NULL,
  `job_acceptance_date` datetime NOT NULL,
  `job_payment_date` datetime NOT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of job_history
-- ----------------------------

-- ----------------------------
-- Table structure for `saved_jobs`
-- ----------------------------
DROP TABLE IF EXISTS `saved_jobs`;
CREATE TABLE `saved_jobs` (
  `user_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `saved_date` datetime NOT NULL,
  `is_saved` int(1) NOT NULL DEFAULT '1' COMMENT '1 => Job is saved. 0 => Job is not saved.',
  PRIMARY KEY (`user_id`,`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of saved_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `payment_address` varchar(255) NOT NULL DEFAULT '' COMMENT 'Not sure what should be the length of the payment address field.',
  `is_reviewer` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 => Not a reviewer, 1 => This developer is a reviewer also.',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
