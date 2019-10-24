FROM mysql:5.7

#设置免密登录
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

#将所需文件放到容器中
COPY setup.sh /var/lib/mysql/setup.sh
COPY access_token.sql /var/lib/mysql/access_token.sql
COPY privileges.sql /var/lib/mysql/privileges.sql
COPY clientconfig.sql /var/lib/mysql/clientconfig.sql
COPY refresh_token.sql /var/lib/mysql/refresh_token.sql
#COPY user.sql /var/lib/mysql/user.sql
COPY my.cnf   /var/lib/mysql/my.cnf

#设置容器启动时执行的命令
CMD ["sh", "/var/lib/mysql/setup.sh"]