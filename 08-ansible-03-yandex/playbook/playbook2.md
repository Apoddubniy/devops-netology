Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

### Описание плейбука site.yml

Плейбук состоит из следующих PLAY:    
   * Clickhouse (1 handler, 4 tasks)    
   * Vector (1 handler, 3 tasks) 
   * Lighthouse (1 handler, 3 tasks) + Nginx

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

#### PLAY Nginx
Для установки сервиса Nginx, и прочего ПО в виде git, необходимо подключить для системы centos 7 epel репозиторий.   
PLAY состоит из следующих пунктов:
* Манипуляции производятся на хостах группы lighthouse `hosts: light` , заданные в файле inventory/prod.yml.
* С помощью pre_tasks подключаем epel репозиторий `ansible.builtin.yum_repository` с сылкой на него. 
* Следующим пунктом идет установка nginx и git с помощью модуля `ansible.builtin.yum`

#### PLAY Lighthouse
Для установки Lighthouse необходимы предустановленные сервисы из PLAY Nginx
* Манипуляции производятся на хостах группы lighthouse `hosts: light` , заданные в файле inventory/prod.yml.
* Хендлер перезапустит веб-сервер nginx (`ansible.builtin.service` /`name: nginx / state: restarted`), после оповещения об изменении конфигурации при помощи задачи `- name: Create light config`, которая из шаблона `template:` изменяет конфигурацию сервиса.
* В конфигурации шаблона [nginx.j2](templates/nginx.j2), в секцию `server` добавлена переменная `root         {{ light_path }};`, которая принимает значение из [light_path](group_vars/light/vars.yml)
* Скачивание lighthouse с помощью модуля `git`, в переменных указаны ссылки и пути:
  * Переменная `{{ light_repo }}` ссылка на репозиторий из файла [vars/light_repo](group_vars/light/vars.yml)
  * Переменная `{{ light_path }}` папка на файловой системе конечного хоста [vars/light_path](group_vars/light/vars.yml)
* Изменены правила файервола, для открытия входящих соединений на 80 (http) порт, следующей конструкцией:
```commandline
    - name: FIREWALL | Add Rules
      changed_when: false
      become: true
      shell: |
        firewall-cmd --permanent --add-service=http
        firewall-cmd --reload
```