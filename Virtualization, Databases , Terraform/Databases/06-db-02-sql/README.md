### Ответ на домашнее задание к 06-02 «SQL»

1. [Dockerfile](docker-compose.yml)

2. В БД из задачи 1:  

* создайте пользователя test-admin-user и БД test_db;  
```commandline
root=# create database test_db;
CREATE DATABASE
```
```commandline
root=# create user "test-admin-user" with password 'postgres';
CREATE ROLE

```
* в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже);
```commandline
test_db=> CREATE TABLE orders (id integer, name text, price integer, PRIMARY KEY (id));
CREATE TABLE
test_db=> CREATE TABLE clients (id integer PRIMARY KEY, lastname text, country text, booking integer, FOREIGN KEY (booking) REFERENCES orders (Id));
CREATE TABLE
```
* предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db;  
```commandline
test_db=# GRANT ALL PRIVILEGES ON DATABASE test_db to "test-admin-user";
GRANT
```
* создайте пользователя test-simple-user;
```commandline
test_db=# create user "test-simple-user" with password 'postgres';
CREATE ROLE
```
* предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE этих таблиц БД test_db.  
```commandline
test_db=# GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
GRANT

```
Приведите:

* итоговый список БД после выполнения пунктов выше;
```commandline
test_db=# \l
                                  List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    |     Access privileges
-----------+-------+----------+------------+------------+----------------------------
 postgres  | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 root      | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root                   +
           |       |          |            |            | root=CTc/root
 template1 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root                   +
           |       |          |            |            | root=CTc/root
 test_db   | root  | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/root                  +
           |       |          |            |            | root=CTc/root             +
           |       |          |            |            | "test-admin-user"=CTc/root
(5 rows)

```
* описание таблиц (describe);
```commandline
test_db=# \d+
                           List of relations
 Schema |  Name   | Type  |      Owner      |    Size    | Description
--------+---------+-------+-----------------+------------+-------------
 public | clients | table | test-admin-user | 8192 bytes |
 public | orders  | table | test-admin-user | 8192 bytes |
(2 rows)

```
* SQL-запрос для выдачи списка пользователей с правами над таблицами test_db;
```commandline
test_db=# SELECT * FROM information_schema.role_table_grants WHERE grantee IN ('test-simple-user');
     grantor     |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
-----------------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 test-admin-user | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 test-admin-user | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 test-admin-user | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
(8 rows)

```
* список пользователей с правами над таблицами test_db.
```commandline
test_db=# \du
                                       List of roles
    Role name     |                         Attributes                         | Member of
------------------+------------------------------------------------------------+-----------
 root             | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  |                                                            | {}
 test-simple-user |                                                            | {}


```
3. Используя SQL-синтаксис, наполните таблицы следующими тестовыми данными:

```commandline
test_db=# insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5

```
```commandline
test_db=# insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович','Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5

```
Используя SQL-синтаксис:

вычислите количество записей для каждой таблицы.
Приведите в ответе:

- запросы,
- результаты их выполнения.  
```commandline
test_db=> SELECT count (*) FROM orders;
 count
-------
     5
(1 row)

test_db=> SELECT count (*) FROM clients;
 count
-------
     5
(1 row)

```
4. Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys, свяжите записи из таблиц, согласно таблице:

```commandline

test_db=> UPDATE clients SET booking = 3 WHERE id = 1;
UPDATE 1
test_db=> UPDATE clients SET booking = 4 WHERE id = 2;
UPDATE 1
test_db=> UPDATE clients SET booking = 5 WHERE id = 3;
UPDATE 1
test_db=> SELECT lastname ФИО, orders.name Заказ FROM clients INNER JOIN orders ON
orders.id = clients.booking;
         ФИО          |  Заказ
----------------------+---------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
(3 rows)

```
5. Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4

```commandline
test_db=> EXPLAIN SELECT lastname ФИО, orders.name Заказ FROM clients INNER JOIN orders ON orders.id = clients.booking;
                              QUERY PLAN
-----------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=64)
   Hash Cond: (clients.booking = orders.id)
   ->  Seq Scan on clients  (cost=0.00..18.10 rows=810 width=36)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=36)
         ->  Seq Scan on orders  (cost=0.00..22.00 rows=1200 width=36)
(5 rows)

```
Результат - время выполнения всего запроса, а так же время создание связи и сбора запроса в таблицу для вывода.

* cost,   
`Это значение оценки затратности операции. Первое значение 0.00 — затраты на получение первой строки. Второе — 18.10 — затраты на получение всех строк.`
* rows,   
` Это приблизительное количество возвращаемых строк при выполнении операции.`
* width,   
`Это средний размер одной строки в байтах`
* seq scan,  
`последовательное, блок за блоком, чтение данных таблицы`
* hash join,   
`Хэш-соединение, используется для того, чтобы объединить 2 набора строк.`
* hash cond  
`Показывает хеш-соеденение таблиц, одна из таблиц хешируется в памяти.`

6. Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. задачу 1).

Остановите контейнер с PostgreSQL, но не удаляйте volumes.

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```commandline
[lex@chrm-centos7 docker]$ sudo docker exec -t 37e550fdda20 pg_dump -U root test_db -f /var/lib/postgresql/db-backup/dump_test_db.sql
[lex@chrm-centos7 docker]$ sudo docker-compose down
[+] Running 2/2
 ✔ Container postgres12    Removed                                                                                                                             0.6s
 ✔ Network docker_default  Removed   
[lex@chrm-centos7 docker]$ sudo rm -r db-data/
[lex@chrm-centos7 docker]$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
[lex@chrm-centos7 docker]$ sudo docker-compose up
[+] Running 2/2
 ✔ Network docker_default  Created                                                                                                                             0.9s
 ✔ Container postgres12    Created                                                                                                                                0.0s
Attaching to postgres12
...
postgres12  | 2023-04-17 12:28:24.281 UTC [1] LOG:  database system is ready to accept connections
[lex@chrm-centos7 docker]$ sudo docker ps
CONTAINER ID   IMAGE         COMMAND                  CREATED              STATUS              PORTS                                       NAMES
8d95931400e9   postgres:12   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:5442->5432/tcp, :::5442->5432/tcp   postgres12
[lex@chrm-centos7 docker]$ sudo docker exec -it 8d95931400e9 psql
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.
root=# create database test_db;
CREATE DATABASE
root=# create user "test-admin-user" with password 'postgres';
CREATE ROLE
root=# GRANT ALL PRIVILEGES ON DATABASE test_db to "test-admin-user";
GRANT
root=# create user "test-simple-user" with password 'postgres';
CREATE ROLE
root=# GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
GRANT
root=# exit
[lex@chrm-centos7 docker]$ sudo docker exec -t 8d95931400e9  psql  -U root -d test_db -f /var/lib/postgresql/db-backup/dump_test_db.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE TABLE
ALTER TABLE
COPY 5
COPY 5
ALTER TABLE
ALTER TABLE
ALTER TABLE
GRANT
GRANT
[lex@chrm-centos7 docker]$ sudo docker exec -it 8d95931400e9 psql -U test-admin-user -d test_db
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

test_db=> \l
                                  List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    |     Access privileges
-----------+-------+----------+------------+------------+----------------------------
 postgres  | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 root      | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root                   +
           |       |          |            |            | root=CTc/root
 template1 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root                   +
           |       |          |            |            | root=CTc/root
 test_db   | root  | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/root                  +
           |       |          |            |            | root=CTc/root             +
           |       |          |            |            | "test-admin-user"=CTc/root
(5 rows)

test_db=> \du
                                       List of roles
    Role name     |                         Attributes                         | Member of
------------------+------------------------------------------------------------+-----------
 root             | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  |                                                            | {}
 test-simple-user |                                                            | {}

test_db=> SELECT lastname ФИО, orders.name Заказ FROM clients INNER JOIN orders ON orders.id = clients.booking;
         ФИО          |  Заказ
----------------------+---------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
(3 rows)

test_db=> exit
```
