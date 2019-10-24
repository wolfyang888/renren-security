-- 因为mysql版本是5.7，因此新建用户为如下命令：
-- CREATE USER 'oathAdm'@'%' IDENTIFIED BY '123456';
-- 将docker_mysql数据库的权限授权给创建的docker用户，密码为123456：
grant all on *.* to 'oathAdm'@'%' identified by '123456' with grant option;
-- 这一条命令一定要有：
flush privileges;


create database IF NOT EXISTS `oath_db` default character set utf8 collate utf8_general_ci;
USE oath_db;
#******************************************
#***************建表语句 begin*************
#******************************************
-- ----------------------------
-- Table structure for Sys_User
-- ----------------------------
DROP TABLE IF EXISTS `Sys_User`;
CREATE TABLE `Sys_User`  (
  `id` int(11) NOT NULL,
  `username` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Sys_Role
-- ----------------------------
DROP TABLE IF EXISTS `Sys_Role`;
CREATE TABLE `Sys_Role`  (
  `id` int(11) NOT NULL,
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `Sys_permission`;
CREATE TABLE `Sys_permission`  (
  `id` int(11) NOT NULL,
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user`  (
  `Sys_User_id` int(11) NOT NULL,
  `Sys_Role_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Sys_permission_role
-- ----------------------------
DROP TABLE IF EXISTS `Sys_permission_role`;
CREATE TABLE `Sys_permission_role`  (
  `id` int(11) NOT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `permission_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for Sys_pid
-- ----------------------------
DROP TABLE IF EXISTS `Sys_pid`;
CREATE TABLE `Sys_pid`  (
  `id` int(11) NOT NULL,
  `desciption` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;



#例子数据
USE oath_db;
-- ----------------------------
INSERT INTO `Sys_User` VALUES (1, 'Alex123', '$2a$04$I9Q2sDc4QGGg5WNTLmsz0.fvGv3OjoZyj81PrSFyGOqMphqfS2qKu');
INSERT INTO `Sys_User` VALUES (2, 'Adam', '$2a$04$I9Q2sDc4QGGg5WNTLmsz0.fvGv3OjoZyj81PrSFyGOqMphqfS2qKu');
INSERT INTO `Sys_Role` VALUES (1, 'ROLE_ADMIN');
INSERT INTO `Sys_Role` VALUES (2, 'ROLE_USER');
INSERT INTO `Sys_Role` VALUES (3, 'ROLE_manager');
INSERT INTO `Sys_Role` VALUES (4, 'ROLE_worker');

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES (1, 1, 1, 1);
INSERT INTO `sys_role_user` VALUES (2, 2, 2, 2);
INSERT INTO `sys_role_user` VALUES (1, 2, 2, 3);


-- ----------------------------
-- Records of Sys_permission_role
-- ----------------------------
INSERT INTO `Sys_permission_role` VALUES (1, 1, 1);
INSERT INTO `Sys_permission_role` VALUES (2, 1, 2);
INSERT INTO `Sys_permission_role` VALUES (3, 2, 3);
INSERT INTO `Sys_permission_role` VALUES (4, 2, 4);

-- ----------------------------
-- Records of Sys_pid
-- ----------------------------
INSERT INTO `Sys_pid` VALUES (1, 'signonchain');
INSERT INTO `Sys_pid` VALUES (2, '快运');

-- ----------------------------
-- Records of Sys_permission
-- ----------------------------
INSERT INTO `Sys_permission` VALUES (1, 'ROLE_READ', 'home', '/', 1);
INSERT INTO `Sys_permission` VALUES (2, 'ROLE_WRITE', 'liurf', '/admin', 1);
INSERT INTO `Sys_permission` VALUES (3, 'ROLE_READ', 'read', '/', 2);
INSERT INTO `Sys_permission` VALUES (4, 'ROLE_WRITE', 'admin', '/', 2);
