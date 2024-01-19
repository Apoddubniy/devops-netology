## Домашнее задание к занятию «Troubleshooting»

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
* Пооблема №1
```commandline
PS C:\Kuber\3.5> kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "web" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found
Error from server (NotFound): error when creating "https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml": namespaces "data" not found

```
Отсутсвуют необходимые неймспейсы `web`, `data`, которые описаны в файле.


3. Исправить проблему, описать, что сделано.
* * Создаем неймспейсы
```commandline
PS C:\Kuber\3.5> kubectl create ns web
namespace/web created
PS C:\Kuber\3.5> kubectl create ns data
namespace/data created

```
4. Продемонстрировать, что проблема решена.
```commandline
PS C:\Kuber\3.5> kubectl get pods -n web                                  
NAME                            READY   STATUS    RESTARTS   AGE
web-consumer-5f87765478-ktrkt   1/1     Running   0          4m28s
web-consumer-5f87765478-rk462   1/1     Running   0          4m28s
PS C:\Kuber\3.5> kubectl get pods -n data                                 
NAME                       READY   STATUS    RESTARTS   AGE
auth-db-7b5cdbdc77-2gcbs   1/1     Running   0          4m32s

```