### Ответ на задание "3.7. Компьютерные сети.Лекция 2"

1. В Linux самая простая утилита это `ifconfig`, в Windows это утилита `ipconfig (ключ /all покажет все интерфейсы)`.
2. Neighbor Discovery Protocol, NDP команда для просмотра `ip -4(6) neighbour`. Или LLDP – протокол для обмена информацией между соседними устройствами.
3. VLAN (Virtual Local Area Network) IEEE 802.1Q, vconfig, ip. Конфиг, который будет удален после перезагрузки.
```commandline
vagrant@vagrant:~$ ip link add link eth0 name eth0.11 type vlan id 11
RTNETLINK answers: Operation not permitted
vagrant@vagrant:~$ sudo ip link add link eth0 name eth0.11 type vlan id 11
vagrant@vagrant:~$ ip -d link show eth0.11
3: eth0.11@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 08:00:27:59:cb:31 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 0 maxmtu 65535
    vlan protocol 802.1Q id 11 <REORDER_HDR> addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
vagrant@vagrant:~$ sudo ip addr add 192.168.1.200/24 brd 192.168.1.255 dev eth0.11
vagrant@vagrant:~$ ip link set dev eth0.11 up
RTNETLINK answers: Operation not permitted
vagrant@vagrant:~$ sudo ip link set dev eth0.11 up
vagrant@vagrant:~$ sudo cat /proc/net/vlan/eth0.11
eth0.11  VID: 11         REORDER_HDR: 1  dev->priv_flags: 1021
         total frames received            0
          total bytes received            0
      Broadcast/Multicast Rcvd            0

      total frames transmitted            8
       total bytes transmitted          656
Device: eth0
INGRESS priority mappings: 0:0  1:0  2:0  3:0  4:0  5:0  6:0 7:0
 EGRESS priority mappings:

```
4. Типы агрегации: mode=0 (balance-rr), mode=1 (active-backup), mode=2 (balance-xor), mode=3 (broadcast), mode=4 (802.3ad), mode=5 (balance-tlb), mode=6 (balance-alb).  
Пример конфигурации:
```commandline
vagrant@vagrant:~$  sudo nano /etc/network/interfaces
  GNU nano 4.8                                                   /etc/network/interfaces                                                    Modified
# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto bond0
iface bond0 inet static
    address 192.168.1.150
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 192.168.1.1 8.8.8.8
    dns-search domain.local
        slaves eth0 eth1
        bond_mode 4
        bond-miimon 100
        bond_downdelay 200
        bound_updelay 200

```

```commandline
vagrant@vagrant:~$ ifenslave -a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:59:cb:31 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 08:00:27:ee:cc:ae brd ff:ff:ff:ff:ff:ff
5: bond0: <NO-CARRIER,BROADCAST,MULTICAST,MASTER,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
    link/ether de:a0:e5:81:28:b9 brd ff:ff:ff:ff:ff:ff


```
5. В сети с маской /29 количество IP адресов составляет 8 шт. Количество подсетей /29 из маски /24 в теории 32. Пример:
```commandline
Network Address	Usable Host Range	Broadcast Address:
10.10.10.0	10.10.10.1 - 10.10.10.6	10.10.10.7
10.10.10.8	10.10.10.9 - 10.10.10.14	10.10.10.15
10.10.10.16	10.10.10.17 - 10.10.10.22	10.10.10.23
10.10.10.24	10.10.10.25 - 10.10.10.30	10.10.10.31
10.10.10.32	10.10.10.33 - 10.10.10.38	10.10.10.39
10.10.10.40	10.10.10.41 - 10.10.10.46	10.10.10.47
10.10.10.48	10.10.10.49 - 10.10.10.54	10.10.10.55
...
10.10.10.240	10.10.10.241 - 10.10.10.246	10.10.10.247
10.10.10.248	10.10.10.249 - 10.10.10.254	10.10.10.255
```
6. Выбираем ip адреса из подсети 100.64.0.0, для ограничения хостов используем маску /26, пришлось с запасом.
7. В Windows проверить записи в АРП таблице `arp -a`, очистить кэш  `netsh interface ip delete arpcache`, удалить конкретный ip `arp -d (ip-адрес)`
В Linux проверить записи в АРП таблице `arp -v`, или `ip neighbour`, очистить кэш `ip link set arp off dev eth0`, удалить конкретный ip `arp -d (ip-адрес)`
