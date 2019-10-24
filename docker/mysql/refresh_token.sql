USE oath_db;
Drop table  if exists oauth_refresh_token;
create table oauth_refresh_token (
  create_time timestamp default now(),
  token_id VARCHAR(255),
  token BLOB,
  authentication BLOB,
  index token_id_index  (token_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;