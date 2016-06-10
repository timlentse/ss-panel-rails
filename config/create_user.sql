drop database if exists `sspanel_timlen_db`;
create database `sspanel_timlen_db`;
drop user 'ss-timlen'@'localhost';
drop user 'ss-timlen'@'%';
create user 'ss-timlen'@'localhost' identified by 'ss-timlen-passwd!@#';
create user 'ss-timlen'@'%' identified by 'ss-timlen-passwd!@#';
grant all privileges on sspanel_timlen_db.* to 'ss-timlen'@'localhost';
grant all privileges on sspanel_timlen_db.* to 'ss-timlen'@'%';
