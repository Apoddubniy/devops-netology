### Ответ на домашнее задание к 08-03 «Использование Ansible»   

Пункты 1-4 выполнены. Готовые файлы в папке [playbook](playbook).

5. Выполнено: `ansible-lint site.yml`
```commandline
lex@chrm-it-08:~/ansible/08-03$ ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
WARNING  Listing 2 violation(s) that are fatal
yaml: wrong indentation: expected 4 but found 3 (indentation)
site.yml:46

yaml: wrong indentation: expected 9 but found 8 (indentation)
site.yml:54

You can skip specific rules or tags by adding them to your configuration file:
# .ansible-lint
warn_list:  # or 'skip_list' to silence them completely
  - yaml  # Violations reported by yamllint

Finished with 2 failure(s), 0 warning(s) on 1 files.

```
6. Выполнено: `ansible-playbook -i inventory/prod.yml site.yml --check`

<details> 
<summary>Вывод консоли</summary>

```commandline
lex@chrm-it-08:~/ansible/08-03$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***********************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:admin_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] ****************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ******************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************

TASK [Create database] ******************************************************************************************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install vector] *******************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get RPM Vector] *******************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install RPM vector] ***************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Input config Vector] **************************************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY [Install Nginx, epel, git] *********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Epel repos] ***********************************************************************************************************************************************************************************************************************
changed: [light-01]

TASK [Install soft] *********************************************************************************************************************************************************************************************************************
ok: [light-01]

PLAY [Install Lighthouse] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Get light distrib] ****************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Create light config] **************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************

TASK [FIREWALL | Add Rules] *************************************************************************************************************************************************************************************************************
skipping: [light-01]

PLAY RECAP ******************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
light-01                   : ok=6    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
</details>

7. Выполнено: `ansible-playbook -i inventory/prod.yml site.yml --diff`

<details> 
<summary>Вывод консоли</summary>

```commandline
lex@chrm-it-08:~/ansible/08-03$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***********************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:admin_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] ****************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ******************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************

TASK [Create database] ******************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] *******************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get RPM Vector] *******************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install RPM vector] ***************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Input config Vector] **************************************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY [Install Nginx, epel, git] *********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Epel repos] ***********************************************************************************************************************************************************************************************************************
--- before: /etc/yum.repos.d/epel.repo
+++ after: /etc/yum.repos.d/epel.repo
@@ -1,6 +1,6 @@
 [epel]
 async = 1
 baseurl = https://download.fedoraproject.org/pub/epel/$releasever/$basearch/
-gpgcheck = 0
+gpgcheck = 1
 name = install epel repos
 

changed: [light-01]

TASK [Install soft] *********************************************************************************************************************************************************************************************************************
ok: [light-01]

PLAY [Install Lighthouse] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Get light distrib] ****************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Create light config] **************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************

TASK [FIREWALL | Add Rules] *************************************************************************************************************************************************************************************************************
ok: [light-01]

PLAY RECAP ******************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
light-01                   : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
</details>

8. Выполнено: `ansible-playbook -i inventory/prod.yml site.yml --diff`
<details> 
<summary>Вывод консоли</summary>

```commandline
lex@chrm-it-08:~/ansible/08-03$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***********************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:admin_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib common] ****************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ******************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************

TASK [Create database] ******************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install vector] *******************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Get RPM Vector] *******************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Install RPM vector] ***************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Input config Vector] **************************************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY [Install Nginx, epel, git] *********************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Epel repos] ***********************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Install soft] *********************************************************************************************************************************************************************************************************************
ok: [light-01]

PLAY [Install Lighthouse] ***************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Get light distrib] ****************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Create light config] **************************************************************************************************************************************************************************************************************
ok: [light-01]

TASK [Flush handlers] *******************************************************************************************************************************************************************************************************************

TASK [FIREWALL | Add Rules] *************************************************************************************************************************************************************************************************************
ok: [light-01]

PLAY RECAP ******************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
light-01                   : ok=7    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-01                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
</details>

9. Составлен файл [playbook.md](playbook/playbook2.md)
10. Откоммичено