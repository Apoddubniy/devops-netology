### Ответ на домашнее задание к 06-03 «MySQL»

1. [Dockerfile](docker-mysql.yml)
* Используя Docker, поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
```commandline
[lex@chrm-centos7 mysql]$ sudo docker-compose -f docker-mysql.yml up -d
[+] Running 1/1
 ✔ Container mysql  Started                                                                                                                                    3.1s
[lex@chrm-centos7 mysql]$ sudo docker ps
CONTAINER ID   IMAGE       COMMAND                  CREATED         STATUS                  PORTS                                                  NAMES
5cf1450d9a78   mysql:8.0   "docker-entrypoint.s…"   9 seconds ago   Up Less than a second   0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 33060/tcp   mysql

```
* Изучите бэкап БД и восстановитесь из него.
```commandline
[lex@chrm-centos7 mysql]$ sudo docker exec -it mysql mysql -u root -p;
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.33 MySQL Community Server - GPL
...

mysql> create database test_db;
Query OK, 1 row affected (0.01 sec)

mysql> \q
Bye
[lex@chrm-centos7 mysql]$ sudo docker exec -it mysql sh
sh-4.4# ls /var/lib/backup/
test_dump.sql
sh-4.4# mysql -u root -p test_db < /var/lib/backup/test_dump.sql
Enter password:
sh-4.4#
```

* Перейдите в управляющую консоль mysql внутри контейнера.
```commandline
sh-4.4# mysql -u root -p
```

* Используя команду \h, получите список управляющих команд.
```commandline
mysql> \h

For information about MySQL products and services, visit:
...
For server side help, type 'help contents'


``` 

* Найдите команду для выдачи статуса БД и приведите в ответе из её вывода версию сервера БД.
 ```

mysql> \s
--------------
mysql  Ver 8.0.33 for Linux on x86_64 (MySQL Community Server - GPL)
...
Server version:         8.0.33 MySQL Community Server - GPL
...
```

* Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```commandline
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

```
 
* Приведите в ответе количество записей с price > 300.
```commandline
mysql> select count(*) from orders where price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

```
2. Создайте пользователя test в БД c паролем test-pass,...

```commandline
mysql> CREATE USER 'test'@'localhost'
          IDENTIFIED WITH mysql_native_password BY 'password'
          WITH MAX_CONNECTIONS_PER_HOUR 100
          PASSWORD EXPIRE INTERVAL 180 DAY
          FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2
          ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
Query OK, 0 rows affected (0.03 sec)

```
Предоставьте привелегии пользователю test на операции SELECT базы test_db.  
```commandline
mysql> GRANT SELECT ON test_db.* to 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.01 sec)
```
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES, получите данные по пользователю test...
```commandline

mysql> SELECT * from INFORMATION_SCHEMA.USER_ATTRIBUTES where USER = 'test';
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.01 sec)

```

3. Решение:

Установка профилирования и вывод команды:

```commandline
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
+----------+------------+-------------------+
| Query_ID | Duration   | Query             |
+----------+------------+-------------------+
|        1 | 0.00094050 | SHOW PROFILES ALL |
|        2 | 0.00057600 | SET profiling = 1 |
+----------+------------+-------------------+
2 rows in set, 1 warning (0.00 sec)


```
Исследуйте, какой engine используется в таблице БД test_db...
```commandline

mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.01 sec)

```
Измените engine...
```commandline
mysql> ALTER TABLE test_db.orders ENGINE = MyIsam;
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE test_db.orders ENGINE = innodb;
Query OK, 5 rows affected (0.04 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SHOW PROFILES;
+----------+------------+-----------------------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                                   |
+----------+------------+-----------------------------------------------------------------------------------------+
|        1 | 0.00094050 | SHOW PROFILES ALL                                                                       |
|        2 | 0.00057600 | SET profiling = 1                                                                       |
|        3 | 0.00973200 | SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES where TABLE_SCHEMA = 'test_db' |
|        4 | 0.04528625 | ALTER TABLE test_db.orders ENGINE = MyIsam                                              |
|        5 | 0.04055425 | ALTER TABLE test_db.orders ENGINE = innodb                                              |
+----------+------------+-----------------------------------------------------------------------------------------+
5 rows in set, 1 warning (0.00 sec)

```

4. Решение:

Изучите файл my.cnf в директории /etc/mysql. А вот нету его там, есть по пути /etc/my.cnf

```commandline
bash-4.4# cat /etc/my.cnf
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/

```
Вот сейчас прикрутим движок InnoDB к этому файлу в соответствии требований.

```commandline
bash-4.4# cat /etc/my.cnf
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.0/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

pid-file=/var/run/mysqld/mysqld.pid
[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/

innodb_flush_log_at_trx_commit = 0
innodb_file_format=Barracuda
innodb_log_buffer_size= 1M
key_buffer_size = 300M
max_binlog_size= 100M
```

