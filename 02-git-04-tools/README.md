### 1. git log --grep= aefea -1

commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545  
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>  
Date:   Thu Jun 18 10:29:58 2020 -0400  

### 2. git log --grep= 85024d3 --oneline -1  
   85024d3100 v0.12.23

### 3. 2 варианта решения ( ответ: 2 родителя у комита)

#### git show -s --format=%p b8d720

56cd7859e0 9ea88f22fc

#### git log --grep= b8d720

commit b8d720f8340221f2146e4e4870bf2ee0bc48f2d5  
Merge: 56cd7859e0 9ea88f22fc  
Author: Chris Griggs <cgriggs@hashicorp.com>  
Date:   Tue Jan 21 17:45:48 2020 -0800  

### 4. git log v0.12.23..v0.12.24 --oneline

33ff1c03bb v0.12.24  
b14b74c493 [Website] vmc provider links  
3f235065b9 Update CHANGELOG.md  
6ae64e247b registry: Fix panic when server is unreachable  
5c619ca1ba website: Remove links to the getting started guide's old location  
06275647e2 Update CHANGELOG.md  
d5f9411f51 command: Fix bug when using terraform login on Windows  
4b6d06cc5d Update CHANGELOG.md  
dd01a35078 Update CHANGELOG.md  
225466bc3e Cleanup after v0.12.23 release  


### 5. git log -S 'func providerSource'

commit 5af1e6234ab6da412fb8637393c5a17a1b293663  
Author: Martin Atkins <mart@degeneration.co.uk>  
Date:   Tue Apr 21 16:28:59 2020 -0700  

commit 8c928e83589d90a031f811fae52a81be7153e82f  
Author: Martin Atkins <mart@degeneration.co.uk>  
Date:   Thu Apr 2 18:04:39 2020 -0700  

### 6.  git log -L :'func globalPluginDirs':plugins.go --oneline

78b1220558 Remove config.go and update things using its aliases  
52dbf94834 keep .terraform.d/plugins for discovery  
41ab0aef7a Add missing OS_ARCH dir to global plugin paths  
66ebff90cd move some more plugin search path logic to command  
8364383c35 Push plugin discovery down into command package  

### 7. git log -S 'func synchronizedWriters'

commit bdfea50cc85161dea41be0fe3381fd98731ff786  
Author: James Bardin <j.bardin@gmail.com>  
Date:   Mon Nov 30 18:02:04 2020 -0500  