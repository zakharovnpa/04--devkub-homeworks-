## Ход выполнения переноса ОС с одного диска (маленького размера) на другой диск.

* Наша задача: 
  * выполнить копирование из раздела /dev/sda5 старого диска на раздел /dev/sdb5 нового диска
  * сделать новый диск загрузочным
  * 
### 1. Загружаемся с помощью LiveCD Ubuntu20.04
### 2. Настриваем в ОС английский язык для клавиатуры
### 3. Подготовка дисков
1. Монтируем диск /dev/sda5 в директорию /mnt LiveCD системы
```
mount /dev/sda5 /mnt
```
2. Монтируем диск /dev/sdb5 в директорию /mnt-new LiveCD системы
```
root@ubuntu:/# mkdir /mnt-new
```
```
root@ubuntu:/# mount /dev/sdb5 /mnt-new
```

3. Проверяем что диски смонитрованы
```
root@ubuntu:/# lsblk -l
NAME  MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
loop0   7:0    0     2G  1 loop /rofs
loop1   7:1    0  55,4M  1 loop /snap/core18/2128
loop2   7:2    0   219M  1 loop /snap/gnome-3-34-1804/72
loop3   7:3    0    51M  1 loop /snap/snap-store/547
loop4   7:4    0  32,3M  1 loop /snap/snapd/12704
loop5   7:5    0  65,1M  1 loop /snap/gtk-common-themes/1515
sda     8:0    0 238,5G  0 disk 
sda1    8:1    0 106,7M  0 part 
sda2    8:2    0 148,8G  0 part 
sda3    8:3    0   1,1G  0 part 
sda4    8:4    0     1K  0 part 
sda5    8:5    0  88,5G  0 part /mnt      # смонтирован
sdb     8:16   0 111,8G  0 disk 
sdb1    8:17   0     1K  0 part 
sdb5    8:21   0 111,8G  0 part /mnt-new  # смонтирован
sdc     8:32   1  14,9G  0 disk 
sdc1    8:33   1  14,9G  0 part /cdrom
sr0    11:0    1  1024M  0 rom 
```

### 4. Выполняем копирование всех каталогов со старого диска /dev/sda5 (подключенный каталог /mnt) на новый /dev/sdb5 (подключенный каталог /mnt-new)

* Проверяем перед копированием наличие свободного места и правильность монтирования каталогов к дискам
```
root@ubuntu:/# df -h
Файл.система   Размер Использовано  Дост Использовано% Cмонтировано в
/dev/sda5         87G          77G  5,5G           94% /mnt
/dev/sdb5        110G          61M  104G            1% /mnt-new

```
* Команда для копирования:
```
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*"} /mnt/ /mnt-new/
```
* Результаты копирования:
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          19G   86G           18% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          24G   81G           23% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          24G   80G           24% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          28G   77G           27% /mnt-new
```
``` 
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          33G   72G           31% /mnt-new
```
``` 
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          37G   68G           36% /mnt-new
```
``` 
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          42G   63G           41% /mnt-new
```
``` 
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          47G   58G           45% /mnt-new
```
``` 
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          52G   52G           50% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          57G   48G           55% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          63G   42G           61% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          70G   35G           67% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          73G   32G           71% /mnt-new
```
```
root@ubuntu:/# df -h | grep sdb5
/dev/sdb5        110G          79G   26G           76% /mnt-new

```
* Отчет команды копирования 
```
sent 82,851,624,644 bytes  received 8,260,168 bytes  96,968,852.91 bytes/sec
total size is 82,798,818,473  speedup is 1.00
```
### 5. Настройка нового SSD для загрузки с него ОС
* Смотрим какие UUID нового и старого дисков:
```
root@ubuntu:~# blkid /dev/sdb5
/dev/sdb5: UUID="ee07073f-3ecb-4f85-acf5-2733cce20dc1" TYPE="ext4" PARTUUID="ee64844d-05"
```
```
root@ubuntu:~# blkid /dev/sda5
/dev/sda5: UUID="3d5f16ee-5b2f-49c5-8202-212677165736" TYPE="ext4" PARTUUID="25bf4779-05"
```
* Переносим в файл `/etc/fstab` параметры UUID нового диска
```
root@ubuntu:/mnt-new/etc# cat fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda5 during installation
UUID=3d5f16ee-5b2f-49c5-8202-212677165736 /               ext4    errors=remount-ro 0       1
/swapfile                                 none            swap    sw              0       0

```
* После редактирования:
```
root@ubuntu:/mnt-new/etc# cat fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda5 during installation
UUID=ee07073f-3ecb-4f85-acf5-2733cce20dc1 /               ext4    errors=remount-ro 0       1
/swapfile                                 none            swap    sw              0       0

```
### 6. Установка загрузчика в новом Linux
* Примонтируем папки 
```
mount --bind /sys /mnt-new/sys
```
```
mount --bind /proc /mnt-new/proc
```
```
mount --bind /dev /mnt-new/dev
```
* Заходим в chroot окружение
```
chroot /mnt-new
```
* Устанавливаем загрузчик на диск `dev/dsb`
```
grub-install /dev/sdb
```
```
root@ubuntu:/# grub-install /dev/sdb
Выполняется установка для платформы i386-pc.
Установка завершена. Ошибок нет.
```
* Создаем конфигурационный файл для загрузчика. Перед этим шагом надо физически извлечь старый SSD из ПК
```
update-grub2
```
* Найден Windows10 на старом /dev/sda1
```
root@ubuntu:/# update-grub2
Sourcing file `/etc/default/grub'
Sourcing file `/etc/default/grub.d/init-select.cfg'
Генерируется файл настройки grub …
Найден образ linux: /boot/vmlinuz-5.13.0-44-generic
Найден образ initrd: /boot/initrd.img-5.13.0-44-generic
Найден образ linux: /boot/vmlinuz-5.13.0-41-generic
Найден образ initrd: /boot/initrd.img-5.13.0-41-generic
Найден образ linux: /boot/vmlinuz-5.11.0-46-generic
Найден образ initrd: /boot/initrd.img-5.11.0-46-generic
Found memtest86+ image: /boot/memtest86+.elf
Found memtest86+ image: /boot/memtest86+.bin
Найден Windows 10 на /dev/sda1
Найден Ubuntu 20.04.4 LTS (20.04) на /dev/sda5
```
### 7. Перезагрузка
* Выходим из chroot окружения
```
root@ubuntu:/# exit
exit
root@ubuntu:~#
```
* Размонитрование системных каталогов и нашего раздела /dev/sdb5
```
umount /mnt-new/sys
```
```
umount /mnt-new/proc
```
```
umount /mnt-new/dev
```
```
umount /mnt-new
```
### 8. Перезагружаем ПК.
