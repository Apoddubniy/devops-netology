### Ответ на домашнее задание к 06-05 «Elasticsearch»

1. Решение:
* составьте Dockerfile-манифест для Elasticsearch:  
   [Dockerfile](Dockerfile)  
* соберите Docker-образ и сделайте push в ваш docker.io-репозиторий, пришлось вручную скачать дистрибутив с просторов интернета, для обучения подойдет, но не для другой среды.  
   [Ссылка на репозиторй](https://hub.docker.com/r/avpoddubniy/elastic_test/tags) 
* запустите контейнер из получившегося образа и выполните запрос пути /c хост-машины.  
```commandline
[lex@chrm-centos7 elastic]$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                                                                                  NAMES
b9331c878e88   elastic_test   "/elasticsearch/bin/…"   8 seconds ago   Up 6 seconds   0.0.0.0:9200->9200/tcp, :::9200->9200/tcp, 0.0.0.0:9300->9300/tcp, :::9300->9300/tcp   agitated_wilson
[lex@chrm-centos7 elastic]$ curl -X GET 'localhost:9200/'
{
  "name" : "b9331c878e88",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "0DQXks32QnmJBDaOZlZQpg",
  "version" : {
    "number" : "7.14.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "dd5a0a2acaa2045ff9624f3729fc8a6f40835aa1",
    "build_date" : "2021-07-29T20:49:32.864135063Z",
    "build_snapshot" : false,
    "lucene_version" : "8.9.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}

```

2. Решение:
* Создание индексов:
```commandline
[lex@chrm-centos7 elastic]$ curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
[lex@chrm-centos7 elastic]$ curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}'
[lex@chrm-centos7 elastic]$ curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'
```

* Список индексов:
```commandline
[lex@chrm-centos7 elastic]$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   ind-1 tVIvgYuCT-in1he3t9-smg   1   0          0            0       208b           208b
yellow open   ind-3 hJEWWYs3Rj6sGeww9lFQfA   4   2          0            0       832b           832b
yellow open   ind-2 _eGFN2YxRLCuq85-kSMgdA   2   1          0            0       416b           416b

```
* Состояние индексов:
```commandline
[lex@chrm-centos7 elastic]$  curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
[lex@chrm-centos7 elastic]$  curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
[lex@chrm-centos7 elastic]$  curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529

```
* Просмотр состояния кластера:
```commandline
[lex@chrm-centos7 elastic]$ curl -X GET 'localhost:9200/_cluster/health?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529

```
Некоторые индексы ind-2 и ind-3, находятся в состоянии yellow, т.к. у них нет реплик, в кластере всего одна нода. В таком случае кластер помечает их желтыми.

* Удаляем индексы:
```commandline
[lex@chrm-centos7 elastic]$ curl -X DELETE 'http://localhost:9200/_all'
```

3. Решение:

* Приведите в ответе запрос API и результат вызова API для создания репозитория:
```commandline
[lex@chrm-centos7 elastic]$ curl -XPUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d '{ "type": "fs", "settings": { "location": "/elasticsearch/snapshots", "compress": true} }'
{
  "acknowledged" : true
}
[lex@chrm-centos7 elastic]$ curl -X POST "localhost:9200/_snapshot/netology_backup/_verify?pretty"
{
  "nodes" : {
    "CvRE2p7NS8eXCP8xvU-vtw" : {
      "name" : "b9331c878e88"
    }
  }
}

```
* Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов:
```commandline
[lex@chrm-centos7 elastic]$  curl -X PUT localhost:9200/test -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}
[lex@chrm-centos7 elastic]$ curl -GET localhost:9200/_cat/indices?pretty
green open test UleltPsdT5mqHx6UMi2zqA 1 0 0 0 208b 208b

```
* Создаем snapshot:
```commandline
[lex@chrm-centos7 elastic]$ curl -X PUT "localhost:9200/_snapshot/netology_backup/test_snapshot?wait_for_completion=true&pretty"
{
  "snapshot" : {
    "snapshot" : "test_snapshot",
    "uuid" : "zZ8pamt_T1if3q0Dqa99dw",
    "repository" : "netology_backup",
    "version_id" : 7140099,
    "version" : "7.14.0",
    "indices" : [
      "test"
    ],
    "data_streams" : [ ],
    "include_global_state" : true,
    "state" : "SUCCESS",
    "start_time" : "2023-05-12T12:13:40.511Z",
    "start_time_in_millis" : 1683893620511,
    "end_time" : "2023-05-12T12:13:40.511Z",
    "end_time_in_millis" : 1683893620511,
    "duration_in_millis" : 0,
    "failures" : [ ],
    "shards" : {
      "total" : 1,
      "failed" : 0,
      "successful" : 1
    },
    "feature_states" : [ ]
  }
}
```
* Список файлов бекапа:
```commandline
[elasticsearch@b9331c878e88 elasticsearch]$ ls -lah /elasticsearch/snapshots/
total 24K
drwxr-xr-x. 1 elasticsearch elasticsearch  134 May 12 12:13 .
drwxr-xr-x. 1 elasticsearch elasticsearch   49 May 12 10:20 ..
-rw-r--r--. 1 elasticsearch elasticsearch  574 May 12 12:13 index-0
-rw-r--r--. 1 elasticsearch elasticsearch    8 May 12 12:13 index.latest
drwxr-xr-x. 3 elasticsearch elasticsearch   36 May 12 12:13 indices
-rw-r--r--. 1 elasticsearch elasticsearch 8.9K May 12 12:13 meta-zZ8pamt_T1if3q0Dqa99dw.dat
-rw-r--r--. 1 elasticsearch elasticsearch  300 May 12 12:13 snap-zZ8pamt_T1if3q0Dqa99dw.dat


```
* Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.  
```commandline
[lex@chrm-centos7 elastic]$ curl -XDELETE http://localhost:9200/test
{"acknowledged":true}
[lex@chrm-centos7 elastic]$ curl -XPUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d '{ "settings" : { "index": { "number_of_shards" : 1, "number_of_replicas" : 0} } }'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}
[lex@chrm-centos7 elastic]$ curl  -GET localhost:9200/_cat/indices
green open test-2 DD-M8mYFT0it-N9f8D7pVg 1 0 0 0 208b 208b

```
* Восстановите состояние кластера Elasticsearch из snapshot, созданного ранее.
```commandline
[lex@chrm-centos7 elastic]$ curl -X POST "localhost:9200/_snapshot/netology_backup/test_snapshot/_restore?pretty" -H 'Content-Type: application/json' -d' { "indices": "test"}'
{
  "accepted" : true
}

```
* Итоговый список индексов после восстановления:
```commandline
[lex@chrm-centos7 elastic]$ curl  -GET localhost:9200/_cat/indices
green open test-2 DD-M8mYFT0it-N9f8D7pVg 1 0 0 0 208b 208b
green open test   OWxTJEiqQoCjJi_suMT1MA 1 0 0 0 208b 208b
```
