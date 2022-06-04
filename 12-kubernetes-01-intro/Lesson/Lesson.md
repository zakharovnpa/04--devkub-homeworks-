## Ход выполнения ДЗ к занятию "12.1 Компоненты Kubernetes"

Вы DevOps инженер в крупной компании с большим парком сервисов. Ваша задача — разворачивать эти продукты в корпоративном кластере. 

## Задача 1: Установить Minikube

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине Minikube.

### Как поставить на AWS:
- создать EC2 виртуальную машину (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type) с типом **t3.small**. Для работы потребуется настроить Security Group для доступа по ssh. Не забудьте указать keypair, он потребуется для подключения.
- подключитесь к серверу по ssh `(ssh ubuntu@<ipv4_public_ip> -i <keypair>.pem)`
- установите миникуб и докер следующими командами:
  
```
  - curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  
  - chmod +x ./kubectl
  - sudo mv ./kubectl /usr/local/bin/kubectl
  - sudo apt-get update && sudo apt-get install docker.io conntrack -y
  - curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```
  
- проверить версию можно командой `minikube version`
- переключаемся на root и запускаем миникуб:` minikube start --vm-driver=none`
- после запуска стоит проверить статус: `minikube status`
- запущенные служебные компоненты можно увидеть командой: `kubectl get pods --namespace=kube-system`

### Для сброса кластера стоит удалить кластер и создать заново:
- `minikube delete`
- `minikube start --vm-driver=none`

Возможно, для повторного запуска потребуется выполнить команду: `sudo sysctl fs.protected_regular=0`

Инструкция по установке Minikube - [ссылка](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

**Важно**: t3.small не входит во free tier, следите за бюджетом аккаунта и удаляйте виртуалку.

**Ответ:**
1. Все ответы на ДЗ должны располагаться каждый в своем репозитории
* Репозиторий ДЗ
2. ДЗ выполнять, используя PyCharm, запуская его от пользователя root
```
root@PC-Ubuntu:~# whereis pycharm
pycharm: /opt/pycharm-community-2022.1/bin/pycharm64.vmoptions /opt/pycharm-community-2022.1/bin/pycharm.svg /opt/pycharm-community-2022.1/bin/pycharm.png /opt/pycharm-community-2022.1/bin/pycharm.sh
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# cd /opt/pycharm-community-2022.1/bin
root@PC-Ubuntu:/opt/pycharm-community-2022.1/bin# 
root@PC-Ubuntu:/opt/pycharm-community-2022.1/bin# ./pycharm.sh
```
![screen-pycharm-root](/12-kubernetes-01-intro/Files/screen-pycharm-root.png)

3. Устанавливаем локально kubectl [Установка и настройка kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/)
4. Устанавливаем локально на ВМ minikube [Установка Minikube](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)

#### Ход выполнения вопроса №1
1. Проверка точго, что Linux и процессор поддерживает виртуализацию. Вывод не должен быть пкстым.
```
root@PC-Ubuntu:~# grep -E --color 'vmx|svm' /proc/cpuinfo
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr cpb hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
root@PC-Ubuntu:~# 

```
2. Скачиваем по ссылке minikube
```
root@PC-Ubuntu:~# mc

root@PC-Ubuntu:~# curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 69.2M  100 69.2M    0     0  9390k      0  0:00:07  0:00:07 --:--:-- 9895k
```
3. Делаем файл исполняемым
```
root@PC-Ubuntu:~# chmod +x minikube
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep minikube
-rwxr-xr-x  1 root    root     70M мая 31 22:45 minikube
```
4. Запускаем установку в директорию `/usr/local/bin/`
```
sudo install minikube /usr/local/bin/
```
5. 
```
minikube start --vm-driver=virtualbox
```

6. Результат выполнения командв установки
```
root@PC-Ubuntu:~# minikube start --vm-driver=virtualbox
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер virtualbox на основе конфига пользователя
🛑  The "virtualbox" driver should not be used with root privileges.
💡  If you are running minikube within a VM, consider using --driver=none:
📘    https://minikube.sigs.k8s.io/docs/reference/drivers/none/

❌  Exiting due to DRV_AS_ROOT: The "virtualbox" driver should not be used with root privileges.

```
* Установка Cubectl
```
root@PC-Ubuntu:~# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 43.5M  100 43.5M    0     0  9296k      0  0:00:04  0:00:04 --:--:-- 9489k
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep kubectl
-rw-r--r--  1 root    root     44M мая 31 23:10 kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# chmod +x kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep kubectl
-rwxr-xr-x  1 root    root     44M мая 31 23:10 kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# mv kubectl /usr/local/bin/
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha | grep kubectl
root@PC-Ubuntu:~# 
root@PC-Ubuntu:~# ls -lha /usr/local/bin/ | grep kubectl
-rwxr-xr-x  1 root root  44M мая 31 23:10 kubectl

```


7. Проверяем статус minikube
```
root@PC-Ubuntu:~# minikube status
🤷  Profile "minikube" not found. Run "minikube profile list" to view all profiles.
👉  To start a cluster, run: "minikube start"

```
8. Для создания ВМ в Virtualbox переходим в пользовательскую УЗ и запускаем `minikube start --vm-driver=none`. Получаем ошибку.
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube start --vm-driver=none
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер none на основе конфига пользователя

🤷  Exiting due to PROVIDER_NONE_NOT_FOUND: The 'none' provider was not found: running the 'none' driver as a regular user requires sudo permissions

maestro@PC-Ubuntu:~/Рабочий стол$ 
```
9. Для создания ВМ в Virtualbox переходим в пользовательскую УЗ на локальной ОС и запускаем `minikube start --vm-driver=virtualbox`
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube start --vm-driver=virtualbox
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер virtualbox на основе конфига пользователя
💿  Downloading VM boot image ...
    > minikube-v1.25.2.iso.sha256: 65 B / 65 B [-------------] 100.00% ? p/s 0s
    > minikube-v1.25.2.iso: 237.06 MiB / 237.06 MiB [] 100.00% 9.77 MiB p/s 24s
👍  Запускается control plane узел minikube в кластере minikube
💾  Скачивается Kubernetes v1.23.3 ...
    > preloaded-images-k8s-v17-v1...: 505.68 MiB / 505.68 MiB  100.00% 9.69 MiB
🔥  Creating virtualbox VM (CPUs=2, Memory=3900MB, Disk=20000MB) ...
🐳  Подготавливается Kubernetes v1.23.3 на Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
    ▪ Используется образ gcr.io/k8s-minikube/storage-provisioner:v5
🔎  Компоненты Kubernetes проверяются ...
🌟  Включенные дополнения: storage-provisioner, default-storageclass
🏄  Готово! kubectl настроен для использования кластера "minikube" и "default" пространства имён по умолчанию

```
* 10 Проверка статуса
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube status
minikube
type: Control Plane
host: Stopped
kubelet: Stopped
apiserver: Stopped
kubeconfig: Stopped

```
* 11 Запуск
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube start
😄  minikube v1.25.2 на Ubuntu 20.04
✨  Используется драйвер virtualbox на основе существующего профиля
👍  Запускается control plane узел minikube в кластере minikube
🔄  Перезагружается существующий virtualbox VM для "minikube" ...
🐳  Подготавливается Kubernetes v1.23.3 на Docker 20.10.12 ...
    ▪ kubelet.housekeeping-interval=5m
    ▪ Используется образ gcr.io/k8s-minikube/storage-provisioner:v5
🔎  Компоненты Kubernetes проверяются ...
🌟  Включенные дополнения: storage-provisioner, default-storageclass
🏄  Готово! kubectl настроен для использования кластера "minikube" и "default" пространства имён по умолчанию
```
* 12 Проверка статуса
```
maestro@PC-Ubuntu:~/Рабочий стол$ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

```



## Задача 2: Запуск Hello World
После установки Minikube требуется его проверить. Для этого подойдет стандартное приложение hello world. А для доступа к нему потребуется ingress.

- развернуть через Minikube тестовое приложение по [туториалу](https://kubernetes.io/ru/docs/tutorials/hello-minikube/#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BA%D0%BB%D0%B0%D1%81%D1%82%D0%B5%D1%80%D0%B0-minikube)
- установить аддоны ingress и dashboard

## Задача 3: Установить kubectl

Подготовить рабочую машину для управления корпоративным кластером. Установить клиентское приложение kubectl.
- подключиться к minikube 
- проверить работу приложения из задания 2, запустив port-forward до кластера

## Задача 4 (*): собрать через ansible (необязательное)

Профессионалы не делают одну и ту же задачу два раза. Давайте закрепим полученные навыки, автоматизировав выполнение заданий  ansible-скриптами. При выполнении задания обратите внимание на доступные модули для k8s под ansible.
 - собрать роль для установки minikube на aws сервисе (с установкой ingress)
 - собрать роль для запуска в кластере hello world
  
  ---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
