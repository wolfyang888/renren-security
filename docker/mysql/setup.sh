set -x

echo '1.启动mysql....'
#启动mysql
#cp /var/lib/mysql/my.cnf /etc/my.cnf
#service mysql start
sleep 4
echo `service mysql status`
#导入数据
echo '2.导入数据....'
mysql < /var/lib/mysql/access_token.sql
mysql < /var/lib/mysql/clientconfig.sql
mysql < /var/lib/mysql/refresh_token.sql
#
echo '4.开始修改密码....'
mysql < /var/lib/mysql/privileges.sql
echo '5.修改密码完毕....'