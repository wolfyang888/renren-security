set -x

echo '1.启动mysql....'
#启动mysql
#service mysql start
/usr/local/bin/docker-entrypoint.sh mysqld &
# $! 为最后执行的后台程序的pid, mysqld 为docker-entrypoint.sh脚本中最后一个后台程序
pid="$!"
sleep 4
echo `service mysql status`
#导入数据
echo '2.导入数据mysql....'
mysql < /var/lib/mysql/privileges.sql
mysql < /var/lib/mysql/admin.sql
mysql < /var/lib/mysql/api.sql
# 等待mysqld 退出,挂住容器
wait $pid