## Ответ на домашнее задание к 11-04 «Микросервисы: масштабирование»

### Задача 1

Предложите решение для обеспечения развёртывания, запуска и управления приложениями. Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:

* поддержка контейнеров;
* обеспечивать обнаружение сервисов и маршрутизацию запросов;
* обеспечивать возможность горизонтального масштабирования;
* обеспечивать возможность автоматического масштабирования;
* обеспечивать явное разделение ресурсов, доступных извне и внутри системы;
* обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т. п.

Обоснуйте свой выбор.

### Ответ

---

| Параметр\Название | OpenShift | Nomand |  Kubernetes|	Docker Swarm|
|---|---|---|---|---|
| Поддержка контейнеров | + | + | + | + |
| Обнаружение сервисов и маршрутизация запросов | + | - | + | + |
| Возможность горизонтального масштабирования | + | + | + | + |
| Возможность автоматического масштабирования | + | + | + | - |
| Явное разделение ресурсов доступных извне и внутри системы | + | + | + | - |
| Возможность конфигурировать приложения с помощью переменных среды | + | + | + | + |

Если рассуждать глобально: в требованиях нет описания для операционных систем на которых работает необходимая инфраструктура (OpenShift устанавливается только на RPM линейку), тогда выбор делаем в пользу Kebernetes, 
т.к. данное ПО, имеет ряд преимуществ: открытый исходный код, документация, полностью бесплатен, большое комьюнити и др.   
А если рассуждать по конкретней: - то всё зависит от задачи, и если есть какие-то особые требования или ситуации, можно выбрать что-то другое.