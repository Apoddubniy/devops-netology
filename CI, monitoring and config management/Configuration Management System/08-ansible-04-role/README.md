## Ответ на домашнее задание к 08-04 «Работа с roles»  



## Подготовка к выполнению

Пункты 1-3 выполнены:
* Репозитории созданы.
* Ключи добавлены.

## Основная часть

Ваша цель — разбить ваш playbook на отдельные roles. 

Задача — сделать roles для ClickHouse, Vector и LightHouse и написать playbook для использования этих ролей. 

Ожидаемый результат — существуют три ваших репозитория: два с roles и один с playbook.

**Что сделано:**

1. Файл создан и дополнен
2. При помощи `ansible-galaxy` скачайте себе эту роль.  
`Сделано с помощью: ansible-galaxy install -r role/requirements.yml`
7. Пункты 3-6 проделаны сразу для двух ролей `vector-role` и `lighthouse-role`
8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.  
`Помучался с гитом, но сделал: создал, выложил, оттегировал. Дважды, версия тэга v.1.1`
9. Переработайте playbook на использование roles.   
Плейбук переделан для использования ролей. Все роли подтягиваются из файла [requirements.yml](playbook/role/requirements.yml), так что заливать весь плейбук полностью на гит, не вижу смысла.

[Сыыслка на плейбук](playbook/site.yml)  
[Ссылка на репозиторий с vector](https://github.com/Apoddubniy/vector-role)  
[Ссылка на репозиторий с lighthouse](https://github.com/Apoddubniy/lighthouse-role)  

#### Описание плейбука
___
* Обновляем кэш приложений на всех хостах с помощью модуля ` ansible.builtin.yum`
* Производится установка clickhouse с помощью скачанной роли с настройками `clickhouse_dbs_custom` и `clickhouse_users_custom`
* Устанавливается с помощью роли Vector версии `vector_ver: "0.31.0"`
* Устанавливается с помощью роли Lighthouse