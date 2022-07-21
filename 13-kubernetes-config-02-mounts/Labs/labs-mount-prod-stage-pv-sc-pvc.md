## Подключение к общему тому нескольких подов (реплик) в Prod и Stage

### Задача:
1. При репликаци обеспечить подключение всех Backend, Frontend к общему тому
2. Использовать сервер nfs в качестве провижионера.
3. Сначала сделать ручное добавление тома
4. Повторить задачу с динамическим подключением тома.
5. Проверить доступность общих файлов на Frontend и на Backend и возможность обмена информацией.

### Ход выполнения задания

#### 1. При репликаци обеспечить подключение всех Backend, Frontend к общему тому
1. Т.к. в данном решении используется Provisioner NFS для динамического создания тома на основе StorageClass, Манифесты будем создавать такие:

* pv.yaml
```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
```

* fb-pod.yaml
```yml
apiVersion: v1
kind: Pod
metadata:
  name: fb-pod
spec:
  replicas: 3
  containers:
    - name: frontend
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
    - name: backend
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```

* pvc.yaml
```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
### Логи

```
controlplane $ date
Thu Jul 21 02:33:48 UTC 2022
controlplane $ 
controlplane $ mkdir -p My-Project
controlplane $ 
controlplane $ cd My-Project/
controlplane $ 
controlplane $ vi fb-pod.yaml
controlplane $ 
controlplane $ vi pvc.yaml
controlplane $ 
controlplane $ vi pv.yaml
controlplane $ 
controlplane $ 
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Jul 21 02:36 .
drwx------ 8 root root 4.0K Jul 21 02:36 ..
-rw-r--r-- 1 root root  402 Jul 21 02:35 fb-pod.yaml
-rw-r--r-- 1 root root  186 Jul 21 02:36 pv.yaml
-rw-r--r-- 1 root root  178 Jul 21 02:35 pvc.yaml
controlplane $ 
controlplane $ cat fb-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: fb-pod
spec:
  replicas: 3
  containers:
    - name: frontend
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
    - name: backend
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
controlplane $ 
controlplane $ cat pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ cat pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
controlplane $ 
controlplane $ date
Thu Jul 21 02:36:53 UTC 2022
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ ##############################################3
controlplane $ 
controlplane $ 
controlplane $ ######################################
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          4m10s
controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io 
NAME   PROVISIONER                                       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
nfs    cluster.local/nfs-server-nfs-server-provisioner   Delete          Immediate           true                   4m16s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv                            
No resources found
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl get svc
NAME                                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                                                                     AGE
kubernetes                          ClusterIP   10.96.0.1        <none>        443/TCP                                                                                                     73d
nfs-server-nfs-server-provisioner   ClusterIP   10.108.237.214   <none>        2049/TCP,2049/UDP,32803/TCP,32803/UDP,20048/TCP,20048/UDP,875/TCP,875/UDP,111/TCP,111/UDP,662/TCP,662/UDP   4m30s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ # start PV 
controlplane $ 
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
controlplane $ 
controlplane $ kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     6s
controlplane $ 
controlplane $ # start Pod
controlplane $ 
controlplane $ kubectl apply -f fb-pod.yaml 
error: error validating "fb-pod.yaml": error validating data: ValidationError(Pod.spec): unknown field "replicas" in io.k8s.api.core.v1.PodSpec; if you choose to ignore these errors, turn validation off with --validate=false
controlplane $ 
controlplane $ vi fb-pod.yaml 
controlplane $ 
controlplane $ kubectl apply -f fb-pod.yaml 
pod/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
fb-pod                                0/2     Pending   0          10s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          8m6s
controlplane $ 
controlplane $ # start PVC
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ date
Thu Jul 21 02:41:47 UTC 2022
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
fb-pod                                2/2     Running   0          44s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          8m40s
controlplane $ 
controlplane $     
controlplane $ kubectl exec fb-pod -c frontend -it bash -- ls -lha | grep static
drwxr-xr-x   2 root root 4.0K Jul 21 02:41 static
controlplane $ 
controlplane $ kubectl exec fb-pod -c backend -it bash -- ls -lha | grep static
error: unable to upgrade connection: container not found ("backend")
controlplane $ 
controlplane $ 
controlplane $ kubectl exec fb-pod -c backend -it bash -- ls -lha | grep static
error: unable to upgrade connection: container not found ("backend")
controlplane $ 
controlplane $ kubectl describe po fb-pod 
Name:         fb-pod
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Thu, 21 Jul 2022 02:41:43 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: f6536f252ca2c0ccf447d396ddc24d22bd673e63f7bdbe8c560c1a5079120442
              cni.projectcalico.org/podIP: 192.168.1.5/32
              cni.projectcalico.org/podIPs: 192.168.1.5/32
Status:       Running
IP:           192.168.1.5
IPs:
  IP:  192.168.1.5
Containers:
  frontend:
    Container ID:   containerd://63fedf21ac6538e4b54c43239e55e76b6abf8fc5f3c79f41bea7cf106d2f024b
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:1761fb5661e4d77e107427d8012ad3a5955007d997e0f4a3d41acc9ff20467c7
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 21 Jul 2022 02:41:47 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-7lbhh (ro)
  backend:
    Container ID:   containerd://35f11bfc98b3c145bd9947ac2292c0f32ace1b9909af87b2f0485a3b220e9b8e
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:1761fb5661e4d77e107427d8012ad3a5955007d997e0f4a3d41acc9ff20467c7
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Thu, 21 Jul 2022 02:43:34 +0000
      Finished:     Thu, 21 Jul 2022 02:43:36 +0000
    Ready:          False
    Restart Count:  4
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-7lbhh (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-7lbhh:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason            Age                   From               Message
  ----     ------            ----                  ----               -------
  Warning  FailedScheduling  3m41s                 default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  3m7s                  default-scheduler  running PreFilter plugin "VolumeBinding": %!!(MISSING)w(<nil>)
  Normal   Scheduled         3m5s                  default-scheduler  Successfully assigned default/fb-pod to node01
  Normal   Pulling           3m4s                  kubelet            Pulling image "nginx"
  Normal   Started           3m1s                  kubelet            Started container frontend
  Normal   Pulled            3m1s                  kubelet            Successfully pulled image "nginx" in 3.37489738s
  Normal   Created           3m1s                  kubelet            Created container frontend
  Normal   Pulled            3m                    kubelet            Successfully pulled image "nginx" in 373.075349ms
  Normal   Pulled            2m56s                 kubelet            Successfully pulled image "nginx" in 331.896143ms
  Normal   Pulled            2m40s                 kubelet            Successfully pulled image "nginx" in 374.432928ms
  Normal   Pulling           2m11s (x4 over 3m1s)  kubelet            Pulling image "nginx"
  Normal   Started           2m10s (x4 over 3m)    kubelet            Started container backend
  Normal   Created           2m10s (x4 over 3m)    kubelet            Created container backend
  Normal   Pulled            2m10s                 kubelet            Successfully pulled image "nginx" in 314.974679ms
  Warning  BackOff           114s (x5 over 2m53s)  kubelet            Back-off restarting failed container
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS             RESTARTS      AGE
fb-pod                                1/2     CrashLoopBackOff   5 (31s ago)   4m24s
nfs-server-nfs-server-provisioner-0   1/1     Running            0             12m
controlplane $ 
controlplane $ 
controlplane $ kubectl logs fb-pod 
Defaulted container "frontend" out of: frontend, backend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/21 02:41:47 [notice] 1#1: using the "epoll" event method
2022/07/21 02:41:47 [notice] 1#1: nginx/1.23.1
2022/07/21 02:41:47 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/21 02:41:47 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/21 02:41:47 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/21 02:41:47 [notice] 1#1: start worker processes
2022/07/21 02:41:47 [notice] 1#1: start worker process 30
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS             RESTARTS      AGE
fb-pod                                1/2     CrashLoopBackOff   5 (73s ago)   5m6s
nfs-server-nfs-server-provisioner-0   1/1     Running            0             13m
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS             RESTARTS      AGE
fb-pod                                1/2     CrashLoopBackOff   6 (57s ago)   7m40s
nfs-server-nfs-server-provisioner-0   1/1     Running            0             15m
controlplane $ 
controlplane $ kubectl delete -f fb-pod.yaml 
pod "fb-pod" deleted
controlplane $ 
controlplane $ 
controlplane $ vi fb-pod.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f fb-pod.yaml 
pod/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
fb-pod                                2/2     Running   0          5s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          16m
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
fb-pod                                2/2     Running   0          8s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          16m
controlplane $ 
controlplane $ kubectl exec fb-pod -c frontend -it bash -- ls -lha | grep static
drwxr-xr-x   2 root root 4.0K Jul 21 02:41 static
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- ls -lha | grep static
drwxr-xr-x    2 root     root        4.0K Jul 21 02:41 static
controlplane $ 
controlplane $ kubectl exec fb-pod -c frontend -it bash -- echo '42' > 42.txt   
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- cat /static/42.txt
cat: can't open '/static/42.txt': No such file or directory
command terminated with exit code 1
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- cat static/42.txt
cat: can't open 'static/42.txt': No such file or directory
command terminated with exit code 1
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- ls /static       
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- ls static
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- cd static && ls -lha
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "94a71a18b28295488318ddc189e32c763cee954b97982c409789a7f086481637": OCI runtime exec failed: exec failed: unable to start container process: exec: "cd": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash -- cd /static && ls -lha
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "b472e64640cca43ac78067e04c0b33b19381142fe13510af1338204554f8930a": OCI runtime exec failed: exec failed: unable to start container process: exec: "cd": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash                         
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "2c46c3e66892cd5be19bdc1fc54595081739d0a1a774e5c78c3fff6d9d92afd0": OCI runtime exec failed: exec failed: unable to start container process: exec: "bash": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash 
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "534dc0838a24770107c891eb1f5475b013906299de327fb2eef2f90c8a450293": OCI runtime exec failed: exec failed: unable to start container process: exec: "bash": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ 
controlplane $ kubectl get pod
NAME                                  READY   STATUS    RESTARTS   AGE
fb-pod                                2/2     Running   0          3m29s
nfs-server-nfs-server-provisioner-0   1/1     Running   0          20m
controlplane $ 
controlplane $ kubectl exec fb-pod -c frontend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod:/# 
root@fb-pod:/# cd static/
root@fb-pod:/static# 
root@fb-pod:/static# ls -lha
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul 21 02:41 .
drwxr-xr-x 1 root root 4.0K Jul 21 02:49 ..
root@fb-pod:/static# 
root@fb-pod:/static# cd
root@fb-pod:~# 
root@fb-pod:~# find / -name 42.txt
find: '/proc/31/map_files': Permission denied
root@fb-pod:~# 
root@fb-pod:~# 
root@fb-pod:~# 
root@fb-pod:~# cd static
bash: cd: static: No such file or directory
root@fb-pod:~# 
root@fb-pod:~# cd /static
root@fb-pod:/static# 
root@fb-pod:/static# 
root@fb-pod:/static# echo '42' > 42.txt
root@fb-pod:/static# 
root@fb-pod:/static# ls
42.txt
root@fb-pod:/static# 
root@fb-pod:/static# cat 42.txt 
42
root@fb-pod:/static# 
root@fb-pod:/static# 
root@fb-pod:/static# exit
exit
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "aa650b459ffa026b7679414c0e9f75137575cb6333405959267db07262081263": OCI runtime exec failed: exec failed: unable to start container process: exec: "bash": executable file not found in $PATH: unknown
controlplane $ 
controlplane $ kubectl exec fb-pod -c busybox -it sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/ # 
/ # 
/ # ls
bin     dev     etc     home    proc    root    static  sys     tmp     usr     var
/ # 
/ # cd static/
/static # 
/static # ls
42.txt
/static # 
/static # echo '43' > 43.txt
/static # 
/static # ls
42.txt  43.txt
/static # 
/static # cat 43.txt 
43
/static # 
/static # exit
controlplane $ 
controlplane $ 
controlplane $ kubectl exec fb-pod -c frontend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod:/# 
root@fb-pod:/# cd static/
root@fb-pod:/static# 
root@fb-pod:/static# ls -lha
total 16K
drwxr-xr-x 2 root root 4.0K Jul 21 02:56 .
drwxr-xr-x 1 root root 4.0K Jul 21 02:49 ..
-rw-r--r-- 1 root root    3 Jul 21 02:55 42.txt
-rw-r--r-- 1 root root    3 Jul 21 02:56 43.txt
root@fb-pod:/static# 
root@fb-pod:/static# cat 42.txt 
42
root@fb-pod:/static# 
root@fb-pod:/static# cat 43.txt 
43
root@fb-pod:/static# 
root@fb-pod:/static# exit
exit
controlplane $ 
controlplane $ ls -lha
total 24K
drwxr-xr-x 2 root root 4.0K Jul 21 02:50 .
drwx------ 8 root root 4.0K Jul 21 02:49 ..
-rw-r--r-- 1 root root    4 Jul 21 02:50 42.txt
-rw-r--r-- 1 root root  423 Jul 21 02:49 fb-pod.yaml
-rw-r--r-- 1 root root  186 Jul 21 02:36 pv.yaml
-rw-r--r-- 1 root root  178 Jul 21 02:35 pvc.yaml
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ cat 42.txt 
42
controlplane $ 
controlplane $ cat 
^Z
[1]+  Stopped                 cat
controlplane $ 
controlplane $ 
controlplane $ cat fb-pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: fb-pod
spec:
  containers:
    - name: frontend
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
    - name: busybox
      image: busybox
      command: ["sleep", "3600"]
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
controlplane $ 
controlplane $ 
controlplane $ cat pv
cat: pv: No such file or directory
controlplane $ 
controlplane $ cat pv.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  capacity:
    storage: 2Gi
  hostPath:
    path: /data/pv
controlplane $ 
controlplane $ 
controlplane $ cat pvc.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
controlplane $ 
controlplane $ 
controlplane $ date
Thu Jul 21 02:59:18 UTC 2022
controlplane $ 
controlplane $ 
```

```
node01 $ 
node01 $ 
node01 $ find / -name 42.txt
/data/pv/42.txt
node01 $ 
node01 $ 
node01 $ find / -name 43.txt
/data/pv/43.txt
node01 $ 
node01 $ 
node01 $ 
```
