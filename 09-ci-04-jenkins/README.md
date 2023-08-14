## Ответ на домашнее задание к 09-04 «Jenkins»  


#### Основная часть

---
1. Сделать Freestyle Job, который будет запускать molecule test из любого вашего репозитория с ролью.

![Скрин](files/01-01.jpg)

<details>
<summary>Лог задания</summary>

```commandline
Started by user admin
Running as SYSTEM
Building remotely on node-125 (linux) in workspace /opt/jenkins_agent/workspace/vector-role
The recommended git tool is: NONE
No credentials specified
Cloning the remote Git repository
Cloning repository https://github.com/Apoddubniy/vector-role.git
 > git init /opt/jenkins_agent/workspace/vector-role # timeout=10
Fetching upstream changes from https://github.com/Apoddubniy/vector-role.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git fetch --tags --force --progress -- https://github.com/Apoddubniy/vector-role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/Apoddubniy/vector-role.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
Checking out Revision 702805b3ab698322d938f0b1bbadd94fb38bf37d (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 702805b3ab698322d938f0b1bbadd94fb38bf37d # timeout=10
Commit message: "Fix9"
First time build. Skipping changelog.
[vector-role] $ /bin/sh -xe /tmp/jenkins16522599724808772555.sh
+ molecule test -s docker
[31mWARNING [0m Driver docker does not provide a schema.
[34mINFO    [0m docker scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
[34mINFO    [0m Performing prerun with [33mrole_name_check[0m=[1;36m0[0m[33m...[0m
[34mINFO    [0m Set [33mANSIBLE_LIBRARY[0m=[35m/root/.cache/ansible-compat/f5bcd7/[0m[95mmodules[0m:[35m/root/.ansible/plugins/[0m[95mmodules[0m:[35m/usr/share/ansible/plugins/[0m[95mmodules[0m
[34mINFO    [0m Set [33mANSIBLE_COLLECTIONS_PATH[0m=[35m/root/.cache/ansible-compat/f5bcd7/[0m[95mcollections[0m:[35m/root/.ansible/[0m[95mcollections[0m:[35m/usr/share/ansible/[0m[95mcollections[0m
[34mINFO    [0m Set [33mANSIBLE_ROLES_PATH[0m=[35m/root/.cache/ansible-compat/f5bcd7/[0m[95mroles[0m:[35m/root/.ansible/[0m[95mroles[0m:[35m/usr/share/ansible/[0m[95mroles[0m:[35m/etc/ansible/[0m[95mroles[0m
[34mINFO    [0m Using [35m/root/.cache/ansible-compat/f5bcd7/roles/[0m[95mvector.vector[0m symlink to current repository in order to enable Ansible to find the role using its expected full name.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdependency[0m
[31mWARNING [0m Skipping, missing the requirements file.
[31mWARNING [0m Skipping, missing the requirements file.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdestroy[0m
[34mINFO    [0m Sanity checks: [32m'docker'[0m

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).[0m
[32mok: [localhost] => (item=centos7)[0m

TASK [Delete docker networks(s)] ***********************************************
[36mskipping: [localhost][0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=3   [0m [33mchanged=1   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32msyntax[0m

playbook: /opt/jenkins_agent/workspace/vector-role/molecule/docker/converge.yml
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcreate[0m

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Log into a Docker registry] **********************************************
[36mskipping: [localhost] => (item=None) [0m
[36mskipping: [localhost][0m

TASK [Check presence of custom Dockerfiles] ************************************
[32mok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m

TASK [Create Dockerfiles from image names] *************************************
[36mskipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m
[36mskipping: [localhost][0m

TASK [Synchronization the context] *********************************************
[36mskipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m
[36mskipping: [localhost][0m

TASK [Discover local Docker images] ********************************************
[32mok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})[0m

TASK [Build an Ansible compatible image (new)] *********************************
[36mskipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7) [0m
[36mskipping: [localhost][0m

TASK [Create docker network(s)] ************************************************
[36mskipping: [localhost][0m

TASK [Determine the CMD directives] ********************************************
[32mok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m

TASK [Create molecule instance(s)] *********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) creation to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).[0m
[33mchanged: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j962848261568.16246', 'results_file': '/root/.ansible_async/j962848261568.16246', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item'})[0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=6   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=5   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mprepare[0m
[31mWARNING [0m Skipping, prepare playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mconverge[0m

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[32mok: [centos7][0m

TASK [Include vector] **********************************************************

TASK [vector-role : install *.rpm] *********************************************
[36mincluded: /opt/jenkins_agent/workspace/vector-role/tasks/rpm.yml for centos7[0m

TASK [vector-role : Get RPM Vector] ********************************************
[33mchanged: [centos7][0m

TASK [vector-role : Install RPM vector] ****************************************
[33mchanged: [centos7][0m

TASK [vector-role : Input config Vector] ***************************************
[33mchanged: [centos7][0m

TASK [vector-role : install *.deb] *********************************************
[36mskipping: [centos7][0m

PLAY RECAP *********************************************************************
[33mcentos7[0m                    : [32mok=5   [0m [33mchanged=3   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32midempotence[0m

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[32mok: [centos7][0m

TASK [Include vector] **********************************************************

TASK [vector-role : install *.rpm] *********************************************
[36mincluded: /opt/jenkins_agent/workspace/vector-role/tasks/rpm.yml for centos7[0m

TASK [vector-role : Get RPM Vector] ********************************************
[32mok: [centos7][0m

TASK [vector-role : Install RPM vector] ****************************************
[32mok: [centos7][0m

TASK [vector-role : Input config Vector] ***************************************
[32mok: [centos7][0m

TASK [vector-role : install *.deb] *********************************************
[36mskipping: [centos7][0m

PLAY RECAP *********************************************************************
[32mcentos7[0m                    : [32mok=5   [0m changed=0    unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Idempotence completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mside_effect[0m
[31mWARNING [0m Skipping, side effect playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mverify[0m
[34mINFO    [0m Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
[32mok: [centos7] => {[0m
[32m    "changed": false,[0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

TASK [Check config file] *******************************************************
[33mchanged: [centos7][0m

PLAY RECAP *********************************************************************
[33mcentos7[0m                    : [32mok=2   [0m [33mchanged=1   [0m unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[34mINFO    [0m Verifier completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdestroy[0m

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).[0m
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Delete docker networks(s)] ***********************************************
[36mskipping: [localhost][0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=3   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Pruning extra files from scenario ephemeral directory
Finished: SUCCESS
```
</details>

2. Сделать Declarative Pipeline Job, который будет запускать molecule test из любого вашего репозитория с ролью.

![pipeline](files/02-01.jpg)

```commandline
pipeline {
    agent {
        label 'pipeline'
    }
    stages {
        stage('Git') {
            steps{
                git branch: 'master', url: 'https://github.com/Apoddubniy/vector-role.git'
            }
        }
        stage ('Molecule version'){
            steps {
                sh 'molecule --version'
            }
        }
        stage('Molecule test'){
            steps{
                sh 'molecule test -s docker'
                cleanWs()
            }
        }
    }
}
```

<details>
<summary>Лог пайплайна</summary>

```commandline
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on node-125 in /opt/jenkins_agent/workspace/pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git)
[Pipeline] git
The recommended git tool is: NONE
No credentials specified
Cloning the remote Git repository
Cloning repository https://github.com/Apoddubniy/vector-role.git
 > git init /opt/jenkins_agent/workspace/pipeline # timeout=10
Fetching upstream changes from https://github.com/Apoddubniy/vector-role.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git fetch --tags --force --progress -- https://github.com/Apoddubniy/vector-role.git +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
Checking out Revision 702805b3ab698322d938f0b1bbadd94fb38bf37d (refs/remotes/origin/master)
Commit message: "Fix9"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Molecule version)
[Pipeline] sh
+ molecule --version
 > git config remote.origin.url https://github.com/Apoddubniy/vector-role.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 702805b3ab698322d938f0b1bbadd94fb38bf37d # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b master 702805b3ab698322d938f0b1bbadd94fb38bf37d # timeout=10
molecule [32m5.1.0[0m using python [1;36m3.9[0m 
    [33mansible[0m[2m:[0m[1;36m2.15.2[0m
    [33mdelegated[0m[2m:[0m[1;36m5.1.0[0m[2m from molecule[0m
    [33mdocker[0m[2m:[0m[1;36m2.1.0[0m[2m from molecule_docker requiring collections: [0m[2;33mcommunity.docker[0m[2m>=[0m[1;2;36m3.0.2[0m[2m [0m[2;33mansible.posix[0m[2m>=[0m[1;2;36m1.4.0[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Molecule test)
[Pipeline] sh
+ molecule test -s docker
[31mWARNING [0m Driver docker does not provide a schema.
[34mINFO    [0m docker scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
[34mINFO    [0m Performing prerun with [33mrole_name_check[0m=[1;36m0[0m[33m...[0m
[34mINFO    [0m Set [33mANSIBLE_LIBRARY[0m=[35m/root/.cache/ansible-compat/23bf0d/[0m[95mmodules[0m:[35m/root/.ansible/plugins/[0m[95mmodules[0m:[35m/usr/share/ansible/plugins/[0m[95mmodules[0m
[34mINFO    [0m Set [33mANSIBLE_COLLECTIONS_PATH[0m=[35m/root/.cache/ansible-compat/23bf0d/[0m[95mcollections[0m:[35m/root/.ansible/[0m[95mcollections[0m:[35m/usr/share/ansible/[0m[95mcollections[0m
[34mINFO    [0m Set [33mANSIBLE_ROLES_PATH[0m=[35m/root/.cache/ansible-compat/23bf0d/[0m[95mroles[0m:[35m/root/.ansible/[0m[95mroles[0m:[35m/usr/share/ansible/[0m[95mroles[0m:[35m/etc/ansible/[0m[95mroles[0m
[34mINFO    [0m Using [35m/root/.cache/ansible-compat/23bf0d/roles/[0m[95mvector.vector[0m symlink to current repository in order to enable Ansible to find the role using its expected full name.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdependency[0m
[31mWARNING [0m Skipping, missing the requirements file.
[31mWARNING [0m Skipping, missing the requirements file.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdestroy[0m
[34mINFO    [0m Sanity checks: [32m'docker'[0m

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).[0m
[32mok: [localhost] => (item=centos7)[0m

TASK [Delete docker networks(s)] ***********************************************
[36mskipping: [localhost][0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=3   [0m [33mchanged=1   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32msyntax[0m

playbook: /opt/jenkins_agent/workspace/pipeline/molecule/docker/converge.yml
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcreate[0m

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Log into a Docker registry] **********************************************
[36mskipping: [localhost] => (item=None) [0m
[36mskipping: [localhost][0m

TASK [Check presence of custom Dockerfiles] ************************************
[32mok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m

TASK [Create Dockerfiles from image names] *************************************
[36mskipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m
[36mskipping: [localhost][0m

TASK [Synchronization the context] *********************************************
[36mskipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m
[36mskipping: [localhost][0m

TASK [Discover local Docker images] ********************************************
[32mok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})[0m

TASK [Build an Ansible compatible image (new)] *********************************
[36mskipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7) [0m
[36mskipping: [localhost][0m

TASK [Create docker network(s)] ************************************************
[36mskipping: [localhost][0m

TASK [Determine the CMD directives] ********************************************
[32mok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m

TASK [Create molecule instance(s)] *********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) creation to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).[0m
[33mchanged: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j491230279447.28937', 'results_file': '/root/.ansible_async/j491230279447.28937', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item'})[0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=6   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=5   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mprepare[0m
[31mWARNING [0m Skipping, prepare playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mconverge[0m

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[32mok: [centos7][0m

TASK [Include vector] **********************************************************

TASK [vector-role : install *.rpm] *********************************************
[36mincluded: /opt/jenkins_agent/workspace/vector-role/tasks/rpm.yml for centos7[0m

TASK [vector-role : Get RPM Vector] ********************************************
[33mchanged: [centos7][0m

TASK [vector-role : Install RPM vector] ****************************************
[33mchanged: [centos7][0m

TASK [vector-role : Input config Vector] ***************************************
[33mchanged: [centos7][0m

TASK [vector-role : install *.deb] *********************************************
[36mskipping: [centos7][0m

PLAY RECAP *********************************************************************
[33mcentos7[0m                    : [32mok=5   [0m [33mchanged=3   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32midempotence[0m

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[32mok: [centos7][0m

TASK [Include vector] **********************************************************

TASK [vector-role : install *.rpm] *********************************************
[36mincluded: /opt/jenkins_agent/workspace/vector-role/tasks/rpm.yml for centos7[0m

TASK [vector-role : Get RPM Vector] ********************************************
[32mok: [centos7][0m

TASK [vector-role : Install RPM vector] ****************************************
[32mok: [centos7][0m

TASK [vector-role : Input config Vector] ***************************************
[32mok: [centos7][0m

TASK [vector-role : install *.deb] *********************************************
[36mskipping: [centos7][0m

PLAY RECAP *********************************************************************
[32mcentos7[0m                    : [32mok=5   [0m changed=0    unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Idempotence completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mside_effect[0m
[31mWARNING [0m Skipping, side effect playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mverify[0m
[34mINFO    [0m Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
[32mok: [centos7] => {[0m
[32m    "changed": false,[0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

TASK [Check config file] *******************************************************
[33mchanged: [centos7][0m

PLAY RECAP *********************************************************************
[33mcentos7[0m                    : [32mok=2   [0m [33mchanged=1   [0m unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[34mINFO    [0m Verifier completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdestroy[0m

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).[0m
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Delete docker networks(s)] ***********************************************
[36mskipping: [localhost][0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=3   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Pruning extra files from scenario ephemeral directory
[Pipeline] cleanWs
[WS-CLEANUP] Deleting project workspace...
[WS-CLEANUP] Deferred wipeout is used...
[WS-CLEANUP] done
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```
</details>

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

### [Ссылка на репозиторий с Jenkinsfile](https://github.com/Apoddubniy/vector-role/blob/master/Jenkinsfile)

4. Создать Multibranch Pipeline на запуск Jenkinsfile из репозитория.

![Скрин multipypeline](files/04-01.jpg)

<details>
<summary>Find log</summary>

```commandline
Started by user admin
[Mon Aug 14 05:43:00 EDT 2023] Starting branch indexing...
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git ls-remote --symref -- https://github.com/Apoddubniy/vector-role # timeout=10
 > git rev-parse --resolve-git-dir /var/lib/jenkins/caches/git-0cb5c8cd1f822474722619e92a256c29/.git # timeout=10
Setting origin to https://github.com/Apoddubniy/vector-role
 > git config remote.origin.url https://github.com/Apoddubniy/vector-role # timeout=10
Fetching & pruning origin...
Listing remote references...
 > git config --get remote.origin.url # timeout=10
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git ls-remote -h -- https://github.com/Apoddubniy/vector-role # timeout=10
Fetching upstream changes from origin
 > git config --get remote.origin.url # timeout=10
 > git fetch --tags --force --progress --prune -- origin +refs/heads/*:refs/remotes/origin/* # timeout=10
Checking branches...
  Checking branch master
      ‘Jenkinsfile’ found
    Met criteria
Changes detected: master (ceed7a3062336f25fe081c1469a536b35fa0ef5d → 08a27948efda77f13c1af99d7c1f1f7c31d4773b)
Scheduled build for branch: master
Processed 1 branches
[Mon Aug 14 05:43:02 EDT 2023] Finished branch indexing. Indexing took 1.9 sec
Finished: SUCCESS

```
</details>

<details>
<summary>Work log</summary>

```commandline
Branch indexing
 > git rev-parse --resolve-git-dir /var/lib/jenkins/caches/git-0cb5c8cd1f822474722619e92a256c29/.git # timeout=10
Setting origin to https://github.com/Apoddubniy/vector-role
 > git config remote.origin.url https://github.com/Apoddubniy/vector-role # timeout=10
Fetching origin...
Fetching upstream changes from origin
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git config --get remote.origin.url # timeout=10
 > git fetch --tags --force --progress -- origin +refs/heads/*:refs/remotes/origin/* # timeout=10
Seen branch in repository origin/master
Seen 1 remote branch
Obtained Jenkinsfile from 08a27948efda77f13c1af99d7c1f1f7c31d4773b
[Pipeline] Start of Pipeline
[Pipeline] node
Running on node-125 in /opt/jenkins_agent/workspace/Multi-pipeline_master
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
Cloning the remote Git repository
Cloning with configured refspecs honoured and without tags
Avoid second fetch
Checking out Revision 08a27948efda77f13c1af99d7c1f1f7c31d4773b (master)
Cloning repository https://github.com/Apoddubniy/vector-role
 > git init /opt/jenkins_agent/workspace/Multi-pipeline_master # timeout=10
Fetching upstream changes from https://github.com/Apoddubniy/vector-role
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git fetch --no-tags --force --progress -- https://github.com/Apoddubniy/vector-role +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/Apoddubniy/vector-role # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 08a27948efda77f13c1af99d7c1f1f7c31d4773b # timeout=10
Commit message: "Fix Jenkinsfile"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Molecule version)
[Pipeline] sh
+ molecule --version
molecule [32m5.1.0[0m using python [1;36m3.9[0m 
    [33mansible[0m[2m:[0m[1;36m2.15.2[0m
    [33mdelegated[0m[2m:[0m[1;36m5.1.0[0m[2m from molecule[0m
    [33mdocker[0m[2m:[0m[1;36m2.1.0[0m[2m from molecule_docker requiring collections: [0m[2;33mcommunity.docker[0m[2m>=[0m[1;2;36m3.0.2[0m[2m [0m[2;33mansible.posix[0m[2m>=[0m[1;2;36m1.4.0[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Molecule test)
[Pipeline] sh
+ molecule test -s docker
[31mWARNING [0m Driver docker does not provide a schema.
[34mINFO    [0m docker scenario test matrix: dependency, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
[34mINFO    [0m Performing prerun with [33mrole_name_check[0m=[1;36m0[0m[33m...[0m
[34mINFO    [0m Set [33mANSIBLE_LIBRARY[0m=[35m/root/.cache/ansible-compat/93d2f9/[0m[95mmodules[0m:[35m/root/.ansible/plugins/[0m[95mmodules[0m:[35m/usr/share/ansible/plugins/[0m[95mmodules[0m
[34mINFO    [0m Set [33mANSIBLE_COLLECTIONS_PATH[0m=[35m/root/.cache/ansible-compat/93d2f9/[0m[95mcollections[0m:[35m/root/.ansible/[0m[95mcollections[0m:[35m/usr/share/ansible/[0m[95mcollections[0m
[34mINFO    [0m Set [33mANSIBLE_ROLES_PATH[0m=[35m/root/.cache/ansible-compat/93d2f9/[0m[95mroles[0m:[35m/root/.ansible/[0m[95mroles[0m:[35m/usr/share/ansible/[0m[95mroles[0m:[35m/etc/ansible/[0m[95mroles[0m
[34mINFO    [0m Using [35m/root/.cache/ansible-compat/93d2f9/roles/[0m[95mvector.vector[0m symlink to current repository in order to enable Ansible to find the role using its expected full name.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdependency[0m
[31mWARNING [0m Skipping, missing the requirements file.
[31mWARNING [0m Skipping, missing the requirements file.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdestroy[0m
[34mINFO    [0m Sanity checks: [32m'docker'[0m

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).[0m
[32mok: [localhost] => (item=centos7)[0m

TASK [Delete docker networks(s)] ***********************************************
[36mskipping: [localhost][0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=3   [0m [33mchanged=1   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32msyntax[0m

playbook: /opt/jenkins_agent/workspace/Multi-pipeline_master/molecule/docker/converge.yml
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcreate[0m

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Log into a Docker registry] **********************************************
[36mskipping: [localhost] => (item=None) [0m
[36mskipping: [localhost][0m

TASK [Check presence of custom Dockerfiles] ************************************
[32mok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m

TASK [Create Dockerfiles from image names] *************************************
[36mskipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m
[36mskipping: [localhost][0m

TASK [Synchronization the context] *********************************************
[36mskipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m
[36mskipping: [localhost][0m

TASK [Discover local Docker images] ********************************************
[32mok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'false_condition': 'not item.pre_build_image | default(false)', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})[0m

TASK [Build an Ansible compatible image (new)] *********************************
[36mskipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7) [0m
[36mskipping: [localhost][0m

TASK [Create docker network(s)] ************************************************
[36mskipping: [localhost][0m

TASK [Determine the CMD directives] ********************************************
[32mok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})[0m

TASK [Create molecule instance(s)] *********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) creation to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).[0m
[33mchanged: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': 'j909628156725.31284', 'results_file': '/root/.ansible_async/j909628156725.31284', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item'})[0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=6   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=5   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mprepare[0m
[31mWARNING [0m Skipping, prepare playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mconverge[0m

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[32mok: [centos7][0m

TASK [Include vector] **********************************************************

TASK [vector-role : install *.rpm] *********************************************
[36mincluded: /opt/jenkins_agent/workspace/vector-role/tasks/rpm.yml for centos7[0m

TASK [vector-role : Get RPM Vector] ********************************************
[33mchanged: [centos7][0m

TASK [vector-role : Install RPM vector] ****************************************
[33mchanged: [centos7][0m

TASK [vector-role : Input config Vector] ***************************************
[33mchanged: [centos7][0m

TASK [vector-role : install *.deb] *********************************************
[36mskipping: [centos7][0m

PLAY RECAP *********************************************************************
[33mcentos7[0m                    : [32mok=5   [0m [33mchanged=3   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32midempotence[0m

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[32mok: [centos7][0m

TASK [Include vector] **********************************************************

TASK [vector-role : install *.rpm] *********************************************
[36mincluded: /opt/jenkins_agent/workspace/vector-role/tasks/rpm.yml for centos7[0m

TASK [vector-role : Get RPM Vector] ********************************************
[32mok: [centos7][0m

TASK [vector-role : Install RPM vector] ****************************************
[32mok: [centos7][0m

TASK [vector-role : Input config Vector] ***************************************
[32mok: [centos7][0m

TASK [vector-role : install *.deb] *********************************************
[36mskipping: [centos7][0m

PLAY RECAP *********************************************************************
[32mcentos7[0m                    : [32mok=5   [0m changed=0    unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Idempotence completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mside_effect[0m
[31mWARNING [0m Skipping, side effect playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mverify[0m
[34mINFO    [0m Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
[32mok: [centos7] => {[0m
[32m    "changed": false,[0m
[32m    "msg": "All assertions passed"[0m
[32m}[0m

TASK [Check config file] *******************************************************
[33mchanged: [centos7][0m

PLAY RECAP *********************************************************************
[33mcentos7[0m                    : [32mok=2   [0m [33mchanged=1   [0m unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[34mINFO    [0m Verifier completed successfully.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mcleanup[0m
[31mWARNING [0m Skipping, cleanup playbook not configured.
[34mINFO    [0m [2;36mRunning [0m[2;32mdocker[0m[2;36m > [0m[2;32mdestroy[0m

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
[32mok: [localhost][0m

TASK [Destroy molecule instance(s)] ********************************************
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Wait for instance(s) deletion to complete] *******************************
[1;30mFAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).[0m
[33mchanged: [localhost] => (item=centos7)[0m

TASK [Delete docker networks(s)] ***********************************************
[36mskipping: [localhost][0m

PLAY RECAP *********************************************************************
[33mlocalhost[0m                  : [32mok=3   [0m [33mchanged=2   [0m unreachable=0    failed=0    [36mskipped=1   [0m rescued=0    ignored=0

[34mINFO    [0m Pruning extra files from scenario ephemeral directory
[Pipeline] cleanWs
[WS-CLEANUP] Deleting project workspace...
[WS-CLEANUP] Deferred wipeout is used...
[WS-CLEANUP] done
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```
</details>

5. Создать Scripted Pipeline, наполнить его скриптом из pipeline.

![skrin](files/05-01.jpg)
6. Внести необходимые изменения, чтобы Pipeline запускал ansible-playbook без флагов --check --diff, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами --check --diff.
![skrin](files/06-01-1.jpg)
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл ScriptedJenkinsfile.


<details>
<summary>False</summary>

```commandline
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on node-125 in /opt/jenkins_agent/workspace/Script-declarate-pipline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git checkout)
[Pipeline] git
The recommended git tool is: NONE
No credentials specified
Fetching changes from the remote Git repository
Checking out Revision 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 (refs/remotes/origin/master)
Commit message: "Merge branch 'master' of https://github.com/aragastmatb/example-playbook"
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Script-declarate-pipline/.git # timeout=10
 > git config remote.origin.url https://github.com/aragastmatb/example-playbook.git # timeout=10
Fetching upstream changes from https://github.com/aragastmatb/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git fetch --tags --force --progress -- https://github.com/aragastmatb/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
 > git rev-list --no-walk 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run playbook)
[Pipeline] sh
+ ansible-playbook site.yml -i inventory/prod.yml --check --diff

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
ok: [localhost]

TASK [java : Extract java in the installation directory] ***********************
skipping: [localhost]

TASK [java : Export environment variables] *************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```
</details>

<details>
<summary>True</summary>

```commandline
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on node-125 in /opt/jenkins_agent/workspace/Script-declarate-pipline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git checkout)
[Pipeline] git
The recommended git tool is: NONE
No credentials specified
Fetching changes from the remote Git repository
Checking out Revision 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 (refs/remotes/origin/master)
Commit message: "Merge branch 'master' of https://github.com/aragastmatb/example-playbook"
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Script-declarate-pipline/.git # timeout=10
 > git config remote.origin.url https://github.com/aragastmatb/example-playbook.git # timeout=10
Fetching upstream changes from https://github.com/aragastmatb/example-playbook.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.3'
 > git fetch --tags --force --progress -- https://github.com/aragastmatb/example-playbook.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
 > git rev-list --no-walk 20bd8d945340bb742acdd9e8c1a8fb5b73cc1700 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run playbook)
[Pipeline] sh
+ ansible-playbook site.yml -i inventory/prod.yml

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [java : Upload .tar.gz file containing binaries from local storage] *******
skipping: [localhost]

TASK [java : Upload .tar.gz file conaining binaries from remote storage] *******
ok: [localhost]

TASK [java : Ensure installation dir exists] ***********************************
ok: [localhost]

TASK [java : Extract java in the installation directory] ***********************
skipping: [localhost]

TASK [java : Export environment variables] *************************************
ok: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
</details>

### [Ссылка на SkriptedJenkinsfile](https://github.com/Apoddubniy/vector-role/blob/master/ScriptedJenkinsfile)
