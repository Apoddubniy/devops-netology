# Домашнее задание к занятию «Компоненты Kubernetes»

### Цель задания

Рассчитать требования к кластеру под проект

### Задание. Необходимо определить требуемые ресурсы
Известно, что проекту нужны база данных, система кеширования, а само приложение состоит из бекенда и фронтенда. Опишите, какие ресурсы нужны, если известно:

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. База данных должна быть отказоустойчивой. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
3. Кеш должен быть отказоустойчивый. Потребляет 4 ГБ ОЗУ в работе, 1 ядро. 3 копии. 
4. Фронтенд обрабатывает внешние запросы быстро, отдавая статику. Потребляет не более 50 МБ ОЗУ на каждый экземпляр, 0.2 ядра. 5 копий. 
5. Бекенд потребляет 600 МБ ОЗУ и по 1 ядру на копию. 10 копий.
----

### Ответ
Необходимо произвести расчет заявленного потребления, составляем таблицу. 

| Сервис     | Memory(Mb) | CPU | Replicas | Mem | CPU |
|------------|-------|---|------|-------|-----|
| БД         | 4000  | 1 | 3    | 12 Gb | 3   |
 | Cache      | 4000  |  1 |  3 | 12 Gb | 3   |
 | Frontend   | 50 | 0.2 | 5 | 250 Mb | 1.0 |
 | Backend    | 600 | 1 | 10| 6 Gb  | 10.0 |
 | Общий итог |     |   |   | 30 250 Mb | 17 CPU |

Рабочая нагрузка расчитана, дале начинается философия:
1. `Необходимо упаковать приложение в чарт для деплоя в разные окружения.`
* * Вот тут напрашивается вопрос: как эти окружения будут деплоиться? Если сразу во все три ( dev, stage, prod), то количество ресурсов можно смело умножать на 3 и добавить 10-15% на слой управления.  
* * Еще вопрос: как приложение будет развертываться при обновлении?  Если методом Blue/Green, то необходимое количество ресурсов увеличивается многократно в определенный момент. 
2. `База данных и кеш должны быть отказоустойчивыми.` 
* * Явное разделение на отдельные ноды, как базы, так и кеша.
3. Фронтенд и Бекенд: 
* * в данном случае фронтендом можно принебречь, т.к. он особой нагрузки не несет и оставить его рядом с бекэндом.

Решения:  
* Нод должно быть минимум 3 для отказоустойчивости баз и кеша, фронтенд и бекэнд остаются на этих же нодах. И так для каждого окружения. Так же не забываем про слой управления + 10-15%. 

| Тип ноды      | Характеристики |
|---------------|----------------|
| Control plane | 6 CPU / 12Gb   |
| Control plane | 6 CPU / 12Gb   |
| Control plane | 8 CPU / 12Gb   |

Данный вариант будет иметь не большой запас по мощности для обновления приложения и обеспечит нормальное функционирование приложения (правда до выхода из строя одной из нод).  

* Другой вариант более рентабельный с точки зрения распределения ресурсов.
* * Разделим все сервисы на отдельные ноды и добавим отдельный слой управления. Так для каждого окружения.

| Тип ноды                  | Характеристики |
|---------------------------|----------------|
| БД (Worker)               | 1 CPU / 4Gb    |
| Cache  (Worker)           | 1 CPU / 4Gb    |
| Frontend+Backend (Worker) | 1 CPU / 1Gb    |
| Control plane             | 2 CPU / 2Gb    |
| Control plane             | 2 CPU / 2Gb    |
| Control plane             | 2 CPU / 2Gb    |

Плюсы такого подхода:
* получаем необходимое количество ресурсов.
* возможность добавить отдельную ноду(реплику) для каждого сервиса, не затрагивая при этом другие сервисы в этом проекте.
* отдельный слой управления (можно использовать один слой для разных окружений). 
* быстрое масштабирование  
* возможность добавить новый сервис отдельной нодой.

Минусы:
* большая нагрузка на слой управления
* возросшая нагрузка на сеть
* сложность администрирования
* сложно мониторить

Выбора нужного варианта зависит от инфраструктуры заказчика и дополнительных требований к проекту.
В первом варианте возможно разместить проект на имеющейся инфраструктуре. А второй вариант подходит больше для облака (в некоторых из них слой управления предоставляется бесплатно)