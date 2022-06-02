## Ход выоплнения работ по расширению корневого раздела за счет добавлению нового SSD 

1. Состояние файловой системы:
```ps
root@PC-Ubuntu:~# df -h
Файл.система   Размер Использовано  Дост Использовано% Cмонтировано в
udev             7,8G            0  7,8G            0% /dev
tmpfs            1,6G         2,0M  1,6G            1% /run
/dev/sda5         87G          77G  5,6G           94% /            #Раздел, требующий расширения
tmpfs            7,8G         151M  7,7G            2% /dev/shm
tmpfs            5,0M         4,0K  5,0M            1% /run/lock
tmpfs            7,8G            0  7,8G            0% /sys/fs/cgroup
/dev/loop0       128K         128K     0          100% /snap/bare/5
/dev/loop2        62M          62M     0          100% /snap/core20/1494
/dev/loop1        56M          56M     0          100% /snap/core18/2344
/dev/loop3       165M         165M     0          100% /snap/gnome-3-28-1804/161
/dev/loop4        56M          56M     0          100% /snap/core18/2409
/dev/loop5       219M         219M     0          100% /snap/gnome-3-34-1804/72
/dev/loop6       249M         249M     0          100% /snap/gnome-3-38-2004/99
/dev/loop7        82M          82M     0          100% /snap/gtk-common-themes/1534
/dev/loop8        55M          55M     0          100% /snap/snap-store/558
/dev/loop9       104M         104M     0          100% /snap/slack/61
/dev/loop10       45M          45M     0          100% /snap/snapd/15534
/dev/loop11      254M         254M     0          100% /snap/dbeaver-ce/184
/dev/loop12       62M          62M     0          100% /snap/core20/1434
/dev/loop13      566M         566M     0          100% /snap/pycharm-community/281
/dev/loop14      255M         255M     0          100% /snap/gnome-3-38-2004/106
/dev/loop15      256M         256M     0          100% /snap/dbeaver-ce/185
/dev/loop16       51M          51M     0          100% /snap/snap-store/547
/dev/loop17      106M         106M     0          100% /snap/slack/62
/dev/loop18      219M         219M     0          100% /snap/gnome-3-34-1804/77
/dev/loop19      566M         566M     0          100% /snap/pycharm-community/278
/dev/loop20       72M          72M     0          100% /snap/fbreader/19
/dev/loop21       66M          66M     0          100% /snap/gtk-common-themes/1519
/dev/loop22       45M          45M     0          100% /snap/snapd/15904
overlay           87G          77G  5,6G           94% /var/lib/docker/overlay2/959cab60859010edc8a7735567d72e1da8addc95429431e98983ad625677cc85/merged
tmpfs            1,6G         9,6M  1,6G            1% /run/user/1000
/dev/sdb5        110G          61M  104G            1% /media/maestro/virt-mashin     #Новый раздел на новом SDD

```

2. Таблицы разделов:
```
root@PC-Ubuntu:~# parted -l
Модель: ATA KINGSTON SKC6002 (scsi)
Диск /dev/sda: 256GB
Размер сектора (логич./физич.): 512B/4096B
Таблица разделов: msdos
Флаги диска: 

Номер  Начало  Конец  Размер  Тип       Файловая система  Флаги
 1     1049kB  113MB  112MB   primary   ntfs              загрузочный
 2     113MB   160GB  160GB   primary   ntfs
 3     160GB   161GB  1165MB  primary   ntfs              msftres
 4     161GB   256GB  95,0GB  extended
 5     161GB   256GB  95,0GB  logical   ext4


Модель: ATA KINGSTON SV300S3 (scsi)
Диск /dev/sdb: 120GB
Размер сектора (логич./физич.): 512B/512B
Таблица разделов: msdos
Флаги диска: 

Номер  Начало  Конец  Размер  Тип       Файловая система  Флаги
 1     1049kB  120GB  120GB   extended
 5     3146kB  120GB  120GB   logical   ext4

```

3. 
