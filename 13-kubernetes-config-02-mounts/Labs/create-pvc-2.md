```
     SecurityContext holds pod-level security attributes and common container
     settings. Optional: Defaults to empty. See type description for default
     values of each field.

   serviceAccount       <string>
     DeprecatedServiceAccount is a depreciated alias for ServiceAccountName.
     Deprecated: Use serviceAccountName instead.

   serviceAccountName   <string>
     ServiceAccountName is the name of the ServiceAccount to use to run this
     pod. More info:
     https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

   setHostnameAsFQDN    <boolean>
     If true the pod's hostname will be configured as the pod's FQDN, rather
     than the leaf name (the default). In Linux containers, this means setting
     the FQDN in the hostname field of the kernel (the nodename field of struct
     utsname). In Windows containers, this means setting the registry value of
     hostname for the registry key
     HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters to
     FQDN. If a pod does not have FQDN, this has no effect. Default to false.

   shareProcessNamespace        <boolean>
     Share a single process namespace between all of the containers in a pod.
     When this is set containers will be able to view and signal processes from
     other containers in the same pod, and the first process in each container
     will not be assigned PID 1. HostPID and ShareProcessNamespace cannot both
     be set. Optional: Default to false.

   subdomain    <string>
     If specified, the fully qualified Pod hostname will be
     "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>". If not
     specified, the pod will not have a domainname at all.

   terminationGracePeriodSeconds        <integer>
     Optional duration in seconds the pod needs to terminate gracefully. May be
     decreased in delete request. Value must be non-negative integer. The value
     zero indicates stop immediately via the kill signal (no opportunity to shut
     down). If this value is nil, the default grace period will be used instead.
     The grace period is the duration in seconds after the processes running in
     the pod are sent a termination signal and the time when the processes are
     forcibly halted with a kill signal. Set this value longer than the expected
     cleanup time for your process. Defaults to 30 seconds.

   tolerations  <[]Object>
     If specified, the pod's tolerations.

   topologySpreadConstraints    <[]Object>
     TopologySpreadConstraints describes how a group of pods ought to spread
     across topology domains. Scheduler will schedule pods in a way which abides
     by the constraints. All topologySpreadConstraints are ANDed.

   volumes      <[]Object>
     List of volumes that can be mounted by containers belonging to the pod.
     More info: https://kubernetes.io/docs/concepts/storage/volumes

controlplane $ kubectl explain Pod.spec.volumes.
KIND:     Pod
VERSION:  v1

RESOURCE: volumes <[]Object>

DESCRIPTION:
     List of volumes that can be mounted by containers belonging to the pod.
     More info: https://kubernetes.io/docs/concepts/storage/volumes

     Volume represents a named volume in a pod that may be accessed by any
     container in the pod.

FIELDS:
   awsElasticBlockStore <Object>
     awsElasticBlockStore represents an AWS Disk resource that is attached to a
     kubelet's host machine and then exposed to the pod. More info:
     https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore

   azureDisk    <Object>
     azureDisk represents an Azure Data Disk mount on the host and bind mount to
     the pod.

   azureFile    <Object>
     azureFile represents an Azure File Service mount on the host and bind mount
     to the pod.

   cephfs       <Object>
     cephFS represents a Ceph FS mount on the host that shares a pod's lifetime

   cinder       <Object>
     cinder represents a cinder volume attached and mounted on kubelets host
     machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md

   configMap    <Object>
     configMap represents a configMap that should populate this volume

   csi  <Object>
     csi (Container Storage Interface) represents ephemeral storage that is
     handled by certain external CSI drivers (Beta feature).

   downwardAPI  <Object>
     downwardAPI represents downward API about the pod that should populate this
     volume

   emptyDir     <Object>
     emptyDir represents a temporary directory that shares a pod's lifetime.
     More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir

   ephemeral    <Object>
     ephemeral represents a volume that is handled by a cluster storage driver.
     The volume's lifecycle is tied to the pod that defines it - it will be
     created before the pod starts, and deleted when the pod is removed.

     Use this if: a) the volume is only needed while the pod runs, b) features
     of normal volumes like restoring from snapshot or capacity tracking are
     needed, c) the storage driver is specified through a storage class, and d)
     the storage driver supports dynamic volume provisioning through a
     PersistentVolumeClaim (see EphemeralVolumeSource for more information on
     the connection between this volume type and PersistentVolumeClaim).

     Use PersistentVolumeClaim or one of the vendor-specific APIs for volumes
     that persist for longer than the lifecycle of an individual pod.

     Use CSI for light-weight local ephemeral volumes if the CSI driver is meant
     to be used that way - see the documentation of the driver for more
     information.

     A pod can use both types of ephemeral volumes and persistent volumes at the
     same time.

   fc   <Object>
     fc represents a Fibre Channel resource that is attached to a kubelet's host
     machine and then exposed to the pod.

   flexVolume   <Object>
     flexVolume represents a generic volume resource that is
     provisioned/attached using an exec based plugin.

   flocker      <Object>
     flocker represents a Flocker volume attached to a kubelet's host machine.
     This depends on the Flocker control service being running

   gcePersistentDisk    <Object>
     gcePersistentDisk represents a GCE Disk resource that is attached to a
     kubelet's host machine and then exposed to the pod. More info:
     https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk

   gitRepo      <Object>
     gitRepo represents a git repository at a particular revision. DEPRECATED:
     GitRepo is deprecated. To provision a container with a git repo, mount an
     EmptyDir into an InitContainer that clones the repo using git, then mount
     the EmptyDir into the Pod's container.

   glusterfs    <Object>
     glusterfs represents a Glusterfs mount on the host that shares a pod's
     lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md

   hostPath     <Object>
     hostPath represents a pre-existing file or directory on the host machine
     that is directly exposed to the container. This is generally used for
     system agents or other privileged things that are allowed to see the host
     machine. Most containers will NOT need this. More info:
     https://kubernetes.io/docs/concepts/storage/volumes#hostpath

   iscsi        <Object>
     iscsi represents an ISCSI Disk resource that is attached to a kubelet's
     host machine and then exposed to the pod. More info:
     https://examples.k8s.io/volumes/iscsi/README.md

   name <string> -required-
     name of the volume. Must be a DNS_LABEL and unique within the pod. More
     info:
     https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names

   nfs  <Object>
     nfs represents an NFS mount on the host that shares a pod's lifetime More
     info: https://kubernetes.io/docs/concepts/storage/volumes#nfs

   persistentVolumeClaim        <Object>
     persistentVolumeClaimVolumeSource represents a reference to a
     PersistentVolumeClaim in the same namespace. More info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

   photonPersistentDisk <Object>
     photonPersistentDisk represents a PhotonController persistent disk attached
     and mounted on kubelets host machine

   portworxVolume       <Object>
     portworxVolume represents a portworx volume attached and mounted on
     kubelets host machine

   projected    <Object>
     projected items for all in one resources secrets, configmaps, and downward
     API

   quobyte      <Object>
     quobyte represents a Quobyte mount on the host that shares a pod's lifetime

   rbd  <Object>
     rbd represents a Rados Block Device mount on the host that shares a pod's
     lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md

   scaleIO      <Object>
     scaleIO represents a ScaleIO persistent volume attached and mounted on
     Kubernetes nodes.

   secret       <Object>
     secret represents a secret that should populate this volume. More info:
     https://kubernetes.io/docs/concepts/storage/volumes#secret

   storageos    <Object>
     storageOS represents a StorageOS volume attached and mounted on Kubernetes
     nodes.

   vsphereVolume        <Object>
     vsphereVolume represents a vSphere volume attached and mounted on kubelets
     host machine

controlplane $ 
controlplane $ 
controlplane $ kubectl get po                   
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          11m
controlplane $ 
controlplane $ kubectl describe po pod
Name:         pod
Namespace:    default
Priority:     0
Node:         <none>
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  nginx:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-p9tzb (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-p9tzb:
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
  Type     Reason            Age                From               Message
  ----     ------            ----               ----               -------
  Warning  FailedScheduling  68s (x3 over 11m)  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          12m
controlplane $ 
controlplane $ 
controlplane $ kubectl describe po pod
Name:         pod
Namespace:    default
Priority:     0
Node:         <none>
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  nginx:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-p9tzb (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-p9tzb:
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
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  2m46s (x3 over 13m)  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  9s                   default-scheduler  running PreFilter plugin "VolumeBinding": %!!(MISSING)w(<nil>)
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pv.yaml  
persistentvolume/pv created
controlplane $ 
controlplane $ kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          14m
controlplane $ 
controlplane $ kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          14m
controlplane $ kubectl get po
^[[ANAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          14m
controlplane $ kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          14m
controlplane $ kubectl get po
NAME   READY   STATUS              RESTARTS   AGE
pod    0/1     ContainerCreating   0          14m
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
pod    1/1     Running   0          14m
controlplane $ 
controlplane $ kubectl describe po pod
Name:         pod
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Fri, 15 Jul 2022 04:18:11 +0000
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: 279eddccf6c15201535b4ef6e86e67e275e383e819c355e2d64901f6b8e42d7f
              cni.projectcalico.org/podIP: 192.168.1.5/32
              cni.projectcalico.org/podIPs: 192.168.1.5/32
Status:       Running
IP:           192.168.1.5
IPs:
  IP:  192.168.1.5
Containers:
  nginx:
    Container ID:   containerd://a70eb5819e03987b49e431689b478efb99fd257c82a2a8b4b5a51958ddc0abc8
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 15 Jul 2022 04:18:12 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /static from my-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-p9tzb (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-p9tzb:
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
  Type     Reason            Age                  From               Message
  ----     ------            ----                 ----               -------
  Warning  FailedScheduling  4m15s (x3 over 14m)  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  98s                  default-scheduler  running PreFilter plugin "VolumeBinding": %!!(MISSING)w(<nil>)
  Warning  FailedScheduling  21s                  default-scheduler  0/2 nodes are available: 2 pod has unbound immediate PersistentVolumeClaims. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Normal   Scheduled         10s                  default-scheduler  Successfully assigned default/pod to node01
  Normal   Pulling           10s                  kubelet            Pulling image "nginx"
  Normal   Pulled            9s                   kubelet            Successfully pulled image "nginx" in 471.999582ms
  Normal   Created           9s                   kubelet            Created container nginx
  Normal   Started           9s                   kubelet            Started container nginx
controlplane $ 
```
