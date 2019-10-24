-- DROP DATABASE if exists oath_db;
create database IF NOT EXISTS `oath_db` default character set utf8 collate utf8_general_ci;
USE oath_db;
Drop table  if exists oauth_access_token;
create table oauth_access_token (
  create_time timestamp default now(),
  token_id VARCHAR(255),
  token BLOB,
  authentication_id VARCHAR(255),
  user_name VARCHAR(255),
  client_id VARCHAR(255),
  authentication BLOB,
  refresh_token VARCHAR(255),
  index token_id_index  (token_id),
  index authentication_id_index (authentication_id),
  index user_name_index (user_name),
  index client_id_index (client_id),
  index refresh_token_index (refresh_token)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;