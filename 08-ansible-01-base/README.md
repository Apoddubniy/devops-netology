### Ответ на домашнее задание к 08-01 «Введение в Ansible»

1. Решение:  
Запуск:
```commandline
ansible-playbook  -i inventory/test.yml site.yml 
```
Значение, в теории оно самое:
```commandline
TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

```
2. В файле `playbook/group_vars/all/examp.yml` изменена строчка `some_fact: all default fact`
```commandline
TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

```
3. Настроенные образы.
```commandline
lex@chrm-it-08:~/ansible/08-01/playbook$ sudo docker ps
CONTAINER ID   IMAGE                      COMMAND           CREATED          STATUS          PORTS     NAMES
35317757a47c   pycontribs/ubuntu:latest   "sleep 6000000"   4 seconds ago    Up 3 seconds              ubuntu
659020bbf046   pycontribs/centos:7        "sleep 6000000"   28 minutes ago   Up 28 minutes             centos7

```
4. Решение:
```commandline
lex@chrm-it-08:~/ansible/08-01/playbook$ sudo ansible-playbook  -i inventory/prod.yml site.yml
...
TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

```
5. Изменил файлы, что бы получить эти значения:  
В файле `playbook/group_vars/el/examp.yml` >>  `some_fact: "el default fact"`  
В файле `playbook/group_vars/deb/examp.yml` >> `some_fact: "deb default fact"`  

6. Запуск:
```commandline
TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

```
7. Выполнено:
```commandline
 lex@chrm-it-08:~/ansible/08-01/playbook$ ansible-vault encrypt group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
lex@chrm-it-08:~/ansible/08-01/playbook$ ansible-vault encrypt group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful

```
8. Вроде работает:
```commandline
 lex@chrm-it-08:~/ansible/08-01/playbook$ sudo ansible-playbook  -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************************************************
.......
PLAY RECAP ******************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
9. В теории как то так:
```commandline
lex@chrm-it-08:~/ansible/08-01/playbook$ ansible-doc -t connection local
> ANSIBLE.BUILTIN.LOCAL    (/usr/lib/python3/dist-packages/ansible/plugins/connection/local.py)

        This connection plugin allows ansible to execute tasks on the Ansible 'controller' instead of on a remote host.

NOTES:
      * The remote user is ignored, the user with which the ansible CLI was executed is used instead.


AUTHOR: ansible (@core)


```
10. Добавил строчки в prod.yml
```commandline
 local:
    hosts:
      loacalhost:
        ansible_connection: local
```
11. Выполненно:

```commandline
TASK [Print OS] *************************************************************************************************************************************************************************************************************************
ok: [loacalhost] => {
    "msg": "Linux Mint"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [loacalhost] => {
    "msg": "all default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

```
12. Сделано. Первая часть в папке `playbook-1`

### Необязательная часть

1. Расшифруйте все зашифрованные файлы с переменными:
```commandline
lex@chrm-it-08:~/ansible/08-01/playbook$ ansible-vault decrypt group_vars/el/examp.yml 
Vault password: 
Decryption successful
lex@chrm-it-08:~/ansible/08-01/playbook$ ansible-vault decrypt group_vars/deb/examp.yml 
Vault password: 
Decryption successful

```
2. Зашифруйте отдельное значение:
```commandline
---
  some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          32623537306237633733313565353961633632636331613165326335643266633836303162616436
          6161383963376561303665626233666530396639356437630a346233643263633232353338346336
          62636330326439616534663839373936646262346135616130383133383839363064393864336334
          3839323736366262390a383433373566393432346163303835376135363135376134326563306464
          3164
```
3. Запустите playbook
```commandline
lex@chrm-it-08:~/ansible/08-01/playbook$ sudo ansible-playbook  -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] *******************************************************************************************************************************************************************************************************************
........

TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [loacalhost] => {
    "msg": "PaSSw0rd"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
loacalhost                 : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```
4. Добавьте новую группу хостов fedora: и даже работает.   
В файле `inventory/prod.yml` добавлены строчки:
```commandline
  fed:
    hosts:
      fedora:
         ansible_connection: docker
```
Создан файл `playbook/group_vars/fed/examp.yml` с содержимым `  some_fact: "FRODO stole the ring"`
```commandline
TASK [Print fact] ***********************************************************************************************************************************************************************************************************************
ok: [loacalhost] => {
    "msg": "PaSSw0rd"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [fedora] => {
    "msg": "FRODO stole the ring"
}

PLAY RECAP ******************************************************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
loacalhost                 : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```
5. Скрипт.
```commandline
#!/bin/bash

docker run -d --name ubuntu pycontribs/ubuntu sleep 600000
docker run -d --name centos7 pycontribs/centos:7 sleep 600000
docker run -d --name fedora pycontribs/fedora sleep 600000

ansible-playbook -i inventory/prod.yml site.yml --vault-password-file secret.txt

docker stop $(docker ps -q)
```