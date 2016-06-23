SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

-- Create user and database
create database `sspanel_db`;
create user 'ss-panel'@'localhost' identified by 'ss-panel-passwd!@#';
create user 'ss-panel'@'%' identified by 'ss-panel-passwd!@#';
grant all privileges on sspanel_db.* to 'ss-panel'@'localhost';
grant all privileges on sspanel_db.* to 'ss-panel'@'%';

use sspanel_db;

-- Create syntax for TABLE 'email_verifies'
CREATE TABLE `email_verifies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(32) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expire_at` datetime NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'invite_codes'
CREATE TABLE `invite_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(128) NOT NULL,
  `user_id` int(11) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)

) ENGINE=InnoDB AUTO_INCREMENT=6021 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'nodes'
CREATE TABLE `nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `cata` int(3) NOT NULL,
  `server` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `method` varchar(64) CHARACTER SET utf8mb4 NOT NULL,
  `custom_method` tinyint(1) NOT NULL DEFAULT '0',
  `traffic_rate` float NOT NULL DEFAULT '1',
  `info` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `status` varchar(128) CHARACTER SET utf8mb4 NOT NULL DEFAULT '可用',
  `offset` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'password_resets'
CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(32) CHARACTER SET latin1 NOT NULL,
  `token` varchar(128) CHARACTER SET latin1 NOT NULL,
  `expire_at` datetime NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user'
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(128) CHARACTER SET utf8mb4 NOT NULL,
  `email` varchar(32) NOT NULL,
  `pass` varchar(64) NOT NULL,
  `passwd` varchar(64) NOT NULL DEFAULT '',
  `t` int(11) NOT NULL DEFAULT '0',
  `u` bigint(20) NOT NULL DEFAULT '0',
  `d` bigint(20) NOT NULL DEFAULT '0',
  `transfer_enable` bigint(20) NOT NULL DEFAULT '5368709120',
  `port` int(11) NOT NULL,
  `switch` tinyint(4) NOT NULL DEFAULT '1',
  `enable` tinyint(4) NOT NULL DEFAULT '1',
  `type` tinyint(4) NOT NULL DEFAULT '1',
  `last_get_gift_time` int(11) NOT NULL DEFAULT '0',
  `last_check_in_time` int(11) NOT NULL DEFAULT '0',
  `last_rest_pass_time` int(11) NOT NULL DEFAULT '0',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invite_num` int(8) NOT NULL DEFAULT '0',
  `is_admin` int(2) NOT NULL DEFAULT '0',
  `ref_by` int(11) NOT NULL DEFAULT '0',
  `expire_time` int(11) NOT NULL DEFAULT '0',
  `method` varchar(64) NOT NULL DEFAULT 'rc4-md5',
  `is_email_verify` tinyint(4) NOT NULL DEFAULT '0',
  `reg_ip` varchar(128) NOT NULL DEFAULT '127.0.0.1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `ux_port` (`port`)

) ENGINE=InnoDB AUTO_INCREMENT=1270 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_comments'
CREATE TABLE `user_comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(256) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `user_name` varchar(50) NOT NULL DEFAULT '',
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_tokens'
CREATE TABLE `user_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(256) NOT NULL,
  `user_id` int(11) NOT NULL,
  `expired_at` datetime NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'user_traffic_logs'
CREATE TABLE `user_traffic_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `u` bigint(11) NOT NULL,
  `d` bigint(11) NOT NULL,
  `traffic` bigint(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  `rate` float NOT NULL,
  `log_at` datetime NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=2400 DEFAULT CHARSET=utf8;

-- Create syntax for TABLE 'site_configs'
CREATE TABLE `site_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) NOT NULL,
  `value` text NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)

) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
