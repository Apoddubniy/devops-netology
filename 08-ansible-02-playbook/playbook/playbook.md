Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
## Плейбук site.yml используюется для установки на хосты ClickHouse и Vector.

Плейбук состоит из PLAY:  
    * Clickhouse (1 handler, 4 tasks)    
    * Vector (1 handler, 3 tasks) 

### **Play Clickhouse**
* Скачиваются пакеты для установки выбранной версии
    * версия ПО задается в переменной `{{clickhouse_version}}` в файле `./playbook/group_vars/clickhouse/vars.yml`
    * состав пакетов указан в значении `with_items: "{{ clickhouse_packages }}"` и подставляется зачение через `{{item}}` в цикле
      ```bash
      ansible.builtin.get_url:
            url: "https://packages.clickhouse.com/rpm/stable/{{ item }}-{{ clickhouse_version }}.noarch.rpm"
            dest: "./{{ item }}-{{ clickhouse_version }}.rpm"
      with_items: "{{ clickhouse_packages }}"
      ```
      
* Пакеты сохраняются для последующей установки в домашней папке пользователя.
* Производится установка пакетов
* По завершении установки пакетов происходит перезапуск службы `clickhouse-server`
* Создается база данных `logs`

* ### **Play Vector**  
* Проверяется его наличие ПО в системе.
* Если ПО установлено, топ перезапускается служба `Vector`
* Скачивается установочный пакет необходимой версии Vector
    * версия ПО задается в переменной `./playbook/group_vars/vector/vars.yml`  
* Устанавливается скачанный пакет.
* Прописывается конфигурация из шаблона по пути /etc/vector/vector.toml



   

