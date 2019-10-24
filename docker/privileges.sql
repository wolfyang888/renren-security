-- 因为mysql版本是5.7，因此新建用户为如下命令：
-- CREATE USER 'oathAdm'@'%' IDENTIFIED BY '123456';
-- 将docker_mysql数据库的权限授权给创建的docker用户，密码为123456：
grant all on *.* to 'oathAdm'@'%' identified by '123456' with grant option;
-- 这一条命令一定要有：
flush privileges;


create database IF NOT EXISTS `renren_security` default character set utf8 collate utf8_general_ci;
USE renren_security;
#******************************************
#***************建表语句 begin*************
#******************************************



#例子数据
USE renren_security;
