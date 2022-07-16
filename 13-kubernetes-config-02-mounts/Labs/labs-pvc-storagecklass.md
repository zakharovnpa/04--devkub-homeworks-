## ЛР по запуску сервера NFS и днамческого создания PV

---

### Устанавливаем NFS



### Манифест для создания PVC

* Манифест автоматически сгенерровался после выполнения установки 

`helm install nfs-server stable/nfs-server-provisioner`
* pvc.yaml
```yml
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
```

### В манифесте пода, в спецификаци указать имя PersistentVolumeClaim

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
          name: my-volume   # \
  volumes:                   #   >- имя должно быть одинаковое - my-volume
    - name: my-volume       # /
      persistentVolumeClaim:
        claimName: nfs   # имя должно быть повторено в pvc.yaml
```                                                                   
* pvc.yml                                                             
                                                                      
```yml                                                                
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
```
* storageclass.yml

```yml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: my-nfs
provisioner: cluster.local/nfs-server-nfs-server-provisioner
parameters:
  server: nfs-server-nfs-server-provisioner-0
  path: /share
  readOnly: "false"
```
