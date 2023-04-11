###  Ответ на домашнее задание к занятию 3 «Введение. Экосистема. Архитектура. Жизненный цикл Docker-контейнера»

1. С очень большим трудом все таки удалось это сделать:  
`docker pull avpoddubniy/hubabuba:latest`  
[Ссылка на репозиторий в Dockerhub](https://hub.docker.com/repository/docker/avpoddubniy/hubabuba/general)    


2. Ответ на сценарии:

* высоконагруженное монолитное Java веб-приложение;  
`Предпочтительней виртуальная машина или физический сервер(в зависимости от нагрузки), т.к. приложение монолитное, его необходимо переделать под микросервисы`
* Nodejs веб-приложение;  
`Возможно использовать Docker. Это веб платформа с подключаемыми внешними библиотеками.`
* мобильное приложение c версиями для Android и iOS;  
`Для мобильного приложения необходим GUI, желательно использование на виртуальной машине, но есть исключения.`
* шина данных на базе Apache Kafka;  
`Зависит от критичности данных. Если данные критичны, то лучше использовать виртуальные машины. Для некритичной информации возможно использование Docker.`
* Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;  
`Elasticsearch для продуктивного приложения - надежнее будет использовать на виртуальной машине, отказоустойчивость проще использовать на уровне кластера. Logstash и kibana можно использовать в Docker`
* мониторинг-стек на базе Prometheus и Grafana;  
`Так как данные не хранятся, то Docker будет хорошим решением.`
* MongoDB как основное хранилище данных для Java-приложения;  
`Предпочтительней виртуальная машина или физический сервер(в зависимости от нагрузки)`
* Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.  
`Docker для сервисов, виртуальные машины для базы данных и файлового хранилища.`  

3. Ответ

```commandline
vagrant@server1:~/2docker$ sudo docker run -it -d --name centos -v /data:/Data centos
```
```commandline
vagrant@server1:~/2docker$ sudo docker run -it -d --name debian -v /data:/Data debian

```
```commandline
vagrant@server1:~/2docker$ sudo docker ps
CONTAINER ID   IMAGE     COMMAND       CREATED          STATUS          PORTS     NAMES
4beeec286fc5   debian    "bash"        40 seconds ago   Up 38 seconds             debian
4ee2c3d9c3d6   centos    "/bin/bash"   2 minutes ago    Up 2 minutes              centos

```
```commandline
vagrant@server1:~/2docker$ sudo docker exec -d centos touch /Data/write_on_centos.txt
vagrant@server1:~/2docker$ ls /data
write_on_centos.txt

```
```commandline
vagrant@server1:~/2docker$ touch /data/made_in_host_file
touch: cannot touch '/data/made_in_host_file': Permission denied
vagrant@server1:~/2docker$ sudo touch /data/made_in_host_file

```
```commandline
vagrant@server1:~/2docker$ sudo docker exec -it debian bash
root@4beeec286fc5:/# ls /Data
made_in_host_file  write_on_centos.txt
root@4beeec286fc5:/# exit
exit

```

4. Собралось только с помощью этого файла [Dockerfile](Dockerfile)  
`docker pull avpoddubniy/ansible`  
[Ссылка на репозиторий в Dockerhub](https://hub.docker.com/r/avpoddubniy/ansible/tags)
