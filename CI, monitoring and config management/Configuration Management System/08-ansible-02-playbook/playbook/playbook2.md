Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

### Описание плейбука site.yml

Плейбук состоит из следующих PLAY:    
   * Clickhouse (1 handler, 4 tasks)    
   * Vector (1 handler, 3 tasks) 

#### PLAY Clickhouse
* Манипуляции производятся на хостах группы clickhouse `hosts: clickhouse` , заданные в файле inventory/prod.yml.  
* Хендлер, с ролью перезапуска `state: restarted` сервиса `name: clickhouse-server` с правами суперпользователя `become: true`  
* Блок задач для получения и установки дистрибутивов `clickhouse`
  * Скачивание дистрибутива с помощью модуля `ansible.builtin.get_url` по ссылкам.
  * Переменная `{{ item }}` принимает значения указанные в `playbook/group_vars/clickhouse/vars.yml` / `clickhouse_packages`
  * Переменная `{{ clickhouse_version }}` принимает значения из `playbook/group_vars/clickhouse/vars.yml` / `clickhouse_version`
  * * Задача `rescue` выполняется в случае ошибок в первой части блока. 
* С помощью модуля `ansible.builtin.yum` происходит установка скачанных пакетов.
* После установки оповещается хендлер.
* Создается БД на сервере с помощью команды `ansible.builtin.command: "clickhouse-client -q 'create database logs;'"`

#### PLAY Vector
* Манипуляции производятся на хостах группы clickhouse `hosts: vector` , заданные в файле inventory/prod.yml. 
* Хендлер, с ролью перезапуска `state: restarted` сервиса `name: vector` с правами суперпользователя `become: true`
* Скачивание дистрибутива с помощью модуля `ansible.builtin.get_url` по ссылкам.
* Переменная `{{ vector_ver }}` принимает значения указанные в `playbook/group_vars/vector/vector.yml` / `vector_ver`
* С помощью модуля `ansible.builtin.yum` происходит установка пакетов.
* С помощью модуля `template` из шаблона, прописывается конфигурация в файл `/etc/vector/vector.toml`, и добавляются права на файл `mode: "0644"`
