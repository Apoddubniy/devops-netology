### Ответ на домашнее задание к 06-06 «Troubleshooting»

1. Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты...  

* напишите список операций, которые вы будете производить для остановки запроса пользователя;

** Необходимо найти opid операции:  

`$ db.currentOp("active" : true, "secs_running" : { "$gt" : 180 }) `  

** Потом завершить ее принудительно:  

`$ db.killOp()`

* предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB. 

** Использовать метод maxTimeMS() для установки временного предела для операций.  
** Попробовать оптимизировать: добавить/удалить индексы, настроить шардинг и т.д.


2. Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL...  

При масштабировании сервиса до N реплик вы увидели, что...  
* сначала происходит рост отношения записанных значений к истекшим,  
* Redis блокирует операции записи.  

Как вы думаете, в чём может быть проблема?   

** Скорее всего, вся память занята истекшими ключами, но еще не удаленными. Redis заблокировался,
чтобы вывести из DB удаленные ключи и снизить их количество менее 25%. Т.к. Redis - однопоточное приложение, то все операции блокируются,
пока он не выполнит очистку.  

3. Вы подняли базу данных MySQL для использования в гис-системе...

* Как вы думаете, почему это начало происходить и как локализовать проблему?  

Основываясь на документации MySQL возможны три причины:  
** Слишком объемные запросы на миллионы строк, рекомендуется увеличение параметра net_read_timeout  
** Малое значение параметра connect_timeout, клиент не успевает установить соединение.  
** Размер сообщения/запроса превышает размер буфера max_allowed_packet на сервере или max_allowed_packet на стороне клиента.  

* Какие пути решения этой проблемы вы можете предложить?   

** Возможно создать индексы для оптимизации и ускорения запросов.  
** Возможно увеличить значения параметров: connect_timeout, net_read_timeout, max_allowed_packet.  
** Возможно что-то не так с аппаратным обеспечением сервера (нехватка ресурсов).  
** Возможны проблемы с сетью.

4. Вы решили перевести гис-систему из задачи 3 на PostgreSQL...  

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

`postmaster invoked oom-killer`

* Как вы думаете, что происходит?  

** Пришел Out-Of-Memory Killer и грохнул якобы не нужный процесс для хостовой системы.

* Как бы вы решили эту проблему?  

** добавить оперативной памяти на хост с БД  
** разрешить\увеличить swap (снизится быстродействие)  
** оптимизировать ресурсоёмкие запросы к БД  
** провести шардирование таблиц  
** произвести настройку параметров, затрагивающих память в Postgres: max_connections, shared_buffer, work_mem, effective_cache_size, maintenance_work_mem.