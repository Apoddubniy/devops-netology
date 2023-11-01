## Ответ на домашнее задание к 12-01 «Kubernetes. Причины появления. Команда kubectl»

### Задание 1. Установка MicroK8S
* Установить MicroK8S на локальную машину или на удалённую виртуальную машину.
```commandline
admin1@ubuntu-srv:~$ microk8s status
microk8s is running
high-availability: no
  datastore master nodes: 127.0.0.1:19001
  datastore standby nodes: none
addons:
  enabled:
    dns                  # (core) CoreDNS
    ha-cluster           # (core) Configure high availability on the current node
    helm                 # (core) Helm - the package manager for Kubernetes
    helm3                # (core) Helm 3 - the package manager for Kubernetes
  disabled:
    cert-manager         # (core) Cloud native certificate management
    community            # (core) The community addons repository
    dashboard            # (core) The Kubernetes dashboard
    gpu                  # (core) Automatic enablement of Nvidia CUDA
    host-access          # (core) Allow Pods connecting to Host services smoothly
    hostpath-storage     # (core) Storage class; allocates storage from host directory
    ingress              # (core) Ingress controller for external access
    kube-ovn             # (core) An advanced network fabric for Kubernetes
    mayastor             # (core) OpenEBS MayaStor
    metallb              # (core) Loadbalancer for your Kubernetes cluster
    metrics-server       # (core) K8s Metrics Server for API access to service metrics
    minio                # (core) MinIO object storage
    observability        # (core) A lightweight observability stack for logs, traces and metrics
    prometheus           # (core) Prometheus operator for monitoring and logging
    rbac                 # (core) Role-Based Access Control for authorisation
    registry             # (core) Private image registry exposed on localhost:32000
    storage              # (core) Alias to hostpath-storage add-on, deprecated

```
* Установить dashboard.  
```bash
admin1@ubuntu-srv:~$ microk8s enable dashboard
Infer repository core for addon dashboard
Enabling Kubernetes Dashboard
Infer repository core for addon metrics-server
Enabling Metrics-Server
serviceaccount/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
service/metrics-server created
deployment.apps/metrics-server created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
clusterrolebinding.rbac.authorization.k8s.io/microk8s-admin created
Metrics-Server is enabled
Applying manifest
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created
secret/microk8s-dashboard-token created

If RBAC is not enabled access the dashboard using the token retrieved with:

microk8s kubectl describe secret -n kube-system microk8s-dashboard-token

Use this token in the https login UI of the kubernetes-dashboard service.

In an RBAC enabled setup (microk8s enable RBAC) you need to create a user with restricted
permissions as shown in:
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

```
* Сгенерировать сертификат для подключения к внешнему ip-адресу.
```commandline
admin1@ubuntu-srv:~$ microk8s kubectl describe secret  -n kube-system microk8s-dashboard-token
Name:         microk8s-dashboard-token
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 41255fb0-1c55-480b-8b0d-d56aaabf5d55

Type:  kubernetes.io/service-account-token

Data
====
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IkplYW5BbkhDblR5LVRQdUtYT0MydlFHem5aTnptNUUzYnZWTnZVdF85WVEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtaWNyb2s4cy1kYXNoYm9hcmQtdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjQxMjU1ZmIwLTFjNTUtNDgwYi04YjBkLWQ1NmFhYWJmNWQ1NSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkZWZhdWx0In0.kU8QY84du5SLFLxSefsRyykRTnVwBHQz-Icnv-Bh1GjVQs7T5ynM2A53_1mFKWH7xASjz1FSMi0HK_Z-gHOQJvG5lWGIIMU8MdOtVt4XKOttIAMstzHNiopnNWNBpN01iL18fAZ2bGz5cy_Q9hQ8Zo8m2eEq_JdQFpY2eTrgnzKWA8QRHBZsssQRHtjucvCnz3nX2z_Ywi_zOqVJAjdpqUXQWvGc3I7R912hYGQlrHm2UJsm5y80n8eyVQto6sIdvd-wL8LSa7faUW_3mCjt7OOo9TAWgTse9zFHY-lvrDOBa8on_XSN7FpYvquSuQ8b-6hPgLenEpQQULw9q97xOw
ca.crt:     1123 bytes
namespace:  11 bytes


```

### Задание 2. Установка и настройка локального kubectl
* Установить на локальную машину kubectl.
На этом этапе пока что так...
```commandline
lex@chrm-it-08:~$ kubectl version
Client Version: v1.28.3
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
The connection to the server localhost:8080 was refused - did you specify the right host or port?

```
* Настроить локально подключение к кластеру.  
Для отображения дашборда на другой машине используем следующую команду с пробросом порта на внешний адрес:  
`microk8s kubectl port-forward --address 192.168.1.127 -n kube-system service/kubernetes-dashboard 10443:443`
* Подключиться к дашборду с помощью port-forward.
![Skrin](img/02-03.jpg)