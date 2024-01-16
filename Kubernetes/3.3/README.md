## Домашнее задание к занятию «Как работает сеть в K8s»

### Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа
1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.  

Ссылки на конфигурации:
* #### [Frontend](src/front.yml)
* #### [Backend](src/back.yml)
* #### [Cache](src/cache.yml)

2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace App.
```commandline
PS C:\Kuber\3.3\src> kubectl get pods -n app
NAME                     READY   STATUS    RESTARTS   AGE
back-c9bbf6f68-tbf4s     1/1     Running   0          113s
cache-bd6c58d5f-4kc9g    1/1     Running   0          113s
front-6d7978b6c6-bmwrr   1/1     Running   0          2m5s

```
4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.  
```commandline
PS C:\Kuber\3.3\src> kubectl get svc -n app
NAME        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
cache-svc   ClusterIP   10.233.3.238    <none>        80/TCP    2m36s
front-svc   ClusterIP   10.233.14.117   <none>        80/TCP    2m49s
svc-back    ClusterIP   10.233.21.151   <none>        80/TCP    2m36s

```
5. Продемонстрировать, что трафик разрешён и запрещён.
```commandline
PS C:\Kuber\3.3\src> kubectl exec -n app front-6d7978b6c6-bmwrr -- curl 10.233.21.151
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   137  100   137    0     0  26070      0 --:--:-- --:--:-- --:--:-- 27400
WBITT Network MultiTool (with NGINX) - back-c9bbf6f68-tbf4s - 10.233.116.2 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
PS C:\Kuber\3.3\src> kubectl exec -n app back-c9bbf6f68-tbf4s -- curl 10.233.3.238
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0WBITT Network MultiTool (with NGINX) - cache-bd6c58d5f-4kc9g - 10.233.85.194 - HTTP: 80 , HTTPS: 443 . (Formerly praqma/network-multitool)
100   139  100   139    0     0  28063      0 --:--:-- --:--:-- --:--:-- 34750
PS C:\Kuber\3.3\src> kubectl exec -n app cache-bd6c58d5f-4kc9g -- curl 10.233.14.117
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:24 --:--:--     0
PS C:\Kuber\3.3\src> kubectl exec -n app cache-bd6c58d5f-4kc9g -- curl 10.233.21.151
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:09 --:--:--     0
PS C:\Kuber\3.3\src> kubectl exec -n app back-c9bbf6f68-tbf4s -- curl 10.233.14.117 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:11 --:--:--     0
PS C:\Kuber\3.3\src> 

```


