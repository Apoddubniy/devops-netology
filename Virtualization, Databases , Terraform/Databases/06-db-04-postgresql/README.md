### Ответ на домашнее задание к 06-04 «PostgreSQL»

1. [Dockerfile](docker-compose.yml)

* вывода списка БД  
```commandline
root=# \l
                             List of databases
   Name    | Owner | Encoding |  Collate   |   Ctype    | Access privileges
-----------+-------+----------+------------+------------+-------------------
 postgres  | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 root      | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root          +
           |       |          |            |            | root=CTc/root
 template1 | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root          +
           |       |          |            |            | root=CTc/root
(4 rows)

```
* подключения к БД  
```commandline
root=# \c postgres
You are now connected to database "postgres" as user "root".
```
* вывода списка таблиц  
```commandline
postgres=# \dtS
                  List of relations
   Schema   |          Name           | Type  | Owner
------------+-------------------------+-------+-------
 pg_catalog | pg_aggregate            | table | root
 pg_catalog | pg_am                   | table | root
 pg_catalog | pg_amop                 | table | root
 pg_catalog | pg_amproc               | table | root
 pg_catalog | pg_attrdef              | table | root
 pg_catalog | pg_attribute            | table | root
...
(62 rows)

```
* вывода описания содержимого таблиц  
```commandline
postgres=# \dS+ pg_am
                                  Table "pg_catalog.pg_am"
  Column   |  Type   | Collation | Nullable | Default | Storage | Stats target | Description
-----------+---------+-----------+----------+---------+---------+--------------+-------------
 oid       | oid     |           | not null |         | plain   |              |
 amname    | name    |           | not null |         | plain   |              |
 amhandler | regproc |           | not null |         | plain   |              |
 amtype    | "char"  |           | not null |         | plain   |              |
Indexes:
    "pg_am_name_index" UNIQUE, btree (amname)
    "pg_am_oid_index" UNIQUE, btree (oid)
Access method: heap

```
* выхода из psql  
```commandline
postgres=# \q
[lex@chrm-centos7 postgres]$
```

2. Решение:
* Используя psql создайте БД test_database.
```commandline
root=# CREATE DATABASE test_database;
CREATE DATABASE
root=# \l
                               List of databases
     Name      | Owner | Encoding |  Collate   |   Ctype    | Access privileges
---------------+-------+----------+------------+------------+-------------------
 postgres      | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 root          | root  | UTF8     | en_US.utf8 | en_US.utf8 |
 template0     | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root          +
               |       |          |            |            | root=CTc/root
 template1     | root  | UTF8     | en_US.utf8 | en_US.utf8 | =c/root          +
               |       |          |            |            | root=CTc/root
 test_database | root  | UTF8     | en_US.utf8 | en_US.utf8 |
(5 rows)

```
* Восстановите бэкап БД в test_database.
```commandline
[lex@chrm-centos7 db-backup]$ sudo docker exec -it postgres13 bash
root@06603e8697e7:/# psql  -d test_database < /var/lib/postgresql/db-backup/test_dump.sql
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
ERROR:  role "postgres" does not exist
CREATE SEQUENCE
ERROR:  role "postgres" does not exist
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```
* Перейдите в управляющую консоль psql внутри контейнера.
```commandline
root@06603e8697e7:/# psql -d test_database
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

test_database=# \dt
        List of relations
 Schema |  Name  | Type  | Owner
--------+--------+-------+-------
 public | orders | table | root
(1 row)

```
* Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.
```commandline
test_database=# ANALYZE verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE

```
* Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.
```commandline
test_database=# select attname, avg_width from pg_stats where tablename='orders';
 attname | avg_width
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)

```

3. Решение:

```commandline
BEGIN;
CREATE TABLE orders_1 (LIKE orders);
INSERT INTO orders_1 SELECT * FROM orders WHERE price >499;
DELETE FROM orders WHERE price >499;
CREATE TABLE orders_2 (LIKE orders);
INSERT INTO orders_2 SELECT * FROM orders WHERE price <=499;
DELETE FROM orders WHERE price <=499;
COMMIT;

BEGIN
CREATE TABLE
INSERT 0 3
DELETE 3
CREATE TABLE
INSERT 0 5
DELETE 5
COMMIT
test_database=# \dt
         List of relations
 Schema |   Name   | Type  | Owner
--------+----------+-------+-------
 public | orders   | table | root
 public | orders_1 | table | root
 public | orders_2 | table | root
(3 rows)

```
* Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?  
`Да, можно было избежать разбиения таблицы вручную, необходимо было определить тип на моменте проектирования и создания - partitioned table.`

4. Решение:
```commandline
root@06603e8697e7:/# pg_dump -U root -d test_database > /var/lib/postgresql/db-backup/dump_test_database.sql
```
* Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?  
`Для уникальности значения столбца title можно добавить строку в бэкап`
```
ALTER TABLE ONLY public.orders ADD CONSTRAINT title_unique UNIQUE (title);
```
