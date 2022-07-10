## Ход установки docker на хост в Яндекс.Облаке

```
yc-user@node3:~$ sudo -i
```
#### Установка Docker-compose
```
root@node3:~# curl -L https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose && chmod +x /usr/bin/docker-compose
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
100 23.5M  100 23.5M    0     0  13.3M      0  0:00:01  0:00:01 --:--:-- 29.4M
```
```
root@node3:~# type docker-compose
docker-compose is /usr/bin/docker-compose
```
```
root@node3:~# whereis docker-compose
docker-compose: /usr/bin/docker-compose
```
#### Проверка установлен ли Docker
```
root@node3:~# docker ps

Command 'docker' not found, but can be installed with:

apt install docker.io

```
#### Установка Docker
```
root@node3:~# apt install docker.io
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  bridge-utils containerd dns-root-data dnsmasq-base git git-man libcurl3-gnutls liberror-perl libgdbm-compat4 libidn11 libperl5.30 patch perl perl-modules-5.30 pigz runc ubuntu-fan
Suggested packages:
  ifupdown aufs-tools btrfs-progs cgroupfs-mount | cgroup-lite debootstrap docker-doc rinse zfs-fuse | zfsutils git-daemon-run | git-daemon-sysvinit git-doc git-el git-email git-gui gitk gitweb git-cvs git-mediawiki git-svn
  diffutils-doc perl-doc libterm-readline-gnu-perl | libterm-readline-perl-perl make libb-debug-perl liblocale-codes-perl
The following NEW packages will be installed:
  bridge-utils containerd dns-root-data dnsmasq-base docker.io git git-man libcurl3-gnutls liberror-perl libgdbm-compat4 libidn11 libperl5.30 patch perl perl-modules-5.30 pigz runc ubuntu-fan
0 upgraded, 18 newly installed, 0 to remove and 0 not upgraded.
Need to get 82.0 MB of archives.
After this operation, 420 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 perl-modules-5.30 all 5.30.0-9ubuntu0.2 [2,738 kB]
Get:2 http://mirror.yandex.ru/ubuntu focal/main amd64 libgdbm-compat4 amd64 1.18.1-5 [6,244 B]
Get:3 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 libperl5.30 amd64 5.30.0-9ubuntu0.2 [3,952 kB]
Get:4 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 perl amd64 5.30.0-9ubuntu0.2 [224 kB]
Get:5 http://mirror.yandex.ru/ubuntu focal/universe amd64 pigz amd64 2.4-1 [57.4 kB]
Get:6 http://mirror.yandex.ru/ubuntu focal/main amd64 bridge-utils amd64 1.6-2ubuntu1 [30.5 kB]
Get:7 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 runc amd64 1.1.0-0ubuntu1~20.04.1 [3,892 kB]
Get:8 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 containerd amd64 1.5.9-0ubuntu1~20.04.4 [33.0 MB]
Get:9 http://mirror.yandex.ru/ubuntu focal/main amd64 dns-root-data all 2019052802 [5,300 B]
Get:10 http://mirror.yandex.ru/ubuntu focal/main amd64 libidn11 amd64 1.33-2.2ubuntu2 [46.2 kB]
Get:11 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 dnsmasq-base amd64 2.80-1.1ubuntu1.5 [315 kB]
Get:12 http://mirror.yandex.ru/ubuntu focal-updates/universe amd64 docker.io amd64 20.10.12-0ubuntu2~20.04.1 [31.8 MB]
Get:13 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 libcurl3-gnutls amd64 7.68.0-1ubuntu2.12 [232 kB]
Get:14 http://mirror.yandex.ru/ubuntu focal/main amd64 liberror-perl all 0.17029-1 [26.5 kB]
Get:15 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 git-man all 1:2.25.1-1ubuntu3.4 [885 kB]
Get:16 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 git amd64 1:2.25.1-1ubuntu3.4 [4,560 kB]
Get:17 http://mirror.yandex.ru/ubuntu focal/main amd64 patch amd64 2.7.6-6 [105 kB]
Get:18 http://mirror.yandex.ru/ubuntu focal-updates/main amd64 ubuntu-fan all 0.12.13ubuntu0.1 [34.4 kB]
Fetched 82.0 MB in 1s (85.4 MB/s)       
Preconfiguring packages ...
Selecting previously unselected package perl-modules-5.30.
(Reading database ... 102314 files and directories currently installed.)
Preparing to unpack .../00-perl-modules-5.30_5.30.0-9ubuntu0.2_all.deb ...

Progress: [  0%] [.............................................................................................................................................................................................................] 
Unpacking perl-modules-5.30 (5.30.0-9ubuntu0.2) ...............................................................................................................................................................................] 

Selecting previously unselected package libgdbm-compat4:amd64..................................................................................................................................................................] 
Preparing to unpack .../01-libgdbm-compat4_1.18.1-5_amd64.deb ...

Unpacking libgdbm-compat4:amd64 (1.18.1-5) ....................................................................................................................................................................................] 

Selecting previously unselected package libperl5.30:amd64......................................................................................................................................................................] 
Preparing to unpack .../02-libperl5.30_5.30.0-9ubuntu0.2_amd64.deb ...

Unpacking libperl5.30:amd64 (5.30.0-9ubuntu0.2) ...............................................................................................................................................................................] 

Selecting previously unselected package perl...................................................................................................................................................................................] 
Preparing to unpack .../03-perl_5.30.0-9ubuntu0.2_amd64.deb ...

Unpacking perl (5.30.0-9ubuntu0.2) ............................................................................................................................................................................................] 

Selecting previously unselected package pigz...................................................................................................................................................................................] 
Preparing to unpack .../04-pigz_2.4-1_amd64.deb ...

Unpacking pigz (2.4-1) ...#################....................................................................................................................................................................................] 

Selecting previously unselected package bridge-utils...........................................................................................................................................................................] 
Preparing to unpack .../05-bridge-utils_1.6-2ubuntu1_amd64.deb ...

Unpacking bridge-utils (1.6-2ubuntu1) ...#######...............................................................................................................................................................................] 

Selecting previously unselected package runc.######............................................................................................................................................................................] 
Preparing to unpack .../06-runc_1.1.0-0ubuntu1~20.04.1_amd64.deb ...

Unpacking runc (1.1.0-0ubuntu1~20.04.1) ...###########.........................................................................................................................................................................] 

Selecting previously unselected package containerd.######......................................................................................................................................................................] 
Preparing to unpack .../07-containerd_1.5.9-0ubuntu1~20.04.4_amd64.deb ...

Unpacking containerd (1.5.9-0ubuntu1~20.04.4) ...###########...................................................................................................................................................................] 

Selecting previously unselected package dns-root-data.########.................................................................................................................................................................] 
Preparing to unpack .../08-dns-root-data_2019052802_all.deb ...

Unpacking dns-root-data (2019052802) ...#########################..............................................................................................................................................................] 

Selecting previously unselected package libidn11:amd64.#############...........................................................................................................................................................] 
Preparing to unpack .../09-libidn11_1.33-2.2ubuntu2_amd64.deb ...

Unpacking libidn11:amd64 (1.33-2.2ubuntu2) ...#########################........................................................................................................................................................] 

Selecting previously unselected package dnsmasq-base.#####################.....................................................................................................................................................] 
Preparing to unpack .../10-dnsmasq-base_2.80-1.1ubuntu1.5_amd64.deb ...

Unpacking dnsmasq-base (2.80-1.1ubuntu1.5) ...##############################...................................................................................................................................................] 

Selecting previously unselected package docker.io.#############################................................................................................................................................................] 
Preparing to unpack .../11-docker.io_20.10.12-0ubuntu2~20.04.1_amd64.deb ...

Unpacking docker.io (20.10.12-0ubuntu2~20.04.1) ...###############################.............................................................................................................................................] 

Selecting previously unselected package libcurl3-gnutls:amd64.#######################..........................................................................................................................................] 
Preparing to unpack .../12-libcurl3-gnutls_7.68.0-1ubuntu2.12_amd64.deb ...

Unpacking libcurl3-gnutls:amd64 (7.68.0-1ubuntu2.12) ...################################.......................................................................................................................................] 

Selecting previously unselected package liberror-perl.#####################################....................................................................................................................................] 
Preparing to unpack .../13-liberror-perl_0.17029-1_all.deb ...

Unpacking liberror-perl (0.17029-1) ...######################################################..................................................................................................................................] 

Selecting previously unselected package git-man.################################################...............................................................................................................................] 
Preparing to unpack .../14-git-man_1%3a2.25.1-1ubuntu3.4_all.deb ...

Unpacking git-man (1:2.25.1-1ubuntu3.4) ...########################################################............................................................................................................................] 

Selecting previously unselected package git.##########################################################.........................................................................................................................] 
Preparing to unpack .../15-git_1%3a2.25.1-1ubuntu3.4_amd64.deb ...

Unpacking git (1:2.25.1-1ubuntu3.4) ...##################################################################......................................................................................................................] 

Selecting previously unselected package patch.#############################################################....................................................................................................................] 
Preparing to unpack .../16-patch_2.7.6-6_amd64.deb ...

Unpacking patch (2.7.6-6) ...#################################################################################.................................................................................................................] 

Selecting previously unselected package ubuntu-fan.##############################################################..............................................................................................................] 
Preparing to unpack .../17-ubuntu-fan_0.12.13ubuntu0.1_all.deb ...

Unpacking ubuntu-fan (0.12.13ubuntu0.1) ...#########################################################################...........................................................................................................] 

Setting up perl-modules-5.30 (5.30.0-9ubuntu0.2) ...###################################################################........................................................................................................] 

Progress: [ 51%] [#######################################################################################################......................................................................................................] 
Setting up libcurl3-gnutls:amd64 (7.68.0-1ubuntu2.12) ...###################################################################...................................................................................................] 

Progress: [ 53%] [#############################################################################################################................................................................................................] 
Setting up runc (1.1.0-0ubuntu1~20.04.1) ...######################################################################################.............................................................................................] 

Progress: [ 56%] [###################################################################################################################..........................................................................................] 
Setting up dns-root-data (2019052802) ...##############################################################################################........................................................................................] 

Progress: [ 59%] [########################################################################################################################.....................................................................................] 
Setting up libidn11:amd64 (1.33-2.2ubuntu2) ...##############################################################################################..................................................................................] 

Progress: [ 62%] [##############################################################################################################################...............................................................................] 
Setting up patch (2.7.6-6) ...#####################################################################################################################............................................................................] 

Progress: [ 64%] [###################################################################################################################################..........................................................................] 
Setting up libgdbm-compat4:amd64 (1.18.1-5) ...#########################################################################################################.......................................................................] 

Progress: [ 67%] [#########################################################################################################################################....................................................................] 
Setting up bridge-utils (1.6-2ubuntu1) ...####################################################################################################################.................................................................] 

Progress: [ 70%] [###############################################################################################################################################..............................................................] 
Setting up pigz (2.4-1) ...#########################################################################################################################################...........................................................] 

Progress: [ 73%] [####################################################################################################################################################.........................................................] 
Setting up libperl5.30:amd64 (5.30.0-9ubuntu0.2) ...#####################################################################################################################......................................................] 

Progress: [ 75%] [##########################################################################################################################################################...................................................] 
Setting up git-man (1:2.25.1-1ubuntu3.4) ...###################################################################################################################################................................................] 

Progress: [ 78%] [################################################################################################################################################################.............................................] 
Setting up containerd (1.5.9-0ubuntu1~20.04.4) ...##################################################################################################################################...........................................] 

Created symlink /etc/systemd/system/multi-user.target.wants/containerd.service → /lib/systemd/system/containerd.service.###############################################################........................................] 

Setting up docker.io (20.10.12-0ubuntu2~20.04.1) ...######################################################################################################################################.....................................] 

Adding group `docker' (GID 115) ...##########################################################################################################################################################..................................] 
Done.
Created symlink /etc/systemd/system/multi-user.target.wants/docker.service → /lib/systemd/system/docker.service.
Created symlink /etc/systemd/system/sockets.target.wants/docker.socket → /lib/systemd/system/docker.socket.

Setting up dnsmasq-base (2.80-1.1ubuntu1.5) ...#################################################################################################################################################...............................] 

Progress: [ 86%] [################################################################################################################################################################################.............................] 
Setting up perl (5.30.0-9ubuntu0.2) ...##############################################################################################################################################################..........................] 

Progress: [ 89%] [######################################################################################################################################################################################.......................] 
Setting up ubuntu-fan (0.12.13ubuntu0.1) ...###############################################################################################################################################################....................] 

Created symlink /etc/systemd/system/multi-user.target.wants/ubuntu-fan.service → /lib/systemd/system/ubuntu-fan.service.######################################################################################.................] 

Setting up liberror-perl (0.17029-1) ...########################################################################################################################################################################...............] 

Progress: [ 95%] [#################################################################################################################################################################################################............] 
Setting up git (1:2.25.1-1ubuntu3.4) ...##############################################################################################################################################################################.........] 

Progress: [ 97%] [#######################################################################################################################################################################################################......] 
Processing triggers for systemd (245.4-4ubuntu3.17) ...#####################################################################################################################################################################...] 
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for dbus (1.12.16-2ubuntu2.2) ...
Processing triggers for libc-bin (2.31-0ubuntu9.9) ...
```
```
root@node3:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
```
root@node3:~# docker image list
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
```