### Ответ на домашнее задание к занятию "03.03".

1. Системный вызов команды `cd` это `chdir("/tmp")`
2. После выполнения 3-х команд: `strace -y -e trace=file  file /dev/tty`, ` strace -y -e trace=file  file /bin/bash`, `strace -y -e trace=file  file /dev/sda`,
найдена строчка: `openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3</usr/lib/file/magic.mgc>`.
Так же присутствуют и другие строчки.
```
stat("/etc/magic", {st_mode=S_IFREG|0644, st_size=111, ...}) = 0
openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3</etc/magic>
```
и если проверить этот файл через `cat`, то увидим следующее.
```
vagrant@vagrant:~$ ls -lah /etc/magic
-rw-r--r-- 1 root root 111 Jan 16  2020 /etc/magic
vagrant@vagrant:~$ cat /etc/magic
Magic local data for file(1) command.
Insert here your local magic data. Format is described in magic(5).
```
В теории ответ: `/etc/magic` и `/usr/share/misc/magic.mgc`

3. Допустим: создаем файл и делаем некоторые изменения, сохраняем `vi /tmp/123.txt` отправляем задачу в фон, далее находим процесс в списке через ps aux:
`vagrant     1880  0.3  0.4  21920  9772 pts/0    T    07:02   0:00 vi /tmp/123.txt`, удаляем файл, получаем список открытых файлов приложением:
`vi      1880 vagrant    4u   REG  253,0     4096 1310825 /tmp/.123.txt.swp`, после этого можно обнулить файл командой `echo qwe > /proc/1880/fd/4`

4. Процессы-Зомби не потребляют никаких ресурсов, память и файловые дескрипторы таких процессов уже освобождены. 
Остается только запись в таблице процессов.
5. 
```bash
vagrant@vagrant:~$ sudo /usr/sbin/opensnoop-bpfcc
PID    COMM               FD ERR PATH
887    vminfo              6   0 /var/run/utmp
641    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
641    dbus-daemon        21   0 /usr/share/dbus-1/system-services
641    dbus-daemon        -1   2 /lib/dbus-1/system-services
641    dbus-daemon        21   0 /var/lib/snapd/dbus-1/system-services/
887    vminfo              6   0 /var/run/utmp
641    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
641    dbus-daemon        21   0 /usr/share/dbus-1/system-services
641    dbus-daemon        -1   2 /lib/dbus-1/system-services
641    dbus-daemon        21   0 /var/lib/snapd/dbus-1/system-services/

```
6. Системный вызов uname()  
Цитата `Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.`  
Узнать версию ОС и ядра можно командой `cat /proc/version`.
7. `&&` логический оператор.   
`;` разделитель команд.  
`test -d /tmp/some_dir && echo Hi`, `echo` выполнится, если команда `test` выполнится успешно.
8. `-e` Немедленный выход, если команда завершается с ненулевым статусом.   
`-u` При подстановке обрабатывать неустановленные переменные как ошибку.  
`-x` Печатать команды и их аргументы по мере их выполнения.   
`-o option-pipefail` возвращаемое значение конвейера - это статус последней команды для выхода с ненулевым статусом или ноль, если ни одна команда не завершилась с ненулевым статусом.  
Для сценария увеличивает детальность логирования. 
Прервет сценарий при возникновении ошибки, кроме завершающей команды.
9. `Ss` - неактивные процессы;  
`R+` - выполняющиеся в группе приоритетных.  
Дополнительные к заглавной букве - это дополнительные значения состояния процесса:
`<` - высокий приоритет;
`N` - низкий приорит;
`L` - имеет страницы, заблокированные в памяти;
`s` - является лидером сеанса;
`l` - является многопоточным;
`+` - находится в группе приоритетных процессов.  