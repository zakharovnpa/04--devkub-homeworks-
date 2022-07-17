## Успешная ЛР по запуску сервера NFS и днамческого создания PV

#### Установка NFS, запуск StorageClass на Control Node

#### Установка NFS Worker Node

#### Логи по запуску
* pvc.yaml
```yml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```
* pod.yaml
```yml
---
apiVersion: v1
kind: Pod
metadata:
  name: pod
spec:
  containers:
    - name: nginx
      image: nginx
      volumeMounts:
        - mountPath: "/static"
          name: my-volume
  volumes:
    - name: my-volume
      persistentVolumeClaim:
        claimName: pvc
```

* [Лои смотри здесь](/13-kubernetes-config-02-mounts/Logs/logs-ok-start-nfs-pvc-pv.md)

