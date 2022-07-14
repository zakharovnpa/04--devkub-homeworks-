## Логи выполнения работы по созданию общих ресурсов в кубере на сайте 

[https://killercoda.com/playgrounds/scenario/kubernetes](https://killercoda.com/playgrounds/scenario/kubernetes)

### Terminal - 1
```
Initialising Kubernetes... done

controlplane $ kubectl explain PersistentVolumeClaim.spec.
KIND:     PersistentVolumeClaim
VERSION:  v1

RESOURCE: spec <Object>

DESCRIPTION:
     spec defines the desired characteristics of a volume requested by a pod
     author. More info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

     PersistentVolumeClaimSpec describes the common attributes of storage
     devices and allows a Source for provider-specific attributes

FIELDS:
   accessModes  <[]string>
     accessModes contains the desired access modes the volume should have. More
     info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1

   dataSource   <Object>
     dataSource field can be used to specify either: * An existing
     VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An
     existing PVC (PersistentVolumeClaim) If the provisioner or an external
     controller can support the specified data source, it will create a new
     volume based on the contents of the specified data source. If the
     AnyVolumeDataSource feature gate is enabled, this field will always have
     the same contents as the DataSourceRef field.

   dataSourceRef        <Object>
     dataSourceRef specifies the object from which to populate the volume with
     data, if a non-empty volume is desired. This may be any local object from a
     non-empty API group (non core object) or a PersistentVolumeClaim object.
     When this field is specified, volume binding will only succeed if the type
     of the specified object matches some installed volume populator or dynamic
     provisioner. This field will replace the functionality of the DataSource
     field and as such if both fields are non-empty, they must have the same
     value. For backwards compatibility, both fields (DataSource and
     DataSourceRef) will be set to the same value automatically if one of them
     is empty and the other is non-empty. There are two important differences
     between DataSource and DataSourceRef: * While DataSource only allows two
     specific types of objects, DataSourceRef allows any non-core object, as
     well as PersistentVolumeClaim objects.
     * While DataSource ignores disallowed values (dropping them), DataSourceRef
     preserves all values, and generates an error if a disallowed value is
     specified. (Beta) Using this field requires the AnyVolumeDataSource feature
     gate to be enabled.

   resources    <Object>
     resources represents the minimum resources the volume should have. If
     RecoverVolumeExpansionFailure feature is enabled users are allowed to
     specify resource requirements that are lower than previous value but must
     still be higher than capacity recorded in the status field of the claim.
     More info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources

   selector     <Object>
     selector is a label query over volumes to consider for binding.

   storageClassName     <string>
     storageClassName is the name of the StorageClass required by the claim.
     More info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1

   volumeMode   <string>
     volumeMode defines what type of volume is required by the claim. Value of
     Filesystem is implied when not included in claim spec.

   volumeName   <string>
     volumeName is the binding reference to the PersistentVolume backing this
     claim.

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
controlplane $ 
controlplane $ kubectl explain Deployments.spec.
KIND:     Deployment
VERSION:  apps/v1

RESOURCE: spec <Object>

DESCRIPTION:
     Specification of the desired behavior of the Deployment.

     DeploymentSpec is the specification of the desired behavior of the
     Deployment.

FIELDS:
   minReadySeconds      <integer>
     Minimum number of seconds for which a newly created pod should be ready
     without any of its container crashing, for it to be considered available.
     Defaults to 0 (pod will be considered available as soon as it is ready)

   paused       <boolean>
     Indicates that the deployment is paused.

   progressDeadlineSeconds      <integer>
     The maximum time in seconds for a deployment to make progress before it is
     considered to be failed. The deployment controller will continue to process
     failed deployments and a condition with a ProgressDeadlineExceeded reason
     will be surfaced in the deployment status. Note that progress will not be
     estimated during the time a deployment is paused. Defaults to 600s.

   replicas     <integer>
     Number of desired pods. This is a pointer to distinguish between explicit
     zero and not specified. Defaults to 1.

   revisionHistoryLimit <integer>
     The number of old ReplicaSets to retain to allow rollback. This is a
     pointer to distinguish between explicit zero and not specified. Defaults to
     10.

   selector     <Object> -required-
     Label selector for pods. Existing ReplicaSets whose pods are selected by
     this will be the ones affected by this deployment. It must match the pod
     template's labels.

   strategy     <Object>
     The deployment strategy to use to replace existing pods with new ones.

   template     <Object> -required-
     Template describes the pods that will be created.

controlplane $ 
controlplane $ kubectl explain Deployments.spec.template.
KIND:     Deployment
VERSION:  apps/v1

RESOURCE: template <Object>

DESCRIPTION:
     Template describes the pods that will be created.

     PodTemplateSpec describes the data a pod should have when created from a
     template

FIELDS:
   metadata     <Object>
     Standard object's metadata. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata

   spec <Object>
     Specification of the desired behavior of the pod. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

controlplane $ 
controlplane $ 
controlplane $ kubectl explain Deployments.spec.template.spec.
KIND:     Deployment
VERSION:  apps/v1

RESOURCE: spec <Object>

DESCRIPTION:
     Specification of the desired behavior of the pod. More info:
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

     PodSpec is a description of a pod.

FIELDS:
   activeDeadlineSeconds        <integer>
     Optional duration in seconds the pod may be active on the node relative to
     StartTime before the system will actively try to mark it failed and kill
     associated containers. Value must be a positive integer.

   affinity     <Object>
     If specified, the pod's scheduling constraints

   automountServiceAccountToken <boolean>
     AutomountServiceAccountToken indicates whether a service account token
     should be automatically mounted.

   containers   <[]Object> -required-
     List of containers belonging to the pod. Containers cannot currently be
     added or removed. There must be at least one container in a Pod. Cannot be
     updated.

   dnsConfig    <Object>
     Specifies the DNS parameters of a pod. Parameters specified here will be
     merged to the generated DNS configuration based on DNSPolicy.

   dnsPolicy    <string>
     Set DNS policy for the pod. Defaults to "ClusterFirst". Valid values are
     'ClusterFirstWithHostNet', 'ClusterFirst', 'Default' or 'None'. DNS
     parameters given in DNSConfig will be merged with the policy selected with
     DNSPolicy. To have DNS options set along with hostNetwork, you have to
     specify DNS policy explicitly to 'ClusterFirstWithHostNet'.

     Possible enum values:
     - `"ClusterFirst"` indicates that the pod should use cluster DNS first
     unless hostNetwork is true, if it is available, then fall back on the
     default (as determined by kubelet) DNS settings.
     - `"ClusterFirstWithHostNet"` indicates that the pod should use cluster DNS
     first, if it is available, then fall back on the default (as determined by
     kubelet) DNS settings.
     - `"Default"` indicates that the pod should use the default (as determined
     by kubelet) DNS settings.
     - `"None"` indicates that the pod should use empty DNS settings. DNS
     parameters such as nameservers and search paths should be defined via
     DNSConfig.

   enableServiceLinks   <boolean>
     EnableServiceLinks indicates whether information about services should be
     injected into pod's environment variables, matching the syntax of Docker
     links. Optional: Defaults to true.

   ephemeralContainers  <[]Object>
     List of ephemeral containers run in this pod. Ephemeral containers may be
     run in an existing pod to perform user-initiated actions such as debugging.
     This list cannot be specified when creating a pod, and it cannot be
     modified by updating the pod spec. In order to add an ephemeral container
     to an existing pod, use the pod's ephemeralcontainers subresource. This
     field is beta-level and available on clusters that haven't disabled the
     EphemeralContainers feature gate.

   hostAliases  <[]Object>
     HostAliases is an optional list of hosts and IPs that will be injected into
     the pod's hosts file if specified. This is only valid for non-hostNetwork
     pods.

   hostIPC      <boolean>
     Use the host's ipc namespace. Optional: Default to false.

   hostNetwork  <boolean>
     Host networking requested for this pod. Use the host's network namespace.
     If this option is set, the ports that will be used must be specified.
     Default to false.

   hostPID      <boolean>
     Use the host's pid namespace. Optional: Default to false.

   hostname     <string>
     Specifies the hostname of the Pod If not specified, the pod's hostname will
     be set to a system-defined value.

   imagePullSecrets     <[]Object>
     ImagePullSecrets is an optional list of references to secrets in the same
     namespace to use for pulling any of the images used by this PodSpec. If
     specified, these secrets will be passed to individual puller
     implementations for them to use. More info:
     https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod

   initContainers       <[]Object>
     List of initialization containers belonging to the pod. Init containers are
     executed in order prior to containers being started. If any init container
     fails, the pod is considered to have failed and is handled according to its
     restartPolicy. The name for an init container or normal container must be
     unique among all containers. Init containers may not have Lifecycle
     actions, Readiness probes, Liveness probes, or Startup probes. The
     resourceRequirements of an init container are taken into account during
     scheduling by finding the highest request/limit for each resource type, and
     then using the max of of that value or the sum of the normal containers.
     Limits are applied to init containers in a similar fashion. Init containers
     cannot currently be added or removed. Cannot be updated. More info:
     https://kubernetes.io/docs/concepts/workloads/pods/init-containers/

   nodeName     <string>
     NodeName is a request to schedule this pod onto a specific node. If it is
     non-empty, the scheduler simply schedules this pod onto that node, assuming
     that it fits resource requirements.

   nodeSelector <map[string]string>
     NodeSelector is a selector which must be true for the pod to fit on a node.
     Selector which must match a node's labels for the pod to be scheduled on
     that node. More info:
     https://kubernetes.io/docs/concepts/configuration/assign-pod-node/

   os   <Object>
     Specifies the OS of the containers in the pod. Some pod and container
     fields are restricted if this is set.

     If the OS field is set to linux, the following fields must be unset:
     -securityContext.windowsOptions

     If the OS field is set to windows, following fields must be unset: -
     spec.hostPID - spec.hostIPC - spec.securityContext.seLinuxOptions -
     spec.securityContext.seccompProfile - spec.securityContext.fsGroup -
     spec.securityContext.fsGroupChangePolicy - spec.securityContext.sysctls -
     spec.shareProcessNamespace - spec.securityContext.runAsUser -
     spec.securityContext.runAsGroup - spec.securityContext.supplementalGroups -
     spec.containers[*].securityContext.seLinuxOptions -
     spec.containers[*].securityContext.seccompProfile -
     spec.containers[*].securityContext.capabilities -
     spec.containers[*].securityContext.readOnlyRootFilesystem -
     spec.containers[*].securityContext.privileged -
     spec.containers[*].securityContext.allowPrivilegeEscalation -
     spec.containers[*].securityContext.procMount -
     spec.containers[*].securityContext.runAsUser -
     spec.containers[*].securityContext.runAsGroup This is a beta field and
     requires the IdentifyPodOS feature

   overhead     <map[string]string>
     Overhead represents the resource overhead associated with running a pod for
     a given RuntimeClass. This field will be autopopulated at admission time by
     the RuntimeClass admission controller. If the RuntimeClass admission
     controller is enabled, overhead must not be set in Pod create requests. The
     RuntimeClass admission controller will reject Pod create requests which
     have the overhead already set. If RuntimeClass is configured and selected
     in the PodSpec, Overhead will be set to the value defined in the
     corresponding RuntimeClass, otherwise it will remain unset and treated as
     zero. More info:
     https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md

   preemptionPolicy     <string>
     PreemptionPolicy is the Policy for preempting pods with lower priority. One
     of Never, PreemptLowerPriority. Defaults to PreemptLowerPriority if unset.

   priority     <integer>
     The priority value. Various system components use this field to find the
     priority of the pod. When Priority Admission Controller is enabled, it
     prevents users from setting this field. The admission controller populates
     this field from PriorityClassName. The higher the value, the higher the
     priority.

   priorityClassName    <string>
     If specified, indicates the pod's priority. "system-node-critical" and
     "system-cluster-critical" are two special keywords which indicate the
     highest priorities with the former being the highest priority. Any other
     name must be defined by creating a PriorityClass object with that name. If
     not specified, the pod priority will be default or zero if there is no
     default.

   readinessGates       <[]Object>
     If specified, all readiness gates will be evaluated for pod readiness. A
     pod is ready when all its containers are ready AND all conditions specified
     in the readiness gates have status equal to "True" More info:
     https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates

   restartPolicy        <string>
     Restart policy for all containers within the pod. One of Always, OnFailure,
     Never. Default to Always. More info:
     https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#restart-policy

     Possible enum values:
     - `"Always"`
     - `"Never"`
     - `"OnFailure"`

   runtimeClassName     <string>
     RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group,
     which should be used to run this pod. If no RuntimeClass resource matches
     the named class, the pod will not be run. If unset or empty, the "legacy"
     RuntimeClass will be used, which is an implicit class with an empty
     definition that uses the default runtime handler. More info:
     https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class

   schedulerName        <string>
     If specified, the pod will be dispatched by specified scheduler. If not
     specified, the pod will be dispatched by default scheduler.

   securityContext      <Object>
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

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl explain Deployments.spec.template.spec.volumes.
KIND:     Deployment
VERSION:  apps/v1

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
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl explain Deployments.spec.template.spec.volumes.persistentVolumeClaim.
KIND:     Deployment
VERSION:  apps/v1

RESOURCE: persistentVolumeClaim <Object>

DESCRIPTION:
     persistentVolumeClaimVolumeSource represents a reference to a
     PersistentVolumeClaim in the same namespace. More info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

     PersistentVolumeClaimVolumeSource references the user's PVC in the same
     namespace. This volume finds the bound PV and mounts that volume for the
     pod. A PersistentVolumeClaimVolumeSource is, essentially, a wrapper around
     another type of volume that is owned by someone else (the system).

FIELDS:
   claimName    <string> -required-
     claimName is the name of a PersistentVolumeClaim in the same namespace as
     the pod using this volume. More info:
     https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims

   readOnly     <boolean>
     readOnly Will force the ReadOnly setting in VolumeMounts. Default false.

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get storageclasses.storage.k8s.io
No resources found
controlplane $ 
controlplane $ kubectl get csinodes
NAME           DRIVERS   AGE
controlplane   0         66d
node01         0         66d
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ ping node01
PING node01 (172.30.2.2) 56(84) bytes of data.
64 bytes from node01 (172.30.2.2): icmp_seq=1 ttl=61 time=0.704 ms
64 bytes from node01 (172.30.2.2): icmp_seq=2 ttl=61 time=0.398 ms
^C
--- node01 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.398/0.551/0.704/0.153 ms
controlplane $ 
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
node01 $ ls -lha
total 28K
drwx------  3 root root 4.0K Jul 14 14:17 .
drwxr-xr-x 19 root root 4.0K May  2 10:23 ..
-rw-------  1 root root   10 Oct  8  2021 .bash_history
-rw-r--r--  1 root root 3.3K May  8 19:39 .bashrc
-rw-r--r--  1 root root  161 Dec  5  2019 .profile
drwx------  2 root root 4.0K May  2 10:20 .ssh
-rw-r--r--  1 root root  109 Jul 14 14:17 .vimrc
lrwxrwxrwx  1 root root    1 May  2 10:23 filesystem -> /
node01 $ 
node01 $ pwd 
/root
node01 $ 
node01 $ cd /
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  19 root root 4.0K May  2 10:23 .
drwxr-xr-x  19 root root 4.0K May  2 10:23 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 103 root root 4.0K May  8 19:46 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 212 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 14 14:17 root
drwxr-xr-x  35 root root 1.1K May  8 19:46 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 14 14:35 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ ls /tmp/
4e15c3fe-ac03-42c5-809b-17b854249267                                   systemd-private-8331619705d04508a430ef0383463737-systemd-logind.service-8DUzMh
github-remote                                                          systemd-private-8331619705d04508a430ef0383463737-systemd-resolved.service-N3HYQf
http-remote                                                            systemd-private-8331619705d04508a430ef0383463737-systemd-timesyncd.service-ORjuYe
netplan_o4qw481v                                                       theia_upload
snap.lxd                                                               tmppsrz5geq
systemd-private-8331619705d04508a430ef0383463737-fwupd.service-29wQ1i
node01 $ 
node01 $ 
node01 $ cd /root/
node01 $ 
node01 $ cd filesystem
node01 $ 
node01 $ pwd
/root/filesystem
node01 $ 
node01 $ ls lha
ls: cannot access 'lha': No such file or directory
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  19 root root 4.0K May  2 10:23 .
drwxr-xr-x  19 root root 4.0K May  2 10:23 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 103 root root 4.0K May  8 19:46 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 212 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 14 14:17 root
drwxr-xr-x  35 root root 1.1K May  8 19:46 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 14 14:35 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ 
node01 $ 
node01 $ kubectl get csidrivers
The connection to the server localhost:8080 was refused - did you specify the right host or port?
node01 $ 
node01 $ exit                                                                             
logout
Connection to node01 closed.
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11156  100 11156    0     0   311k      0 --:--:-- --:--:-- --:--:--  311k
Downloading https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz
Verifying checksum... Done.
Preparing to install helm into /usr/local/bin
helm installed into /usr/local/bin/helm
controlplane $ 
controlplane $ helm repo add stable https://charts.helm.sh/stable && helm repo update
"stable" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈Happy Helming!⎈
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ helm install nfs-server stable/nfs-server-provisioner
WARNING: This chart is deprecated
NAME: nfs-server
LAST DEPLOYED: Thu Jul 14 14:39:43 2022
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
controlplane $ 
controlplane $ sudo apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (1897 kB/s)   
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
Preparing to unpack .../3-keyutils_1.6-6ubuntu1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1) ...
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
controlplane $ 
controlplane $ ssh node01
Last login: Thu Jul 14 14:34:51 2022 from 10.244.4.46
node01 $ 
node01 $ sudo apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Do you want to continue? [Y/n] н
Abort.
node01 $ 
node01 $ sudo apt install nfs-common
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 rpcbind
Suggested packages:
  watchdog
The following NEW packages will be installed:
  keyutils libnfsidmap2 libtirpc-common libtirpc3 nfs-common rpcbind
0 upgraded, 6 newly installed, 0 to remove and 130 not upgraded.
Need to get 404 kB of archives.
After this operation, 1517 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Get:1 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc-common all 1.2.5-1 [7632 B]
Get:2 http://archive.ubuntu.com/ubuntu focal/main amd64 libtirpc3 amd64 1.2.5-1 [77.2 kB]
Get:3 http://archive.ubuntu.com/ubuntu focal/main amd64 rpcbind amd64 1.2.5-8 [42.8 kB]
Get:4 http://archive.ubuntu.com/ubuntu focal/main amd64 keyutils amd64 1.6-6ubuntu1 [45.0 kB]
Get:5 http://archive.ubuntu.com/ubuntu focal/main amd64 libnfsidmap2 amd64 0.25-5.1ubuntu1 [27.9 kB]
Get:6 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 nfs-common amd64 1:1.3.4-2.5ubuntu3.4 [204 kB]
Fetched 404 kB in 0s (2022 kB/s)  
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
Preparing to unpack .../3-keyutils_1.6-6ubuntu1_amd64.deb ...
Unpacking keyutils (1.6-6ubuntu1) ...
Selecting previously unselected package libnfsidmap2:amd64.
Preparing to unpack .../4-libnfsidmap2_0.25-5.1ubuntu1_amd64.deb ...
Unpacking libnfsidmap2:amd64 (0.25-5.1ubuntu1) ...
Selecting previously unselected package nfs-common.
Preparing to unpack .../5-nfs-common_1%3a1.3.4-2.5ubuntu3.4_amd64.deb ...
Unpacking nfs-common (1:1.3.4-2.5ubuntu3.4) ...
Setting up libtirpc-common (1.2.5-1) ...
Setting up keyutils (1.6-6ubuntu1) ...
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
node01 $ 
node01 $ 
node01 $ 
node01 $ type nfs-server
-bash: type: nfs-server: not found
node01 $ 
node01 $ type nfs-common
-bash: type: nfs-common: not found
node01 $ 
node01 $ sudo type nfs-common
sudo: type: command not found
node01 $ 
node01 $ sudo whereis nfs-common
nfs-common: /usr/share/nfs-common
node01 $ 
node01 $ whereis nfs-common
nfs-common: /usr/share/nfs-common
node01 $ 
node01 $ nfs-common -h
nfs-common: command not found
node01 $ 
node01 $ nfs-common --help
nfs-common: command not found
node01 $ 
node01 $ sudo nfs-common --help
sudo: nfs-common: command not found
node01 $ 
node01 $ sudo nfs-common       
sudo: nfs-common: command not found
node01 $ 
node01 $ cd //
node01 $ 
node01 $ cd /
node01 $ 
node01 $ pwd
/
node01 $ 
node01 $ ls -lha
total 1.1G
drwxr-xr-x  19 root root 4.0K May  2 10:23 .
drwxr-xr-x  19 root root 4.0K May  2 10:23 ..
lrwxrwxrwx   1 root root    7 Oct  7  2021 bin -> usr/bin
drwxr-xr-x   4 root root 4.0K May  2 10:22 boot
drwxr-xr-x  17 root root 3.7K May  2 10:20 dev
drwxr-xr-x 105 root root 4.0K Jul 14 14:52 etc
drwxr-xr-x   3 root root 4.0K Oct  8  2021 home
lrwxrwxrwx   1 root root    7 Oct  7  2021 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib32 -> usr/lib32
lrwxrwxrwx   1 root root    9 Oct  7  2021 lib64 -> usr/lib64
lrwxrwxrwx   1 root root   10 Oct  7  2021 libx32 -> usr/libx32
drwx------   2 root root  16K Oct  7  2021 lost+found
drwxr-xr-x   2 root root 4.0K Oct  7  2021 media
drwxr-xr-x   2 root root 4.0K Oct  7  2021 mnt
drwxr-xr-x   4 root root 4.0K May  8 19:39 opt
dr-xr-xr-x 222 root root    0 May  2 10:19 proc
drwx------   3 root root 4.0K Jul 14 14:17 root
drwxr-xr-x  36 root root 1.2K Jul 14 14:52 run
lrwxrwxrwx   1 root root    8 Oct  7  2021 sbin -> usr/sbin
drwxr-xr-x   6 root root 4.0K Oct  7  2021 snap
drwxr-xr-x   2 root root 4.0K Oct  7  2021 srv
-rw-------   1 root root 1.0G May  2 10:23 swapfile
dr-xr-xr-x  13 root root    0 May  2 10:19 sys
drwxrwxrwt  18 root root 4.0K Jul 14 14:56 tmp
drwxr-xr-x  15 root root 4.0K Oct  7  2021 usr
drwxr-xr-x  13 root root 4.0K Oct  7  2021 var
node01 $ cd /mnt/
node01 $ 
node01 $ ls -lha
total 8.0K
drwxr-xr-x  2 root root 4.0K Oct  7  2021 .
drwxr-xr-x 19 root root 4.0K May  2 10:23 ..
node01 $ 
node01 $ exit
logout
Connection to node01 closed.
controlplane $ 
controlplane $ 
controlplane $ 
```

### Terminal - 2
```
controlplane $ cd My-Project/
controlplane $ 
controlplane $ kubectl apply -f pod.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          20m
pod                                   0/1     Pending   0          23s
controlplane $ 
controlplane $ kubectl get po nfs-server-nfs-server-provisioner-0 
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          20m
controlplane $ 
controlplane $ kubectl get po nfs-server-nfs-server-provisioner-0 -o qide
error: unable to match a printer suitable for the output format "qide", allowed formats are: custom-columns,custom-columns-file,go-template,go-template-file,json,jsonpath,jsonpath-as-json,jsonpath-file,name,template,templatefile,wide,yaml
controlplane $ 
controlplane $ kubectl get po nfs-server-nfs-server-provisioner-0 -o wide
NAME                                  READY   STATUS    RESTARTS   AGE   IP            NODE     NOMINATED NODE   READINESS GATES
nfs-server-nfs-server-provisioner-0   1/1     Running   0          20m   192.168.1.4   node01   <none>           <none>
controlplane $ 
controlplane $ kubectl describe po nfs-server-nfs-server-provisioner-0        
Name:         nfs-server-nfs-server-provisioner-0
Namespace:    default
Priority:     0
Node:         node01/172.30.2.2
Start Time:   Thu, 14 Jul 2022 14:39:43 +0000
Labels:       app=nfs-server-provisioner
              chart=nfs-server-provisioner-1.1.3
              controller-revision-hash=nfs-server-nfs-server-provisioner-64bd6d7f65
              heritage=Helm
              release=nfs-server
              statefulset.kubernetes.io/pod-name=nfs-server-nfs-server-provisioner-0
Annotations:  cni.projectcalico.org/containerID: 22cf4427afc60abdbfed6ab0c0b809794800f6b5ca753021b9f3e2e5ddcf15d4
              cni.projectcalico.org/podIP: 192.168.1.4/32
              cni.projectcalico.org/podIPs: 192.168.1.4/32
Status:       Running
IP:           192.168.1.4
IPs:
  IP:           192.168.1.4
Controlled By:  StatefulSet/nfs-server-nfs-server-provisioner
Containers:
  nfs-server-provisioner:
    Container ID:  containerd://89449c72224ad391fe5bd8e4c211ad19b51900c283545cbf49fd0de269dcb362
    Image:         quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0
    Image ID:      quay.io/kubernetes_incubator/nfs-provisioner@sha256:f402e6039b3c1e60bf6596d283f3c470ffb0a1e169ceb8ce825e3218cd66c050
    Ports:         2049/TCP, 2049/UDP, 32803/TCP, 32803/UDP, 20048/TCP, 20048/UDP, 875/TCP, 875/UDP, 111/TCP, 111/UDP, 662/TCP, 662/UDP
    Host Ports:    0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP, 0/TCP, 0/UDP
    Args:
      -provisioner=cluster.local/nfs-server-nfs-server-provisioner
    State:          Running
      Started:      Thu, 14 Jul 2022 14:39:50 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      POD_IP:          (v1:status.podIP)
      SERVICE_NAME:   nfs-server-nfs-server-provisioner
      POD_NAMESPACE:  default (v1:metadata.namespace)
    Mounts:
      /export from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-bgn98 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-bgn98:
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  21m   default-scheduler  Successfully assigned default/nfs-server-nfs-server-provisioner-0 to node01
  Normal  Pulling    21m   kubelet            Pulling image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0"
  Normal  Pulled     20m   kubelet            Successfully pulled image "quay.io/kubernetes_incubator/nfs-provisioner:v2.3.0" in 5.833050294s
  Normal  Created    20m   kubelet            Created container nfs-server-provisioner
  Normal  Started    20m   kubelet            Started container nfs-server-provisioner
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME                                  READY   STATUS    RESTARTS   AGE
nfs-server-nfs-server-provisioner-0   1/1     Running   0          21m
pod                                   0/1     Pending   0          112s
controlplane $ 
controlplane $ kubectl get po -o wide
NAME                                  READY   STATUS    RESTARTS   AGE    IP            NODE     NOMINATED NODE   READINESS GATES
nfs-server-nfs-server-provisioner-0   1/1     Running   0          21m    192.168.1.4   node01   <none>           <none>
pod                                   0/1     Pending   0          118s   <none>        <none>   <none>           <none>
controlplane $ 
controlplane $ 
```
