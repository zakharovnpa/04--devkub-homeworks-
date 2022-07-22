### Логи выполнения тестового создания окружения с подключением к общему тому в окружении prod

```
Initialising Kubernetes... done

controlplane $ 
controlplane $ date
Fri Jul 22 02:30:56 UTC 2022
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash && \
> helm repo add stable https://charts.helm.sh/stable && helm repo update && \
> helm install nfs-server stable/nfs-server-provisioner && apt install nfs-common -y
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0  91442      0 --:--:-- --:--:-- --:--:-- 91442
Downloading https://get.helm.sh/helm-v3.9.2-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Fri Jul 22 02:31:06 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
The NFS Provisioner service has now been installed.

A storage class named 'nfs' has now been created
and is available to provision dynamic volumes.

You can use this storageclass by creating a `PersistentVolumeClaim` with the
correct storageClassName attribute. For example:

    ---
    kind: PersistentVolumeClaim
    apiVersion: v1
    metadata:
      name: test-dynamic-volume-claim
    spec:
      storageClassName: "nfs"
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: 100Mi
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 194 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 keyutils amd64 1.6-6ubuntu1.1 [44.8 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (1716 kB/s)   
Selecting previously unselected package libtirpc-common.
(Reading database ... 72097 files and directories currently installed.)
Preparing to unpack .../0-libtirpc-common_1.2.5-1_all.deb ...
Unpacking libtirpc-common (1.2.5-1) ...
Selecting previously unselected package libtirpc3:amd64.
Preparing to unpack .../1-libtirpc3_1.2.5-1_amd64.deb ...
Unpacking libtirpc3:amd64 (1.2.5-1) ...
Selecting previously unselected package rpcbind.
Preparing to unpack .../2-rpcbind_1.2.5-8_amd64.deb ...
Unpacking rpcbind (1.2.5-8) ...
Selecting previously unselected package keyutils.
Preparing to unpack .../3-keyutils_1.6-6ubuntu1.1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1.1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1.1) ...
Setting up libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Setting up libtirpc3:amd64 (1.2.5-1) ...
Setting up rpcbind (1.2.5-8) ...
Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /lib/systemd/system/rpcbind.service.
Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /lib/systemd/system/rpcbind.socket.
Setting up nfs-common (1:1.3.4-2.5ubuntu3.4) ...

Creating config file /etc/idmapd.conf with new version
Adding system user `statd' (UID 114) ...
Adding new user `statd' (UID 114) with group `nogroup' ...
Not creating home directory `/var/lib/nfs'.
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
Created symlink /etc/systemd/system/remote-fs.target.wants/nfs-client.target → /lib/systemd/system/nfs-client.target.
nfs-utils.service is a disabled or a static unit, not starting it.
Processing triggers for systemd (245.4-4ubuntu3.13) ...
Processing triggers for man-db (2.9.1-1) ...
Processing triggers for libc-bin (2.31-0ubuntu9.2) ...
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get po 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          73s
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ kubectl get sc
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   80s
controlplane $ 
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ vi pv.yaml
controlplane $ 
controlplane $ vi pvc.yaml
controlplane $ 
controlplane $ vi prod-frontend.yaml
controlplane $ 
controlplane $ vi prod-backend.yaml
controlplane $ 
controlplane $ 
controlplane $ date
Fri Jul 22 02:34:56 UTC 2022
controlplane $ 
controlplane $ kubectl create namespace prod
namespace/prod created
controlplane $ 
controlplane $ kubectl get ns
NAME              STATUS   AGE
default           Active   74d
kube-node-lease   Active   74d
kube-public       Active   74d
kube-system       Active   74d
prod              Active   9s
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 24K
drwxr-xr-x 2 root root 4.0K Jul 22 02:34 .
drwx------ 8 root root 4.0K Jul 22 02:34 ..
-rw-r--r-- 1 root root 1.4K Jul 22 02:34 prod-backend.yaml
-rw-r--r-- 1 root root  774 Jul 22 02:34 prod-frontend.yaml
-rw-r--r-- 1 root root  186 Jul 22 02:33 pv.yaml
-rw-r--r-- 1 root root  196 Jul 22 02:33 pvc.yaml
controlplane $ 
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
controlplane $ 
controlplane $ kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     10s
controlplane $ 
controlplane $ kubectl -n prod get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     21s
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ kubectl -n deafult get pvc
No resources found in deafult namespace.
controlplane $ 
controlplane $ kubectl -n prod get pvc
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pv       2Gi        RWX            nfs            20s
controlplane $ 
controlplane $ kubectl apply -f prod-frontend.yaml 
statefulset.apps/f-pod created
service/f-svc created
controlplane $ 
controlplane $ date
Fri Jul 22 02:37:46 UTC 2022
controlplane $ 
controlplane $ kubectl -n prod get pod
NAME      READY   STATUS    RESTARTS   AGE
f-pod-0   1/1     Running   0          14s
controlplane $ 
controlplane $ kubectl apply -f prod-backend.yaml  
statefulset.apps/b-pod created
service/db created
service/b-pod created
endpoints/db created
controlplane $ 
controlplane $ date
Fri Jul 22 02:38:22 UTC 2022
controlplane $ 
controlplane $ kubectl -n prod get pod
NAME      READY   STATUS              RESTARTS   AGE
b-pod-0   0/1     ContainerCreating   0          11s
f-pod-0   1/1     Running             0          45s
controlplane $ 
controlplane $ kubectl -n prod get pod
NAME      READY   STATUS              RESTARTS   AGE
b-pod-0   0/1     ContainerCreating   0          21s
f-pod-0   1/1     Running             0          55s
controlplane $ 
controlplane $ kubectl -n prod get pod
NAME      READY   STATUS    RESTARTS   AGE
b-pod-0   1/1     Running   0          44s
f-pod-0   1/1     Running   0          78s
controlplane $ 
controlplane $ date
Fri Jul 22 02:39:04 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- pwd
/app
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /static
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '42' > /static/42.txt
bash: /static/42.txt: No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '42' > static/42.txt
bash: static/42.txt: No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cd / && pwd              
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "bcad2eab8f466a4f1505a2911622a33604136e880e7b35bb9d1d621dcb6591c0": OCI runtime exec failed: exec failed: unable to start container process: exec: "cd": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash               
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@b-pod-0:/app# 
root@b-pod-0:/app# pwd
/app
root@b-pod-0:/app# 
root@b-pod-0:/app# ls -lha
total 28K
drwxr-xr-x 1 root root 4.0K Jul 12 14:41 .
drwxr-xr-x 1 root root 4.0K Jul 22 02:38 ..
-rw-r--r-- 1 root root  280 Jul  4 09:09 Pipfile
-rw-r--r-- 1 root root  12K Jul  4 09:09 Pipfile.lock
-rw-r--r-- 1 root root 2.3K Jul  4 09:09 main.py
root@b-pod-0:/app# 
root@b-pod-0:/app# cd /
root@b-pod-0:/# 
root@b-pod-0:/# ls -lha
total 80K
drwxr-xr-x   1 root root 4.0K Jul 22 02:38 .
drwxr-xr-x   1 root root 4.0K Jul 22 02:38 ..
drwxr-xr-x   1 root root 4.0K Jul 12 14:41 app
drwxr-xr-x   1 root root 4.0K Jun 23 00:52 bin
drwxr-xr-x   2 root root 4.0K Mar 19 13:44 boot
drwxr-xr-x   5 root root  360 Jul 22 02:38 dev
drwxr-xr-x   1 root root 4.0K Jul 22 02:38 etc
drwxr-xr-x   2 root root 4.0K Mar 19 13:44 home
drwxr-xr-x   1 root root 4.0K Jun 23 00:52 lib
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 media
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 opt
dr-xr-xr-x 239 root root    0 Jul 22 02:38 proc
drwx------   1 root root 4.0K Jul 12 14:41 root
drwxr-xr-x   1 root root 4.0K Jul 22 02:38 run
drwxr-xr-x   1 root root 4.0K Jun 23 00:51 sbin
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 srv
drwxr-xr-x   2 root root 4.0K Jul 22 02:38 static
dr-xr-xr-x  13 root root    0 Jul 22 02:38 sys
drwxrwxrwt   1 root root 4.0K Jul 12 14:41 tmp
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 usr
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 var
root@b-pod-0:/# 
root@b-pod-0:/# echo '42' > static/42.txt
root@b-pod-0:/# 
root@b-pod-0:/# ls static
42.txt
root@b-pod-0:/# 
root@b-pod-0:/# exit
exit
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls static
ls: cannot access 'static': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /static
42.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cat /static
cat: /static: Is a directory
command terminated with exit code 1
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cat /static/42.txt
42
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '43' > static/43.txt
bash: static/43.txt: No such file or directory
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- touch static/43.txt
touch: cannot touch 'static/43.txt': No such file or directory
command terminated with exit code 1
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- touch /static/43.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '44' > /static/44.txt
bash: /static/44.txt: No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- touch /static/44.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '44' > /static/44.txt
bash: /static/44.txt: No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '44' > static/44.txt
bash: static/44.txt: No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- pwd                      
/app
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- mkdir -p 2-static        
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- echo '45' > 2-static/45.txt
bash: 2-static/45.txt: No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls                         
2-static  Pipfile  Pipfile.lock  main.py
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls 2-static
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- touch 2-static/46.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- touch 2-static/47.txt && touch 2-static/48.txt
touch: cannot touch '2-static/48.txt': No such file or directory
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- touch 2-static/47.txt -- touch 2-static/48.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls 2-static                                   
46.txt  47.txt  48.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls 2-static -- cd / -- ls
ls: cannot access 'cd': No such file or directory
ls: cannot access '--': No such file or directory
ls: cannot access 'ls': No such file or directory
/:
app  boot  etc   lib    media  opt   root  sbin  static  tmp  var
bin  dev   home  lib64  mnt    proc  run   srv   sys     usr

2-static:
46.txt  47.txt  48.txt
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls 2-static -- cd \/ -- ls
ls: cannot access 'cd': No such file or directory
ls: cannot access '--': No such file or directory
ls: cannot access 'ls': No such file or directory
/:
app  boot  etc   lib    media  opt   root  sbin  static  tmp  var
bin  dev   home  lib64  mnt    proc  run   srv   sys     usr

2-static:
46.txt  47.txt  48.txt
command terminated with exit code 2
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls 2-static -- ls
ls: cannot access 'ls': No such file or directory
2-static:
46.txt  47.txt  48.txt
command terminated with exit code 2
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /2-static -- ls
ls: cannot access '/2-static': No such file or directory
ls: cannot access 'ls': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /2-static -- cat 2-static/46.txt
ls: cannot access '/2-static': No such file or directory
ls: cannot access 'cat': No such file or directory
2-static/46.txt
command terminated with exit code 2
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /2-static -- cat 2-static/44.txt
ls: cannot access '/2-static': No such file or directory
ls: cannot access 'cat': No such file or directory
ls: cannot access '2-static/44.txt': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- ls /2-static -- cat static/43.txt
ls: cannot access '/2-static': No such file or directory
ls: cannot access 'cat': No such file or directory
ls: cannot access 'static/43.txt': No such file or directory
command terminated with exit code 2
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cat static/43.txt
cat: static/43.txt: No such file or directory
command terminated with exit code 1
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cat /static/43.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cat /static/44.txt
controlplane $ 
controlplane $ kubectl -n prod exec b-pod-0 -c backend -it bash -- cat /static/42.txt
42
controlplane $ 
controlplane $ 
```
