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
* Команда для копирования:
```
rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*"} /mnt/ /mnt-new/
```
* Проверяем перед копированием наличие свободного места и правильность монтирования каталогов к дискам
```
root@ubuntu:/# df -h
Файл.система   Размер Использовано  Дост Использовано% Cмонтировано в
/dev/sda5         87G          77G  5,5G           94% /mnt
/dev/sdb5        110G          61M  104G            1% /mnt-new

```
