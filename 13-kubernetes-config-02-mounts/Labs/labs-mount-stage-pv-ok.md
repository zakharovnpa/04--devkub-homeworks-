## Успешное подключение Deployment Stage


```
controlplane $ ls -lha
total 20K
drwxr-xr-x 2 root root 4.0K Jul 21 13:55 .
drwx------ 8 root root 4.0K Jul 21 13:55 ..
-rw-r--r-- 1 root root  186 Jul 21 13:51 pv.yaml
-rw-r--r-- 1 root root  197 Jul 21 13:55 pvc.yaml
-rw-r--r-- 1 root root 1.1K Jul 21 13:55 stage-front-back.yaml
controlplane $ 
controlplane $ 
```
* cat pv.yaml

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
* cat pvc.yaml
```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
  namespace: stage
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```

* stage-front-back.yaml
```yml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod 
  namespace: stage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fb-app
  template:
    metadata:
      labels:
        app: fb-app
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
          ports:
          - containerPort: 80
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
          volumeMounts:
            - mountPath: "/static"
              name: my-volume
      volumes:
       - name: my-volume
         persistentVolumeClaim:
           claimName: pvc
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-pod
  namespace: stage
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb-pod
```




* Tab 1

```
nitialising Kubernetes... done

controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   145k      0 --:--:-- --:--:-- --:--:--  145k
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
controlplane $ 
controlplane $ helm repo add stable https://charts.helm.sh/stable
"stable" has been added to your repositories
controlplane $ 
controlplane $ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
controlplane $ 
controlplane $ 
controlplane $ helm install nfs-server stable/nfs-server-provisioner 
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Thu Jul 21 13:50:24 2022
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
controlplane $ 
controlplane $ 
controlplane $ apt install nfs-common -y
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
Fetched 404 kB in 0s (1750 kB/s)       
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
controlplane $ mkdir -p My-project
controlplane $ 
controlplane $ cd My-project/
controlplane $ 
controlplane $ vi pvc.yaml
controlplane $ 
controlplane $ vi pv.yaml
controlplane $ 
controlplane $ mv pvc.yaml pv.yaml
controlplane $ 
controlplane $ vi pvc.yaml
controlplane $ 
controlplane $ vi stage-front-back.yaml
controlplane $ 
controlplane $ kubectl create namespace stage
namespace/stage created
controlplane $ 
controlplane $ 
controlplane $ vi pvc.yaml 
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          5m31s
controlplane $ 
controlplane $ kubectl get pv
No resources found
controlplane $ 
controlplane $ kubectl get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl -n stage get pvc
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get pv 
No resources found
controlplane $ 
controlplane $ kubectl -n stage get p0
error: the server doesn't have a resource type "p0"
controlplane $ 
controlplane $ kubectl -n stage get po
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get svc
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl -n stage get deployments.apps 
No resources found in stage namespace.
controlplane $ 
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     7s
controlplane $ 
controlplane $ kubectl -n default get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv     2Gi        RWX            Retain           Available           nfs                     20s
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n default get pvc
No resources found in default namespace.
controlplane $ 
controlplane $ kubectl -n stage get pvc
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc    Bound    pv       2Gi        RWX            nfs            11s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f stage-front-back.yaml 
deployment.apps/fb-pod created
service/fb-pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   0/1     1            0           22s
controlplane $ 
controlplane $ kubectl -n stage get pod              
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-lqh7v   2/2     Running   0          36s
controlplane $ 
controlplane $ kubectl -n stage logs fb-pod-6c4fbd7c86-lqh7v -c frontend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/21 13:57:54 [notice] 1#1: using the "epoll" event method
2022/07/21 13:57:54 [notice] 1#1: nginx/1.23.0
2022/07/21 13:57:54 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/21 13:57:54 [notice] 1#1: OS: Linux 5.4.0-88-generic
2022/07/21 13:57:54 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/21 13:57:54 [notice] 1#1: start worker processes
2022/07/21 13:57:54 [notice] 1#1: start worker process 30
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage logs fb-pod-6c4fbd7c86-lqh7v -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [7] using statreload
Process SpawnProcess-1:
Traceback (most recent call last):
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
psycopg2.OperationalError: could not translate host name "db" to address: Name or service not known


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
    self.run()
  File "/usr/local/lib/python3.9/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/subprocess.py", line 61, in subprocess_started
    target(sockets=sockets)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 49, in run
    loop.run_until_complete(self.serve(sockets=sockets))
  File "/usr/local/lib/python3.9/asyncio/base_events.py", line 647, in run_until_complete
    return future.result()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/server.py", line 56, in serve
    config.load()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/config.py", line 308, in load
    self.loaded_app = import_from_string(self.app)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/uvicorn/importer.py", line 20, in import_from_string
    module = importlib.import_module(module_str)
  File "/usr/local/lib/python3.9/importlib/__init__.py", line 127, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1030, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1007, in _find_and_load
  File "<frozen importlib._bootstrap>", line 986, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 680, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 850, in exec_module
  File "<frozen importlib._bootstrap>", line 228, in _call_with_frames_removed
  File "/app/./main.py", line 46, in <module>
    metadata.create_all(engine)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/sql/schema.py", line 4664, in create_all
    bind._run_visitor(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2094, in _run_visitor
    with self._optional_conn_ctx_manager(connection) as conn:
  File "/usr/local/lib/python3.9/contextlib.py", line 119, in __enter__
    return next(self.gen)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2086, in _optional_conn_ctx_manager
    with self._contextual_connect() as conn:
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2302, in _contextual_connect
    self._wrap_pool_connect(self.pool.connect, None),
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2339, in _wrap_pool_connect
    Connection._handle_dbapi_exception_noconnection(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 1583, in _handle_dbapi_exception_noconnection
    util.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/base.py", line 2336, in _wrap_pool_connect
    return fn()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 364, in connect
    return _ConnectionFairy._checkout(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 778, in _checkout
    fairy = _ConnectionRecord.checkout(pool)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 495, in checkout
    rec = pool._do_get()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 140, in _do_get
    self._dec_overflow()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/impl.py", line 137, in _do_get
    return self._create_connection()
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 309, in _create_connection
    return _ConnectionRecord(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 440, in __init__
    self.__connect(first_connect_check=True)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 661, in __connect
    pool.logger.debug("Error on connect(): %s", e)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/langhelpers.py", line 68, in __exit__
    compat.raise_(
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/util/compat.py", line 182, in raise_
    raise exception
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/pool/base.py", line 656, in __connect
    connection = pool._invoke_creator(self)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/strategies.py", line 114, in connect
    return dialect.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/sqlalchemy/engine/default.py", line 508, in connect
    return self.dbapi.connect(*cargs, **cparams)
  File "/root/.local/share/virtualenvs/app-4PlAip0Q/lib/python3.9/site-packages/psycopg2/__init__.py", line 127, in connect
    conn = _connect(dsn, connection_factory=connection_factory, **kwasync)
sqlalchemy.exc.OperationalError: (psycopg2.OperationalError) could not translate host name "db" to address: Name or service not known

(Background on this error at: http://sqlalche.me/e/13/e3q8)
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c frontend -it bash --
error: you must specify at least one command for the container
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c frontend -it bash   
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-lqh7v:/app# 
root@fb-pod-6c4fbd7c86-lqh7v:/app# cd  
root@fb-pod-6c4fbd7c86-lqh7v:~# 
root@fb-pod-6c4fbd7c86-lqh7v:~# 
root@fb-pod-6c4fbd7c86-lqh7v:~# ls -lha
total 16K
drwx------ 2 root root 4.0K Jun 22 00:00 .
drwxr-xr-x 1 root root 4.0K Jul 21 13:57 ..
-rw-r--r-- 1 root root  571 Apr 10  2021 .bashrc
-rw-r--r-- 1 root root  161 Jul  9  2019 .profile
root@fb-pod-6c4fbd7c86-lqh7v:~# 
root@fb-pod-6c4fbd7c86-lqh7v:~# pwd
/root
root@fb-pod-6c4fbd7c86-lqh7v:~# 
root@fb-pod-6c4fbd7c86-lqh7v:~# cd /
root@fb-pod-6c4fbd7c86-lqh7v:/# 
root@fb-pod-6c4fbd7c86-lqh7v:/# ls -lha
total 96K
drwxr-xr-x   1 root root 4.0K Jul 21 13:57 .
drwxr-xr-x   1 root root 4.0K Jul 21 13:57 ..
drwxr-xr-x   1 root root 4.0K Jul  4 12:30 app
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 bin
drwxr-xr-x   2 root root 4.0K Mar 19 13:46 boot
drwxr-xr-x   5 root root  360 Jul 21 13:57 dev
drwxr-xr-x   1 root root 4.0K Jun 23 04:13 docker-entrypoint.d
-rwxrwxr-x   1 root root 1.2K Jun 23 04:13 docker-entrypoint.sh
drwxr-xr-x   1 root root 4.0K Jul 21 13:57 etc
drwxr-xr-x   2 root root 4.0K Mar 19 13:46 home
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 lib
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 lib64
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 media
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 mnt
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 opt
dr-xr-xr-x 228 root root    0 Jul 21 13:57 proc
drwx------   2 root root 4.0K Jun 22 00:00 root
drwxr-xr-x   1 root root 4.0K Jul 21 13:57 run
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 sbin
drwxr-xr-x   2 root root 4.0K Jun 22 00:00 srv
drwxr-xr-x   2 root root 4.0K Jul 21 13:57 static
dr-xr-xr-x  13 root root    0 Jul 21 13:57 sys
drwxrwxrwt   1 root root 4.0K Jun 23 04:13 tmp
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 usr
drwxr-xr-x   1 root root 4.0K Jun 22 00:00 var
root@fb-pod-6c4fbd7c86-lqh7v:/# 
root@fb-pod-6c4fbd7c86-lqh7v:/# cd static/
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls -lha
total 8.0K
drwxr-xr-x 2 root root 4.0K Jul 21 13:57 .
drwxr-xr-x 1 root root 4.0K Jul 21 13:57 ..
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# echo '42' > 42.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# cat 42.txt 
42
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls -lha
total 16K
drwxr-xr-x 2 root root 4.0K Jul 21 14:03 .
drwxr-xr-x 1 root root 4.0K Jul 21 13:57 ..
-rw-r--r-- 1 root root    3 Jul 21 14:02 42.txt
-rw-r--r-- 1 root root    3 Jul 21 14:03 43.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# cat 43.txt 
43
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
```
* Tab 2

```
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-lqh7v:/app# cd /
root@fb-pod-6c4fbd7c86-lqh7v:/# 
root@fb-pod-6c4fbd7c86-lqh7v:/# cd static/
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls
42.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# echo '43' > 43.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls
42.txt  43.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
```
* Tab 3

```
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c backend -it bash
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-lqh7v:/app# cd /
root@fb-pod-6c4fbd7c86-lqh7v:/# 
root@fb-pod-6c4fbd7c86-lqh7v:/# cd static/
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls
42.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# echo '43' > 43.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# ls
42.txt  43.txt
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
root@fb-pod-6c4fbd7c86-lqh7v:/static# 
```

* Tab 4
```
ontrolplane $ 
controlplane $ 
controlplane $ kubectl -n stage scale deployment fb-pod --replicas=3
deployment.apps/fb-pod scaled
controlplane $ 
controlplane $ kubectl -n stage get deployment
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   2/3     3            2           7m49s
controlplane $ 
controlplane $ kubectl -n stage get deployment
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   2/3     3            2           7m57s
controlplane $ 
controlplane $ kubectl -n stage get pod       
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-6c4fbd7c86-2b99x   2/2     Running   0          50s
fb-pod-6c4fbd7c86-8tprw   2/2     Running   0          50s
fb-pod-6c4fbd7c86-lqh7v   2/2     Running   0          8m11s
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -it bash -- ls /static
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -c frontend -it bash -- ls /static
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -c frontend -it bash              
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -c frontend -it bash -- ls /static
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -c frontend -it bash -- ls static
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -c frontend -it bash -- pwd      
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-2b99x -c frontend -it sh -- pwd
error: cannot exec into a container in a completed pod; current phase is Failed
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6c4fbd7c86-2b99x   0/2     ContainerStatusUnknown   2          3m37s
fb-pod-6c4fbd7c86-8tprw   2/2     Running                  0          3m37s
fb-pod-6c4fbd7c86-jncwt   2/2     Running                  0          2m21s
fb-pod-6c4fbd7c86-lqh7v   2/2     Running                  0          10m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c frontend -it bash     
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
root@fb-pod-6c4fbd7c86-8tprw:/app# 
root@fb-pod-6c4fbd7c86-8tprw:/app# cd /
root@fb-pod-6c4fbd7c86-8tprw:/# 
root@fb-pod-6c4fbd7c86-8tprw:/# pwd
/
root@fb-pod-6c4fbd7c86-8tprw:/# 
root@fb-pod-6c4fbd7c86-8tprw:/# 
root@fb-pod-6c4fbd7c86-8tprw:/# ls static/
42.txt  43.txt
root@fb-pod-6c4fbd7c86-8tprw:/# 
root@fb-pod-6c4fbd7c86-8tprw:/# exit
exit
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c frontend -it bash -- ls static
image.png
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage get pod
NAME                      READY   STATUS                   RESTARTS   AGE
fb-pod-6c4fbd7c86-2b99x   0/2     ContainerStatusUnknown   2          5m6s
fb-pod-6c4fbd7c86-8tprw   2/2     Running                  0          5m6s
fb-pod-6c4fbd7c86-jncwt   2/2     Running                  0          3m50s
fb-pod-6c4fbd7c86-lqh7v   2/2     Running                  0          12m
controlplane $ 
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-8tprw -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-jncwt -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-jncwt -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c frontend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ kubectl -n stage exec fb-pod-6c4fbd7c86-lqh7v -c backend -it bash -- ls /static
42.txt  43.txt
controlplane $ 
controlplane $ 
```
