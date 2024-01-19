## Домашнее задание к занятию «Обновление приложений»

### Задание 1. Выбрать стратегию обновления приложения и описать ваш выбор

1. Имеется приложение, состоящее из нескольких реплик, которое требуется обновить.
2. Ресурсы, выделенные для приложения, ограничены, и нет возможности их увеличить.
3. Запас по ресурсам в менее загруженный момент времени составляет 20%.
4. Обновление мажорное, новые версии приложения не умеют работать со старыми.
5. Вам нужно объяснить свой выбор стратегии обновления приложения.



### Задание 2. Обновить приложение

1. Создать deployment приложения с контейнерами nginx и multitool. Версию nginx взять 1.19. Количество реплик — 5.
```commandline
PS C:\Kuber\3.4> kubectl get pods -n kub-update
NAME                               READY   STATUS    RESTARTS   AGE
nginx-multitool-56fc658c79-58jzw   2/2     Running   0          83s
nginx-multitool-56fc658c79-5k56h   2/2     Running   0          83s
nginx-multitool-56fc658c79-6k6ws   2/2     Running   0          83s
nginx-multitool-56fc658c79-mm75s   2/2     Running   0          83s
nginx-multitool-56fc658c79-rg7xf   2/2     Running   0          83s
PS C:\Kuber\3.4> kubectl get svc -n kub-update
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)           AGE
svc-kub-update   ClusterIP   10.233.51.39   <none>        1180/TCP,80/TCP   98s

```
```commandline
PS C:\Kuber\3.4> kubectl describe pod nginx-multitool-56fc658c79-58jzw -n kub-update| findstr nginx
Name:             nginx-multitool-56fc658c79-58jzw
Labels:           app=nginx-multitool
Controlled By:  ReplicaSet/nginx-multitool-56fc658c79
  nginx:
    Image:          nginx:1.19
    Image ID:       docker.io/library/nginx@sha256:df13abe416e37eb3db4722840dd479b00ba193ac6606e7902331dcea50f4f1f2
  Normal  Scheduled  3m15s  default-scheduler  Successfully assigned kub-update/nginx-multitool-56fc658c79-58jzw to kube-master-3
  Normal  Pulled     3m12s  kubelet            Container image "nginx:1.19" already present on machine
  Normal  Created    3m12s  kubelet            Created container nginx
  Normal  Started    3m12s  kubelet            Started container nginx
```
2. Обновить версию nginx в приложении до версии 1.20, сократив время обновления до минимума. Приложение должно быть доступно.  
* Добавим строки в деплой
```commandline
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 100%
      maxUnavailable: 25%
```
* Применяем новую версию Nginx
```commandline
PS C:\Kuber\3.4> kubectl apply -f deploy.yml  
namespace/kub-update unchanged
deployment.apps/nginx-multitool configured
service/svc-kub-update unchanged
PS C:\Kuber\3.4> kubectl rollout history deployment -n kub-update
deployment.apps/nginx-multitool 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
PS C:\Kuber\3.4> kubectl get pods -n kub-update                                                    
NAME                               READY   STATUS    RESTARTS   AGE
nginx-multitool-596b9b597f-8jdff   2/2     Running   0          87s
nginx-multitool-596b9b597f-n965w   2/2     Running   0          87s
nginx-multitool-596b9b597f-wfscn   2/2     Running   0          87s
nginx-multitool-596b9b597f-wlrk2   2/2     Running   0          87s
nginx-multitool-596b9b597f-wplwp   2/2     Running   0          87s
PS C:\Kuber\3.4> kubectl describe pod nginx-multitool-596b9b597f-8jdff -n kub-update| findstr nginx
Name:             nginx-multitool-596b9b597f-8jdff
Labels:           app=nginx-multitool
Controlled By:  ReplicaSet/nginx-multitool-596b9b597f
  nginx:
    Image:          nginx:1.20
    Image ID:       docker.io/library/nginx@sha256:38f8c1d9613f3f42e7969c3b1dd5c3277e635d4576713e6453c6193e66270a6d
  Normal  Scheduled  108s  default-scheduler  Successfully assigned kub-update/nginx-multitool-596b9b597f-8jdff to kube-worker-1
  Normal  Pulled     106s  kubelet            Container image "nginx:1.20" already present on machine
  Normal  Created    105s  kubelet            Created container nginx
  Normal  Started    105s  kubelet            Started container nginx
```
3. Попытаться обновить nginx до версии 1.28, приложение должно оставаться доступным.  
* При изменении версии Nginx на 1.28 новые поды не создаются в колонке `STATUS` ошибка `ErrImagePull`
```commandline
PS C:\Kuber\3.4> kubectl get pods -n kub-update                                                    
NAME                               READY   STATUS         RESTARTS   AGE
nginx-multitool-596b9b597f-8jdff   2/2     Running        0          2m57s
nginx-multitool-596b9b597f-n965w   2/2     Running        0          2m57s
nginx-multitool-596b9b597f-wfscn   2/2     Running        0          2m57s
nginx-multitool-596b9b597f-wlrk2   2/2     Running        0          2m57s
nginx-multitool-8774d8567-7ql7b    1/2     ErrImagePull   0          10s
nginx-multitool-8774d8567-94bl6    1/2     ErrImagePull   0          10s
nginx-multitool-8774d8567-ftd29    1/2     ErrImagePull   0          10s
nginx-multitool-8774d8567-gw8hj    1/2     ErrImagePull   0          10s
nginx-multitool-8774d8567-x7ml5    1/2     ErrImagePull   0          10s
```
В логах ошибочных подов видна строчка `Failed to pull image "nginx:1.28": rpc error: code = NotFound desc = failed to pull and unpack image "docker.io/library/nginx:1.28": failed to resolve reference "docker.io/library/nginx:1.28": docker.io/library/nginx:1.28: not found`  
Ошибка заключается в отсутствии данного образа в докере.
* Приложение осталось доступным, т.к. старые поды не были уничтожены. Т.к. не создавал ingress приложение не выходит наружу кластера, но curl на сервис с нод работает
```html
core@kube-master-1 ~ $ curl 10.233.51.39:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```
4. Откатиться после неудачного обновления.  
Откатываемся на прошлую (2) версию:
```commandline
PS C:\Kuber\3.4> kubectl rollout history deployment -n kub-update
deployment.apps/nginx-multitool 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>

PS C:\Kuber\3.4> kubectl rollout undo deployment --to-revision 2 -n kub-update
deployment.apps/nginx-multitool rolled back
PS C:\Kuber\3.4> kubectl get pods -n kub-update                               
NAME                               READY   STATUS              RESTARTS   AGE
nginx-multitool-596b9b597f-8jdff   2/2     Running             0          26m
nginx-multitool-596b9b597f-n965w   2/2     Running             0          26m
nginx-multitool-596b9b597f-qsx98   0/2     ContainerCreating   0          4s
nginx-multitool-596b9b597f-wfscn   2/2     Running             0          26m
nginx-multitool-596b9b597f-wlrk2   2/2     Running             0          26m
PS C:\Kuber\3.4> 
deployment.apps/nginx-multitool 
REVISION  CHANGE-CAUSE
1         <none>
3         <none>
4         <none>

```