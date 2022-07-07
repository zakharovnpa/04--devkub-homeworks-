## Лабораторная работа при выполнении ДЗ по теме "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

### Задача - создать тестовое окружение в кластере Kubernetes

* Просто логи всего что было сделано
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get nodes
NAME        STATUS   ROLES           AGE   VERSION
cp1-cl2     Ready    control-plane   36h   v1.24.2
node1-cl2   Ready    <none>          36h   v1.24.2
node2-cl2   Ready    <none>          36h   v1.24.2
maestro@PC-Ubuntu:~/Рабочий стол$ 
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get sa
NAME      SECRETS   AGE
default   0         36h
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get sa
The connection to the server 51.250.13.231:6443 was refused - did you specify the right host or port?
maestro@PC-Ubuntu:~/Рабочий стол$ 
maestro@PC-Ubuntu:~/Рабочий стол$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/con
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get sa
NAME      SECRETS   AGE
default   0         25m
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   25m   v1.24.2
node1   Ready    <none>          24m   v1.24.2
node2   Ready    <none>          24m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get podds
error: the server doesn't have a resource type "podds"
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get pods
No resources found in default namespace.
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get pods
No resources found in default namespace.
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE    VERSION
cp1     Ready    control-plane   101m   v1.24.2
node1   Ready    <none>          100m   v1.24.2
node2   Ready    <none>          100m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июн 28 10:45 .
drwxrwxr-x 3 maestro maestro 4,0K июн 28 10:17 ..
drwxrwxr-x 3 maestro maestro 4,0K июн 28 10:17 manifest
drwxrwxr-x 2 maestro maestro 4,0K июл  3 10:22 network-policy
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get apiservices.apiregistration.k8s.io 
NAME                                   SERVICE   AVAILABLE   AGE
v1.                                    Local     True        118m
v1.admissionregistration.k8s.io        Local     True        118m
v1.apiextensions.k8s.io                Local     True        118m
v1.apps                                Local     True        118m
v1.authentication.k8s.io               Local     True        118m
v1.authorization.k8s.io                Local     True        118m
v1.autoscaling                         Local     True        118m
v1.batch                               Local     True        118m
v1.certificates.k8s.io                 Local     True        118m
v1.coordination.k8s.io                 Local     True        118m
v1.crd.projectcalico.org               Local     True        113m
v1.discovery.k8s.io                    Local     True        118m
v1.events.k8s.io                       Local     True        118m
v1.networking.k8s.io                   Local     True        118m
v1.node.k8s.io                         Local     True        118m
v1.policy                              Local     True        118m
v1.rbac.authorization.k8s.io           Local     True        118m
v1.scheduling.k8s.io                   Local     True        118m
v1.storage.k8s.io                      Local     True        118m
v1beta1.batch                          Local     True        118m
v1beta1.discovery.k8s.io               Local     True        118m
v1beta1.events.k8s.io                  Local     True        118m
v1beta1.flowcontrol.apiserver.k8s.io   Local     True        118m
v1beta1.node.k8s.io                    Local     True        118m
v1beta1.policy                         Local     True        118m
v1beta1.storage.k8s.io                 Local     True        118m
v1beta2.flowcontrol.apiserver.k8s.io   Local     True        118m
v2.autoscaling                         Local     True        118m
v2beta1.autoscaling                    Local     True        118m
v2beta2.autoscaling                    Local     True        118m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get nodes 
NAME    STATUS   ROLES           AGE    VERSION
cp1     Ready    control-plane   119m   v1.24.2
node1   Ready    <none>          118m   v1.24.2
node2   Ready    <none>          118m   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get nod cp1
error: the server doesn't have a resource type "nod"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get node cp1
NAME   STATUS   ROLES           AGE    VERSION
cp1    Ready    control-plane   119m   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get node cp1 -o wide
NAME   STATUS   ROLES           AGE    VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
cp1    Ready    control-plane   120m   v1.24.2   10.128.0.18   <none>        Ubuntu 20.04.4 LTS   5.4.0-121-generic   containerd://1.6.6
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get node cp1 -o yaml
apiVersion: v1
kind: Node
metadata:
  annotations:
    kubeadm.alpha.kubernetes.io/cri-socket: unix:////var/run/containerd/containerd.sock
    node.alpha.kubernetes.io/ttl: "0"
    projectcalico.org/IPv4Address: 10.128.0.18/24
    projectcalico.org/IPv4VXLANTunnelAddr: 10.233.110.0
    volumes.kubernetes.io/controller-managed-attach-detach: "true"
  creationTimestamp: "2022-07-04T06:33:08Z"
  labels:
    beta.kubernetes.io/arch: amd64
    beta.kubernetes.io/os: linux
    kubernetes.io/arch: amd64
    kubernetes.io/hostname: cp1
    kubernetes.io/os: linux
    node-role.kubernetes.io/control-plane: ""
    node.kubernetes.io/exclude-from-external-load-balancers: ""
  name: cp1
  resourceVersion: "13033"
  uid: f2da1890-1b20-466d-a08c-2f90a8d62244
spec:
  podCIDR: 10.233.64.0/24
  podCIDRs:
  - 10.233.64.0/24
  taints:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
status:
  addresses:
  - address: 10.128.0.18
    type: InternalIP
  - address: cp1
    type: Hostname
  allocatable:
    cpu: 1800m
    ephemeral-storage: "18968795105"
    hugepages-1Gi: "0"
    hugepages-2Mi: "0"
    memory: 1403968Ki
    pods: "110"
  capacity:
    cpu: "2"
    ephemeral-storage: 20582460Ki
    hugepages-1Gi: "0"
    hugepages-2Mi: "0"
    memory: 2030656Ki
    pods: "110"
  conditions:
  - lastHeartbeatTime: "2022-07-04T06:35:49Z"
    lastTransitionTime: "2022-07-04T06:35:49Z"
    message: Calico is running on this node
    reason: CalicoIsUp
    status: "False"
    type: NetworkUnavailable
  - lastHeartbeatTime: "2022-07-04T08:33:08Z"
    lastTransitionTime: "2022-07-04T06:33:08Z"
    message: kubelet has sufficient memory available
    reason: KubeletHasSufficientMemory
    status: "False"
    type: MemoryPressure
  - lastHeartbeatTime: "2022-07-04T08:33:08Z"
    lastTransitionTime: "2022-07-04T06:33:08Z"
    message: kubelet has no disk pressure
    reason: KubeletHasNoDiskPressure
    status: "False"
    type: DiskPressure
  - lastHeartbeatTime: "2022-07-04T08:33:08Z"
    lastTransitionTime: "2022-07-04T06:33:08Z"
    message: kubelet has sufficient PID available
    reason: KubeletHasSufficientPID
    status: "False"
    type: PIDPressure
  - lastHeartbeatTime: "2022-07-04T08:33:08Z"
    lastTransitionTime: "2022-07-04T06:37:33Z"
    message: kubelet is posting ready status. AppArmor enabled
    reason: KubeletReady
    status: "True"
    type: Ready
  daemonEndpoints:
    kubeletEndpoint:
      Port: 10250
  images:
  - names:
    - quay.io/calico/cni:v3.23.1
    sizeBytes: 110500425
  - names:
    - quay.io/calico/node:v3.23.1
    sizeBytes: 76574475
  - names:
    - quay.io/calico/kube-controllers:v3.23.1
    sizeBytes: 56361853
  - names:
    - registry.k8s.io/dns/k8s-dns-node-cache:1.21.1
    sizeBytes: 42449267
  - names:
    - registry.k8s.io/kube-proxy:v1.24.2
    sizeBytes: 39515830
  - names:
    - registry.k8s.io/kube-apiserver:v1.24.2
    sizeBytes: 33795763
  - names:
    - registry.k8s.io/kube-controller-manager:v1.24.2
    sizeBytes: 31035052
  - names:
    - registry.k8s.io/kube-scheduler:v1.24.2
    sizeBytes: 15488980
  - names:
    - registry.k8s.io/cpa/cluster-proportional-autoscaler-amd64:1.8.5
    sizeBytes: 15208063
  - names:
    - registry.k8s.io/coredns/coredns:v1.8.6
    sizeBytes: 13585107
  - names:
    - quay.io/calico/pod2daemon-flexvol:v3.23.1
    sizeBytes: 8671600
  - names:
    - registry.k8s.io/pause@sha256:bb6ed397957e9ca7c65ada0db5c5d1c707c9c8afc80a94acbe69f3ae76988f0c
    - registry.k8s.io/pause:3.7
    sizeBytes: 311278
  - names:
    - registry.k8s.io/pause:3.3
    sizeBytes: 299480
  nodeInfo:
    architecture: amd64
    bootID: 6eccf9ab-cc4f-4297-ab96-b1bc78243143
    containerRuntimeVersion: containerd://1.6.6
    kernelVersion: 5.4.0-121-generic
    kubeProxyVersion: v1.24.2
    kubeletVersion: v1.24.2
    machineID: 23000007c6df39a47ef4ea4052d1f334
    operatingSystem: linux
    osImage: Ubuntu 20.04.4 LTS
    systemUUID: 23000007-c6df-39a4-7ef4-ea4052d1f334
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe node cp1 -o yaml
error: unknown shorthand flag: 'o' in -o
See 'kubectl describe --help' for usage.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe node cp1
Name:               cp1
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=cp1
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:////var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    projectcalico.org/IPv4Address: 10.128.0.18/24
                    projectcalico.org/IPv4VXLANTunnelAddr: 10.233.110.0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Mon, 04 Jul 2022 10:33:08 +0400
Taints:             node-role.kubernetes.io/master:NoSchedule
Unschedulable:      false
Lease:
  HolderIdentity:  cp1
  AcquireTime:     <unset>
  RenewTime:       Mon, 04 Jul 2022 12:35:09 +0400
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Mon, 04 Jul 2022 10:35:49 +0400   Mon, 04 Jul 2022 10:35:49 +0400   CalicoIsUp                   Calico is running on this node
  MemoryPressure       False   Mon, 04 Jul 2022 12:35:11 +0400   Mon, 04 Jul 2022 10:33:08 +0400   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Mon, 04 Jul 2022 12:35:11 +0400   Mon, 04 Jul 2022 10:33:08 +0400   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Mon, 04 Jul 2022 12:35:11 +0400   Mon, 04 Jul 2022 10:33:08 +0400   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Mon, 04 Jul 2022 12:35:11 +0400   Mon, 04 Jul 2022 10:37:33 +0400   KubeletReady                 kubelet is posting ready status. AppArmor enabled
Addresses:
  InternalIP:  10.128.0.18
  Hostname:    cp1
Capacity:
  cpu:                2
  ephemeral-storage:  20582460Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             2030656Ki
  pods:               110
Allocatable:
  cpu:                1800m
  ephemeral-storage:  18968795105
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             1403968Ki
  pods:               110
System Info:
  Machine ID:                 23000007c6df39a47ef4ea4052d1f334
  System UUID:                23000007-c6df-39a4-7ef4-ea4052d1f334
  Boot ID:                    6eccf9ab-cc4f-4297-ab96-b1bc78243143
  Kernel Version:             5.4.0-121-generic
  OS Image:                   Ubuntu 20.04.4 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.6
  Kubelet Version:            v1.24.2
  Kube-Proxy Version:         v1.24.2
PodCIDR:                      10.233.64.0/24
PodCIDRs:                     10.233.64.0/24
Non-terminated Pods:          (8 in total)
  Namespace                   Name                               CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                               ------------  ----------  ---------------  -------------  ---
  kube-system                 calico-node-4nlrt                  150m (8%)     300m (16%)  64M (4%)         500M (34%)     119m
  kube-system                 coredns-666959ff67-ccsc2           100m (5%)     0 (0%)      70Mi (5%)        170Mi (12%)    118m
  kube-system                 dns-autoscaler-59b8867c86-8f5xm    20m (1%)      0 (0%)      10Mi (0%)        0 (0%)         118m
  kube-system                 kube-apiserver-cp1                 250m (13%)    0 (0%)      0 (0%)           0 (0%)         122m
  kube-system                 kube-controller-manager-cp1        200m (11%)    0 (0%)      0 (0%)           0 (0%)         122m
  kube-system                 kube-proxy-8dtqq                   0 (0%)        0 (0%)      0 (0%)           0 (0%)         120m
  kube-system                 kube-scheduler-cp1                 100m (5%)     0 (0%)      0 (0%)           0 (0%)         122m
  kube-system                 nodelocaldns-zt85t                 100m (5%)     0 (0%)      70Mi (5%)        170Mi (12%)    118m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests         Limits
  --------           --------         ------
  cpu                920m (51%)       300m (16%)
  memory             221286400 (15%)  856515840 (59%)
  ephemeral-storage  0 (0%)           0 (0%)
  hugepages-1Gi      0 (0%)           0 (0%)
  hugepages-2Mi      0 (0%)           0 (0%)
Events:              <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get rs
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl create deployment k8s-frontend --image=zakharovnpa/k8s-frontend:05.07.22
deployment.apps/k8s-frontend created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-frontend   1/1     1            1           26s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment -o yaml
apiVersion: v1
items:
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    annotations:
      deployment.kubernetes.io/revision: "1"
    creationTimestamp: "2022-07-04T19:51:47Z"
    generation: 1
    labels:
      app: k8s-frontend
    name: k8s-frontend
    namespace: default
    resourceVersion: "81654"
    uid: c4e0c5f7-ed0f-4f2a-a1cf-4dd759986d22
  spec:
    progressDeadlineSeconds: 600
    replicas: 1
    revisionHistoryLimit: 10
    selector:
      matchLabels:
        app: k8s-frontend
    strategy:
      rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 25%
      type: RollingUpdate
    template:
      metadata:
        creationTimestamp: null
        labels:
          app: k8s-frontend
      spec:
        containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: k8s-frontend
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        schedulerName: default-scheduler
        securityContext: {}
        terminationGracePeriodSeconds: 30
  status:
    availableReplicas: 1
    conditions:
    - lastTransitionTime: "2022-07-04T19:52:00Z"
      lastUpdateTime: "2022-07-04T19:52:00Z"
      message: Deployment has minimum availability.
      reason: MinimumReplicasAvailable
      status: "True"
      type: Available
    - lastTransitionTime: "2022-07-04T19:51:47Z"
      lastUpdateTime: "2022-07-04T19:52:00Z"
      message: ReplicaSet "k8s-frontend-7d4b4986f5" has successfully progressed.
      reason: NewReplicaSetAvailable
      status: "True"
      type: Progressing
    observedGeneration: 1
    readyReplicas: 1
    replicas: 1
    updatedReplicas: 1
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          8h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-frontend   1/1     1            1           8h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment -o yaml
apiVersion: v1
items:
- apiVersion: apps/v1
  kind: Deployment
  metadata:
    annotations:
      deployment.kubernetes.io/revision: "1"
    creationTimestamp: "2022-07-04T19:51:47Z"
    generation: 1
    labels:
      app: k8s-frontend
    name: k8s-frontend
    namespace: default
    resourceVersion: "81654"
    uid: c4e0c5f7-ed0f-4f2a-a1cf-4dd759986d22
  spec:
    progressDeadlineSeconds: 600
    replicas: 1
    revisionHistoryLimit: 10
    selector:
      matchLabels:
        app: k8s-frontend
    strategy:
      rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 25%
      type: RollingUpdate
    template:
      metadata:
        creationTimestamp: null
        labels:
          app: k8s-frontend
      spec:
        containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: k8s-frontend
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
        dnsPolicy: ClusterFirst
        restartPolicy: Always
        schedulerName: default-scheduler
        securityContext: {}
        terminationGracePeriodSeconds: 30
  status:
    availableReplicas: 1
    conditions:
    - lastTransitionTime: "2022-07-04T19:52:00Z"
      lastUpdateTime: "2022-07-04T19:52:00Z"
      message: Deployment has minimum availability.
      reason: MinimumReplicasAvailable
      status: "True"
      type: Available
    - lastTransitionTime: "2022-07-04T19:51:47Z"
      lastUpdateTime: "2022-07-04T19:52:00Z"
      message: ReplicaSet "k8s-frontend-7d4b4986f5" has successfully progressed.
      reason: NewReplicaSetAvailable
      status: "True"
      type: Progressing
    observedGeneration: 1
    readyReplicas: 1
    replicas: 1
    updatedReplicas: 1
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl edit deployment k8s-frontend 
deployment.apps/k8s-frontend edited
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get pod
NAME                            READY   STATUS              RESTARTS   AGE
k8s-frontend-7d4b4986f5-7bl5n   0/1     ContainerCreating   0          5s
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          8h
k8s-frontend-7d4b4986f5-gdnqd   0/1     ContainerCreating   0          5s
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          5s
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          5s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get pod
NAME                            READY   STATUS              RESTARTS   AGE
k8s-frontend-7d4b4986f5-7bl5n   0/1     ContainerCreating   0          9s
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          8h
k8s-frontend-7d4b4986f5-gdnqd   0/1     ContainerCreating   0          9s
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          9s
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          9s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          14s
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          8h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          14s
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          14s
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          14s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe pod k8s-frontend-7d4b4986f5-7bl5n
Name:         k8s-frontend-7d4b4986f5-7bl5n
Namespace:    default
Priority:     0
Node:         node1/10.128.0.23
Start Time:   Tue, 05 Jul 2022 08:35:40 +0400
Labels:       app=k8s-frontend
              pod-template-hash=7d4b4986f5
Annotations:  cni.projectcalico.org/containerID: e1c202deda5621458bf477f18b2a071a434c9cb7d0da8f23185a5b894b47fd9a
              cni.projectcalico.org/podIP: 10.233.90.3/32
              cni.projectcalico.org/podIPs: 10.233.90.3/32
Status:       Running
IP:           10.233.90.3
IPs:
  IP:           10.233.90.3
Controlled By:  ReplicaSet/k8s-frontend-7d4b4986f5
Containers:
  k8s-frontend:
    Container ID:   containerd://d5b0af250c7b9859ae425364b8f41de1817b32674655ce8d893b70fb9c126246
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 08:35:51 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-88fp6 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-88fp6:
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
  Normal  Scheduled  38s   default-scheduler  Successfully assigned default/k8s-frontend-7d4b4986f5-7bl5n to node1
  Normal  Pulling    36s   kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     28s   kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 8.31878301s
  Normal  Created    28s   kubelet            Created container k8s-frontend
  Normal  Started    28s   kubelet            Started container k8s-frontend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe pod k8s-frontend-7d4b4986f5-7bl5n | grep NodeName
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe pod k8s-frontend-7d4b4986f5-7bl5n | grep Node
Node:         node1/10.128.0.23
Node-Selectors:              <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe pod k8s-frontend | grep Node
Node:         node1/10.128.0.23
Node-Selectors:              <none>
Node:         node2/10.128.0.17
Node-Selectors:              <none>
Node:         node1/10.128.0.23
Node-Selectors:              <none>
Node:         node2/10.128.0.17
Node-Selectors:              <none>
Node:         node2/10.128.0.17
Node-Selectors:              <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl describe pod k8s-frontend | grep "^IP"
IP:           10.233.90.3
IPs:
IP:           10.233.96.1
IPs:
IP:           10.233.90.2
IPs:
IP:           10.233.96.3
IPs:
IP:           10.233.96.2
IPs:
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   22h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-frontend   5/5     5            5           8h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl edit deployment k8s-frontend
Edit cancelled, no changes made.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl create deployment k8s-backend --image=zakharovnpa/k8s-backend:05.07.22
deployment.apps/k8s-backend created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-backend    0/1     1            0           7s
k8s-frontend   5/5     5            5           9h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS              RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     0/1     ContainerCreating   0          14s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS              RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     0/1     ContainerCreating   0          20s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS              RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     0/1     ContainerCreating   0          22s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS              RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     0/1     ContainerCreating   0          25s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS              RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     0/1     ContainerCreating   0          27s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS              RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     0/1     ContainerCreating   0          29s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running             0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running             0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running             0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          31s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          33s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          36s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          9h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          23m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          23m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl edit deployment k8s-backend -o yaml
Edit cancelled, no changes made.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get deployment k8s-backend -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2022-07-05T04:58:29Z"
  generation: 1
  labels:
    app: k8s-backend
  name: k8s-backend
  namespace: default
  resourceVersion: "137025"
  uid: 9a93f04d-8960-4cad-a9a0-de57f423895a
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: k8s-backend
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: k8s-backend
    spec:
      containers:
      - image: zakharovnpa/k8s-backend:05.07.22
        imagePullPolicy: IfNotPresent
        name: k8s-backend
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2022-07-05T04:58:59Z"
    lastUpdateTime: "2022-07-05T04:58:59Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2022-07-05T04:58:29Z"
    lastUpdateTime: "2022-07-05T04:58:59Z"
    message: ReplicaSet "k8s-backend-95b5f4f77" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get -all
error: unknown shorthand flag: 'a' in -all
See 'kubectl get --help' for usage.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get --all
error: unknown flag: --all
See 'kubectl get --help' for usage.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   22h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get svc kubernetes -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2022-07-04T06:33:10Z"
  labels:
    component: apiserver
    provider: kubernetes
  name: kubernetes
  namespace: default
  resourceVersion: "199"
  uid: 44070298-5a8c-4d3a-9a77-a4aaacd271e8
spec:
  clusterIP: 10.233.0.1
  clusterIPs:
  - 10.233.0.1
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: https
    port: 443
    protocol: TCP
    targetPort: 6443
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl get statefulsets.apps 
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ kubectl create --help
Create a resource from a file or from stdin.

 JSON and YAML formats are accepted.

Examples:
  # Create a pod using the data in pod.json
  kubectl create -f ./pod.json
  
  # Create a pod based on the JSON passed into stdin
  cat pod.json | kubectl create -f -
  
  # Edit the data in registry.yaml in JSON then create the resource using the edited data
  kubectl create -f registry.yaml --edit -o json

Available Commands:
  clusterrole           Create a cluster role
  clusterrolebinding    Create a cluster role binding for a particular cluster role
  configmap             Create a config map from a local file, directory or literal value
  cronjob               Create a cron job with the specified name
  deployment            Create a deployment with the specified name
  ingress               Create an ingress with the specified name
  job                   Create a job with the specified name
  namespace             Create a namespace with the specified name
  poddisruptionbudget   Create a pod disruption budget with the specified name
  priorityclass         Create a priority class with the specified name
  quota                 Create a quota with the specified name
  role                  Create a role with single rule
  rolebinding           Create a role binding for a particular role or cluster role
  secret                Create a secret using specified subcommand
  service               Create a service using a specified subcommand
  serviceaccount        Create a service account with the specified name
  token                 Request a service account token

Options:
    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --dry-run='none':
	Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
	sending it. If server strategy, submit server-side request without persisting the resource.

    --edit=false:
	Edit the API resource before creating

    --field-manager='kubectl-create':
	Name of the manager used to track field ownership.

    -f, --filename=[]:
	Filename, directory, or URL to files to use to create the resource

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file).

    --raw='':
	Raw URI to POST to the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    --save-config=false:
	If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
	be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --validate='strict':
	Must be one of: strict (or true), warn, ignore (or false). 		"true" or "strict" will use a schema to validate
	the input and fail the request if invalid. It will perform server side validation if ServerSideFieldValidation
	is enabled on the api-server, but will fall back to less reliable client-side validation if not. 		"warn" will
	warn about unknown or duplicate fields without blocking the request if server-side field validation is enabled
	on the API server, and behave as "ignore" otherwise. 		"false" or "ignore" will not perform any schema
	validation, silently dropping any unknown or duplicate fields.

    --windows-line-endings=false:
	Only relevant if --edit=true. Defaults to the line ending native to your platform.

Usage:
  kubectl create -f FILENAME [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июн 28 10:45 .
drwxrwxr-x 4 maestro maestro 4,0K июл  4 13:05 ..
drwxrwxr-x 3 maestro maestro 4,0K июн 28 10:17 manifest
drwxrwxr-x 2 maestro maestro 4,0K июл  3 10:22 network-policy
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta$ cd manifest/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ ls -lha
итого 12K
drwxrwxr-x 3 maestro maestro 4,0K июн 28 10:17 .
drwxrwxr-x 4 maestro maestro 4,0K июн 28 10:45 ..
drwxrwxr-x 2 maestro maestro 4,0K июн 28 10:20 main
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ cd main/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ ls -lha
итого 20K
drwxrwxr-x 2 maestro maestro 4,0K июн 28 10:20 .
drwxrwxr-x 3 maestro maestro 4,0K июн 28 10:17 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  585 июн 28 10:20 cache.yml
-rw-rw-r-- 1 maestro maestro  604 июн 28 10:19 frontend.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ vim k8s-database.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   25h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get -n deault svc
No resources found in deault namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl apply -f k8s-database.yml 
statefulset.apps/k8s-database created
service/k8s-database-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS             RESTARTS     AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running            0            156m
k8s-database-0                  0/1     CrashLoopBackOff   1 (3s ago)   14s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running            0            179m
k8s-frontend-7d4b4986f5-dk928   1/1     Running            0            11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running            0            179m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running            0            179m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running            0            179m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS             RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running            0             156m
k8s-database-0                  0/1     CrashLoopBackOff   1 (16s ago)   27s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running            0             179m
k8s-frontend-7d4b4986f5-dk928   1/1     Running            0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running            0             179m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running            0             179m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running            0             179m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0             157m
k8s-database-0                  0/1     Error     2 (24s ago)   35s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0             179m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0             179m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0             179m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0             179m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0             157m
k8s-database-0                  0/1     Error     2 (29s ago)   40s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0             179m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0             179m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0             179m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0             179m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl describe pod k8s-database-0
Name:         k8s-database-0
Namespace:    default
Priority:     0
Node:         node2/10.128.0.17
Start Time:   Tue, 05 Jul 2022 11:34:54 +0400
Labels:       app=k8s-database
              controller-revision-hash=k8s-database-7f9878487b
              statefulset.kubernetes.io/pod-name=k8s-database-0
Annotations:  cni.projectcalico.org/containerID: 169005245a7f24abbd883849140110c6a9020d850c6f5aa32661d66d0be23be7
              cni.projectcalico.org/podIP: 10.233.96.4/32
              cni.projectcalico.org/podIPs: 10.233.96.4/32
Status:       Running
IP:           10.233.96.4
IPs:
  IP:           10.233.96.4
Controlled By:  StatefulSet/k8s-database
Containers:
  k8s-database:
    Container ID:   containerd://a7bdd5b055e641408e95f376e607a1c05d4c6c812552b6bd67e3cb9b8becbff9
    Image:          postgres:13-alpine
    Image ID:       docker.io/library/postgres@sha256:88b4d86d81a362b4a9b38cc8ed9766d2e4bfb98d731dda1542bead96982a866c
    Port:           <none>
    Host Port:      <none>
    State:          Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Tue, 05 Jul 2022 11:35:50 +0400
      Finished:     Tue, 05 Jul 2022 11:35:50 +0400
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Tue, 05 Jul 2022 11:35:23 +0400
      Finished:     Tue, 05 Jul 2022 11:35:23 +0400
    Ready:          False
    Restart Count:  3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-znkql (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-api-access-znkql:
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
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  60s               default-scheduler  Successfully assigned default/k8s-database-0 to node2
  Normal   Pulling    59s               kubelet            Pulling image "postgres:13-alpine"
  Normal   Pulled     50s               kubelet            Successfully pulled image "postgres:13-alpine" in 9.01836972s
  Normal   Created    4s (x4 over 50s)  kubelet            Created container k8s-database
  Normal   Started    4s (x4 over 50s)  kubelet            Started container k8s-database
  Normal   Pulled     4s (x3 over 49s)  kubelet            Container image "postgres:13-alpine" already present on machine
  Warning  BackOff    4s (x5 over 48s)  kubelet            Back-off restarting failed container
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0             158m
k8s-database-0                  0/1     Error     4 (63s ago)   119s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0             3h1m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0             3h1m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0             3h1m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0             3h1m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ vim k8s-database.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get statefulsets.apps 
NAME           READY   AGE
k8s-database   0/1     3m5s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete k8s-database
error: the server doesn't have a resource type "k8s-database"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete statefulsets.apps k8s-database 
statefulset.apps "k8s-database" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          160m
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          3h3m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          3h3m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          3h3m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          3h3m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl apply -f k8s-database.yml 
statefulset.apps/k8s-database created
service/k8s-database-svc unchanged
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS             RESTARTS     AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running            0            160m
k8s-database-0                  0/1     CrashLoopBackOff   1 (5s ago)   9s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running            0            3h3m
k8s-frontend-7d4b4986f5-dk928   1/1     Running            0            11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running            0            3h3m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running            0            3h3m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running            0            3h3m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS             RESTARTS     AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running            0            160m
k8s-database-0                  0/1     CrashLoopBackOff   1 (9s ago)   13s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running            0            3h3m
k8s-frontend-7d4b4986f5-dk928   1/1     Running            0            11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running            0            3h3m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running            0            3h3m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running            0            3h3m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0             160m
k8s-database-0                  0/1     Error     2 (16s ago)   20s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0             3h3m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0             3h3m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0             3h3m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0             3h3m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0             161m
k8s-database-0                  0/1     Error     2 (21s ago)   25s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0             3h3m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0             3h3m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0             3h3m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0             3h3m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl describe pod k8s-database-0
Name:         k8s-database-0
Namespace:    default
Priority:     0
Node:         node2/10.128.0.17
Start Time:   Tue, 05 Jul 2022 11:39:07 +0400
Labels:       app=k8s-database
              controller-revision-hash=k8s-database-5989886bc9
              statefulset.kubernetes.io/pod-name=k8s-database-0
Annotations:  cni.projectcalico.org/containerID: 6e2968a26eeca77a54c25e00b20c547442bd9fd06df95beb4d611d38cf40e187
              cni.projectcalico.org/podIP: 10.233.96.5/32
              cni.projectcalico.org/podIPs: 10.233.96.5/32
Status:       Running
IP:           10.233.96.5
IPs:
  IP:           10.233.96.5
Controlled By:  StatefulSet/k8s-database
Containers:
  k8s-database:
    Container ID:   containerd://daffa01fccdbd5486fd5919e195b0c4f910ce1a51064bad43b94fdb994753d5b
    Image:          zakharovnpa/k8s-database:05.07.22
    Image ID:       docker.io/library/postgres@sha256:88b4d86d81a362b4a9b38cc8ed9766d2e4bfb98d731dda1542bead96982a866c
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Tue, 05 Jul 2022 11:39:24 +0400
      Finished:     Tue, 05 Jul 2022 11:39:24 +0400
    Ready:          False
    Restart Count:  2
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-chdh4 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-api-access-chdh4:
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
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  41s                default-scheduler  Successfully assigned default/k8s-database-0 to node2
  Normal   Pulling    41s                kubelet            Pulling image "zakharovnpa/k8s-database:05.07.22"
  Normal   Pulled     40s                kubelet            Successfully pulled image "zakharovnpa/k8s-database:05.07.22" in 1.226581928s
  Normal   Created    25s (x3 over 40s)  kubelet            Created container k8s-database
  Normal   Started    25s (x3 over 39s)  kubelet            Started container k8s-database
  Normal   Pulled     25s (x2 over 38s)  kubelet            Container image "zakharovnpa/k8s-database:05.07.22" already present on machine
  Warning  BackOff    10s (x4 over 37s)  kubelet            Back-off restarting failed container
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS             RESTARTS      AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running            0             167m
k8s-database-0                  0/1     CrashLoopBackOff   6 (46s ago)   6m33s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running            0             3h10m
k8s-frontend-7d4b4986f5-dk928   1/1     Running            0             11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running            0             3h10m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running            0             3h10m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running            0             3h10m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-database-0
Error: Database is uninitialized and superuser password is not specified.
       You must specify POSTGRES_PASSWORD to a non-empty value for the
       superuser. For example, "-e POSTGRES_PASSWORD=password" on "docker run".

       You may also use "POSTGRES_HOST_AUTH_METHOD=trust" to allow all
       connections without a password. This is *not* recommended.

       See PostgreSQL documentation about "trust":
       https://www.postgresql.org/docs/current/auth-trust.html
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete statefulsets.apps k8s-database 
statefulset.apps "k8s-database" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete service k8s-database-svc 
service "k8s-database-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ vim k8s-database.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl apply -f k8s-database.yml 
statefulset.apps/k8s-database created
service/k8s-database-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          170m
k8s-database-0                  1/1     Running   0          6s
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          3h13m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          11h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          3h13m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          3h13m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          3h13m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-database-0
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-07-05 07:49:06.512 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-07-05 07:49:07.846 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-05 07:49:07.851 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-05 07:49:07.879 UTC [37] LOG:  database system was shut down at 2022-07-05 07:49:07 UTC
2022-07-05 07:49:07.892 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down....2022-07-05 07:49:08.233 UTC [36] LOG:  received fast shutdown request
2022-07-05 07:49:08.247 UTC [36] LOG:  aborting any active transactions
2022-07-05 07:49:08.249 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-07-05 07:49:08.249 UTC [38] LOG:  shutting down
2022-07-05 07:49:08.324 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-07-05 07:49:08.368 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-05 07:49:08.369 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-07-05 07:49:08.369 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-07-05 07:49:08.378 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-05 07:49:08.407 UTC [50] LOG:  database system was shut down at 2022-07-05 07:49:08 UTC
2022-07-05 07:49:08.418 UTC [1] LOG:  database system is ready to accept connections
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   26h   v1.24.2
node1   Ready    <none>          26h   v1.24.2
node2   Ready    <none>          26h   v1.24.2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          3h48m
k8s-database-0                  1/1     Running   0          58m
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          4h11m
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          12h
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          4h11m
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          4h11m
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          4h11m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          3h57m   10.233.90.4   node1   <none>           <none>
k8s-database-0                  1/1     Running   0          66m     10.233.96.6   node2   <none>           <none>
k8s-frontend-7d4b4986f5-7bl5n   1/1     Running   0          4h20m   10.233.90.3   node1   <none>           <none>
k8s-frontend-7d4b4986f5-dk928   1/1     Running   0          13h     10.233.96.1   node2   <none>           <none>
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          4h20m   10.233.90.2   node1   <none>           <none>
k8s-frontend-7d4b4986f5-lwrgw   1/1     Running   0          4h20m   10.233.96.3   node2   <none>           <none>
k8s-frontend-7d4b4986f5-xjvks   1/1     Running   0          4h20m   10.233.96.2   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl edit po k8s-frontend
Error from server (NotFound): pods "k8s-frontend" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl edit po k8s-frontend-7d4b4986f5
Error from server (NotFound): pods "k8s-frontend-7d4b4986f5" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl edit deployments.apps k8s-frontend 
deployment.apps/k8s-frontend edited
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          5h36m   10.233.90.4   node1   <none>           <none>
k8s-database-0                  1/1     Running   0          165m    10.233.96.6   node2   <none>           <none>
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          5h59m   10.233.90.2   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get svc -o wide
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   174m   app=k8s-database
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          28h    <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get svc, ep -o wide
error: arguments in resource/name form must have a single resource and name
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get ep -o wide
NAME               ENDPOINTS          AGE
k8s-database-svc   10.233.96.6:5432   175m
kubernetes         10.128.0.18:6443   28h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs po k8s-backend-95b5f4f77-98fd2
Error from server (NotFound): pods "po" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-backend-95b5f4f77-98fd2
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-frontend-7d4b4986f5-gdnqd 
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/05 04:35:50 [notice] 1#1: using the "epoll" event method
2022/07/05 04:35:50 [notice] 1#1: nginx/1.23.0
2022/07/05 04:35:50 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/05 04:35:50 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/05 04:35:50 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/05 04:35:50 [notice] 1#1: start worker processes
2022/07/05 04:35:50 [notice] 1#1: start worker process 30
2022/07/05 04:35:50 [notice] 1#1: start worker process 31
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          6h22m
k8s-database-0                  1/1     Running   0          3h31m
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          6h45m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete po k8s-database-0 
pod "k8s-database-0" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          6h22m
k8s-database-0                  1/1     Running   0          3s
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          6h45m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get statefulsets.apps 
NAME           READY   AGE
k8s-database   1/1     3h32m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete statefulsets.apps k8s-database 
statefulset.apps "k8s-database" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          6h23m
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          6h46m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ cp k8s-database.yml db.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ cat db.yaml 
# Config PostgreSQL StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: db-svc
spec:
  selector:
    app: db
  type: LoadBalancer
  ports:
    - port: 5432
      targetPort: 5432

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl create -f db.yaml 
statefulset.apps/db created
service/db-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
db-0                            1/1     Running   0          9s
k8s-backend-95b5f4f77-98fd2     1/1     Running   0          6h27m
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          6h49m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-backend-95b5f4f77-98fd2
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete po k8s-backend
Error from server (NotFound): pods "k8s-backend" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl delete po k8s-backend-95b5f4f77-98fd2 
pod "k8s-backend-95b5f4f77-98fd2" deleted
^C
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS        RESTARTS   AGE
db-0                            1/1     Running       0          2m36s
k8s-backend-95b5f4f77-98fd2     1/1     Terminating   0          6h29m
k8s-backend-95b5f4f77-g6k9r     1/1     Running       0          30s
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running       0          6h52m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl get po
NAME                            READY   STATUS    RESTARTS   AGE
db-0                            1/1     Running   0          2m46s
k8s-backend-95b5f4f77-g6k9r     1/1     Running   0          40s
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          6h52m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl logs k8s-backend-95b5f4f77-g6k9r 
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ kubectl exec k8s-backend-95b5f4f77-g6k9r -- ping db 
ping: db: Name or service not known
command terminated with exit code 2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/main$ cd ..
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ mkdir -p postgres
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ cp main/db.yaml postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ cd postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 12K
drwxrwxr-x 2 maestro maestro 4,0K июл  5 15:30 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  765 июл  5 15:30 db.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 20K
drwxrwxr-x 2 maestro maestro 4,0K июл  5 15:31 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  765 июл  5 15:30 db.yaml
-rw-rw-r-- 1 maestro maestro  604 июн 28 10:19 frontend.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim frontend.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim frontend.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim frontend.yml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME               ENDPOINTS          AGE
db-svc             10.233.96.8:5432   58m
k8s-database-svc   <none>             4h34m
kubernetes         10.128.0.18:6443   29h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep db-svc -o wide
NAME     ENDPOINTS          AGE
db-svc   10.233.96.8:5432   58m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep db-svc -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-05T11:25:32Z"
  creationTimestamp: "2022-07-05T11:25:30Z"
  name: db-svc
  namespace: default
  resourceVersion: "176409"
  uid: 10c60c1e-5590-4ec7-afb7-2d7ea71e42d5
subsets:
- addresses:
  - hostname: db-0
    ip: 10.233.96.8
    nodeName: node2
    targetRef:
      kind: Pod
      name: db-0
      namespace: default
      uid: 8792452f-8c73-4de3-aa5a-4bc6fcd2298a
  ports:
  - port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc             LoadBalancer   10.233.43.4     <pending>     5432:31545/TCP   60m
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   4h36m
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          29h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
db-0                            1/1     Running   0          67m
k8s-backend-95b5f4f77-g6k9r     1/1     Running   0          65m
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          7h57m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
db-0                            1/1     Running   0          67m     10.233.96.8   node2   <none>           <none>
k8s-backend-95b5f4f77-g6k9r     1/1     Running   0          65m     10.233.96.9   node2   <none>           <none>
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          7h57m   10.233.90.2   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod db-0 
Name:         db-0
Namespace:    default
Priority:     0
Node:         node2/10.128.0.17
Start Time:   Tue, 05 Jul 2022 15:25:30 +0400
Labels:       app=db
              controller-revision-hash=db-58b74bf99f
              statefulset.kubernetes.io/pod-name=db-0
Annotations:  cni.projectcalico.org/containerID: afaf6724fb48be7c520c85846b5811521a12952802419656d31414a7ab822bb5
              cni.projectcalico.org/podIP: 10.233.96.8/32
              cni.projectcalico.org/podIPs: 10.233.96.8/32
Status:       Running
IP:           10.233.96.8
IPs:
  IP:           10.233.96.8
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://9a1cf46281163e4c49a6aab67cbb31564c1ec0c43fa516d8fd66e039807cadd3
    Image:          zakharovnpa/k8s-database:05.07.22
    Image ID:       docker.io/library/postgres@sha256:88b4d86d81a362b4a9b38cc8ed9766d2e4bfb98d731dda1542bead96982a866c
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 15:25:31 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-d4m9z (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-d4m9z:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                            READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                            1/1     Running   0          74m   10.233.96.8   node2   <none>           <none>
k8s-backend-95b5f4f77-g6k9r     1/1     Running   0          71m   10.233.96.9   node2   <none>           <none>
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          8h    10.233.90.2   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod k8s-frontend-7d4b4986f5-gdnqd
Name:         k8s-frontend-7d4b4986f5-gdnqd
Namespace:    default
Priority:     0
Node:         node1/10.128.0.23
Start Time:   Tue, 05 Jul 2022 08:35:40 +0400
Labels:       app=k8s-frontend
              pod-template-hash=7d4b4986f5
Annotations:  cni.projectcalico.org/containerID: 68e72cce8209f847641e15b950e2a631299876d4ccd4e7a659297d5b36c47288
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  ReplicaSet/k8s-frontend-7d4b4986f5
Containers:
  k8s-frontend:
    Container ID:   containerd://753c479e74af45fc534d7c2b1f0f4e05aa2e5f6b2da247f0ab5dc840f505a6f5
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 08:35:50 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-bgwlw (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-bgwlw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod k8s-backend-95b5f4f77-g6k9r
Name:         k8s-backend-95b5f4f77-g6k9r
Namespace:    default
Priority:     0
Node:         node2/10.128.0.17
Start Time:   Tue, 05 Jul 2022 15:27:36 +0400
Labels:       app=k8s-backend
              pod-template-hash=95b5f4f77
Annotations:  cni.projectcalico.org/containerID: 79929a1f7be386f9bed59c49cc02d8553eae5e575c6c88cb28e0abfba201ceac
              cni.projectcalico.org/podIP: 10.233.96.9/32
              cni.projectcalico.org/podIPs: 10.233.96.9/32
Status:       Running
IP:           10.233.96.9
IPs:
  IP:           10.233.96.9
Controlled By:  ReplicaSet/k8s-backend-95b5f4f77
Containers:
  k8s-backend:
    Container ID:   containerd://35341dee2d8052892fe9e1bec47abe2c4933ef9a27cc3373c8b7d48550faaf73
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 15:28:04 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-bjzq4 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-bjzq4:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 20K
drwxrwxr-x 2 maestro maestro 4,0K июл  5 16:23 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  765 июл  5 15:30 db.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ touch web-services.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat frontend.yml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: frontend
  name: frontend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - image: zakharovnpa/k8s-frontend:05.07.22
          imagePullPolicy: IfNotPresent
          name: frontend
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: frontend-svc
  labels:
    app: frontend
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: fb


#---
#apiVersion: v1
#kind: Service
#metadata:
#  name: frontend
#  namespace: default
#spec:
#  ports:
#    - name: web
#      port: 80
#  selector:
#    app: frontend



maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat backend.yml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: backend
  name: backend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: backend
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
db-0                            1/1     Running   0          152m
k8s-backend-95b5f4f77-g6k9r     1/1     Running   0          150m
k8s-frontend-7d4b4986f5-gdnqd   1/1     Running   0          9h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
k8s-backend    1/1     1            1           8h
k8s-frontend   1/1     1            1           18h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get statefulsets.apps 
NAME   READY   AGE
db     1/1     152m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete deployments.apps 
error: resource(s) were provided, but no name was specified
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete deployments.apps k8s-frontend k8s-backend
deployment.apps "k8s-frontend" deleted
deployment.apps "k8s-backend" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                          READY   STATUS        RESTARTS   AGE
db-0                          1/1     Running       0          153m
k8s-backend-95b5f4f77-g6k9r   1/1     Terminating   0          151m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                          READY   STATUS        RESTARTS   AGE
db-0                          1/1     Running       0          153m
k8s-backend-95b5f4f77-g6k9r   1/1     Terminating   0          151m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                          READY   STATUS        RESTARTS   AGE
db-0                          1/1     Running       0          153m
k8s-backend-95b5f4f77-g6k9r   1/1     Terminating   0          151m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                          READY   STATUS        RESTARTS   AGE
db-0                          1/1     Running       0          153m
k8s-backend-95b5f4f77-g6k9r   1/1     Terminating   0          151m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          155m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-services.yaml 
deployment.apps/frontend created
deployment.apps/backend created
service/frontend-svc created
service/backend created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
backend-64ccb8cddc-wgjkl    1/1     Running   0          5s
db-0                        1/1     Running   0          156m
frontend-5b9dd567c5-gr9pz   1/1     Running   0          5s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
backend-64ccb8cddc-wgjkl    1/1     Running   0          11s
db-0                        1/1     Running   0          156m
frontend-5b9dd567c5-gr9pz   1/1     Running   0          11s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP             NODE    NOMINATED NODE   READINESS GATES
backend-64ccb8cddc-wgjkl    1/1     Running   0          16s    10.233.96.10   node2   <none>           <none>
db-0                        1/1     Running   0          156m   10.233.96.8    node2   <none>           <none>
frontend-5b9dd567c5-gr9pz   1/1     Running   0          16s    10.233.90.5    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod frontend-5b9dd567c5-gr9pz 
Name:         frontend-5b9dd567c5-gr9pz
Namespace:    default
Priority:     0
Node:         node1/10.128.0.23
Start Time:   Tue, 05 Jul 2022 18:01:27 +0400
Labels:       app=frontend
              pod-template-hash=5b9dd567c5
Annotations:  cni.projectcalico.org/containerID: b0ffae63bb7b5b941eaf7084351b0b93db4e24d503b631b30f24b0fc3618bc6c
              cni.projectcalico.org/podIP: 10.233.90.5/32
              cni.projectcalico.org/podIPs: 10.233.90.5/32
Status:       Running
IP:           10.233.90.5
IPs:
  IP:           10.233.90.5
Controlled By:  ReplicaSet/frontend-5b9dd567c5
Containers:
  frontend:
    Container ID:   containerd://2956e605a5adba1c20e783a5b58e263a312774f4d1f3d9d67599f483d1e46323
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 18:01:28 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-ntnjh (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-ntnjh:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  2m31s  default-scheduler  Successfully assigned default/frontend-5b9dd567c5-gr9pz to node1
  Normal  Pulled     2m31s  kubelet            Container image "zakharovnpa/k8s-frontend:05.07.22" already present on machine
  Normal  Created    2m31s  kubelet            Created container frontend
  Normal  Started    2m31s  kubelet            Started container frontend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod backend-64ccb8cddc-wgjkl 
Name:         backend-64ccb8cddc-wgjkl
Namespace:    default
Priority:     0
Node:         node2/10.128.0.17
Start Time:   Tue, 05 Jul 2022 18:01:27 +0400
Labels:       app=backend
              pod-template-hash=64ccb8cddc
Annotations:  cni.projectcalico.org/containerID: d10df6cb2589447aa8434d83b6111fcb057571a1324530292ec267ccb9dd6a7f
              cni.projectcalico.org/podIP: 10.233.96.10/32
              cni.projectcalico.org/podIPs: 10.233.96.10/32
Status:       Running
IP:           10.233.96.10
IPs:
  IP:           10.233.96.10
Controlled By:  ReplicaSet/backend-64ccb8cddc
Containers:
  backend:
    Container ID:   containerd://71fcf2650ab7ac61f0f17eeb167d3dbc0dc59a1bd7185779acbdfda6bff6be7d
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 18:01:28 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vzb5p (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-vzb5p:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m22s  default-scheduler  Successfully assigned default/backend-64ccb8cddc-wgjkl to node2
  Normal  Pulled     3m22s  kubelet            Container image "zakharovnpa/k8s-backend:05.07.22" already present on machine
  Normal  Created    3m22s  kubelet            Created container backend
  Normal  Started    3m22s  kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec frontend-5b9dd567c5-gr9pz -- curl -s -m 1 backend
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec frontend-5b9dd567c5-gr9pz -- curl -s -m 1 backend-64ccb8cddc-wgjkl
command terminated with exit code 6
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs frontend-5b9dd567c5-gr9pz 
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/05 14:01:29 [notice] 1#1: using the "epoll" event method
2022/07/05 14:01:29 [notice] 1#1: nginx/1.23.0
2022/07/05 14:01:29 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/05 14:01:29 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/05 14:01:29 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/05 14:01:29 [notice] 1#1: start worker processes
2022/07/05 14:01:29 [notice] 1#1: start worker process 29
2022/07/05 14:01:29 [notice] 1#1: start worker process 30
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs backend-64ccb8cddc-wgjkl 
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
backend-64ccb8cddc-wgjkl    1/1     Running   0          9m24s
db-0                        1/1     Running   0          165m
frontend-5b9dd567c5-gr9pz   1/1     Running   0          9m24s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
backend    1/1     1            1           9m34s
frontend   1/1     1            1           9m34s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete deployments.apps backend frontend 
deployment.apps "backend" deleted
deployment.apps "frontend" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                       READY   STATUS        RESTARTS   AGE
backend-64ccb8cddc-wgjkl   1/1     Terminating   0          9m59s
db-0                       1/1     Running       0          165m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          166m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat backend.yml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: backend
  name: backend
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
    spec:
      containers:
        - image: praqma/network-multitool:alpine-extra
          imagePullPolicy: IfNotPresent
          name: network-multitool
      terminationGracePeriodSeconds: 30

---
apiVersion: v1
kind: Service
metadata:
  name: backend
  namespace: default
spec:
  ports:
    - name: web
      port: 80
  selector:
    app: backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          3h19m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
backend            ClusterIP      10.233.2.72     <none>        9000/TCP         43m
db-svc             LoadBalancer   10.233.43.4     <pending>     5432:31545/TCP   3h19m
frontend-svc       NodePort       10.233.40.99    <none>        80:31000/TCP     43m
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   6h55m
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          32h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --all
error: unknown flag: --all
See 'kubectl get --help' for usage.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get -A
You must specify the type of resource to get. Use "kubectl api-resources" for a complete list of supported resources.

error: Required resource not specified.
Use "kubectl explain <resource>" for a detailed description of that resource (e.g. kubectl explain pods).
See 'kubectl get -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl --help
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources.
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL.

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh or fish)

Other Commands:
  alpha           Commands for features in alpha
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-services.yaml 
deployment.apps/frontend-backend created
error: error parsing web-services.yaml: error converting YAML to JSON: yaml: line 14: did not find expected key
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-services.yaml 
deployment.apps/frontend-backend unchanged
error: error parsing web-services.yaml: error converting YAML to JSON: yaml: line 14: did not find expected key
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-services.yaml 
deployment.apps/fb-pod created
The Service "fb-svc" is invalid: spec.ports[0].nodePort: Invalid value: 31000: provided port is already allocated
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                                READY   STATUS    RESTARTS   AGE
db-0                                1/1     Running   0          3h35m
fb-pod-65b9777746-lf4w8             2/2     Running   0          24s
frontend-backend-5cf98798c9-p774s   2/2     Running   0          10m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                                READY   STATUS    RESTARTS   AGE     IP             NODE    NOMINATED NODE   READINESS GATES
db-0                                1/1     Running   0          3h35m   10.233.96.8    node2   <none>           <none>
fb-pod-65b9777746-lf4w8             2/2     Running   0          36s     10.233.96.11   node2   <none>           <none>
frontend-backend-5cf98798c9-p774s   2/2     Running   0          10m     10.233.90.6    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod             1/1     1            1           70s
frontend-backend   1/1     1            1           10m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc 
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
backend            ClusterIP      10.233.2.72     <none>        9000/TCP         60m
db-svc             LoadBalancer   10.233.43.4     <pending>     5432:31545/TCP   3h36m
frontend-svc       NodePort       10.233.40.99    <none>        80:31000/TCP     60m
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   7h12m
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          32h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe deployments.apps frontend-backend
Name:                   frontend-backend
Namespace:              default
CreationTimestamp:      Tue, 05 Jul 2022 18:50:40 +0400
Labels:                 app=frontend-backend
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=frontend-backend
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=frontend-backend
  Containers:
   frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   backend:
    Image:        zakharovnpa/k8s-backend:05.07.22
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   frontend-backend-5cf98798c9 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  11m   deployment-controller  Scaled up replica set frontend-backend-5cf98798c9 to 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe deployments.apps fb-pod
Name:                   fb-pod
Namespace:              default
CreationTimestamp:      Tue, 05 Jul 2022 19:00:22 +0400
Labels:                 app=fb-app
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=fb-app
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=fb-app
  Containers:
   frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   backend:
    Image:        zakharovnpa/k8s-backend:05.07.22
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   fb-pod-65b9777746 (1/1 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  2m17s  deployment-controller  Scaled up replica set fb-pod-65b9777746 to 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod             1/1     1            1           54m
frontend-backend   1/1     1            1           64m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe deployments.apps frontend-backend 
Name:                   frontend-backend
Namespace:              default
CreationTimestamp:      Tue, 05 Jul 2022 18:50:40 +0400
Labels:                 app=frontend-backend
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=frontend-backend
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=frontend-backend
  Containers:
   frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   backend:
    Image:        zakharovnpa/k8s-backend:05.07.22
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   frontend-backend-5cf98798c9 (1/1 replicas created)
Events:          <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete deployments.apps frontend-backend 
deployment.apps "frontend-backend" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete deployments.apps fb-pod 
deployment.apps "fb-pod" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                                READY   STATUS        RESTARTS   AGE
db-0                                1/1     Running       0          4h31m
fb-pod-65b9777746-lf4w8             2/2     Terminating   0          56m
frontend-backend-5cf98798c9-p774s   2/2     Terminating   0          66m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                                READY   STATUS        RESTARTS   AGE
db-0                                1/1     Running       0          4h31m
fb-pod-65b9777746-lf4w8             2/2     Terminating   0          56m
frontend-backend-5cf98798c9-p774s   2/2     Terminating   0          66m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          4h41m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-services.yaml 
deployment.apps/fb-pod created
The Service "fb-svc" is invalid: spec.ports[0].nodePort: Invalid value: 31000: provided port is already allocated
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          4h41m
fb-pod-65b9777746-qhvvj   2/2     Running   0          12s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
backend            ClusterIP      10.233.2.72     <none>        9000/TCP         125m
db-svc             LoadBalancer   10.233.43.4     <pending>     5432:31545/TCP   4h41m
frontend-svc       NodePort       10.233.40.99    <none>        80:31000/TCP     125m
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   8h
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          33h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete svc backend frontend-svc
service "backend" deleted
service "frontend-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc             LoadBalancer   10.233.43.4     <pending>     5432:31545/TCP   4h42m
k8s-database-svc   LoadBalancer   10.233.43.231   <pending>     5432:30352/TCP   8h
kubernetes         ClusterIP      10.233.0.1      <none>        443/TCP          33h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete svc k8s-database-svc
service "k8s-database-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          4h43m
fb-pod-65b9777746-qhvvj   2/2     Running   0          2m14s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           2m20s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete deployments.apps fb-pod
deployment.apps "fb-pod" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS        RESTARTS   AGE
db-0                      1/1     Running       0          4h44m
fb-pod-65b9777746-qhvvj   2/2     Terminating   0          2m45s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          4h45m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)          AGE
db-svc       LoadBalancer   10.233.43.4   <pending>     5432:31545/TCP   4h45m
kubernetes   ClusterIP      10.233.0.1    <none>        443/TCP          33h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete svc db-svc
service "db-svc" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   33h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          4h45m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
No resources found in default namespace.
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-services.yaml 
deployment.apps/fb-pod created
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           9s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps -o wide
NAME     READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS         IMAGES                                                               SELECTOR
fb-pod   1/1     1            1           19s   frontend,backend   zakharovnpa/k8s-frontend:05.07.22,zakharovnpa/k8s-backend:05.07.22   app=fb-app
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get po -o wide
NAME                      READY   STATUS    RESTARTS   AGE     IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          4h48m   10.233.96.8   node2   <none>           <none>
fb-pod-65b9777746-5ztxd   2/2     Running   0          75s     10.233.90.8   node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE     SELECTOR
fb-svc       NodePort    10.233.3.228   <none>        80:31000/TCP   3m23s   app=fb
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP        33h     <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep -o wide
NAME         ENDPOINTS          AGE
fb-svc       <none>             3m33s
kubernetes   10.128.0.18:6443   33h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl descr ep
error: unknown command "descr" for "kubectl"

Did you mean this?
	describe
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep
Name:         fb-svc
Namespace:    default
Labels:       app=fb
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-05T16:12:56Z
Subsets:
Events:  <none>


Name:         kubernetes
Namespace:    default
Labels:       endpointslice.kubernetes.io/skip-mirror=true
Annotations:  <none>
Subsets:
  Addresses:          10.128.0.18
  NotReadyAddresses:  <none>
  Ports:
    Name   Port  Protocol
    ----   ----  --------
    https  6443  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep kubernetes
Name:         kubernetes
Namespace:    default
Labels:       endpointslice.kubernetes.io/skip-mirror=true
Annotations:  <none>
Subsets:
  Addresses:          10.128.0.18
  NotReadyAddresses:  <none>
  Ports:
    Name   Port  Protocol
    ----   ----  --------
    https  6443  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep fb-svc
Name:         fb-svc
Namespace:    default
Labels:       app=fb
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-05T16:12:56Z
Subsets:
Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"labels":{"app":"fb"},"name":"fb-svc","namespace":"default"},"spec":{"ports":[{"nodePort":31000,"port":80}],"selector":{"app":"fb"},"type":"NodePort"}}
    creationTimestamp: "2022-07-05T16:12:56Z"
    labels:
      app: fb
    name: fb-svc
    namespace: default
    resourceVersion: "205756"
    uid: 03535b29-053c-4a5b-bd96-31d62b033d56
  spec:
    clusterIP: 10.233.3.228
    clusterIPs:
    - 10.233.3.228
    externalTrafficPolicy: Cluster
    internalTrafficPolicy: Cluster
    ipFamilies:
    - IPv4
    ipFamilyPolicy: SingleStack
    ports:
    - nodePort: 31000
      port: 80
      protocol: TCP
      targetPort: 80
    selector:
      app: fb
    sessionAffinity: None
    type: NodePort
  status:
    loadBalancer: {}
- apiVersion: v1
  kind: Service
  metadata:
    creationTimestamp: "2022-07-04T06:33:10Z"
    labels:
      component: apiserver
      provider: kubernetes
    name: kubernetes
    namespace: default
    resourceVersion: "199"
    uid: 44070298-5a8c-4d3a-9a77-a4aaacd271e8
  spec:
    clusterIP: 10.233.0.1
    clusterIPs:
    - 10.233.0.1
    internalTrafficPolicy: Cluster
    ipFamilies:
    - IPv4
    ipFamilyPolicy: SingleStack
    ports:
    - name: https
      port: 443
      protocol: TCP
      targetPort: 6443
    sessionAffinity: None
    type: ClusterIP
  status:
    loadBalancer: {}
kind: List
metadata:
  resourceVersion: ""
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          4h54m
fb-pod-65b9777746-5ztxd   2/2     Running   0          6m58s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe po fb-pod-65b9777746-5ztxd 
Name:         fb-pod-65b9777746-5ztxd
Namespace:    default
Priority:     0
Node:         node1/10.128.0.23
Start Time:   Tue, 05 Jul 2022 20:12:55 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: 271035e70868fe385bb0d184b83dfb330b00ab2961805be7a1875c36c0ea443e
              cni.projectcalico.org/podIP: 10.233.90.8/32
              cni.projectcalico.org/podIPs: 10.233.90.8/32
Status:       Running
IP:           10.233.90.8
IPs:
  IP:           10.233.90.8
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://b09be2c662873735b4cff1273342f68cbf16c4cc977773a7f7ebcfa801c7e9bb
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 05 Jul 2022 20:12:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrdhr (ro)
  backend:
    Container ID:   containerd://e26ddfa7a7f6d3c2654c06a561672a97448b3fda9081505448e1c9d70aa223a7
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 20:12:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrdhr (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-vrdhr:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  7m38s  default-scheduler  Successfully assigned default/fb-pod-65b9777746-5ztxd to node1
  Normal  Pulled     7m38s  kubelet            Container image "zakharovnpa/k8s-frontend:05.07.22" already present on machine
  Normal  Created    7m38s  kubelet            Created container frontend
  Normal  Started    7m38s  kubelet            Started container frontend
  Normal  Pulled     7m38s  kubelet            Container image "zakharovnpa/k8s-backend:05.07.22" already present on machine
  Normal  Created    7m38s  kubelet            Created container backend
  Normal  Started    7m38s  kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-5ztxd 
Defaulted container "frontend" out of: frontend, backend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/05 16:12:56 [notice] 1#1: using the "epoll" event method
2022/07/05 16:12:56 [notice] 1#1: nginx/1.23.0
2022/07/05 16:12:56 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/05 16:12:56 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/05 16:12:56 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/05 16:12:56 [notice] 1#1: start worker processes
2022/07/05 16:12:56 [notice] 1#1: start worker process 30
2022/07/05 16:12:56 [notice] 1#1: start worker process 31
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-5ztxd -c frontend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/05 16:12:56 [notice] 1#1: using the "epoll" event method
2022/07/05 16:12:56 [notice] 1#1: nginx/1.23.0
2022/07/05 16:12:56 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/05 16:12:56 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/05 16:12:56 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/05 16:12:56 [notice] 1#1: start worker processes
2022/07/05 16:12:56 [notice] 1#1: start worker process 30
2022/07/05 16:12:56 [notice] 1#1: start worker process 31
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-5ztxd -c backend
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-services.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
fb-svc       NodePort    10.233.3.228   <none>        80:31000/TCP   19m
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP        33h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get statefulsets.apps 
NAME   READY   AGE
db     1/1     5h6m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          5h7m
fb-pod-65b9777746-5ztxd   2/2     Running   0          19m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl delete statefulsets.apps db
statefulset.apps "db" deleted
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-65b9777746-5ztxd   2/2     Running   0          20m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db.yaml 
statefulset.apps/db created
service/db-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
db-svc       NodePort    10.233.0.124   <none>        5432:30159/TCP   7s
fb-svc       NodePort    10.233.3.228   <none>        80:31000/TCP     21m
kubernetes   ClusterIP   10.233.0.1     <none>        443/TCP          34h
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          19s
fb-pod-65b9777746-5ztxd   2/2     Running   0          21m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          28s   10.233.96.12   node2   <none>           <none>
fb-pod-65b9777746-5ztxd   2/2     Running   0          21m   10.233.90.8    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe statefulsets.apps db
Name:               db
Namespace:          default
CreationTimestamp:  Tue, 05 Jul 2022 20:33:54 +0400
Selector:           app=db
Labels:             <none>
Annotations:        <none>
Replicas:           1 desired | 1 total
Update Strategy:    RollingUpdate
  Partition:        0
Pods Status:        1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=db
  Containers:
   db:
    Image:      zakharovnpa/k8s-database:05.07.22
    Port:       <none>
    Host Port:  <none>
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:               <none>
  Volumes:                <none>
Volume Claims:            <none>
Events:
  Type    Reason            Age   From                    Message
  ----    ------            ----  ----                    -------
  Normal  SuccessfulCreate  74s   statefulset-controller  create Pod db-0 in StatefulSet db successful
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe deployments.apps fb-pod 
Name:                   fb-pod
Namespace:              default
CreationTimestamp:      Tue, 05 Jul 2022 20:12:55 +0400
Labels:                 app=fb-app
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=fb-app
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=fb-app
  Containers:
   frontend:
    Image:        zakharovnpa/k8s-frontend:05.07.22
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
   backend:
    Image:        zakharovnpa/k8s-backend:05.07.22
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   fb-pod-65b9777746 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  23m   deployment-controller  Scaled up replica set fb-pod-65b9777746 to 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe service db-svc
Name:                     db-svc
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=db
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.0.124
IPs:                      10.233.0.124
Port:                     <unset>  5432/TCP
TargetPort:               5432/TCP
NodePort:                 <unset>  30159/TCP
Endpoints:                10.233.96.12:5432
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe service fb-svc
Name:                     fb-svc
Namespace:                default
Labels:                   app=fb
Annotations:              <none>
Selector:                 app=fb
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.3.228
IPs:                      10.233.3.228
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  31000/TCP
Endpoints:                <none>
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs po fb-pod-65b9777746-5ztxd -c frontend
Error from server (NotFound): pods "po" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-5ztxd -c frontend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/05 16:12:56 [notice] 1#1: using the "epoll" event method
2022/07/05 16:12:56 [notice] 1#1: nginx/1.23.0
2022/07/05 16:12:56 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/05 16:12:56 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/05 16:12:56 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/05 16:12:56 [notice] 1#1: start worker processes
2022/07/05 16:12:56 [notice] 1#1: start worker process 30
2022/07/05 16:12:56 [notice] 1#1: start worker process 31
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-5ztxd -c backend
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE    IP             NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          8m7s   10.233.96.12   node2   <none>           <none>
fb-pod-65b9777746-5ztxd   2/2     Running   0          29m    10.233.90.8    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod fb-pod-65b9777746-5ztxd -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: 271035e70868fe385bb0d184b83dfb330b00ab2961805be7a1875c36c0ea443e
    cni.projectcalico.org/podIP: 10.233.90.8/32
    cni.projectcalico.org/podIPs: 10.233.90.8/32
  creationTimestamp: "2022-07-05T16:12:55Z"
  generateName: fb-pod-65b9777746-
  labels:
    app: fb-app
    pod-template-hash: 65b9777746
  name: fb-pod-65b9777746-5ztxd
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: fb-pod-65b9777746
    uid: 0ab1d727-9689-494d-aa85-a14a72497dc2
  resourceVersion: "205772"
  uid: 2529eac0-bd4b-46d1-a60b-4548c4f7199f
spec:
  containers:
  - image: zakharovnpa/k8s-frontend:05.07.22
    imagePullPolicy: IfNotPresent
    name: frontend
    ports:
    - containerPort: 80
      protocol: TCP
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-vrdhr
      readOnly: true
  - image: zakharovnpa/k8s-backend:05.07.22
    imagePullPolicy: IfNotPresent
    name: backend
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-vrdhr
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: node1
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-vrdhr
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2022-07-05T16:12:55Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-07-05T16:12:57Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-07-05T16:12:57Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-07-05T16:12:55Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://e26ddfa7a7f6d3c2654c06a561672a97448b3fda9081505448e1c9d70aa223a7
    image: docker.io/zakharovnpa/k8s-backend:05.07.22
    imageID: docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    lastState: {}
    name: backend
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-05T16:12:56Z"
  - containerID: containerd://b09be2c662873735b4cff1273342f68cbf16c4cc977773a7f7ebcfa801c7e9bb
    image: docker.io/zakharovnpa/k8s-frontend:05.07.22
    imageID: docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    lastState: {}
    name: frontend
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-05T16:12:56Z"
  hostIP: 10.128.0.23
  phase: Running
  podIP: 10.233.90.8
  podIPs:
  - ip: 10.233.90.8
  qosClass: BestEffort
  startTime: "2022-07-05T16:12:55Z"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps 
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
fb-pod   1/1     1            1           40m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get deployments.apps fb-pod -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"fb-app"},"name":"fb-pod","namespace":"default"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"fb-app"}},"template":{"metadata":{"labels":{"app":"fb-app"}},"spec":{"containers":[{"image":"zakharovnpa/k8s-frontend:05.07.22","imagePullPolicy":"IfNotPresent","name":"frontend","ports":[{"containerPort":80}]},{"image":"zakharovnpa/k8s-backend:05.07.22","imagePullPolicy":"IfNotPresent","name":"backend"}],"terminationGracePeriodSeconds":30}}}}
  creationTimestamp: "2022-07-05T16:12:55Z"
  generation: 1
  labels:
    app: fb-app
  name: fb-pod
  namespace: default
  resourceVersion: "205774"
  uid: e104a79b-9745-4261-abd4-7f8e361e0da0
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: fb-app
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: fb-app
    spec:
      containers:
      - image: zakharovnpa/k8s-frontend:05.07.22
        imagePullPolicy: IfNotPresent
        name: frontend
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      - image: zakharovnpa/k8s-backend:05.07.22
        imagePullPolicy: IfNotPresent
        name: backend
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2022-07-05T16:12:57Z"
    lastUpdateTime: "2022-07-05T16:12:57Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2022-07-05T16:12:55Z"
    lastUpdateTime: "2022-07-05T16:12:57Z"
    message: ReplicaSet "fb-pod-65b9777746" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd --help
Execute a command in a container.

Examples:
  # Get output from running the 'date' command from pod mypod, using the first container by default
  kubectl exec mypod -- date
  
  # Get output from running the 'date' command in ruby-container from pod mypod
  kubectl exec mypod -c ruby-container -- date
  
  # Switch to raw terminal mode; sends stdin to 'bash' in ruby-container from pod mypod
  # and sends stdout/stderr from 'bash' back to the client
  kubectl exec mypod -c ruby-container -i -t -- bash -il
  
  # List contents of /usr from the first container of pod mypod and sort by modification time
  # If the command you want to execute in the pod has any flags in common (e.g. -i),
  # you must use two dashes (--) to separate your command's flags/arguments
  # Also note, do not surround your command and its flags/arguments with quotes
  # unless that is how you would execute it normally (i.e., do ls -t /usr, not "ls -t /usr")
  kubectl exec mypod -i -t -- ls -t /usr
  
  # Get output from running 'date' command from the first pod of the deployment mydeployment, using the first container
by default
  kubectl exec deploy/mydeployment -- date
  
  # Get output from running 'date' command from the first pod of the service myservice, using the first container by
default
  kubectl exec svc/myservice -- date

Options:
    -c, --container='':
	Container name. If omitted, use the kubectl.kubernetes.io/default-container annotation for selecting the
	container to be attached or the first container in the pod will be chosen

    -f, --filename=[]:
	to use to exec into the resource

    --pod-running-timeout=1m0s:
	The length of time (like 5s, 2m, or 3h, higher than zero) to wait until at least one pod is running

    -q, --quiet=false:
	Only print output from the remote session

    -i, --stdin=false:
	Pass stdin to the container

    -t, --tty=false:
	Stdin is a TTY

Usage:
  kubectl exec (POD | TYPE/NAME) [-c CONTAINER] [flags] -- COMMAND [args...] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend ^C
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# pwd
/app
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# cd
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping db
ping: db: Name or service not known
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# nslookup
bash: nslookup: command not found
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping ya.ru
PING ya.ru (87.250.250.242) 56(84) bytes of data.
64 bytes from ya.ru (87.250.250.242): icmp_seq=1 ttl=58 time=0.888 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=2 ttl=58 time=0.366 ms
64 bytes from ya.ru (87.250.250.242): icmp_seq=3 ttl=58 time=0.374 ms
^C
--- ya.ru ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 25ms
rtt min/avg/max/mdev = 0.366/0.542/0.888/0.245 ms
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping backend
ping: backend: Name or service not known
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl backend
curl: (6) Could not resolve host: backend
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=60 time=17.7 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=60 time=17.3 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 3ms
rtt min/avg/max/mdev = 17.254/17.461/17.669/0.246 ms
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# curl ipconfig.me
Moved Permanently. Redirecting to https://ifconfig.me/root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# curl ifconfig.me
51.250.93.166root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          11h   10.233.96.12   node2   <none>           <none>
fb-pod-65b9777746-5ztxd   2/2     Running   0          11h   10.233.90.8    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ping 10.233.90.8
PING 10.233.90.8 (10.233.90.8) 56(84) bytes of data.
64 bytes from 10.233.90.8: icmp_seq=1 ttl=64 time=0.026 ms
64 bytes from 10.233.90.8: icmp_seq=2 ttl=64 time=0.044 ms
64 bytes from 10.233.90.8: icmp_seq=3 ttl=64 time=0.038 ms
64 bytes from 10.233.90.8: icmp_seq=4 ttl=64 time=0.048 ms
^C
--- 10.233.90.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 70ms
rtt min/avg/max/mdev = 0.026/0.039/0.048/0.008 ms
root@fb-pod-65b9777746-5ztxd:/app# ping 10.233.90.12
PING 10.233.90.12 (10.233.90.12) 56(84) bytes of data.
^C
--- 10.233.90.12 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 54ms

root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1430 qdisc noqueue state UP group default 
    link/ether d2:b5:8b:51:74:70 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.233.90.8/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::d0b5:8bff:fe51:7470/64 scope link 
       valid_lft forever preferred_lft forever
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c frontend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ip a
bash: ip: command not found
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ping 8.8.8.8
bash: ping: command not found
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# cat /etc/*release
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# curl ifconfig.me
51.250.93.166root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# curl -m -s 1 backend
curl: option -m: expected a proper numerical parameter
curl: try 'curl --help' or 'curl --manual' for more information
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# curl backend
curl: (6) Could not resolve host: backend
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ifconfig
bash: ifconfig: command not found
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt install net-tools
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package net-tools
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt install net tools
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package net
E: Unable to locate package tools
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit                 
logout
command terminated with exit code 100
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# cat /etc/*release
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
root@fb-pod-65b9777746-5ztxd:/app# apt installing list
E: Invalid operation installing
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt --help
apt 1.8.2.3 (amd64)
Usage: apt [options] command

apt is a commandline package manager and provides commands for
searching and managing as well as querying information about packages.
It provides the same functionality as the specialized APT tools,
like apt-get and apt-cache, but enables options more suitable for
interactive use by default.

Most used commands:
  list - list packages based on package names
  search - search in package descriptions
  show - show package details
  install - install packages
  reinstall - reinstall packages
  remove - remove packages
  autoremove - Remove automatically all unused packages
  update - update list of available packages
  upgrade - upgrade the system by installing/upgrading packages
  full-upgrade - upgrade the system by removing/installing/upgrading packages
  edit-sources - edit the source information file

See apt(8) for more information about the available commands.
Configuration options and syntax is detailed in apt.conf(5).
Information about how to configure sources can be found in sources.list(5).
Package and version choices can be expressed via apt_preferences(5).
Security details are available in apt-secure(8).
                                        This APT has Super Cow Powers.
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt list
Listing... Done
adduser/now 3.118 all [installed,local]
apt/now 1.8.2.3 amd64 [installed,local]
autoconf/now 2.69-11 all [installed,local]
automake/now 1:1.16.1-4 all [installed,local]
autotools-dev/now 20180224.1 all [installed,local]
base-files/now 10.3+deb10u12 amd64 [installed,local]
base-passwd/now 3.5.46 amd64 [installed,local]
bash/now 5.0-4 amd64 [installed,local]
binutils-common/now 2.31.1-16 amd64 [installed,local]
binutils-x86-64-linux-gnu/now 2.31.1-16 amd64 [installed,local]
binutils/now 2.31.1-16 amd64 [installed,local]
bsdutils/now 1:2.33.1-0.1 amd64 [installed,local]
bzip2/now 1.0.6-9.2~deb10u1 amd64 [installed,local]
ca-certificates/now 20200601~deb10u2 all [installed,local]
comerr-dev/now 2.1-1.44.5-1+deb10u3 amd64 [installed,local]
coreutils/now 8.30-3 amd64 [installed,local]
cpp-8/now 8.3.0-6 amd64 [installed,local]
cpp/now 4:8.3.0-1 amd64 [installed,local]
curl/now 7.64.0-4+deb10u2 amd64 [installed,local]
dash/now 0.5.10.2-5 amd64 [installed,local]
debconf/now 1.5.71+deb10u1 all [installed,local]
debian-archive-keyring/now 2019.1+deb10u1 all [installed,local]
debianutils/now 4.8.6.1 amd64 [installed,local]
default-libmysqlclient-dev/now 1.0.5 amd64 [installed,local]
diffutils/now 1:3.7-3 amd64 [installed,local]
dirmngr/now 2.2.12-1+deb10u1 amd64 [installed,local]
dpkg-dev/now 1.19.8 all [installed,local]
dpkg/now 1.19.8 amd64 [installed,local]
e2fsprogs/now 1.44.5-1+deb10u3 amd64 [installed,local]
fdisk/now 2.33.1-0.1 amd64 [installed,local]
file/now 1:5.35-4+deb10u2 amd64 [installed,local]
findutils/now 4.6.0+git+20190209-2 amd64 [installed,local]
fontconfig-config/now 2.13.1-2 all [installed,local]
fontconfig/now 2.13.1-2 amd64 [installed,local]
fonts-dejavu-core/now 2.37-1 all [installed,local]
g++-8/now 8.3.0-6 amd64 [installed,local]
g++/now 4:8.3.0-1 amd64 [installed,local]
gcc-8-base/now 8.3.0-6 amd64 [installed,local]
gcc-8/now 8.3.0-6 amd64 [installed,local]
gcc/now 4:8.3.0-1 amd64 [installed,local]
gir1.2-freedesktop/now 1.58.3-2 amd64 [installed,local]
gir1.2-gdkpixbuf-2.0/now 2.38.1+dfsg-1 amd64 [installed,local]
gir1.2-glib-2.0/now 1.58.3-2 amd64 [installed,local]
gir1.2-rsvg-2.0/now 2.44.10-2.1 amd64 [installed,local]
git-man/now 1:2.20.1-2+deb10u3 all [installed,local]
git/now 1:2.20.1-2+deb10u3 amd64 [installed,local]
gnupg-l10n/now 2.2.12-1+deb10u1 all [installed,local]
gnupg-utils/now 2.2.12-1+deb10u1 amd64 [installed,local]
gnupg/now 2.2.12-1+deb10u1 all [installed,local]
gpg-agent/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpg-wks-client/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpg-wks-server/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpg/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpgconf/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpgsm/now 2.2.12-1+deb10u1 amd64 [installed,local]
gpgv/now 2.2.12-1+deb10u1 amd64 [installed,local]
grep/now 3.3-1 amd64 [installed,local]
gzip/now 1.9-3+deb10u1 amd64 [installed,local]
hicolor-icon-theme/now 0.17-2 all [installed,local]
hostname/now 3.21 amd64 [installed,local]
icu-devtools/now 63.1-6+deb10u3 amd64 [installed,local]
imagemagick-6-common/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
imagemagick-6.q16/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
imagemagick/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
init-system-helpers/now 1.56+nmu1 all [installed,local]
iproute2/now 4.20.0-2+deb10u1 amd64 [installed,local]
iputils-ping/now 3:20180629-2+deb10u2 amd64 [installed,local]
krb5-multidev/now 1.17-3+deb10u3 amd64 [installed,local]
libacl1/now 2.2.53-4 amd64 [installed,local]
libapr1/now 1.6.5-1+b1 amd64 [installed,local]
libaprutil1/now 1.6.1-4 amd64 [installed,local]
libapt-pkg5.0/now 1.8.2.3 amd64 [installed,local]
libasan5/now 8.3.0-6 amd64 [installed,local]
libassuan0/now 2.5.2-1 amd64 [installed,local]
libatomic1/now 8.3.0-6 amd64 [installed,local]
libattr1/now 1:2.4.48-4 amd64 [installed,local]
libaudit-common/now 1:2.8.4-3 all [installed,local]
libaudit1/now 1:2.8.4-3 amd64 [installed,local]
libbinutils/now 2.31.1-16 amd64 [installed,local]
libblkid-dev/now 2.33.1-0.1 amd64 [installed,local]
libblkid1/now 2.33.1-0.1 amd64 [installed,local]
libbluetooth-dev/now 5.50-1.2~deb10u2 amd64 [installed,local]
libbluetooth3/now 5.50-1.2~deb10u2 amd64 [installed,local]
libbsd0/now 0.9.1-2+deb10u1 amd64 [installed,local]
libbz2-1.0/now 1.0.6-9.2~deb10u1 amd64 [installed,local]
libbz2-dev/now 1.0.6-9.2~deb10u1 amd64 [installed,local]
libc-bin/now 2.28-10+deb10u1 amd64 [installed,local]
libc-dev-bin/now 2.28-10+deb10u1 amd64 [installed,local]
libc6-dev/now 2.28-10+deb10u1 amd64 [installed,local]
libc6/now 2.28-10+deb10u1 amd64 [installed,local]
libcairo-gobject2/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcairo-script-interpreter2/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcairo2-dev/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcairo2/now 1.16.0-4+deb10u1 amd64 [installed,local]
libcap-ng0/now 0.7.9-2 amd64 [installed,local]
libcap2-bin/now 1:2.25-2 amd64 [installed,local]
libcap2/now 1:2.25-2 amd64 [installed,local]
libcc1-0/now 8.3.0-6 amd64 [installed,local]
libcom-err2/now 1.44.5-1+deb10u3 amd64 [installed,local]
libcroco3/now 0.6.12-3 amd64 [installed,local]
libcurl3-gnutls/now 7.64.0-4+deb10u2 amd64 [installed,local]
libcurl4-openssl-dev/now 7.64.0-4+deb10u2 amd64 [installed,local]
libcurl4/now 7.64.0-4+deb10u2 amd64 [installed,local]
libdatrie1/now 0.2.12-2 amd64 [installed,local]
libdb-dev/now 5.3.1+nmu1 amd64 [installed,local]
libdb5.3-dev/now 5.3.28+dfsg1-0.5 amd64 [installed,local]
libdb5.3/now 5.3.28+dfsg1-0.5 amd64 [installed,local]
libde265-0/now 1.0.3-1+b1 amd64 [installed,local]
libdebconfclient0/now 0.249 amd64 [installed,local]
libdjvulibre-dev/now 3.5.27.1-10+deb10u1 amd64 [installed,local]
libdjvulibre-text/now 3.5.27.1-10+deb10u1 all [installed,local]
libdjvulibre21/now 3.5.27.1-10+deb10u1 amd64 [installed,local]
libdpkg-perl/now 1.19.8 all [installed,local]
libedit2/now 3.1-20181209-1 amd64 [installed,local]
libelf1/now 0.176-1.1 amd64 [installed,local]
liberror-perl/now 0.17027-2 all [installed,local]
libevent-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-core-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-dev/now 2.1.8-stable-4 amd64 [installed,local]
libevent-extra-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-openssl-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libevent-pthreads-2.1-6/now 2.1.8-stable-4 amd64 [installed,local]
libexif-dev/now 0.6.21-5.1+deb10u5 amd64 [installed,local]
libexif12/now 0.6.21-5.1+deb10u5 amd64 [installed,local]
libexpat1-dev/now 2.2.6-2+deb10u4 amd64 [installed,local]
libexpat1/now 2.2.6-2+deb10u4 amd64 [installed,local]
libext2fs2/now 1.44.5-1+deb10u3 amd64 [installed,local]
libfdisk1/now 2.33.1-0.1 amd64 [installed,local]
libffi-dev/now 3.2.1-9 amd64 [installed,local]
libffi6/now 3.2.1-9 amd64 [installed,local]
libfftw3-double3/now 3.3.8-2 amd64 [installed,local]
libfontconfig1-dev/now 2.13.1-2 amd64 [installed,local]
libfontconfig1/now 2.13.1-2 amd64 [installed,local]
libfreetype6-dev/now 2.9.1-3+deb10u2 amd64 [installed,local]
libfreetype6/now 2.9.1-3+deb10u2 amd64 [installed,local]
libfribidi0/now 1.0.5-3.1+deb10u1 amd64 [installed,local]
libgcc-8-dev/now 8.3.0-6 amd64 [installed,local]
libgcc1/now 1:8.3.0-6 amd64 [installed,local]
libgcrypt20/now 1.8.4-5+deb10u1 amd64 [installed,local]
libgdbm-compat4/now 1.18.1-4 amd64 [installed,local]
libgdbm-dev/now 1.18.1-4 amd64 [installed,local]
libgdbm6/now 1.18.1-4 amd64 [installed,local]
libgdk-pixbuf2.0-0/now 2.38.1+dfsg-1 amd64 [installed,local]
libgdk-pixbuf2.0-bin/now 2.38.1+dfsg-1 amd64 [installed,local]
libgdk-pixbuf2.0-common/now 2.38.1+dfsg-1 all [installed,local]
libgdk-pixbuf2.0-dev/now 2.38.1+dfsg-1 amd64 [installed,local]
libgirepository-1.0-1/now 1.58.3-2 amd64 [installed,local]
libglib2.0-0/now 2.58.3-2+deb10u3 amd64 [installed,local]
libglib2.0-bin/now 2.58.3-2+deb10u3 amd64 [installed,local]
libglib2.0-data/now 2.58.3-2+deb10u3 all [installed,local]
libglib2.0-dev-bin/now 2.58.3-2+deb10u3 amd64 [installed,local]
libglib2.0-dev/now 2.58.3-2+deb10u3 amd64 [installed,local]
libgmp-dev/now 2:6.1.2+dfsg-4+deb10u1 amd64 [installed,local]
libgmp10/now 2:6.1.2+dfsg-4+deb10u1 amd64 [installed,local]
libgmpxx4ldbl/now 2:6.1.2+dfsg-4+deb10u1 amd64 [installed,local]
libgnutls-dane0/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutls-openssl27/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutls28-dev/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutls30/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgnutlsxx28/now 3.6.7-4+deb10u7 amd64 [installed,local]
libgomp1/now 8.3.0-6 amd64 [installed,local]
libgpg-error0/now 1.35-1 amd64 [installed,local]
libgraphite2-3/now 1.3.13-7 amd64 [installed,local]
libgssapi-krb5-2/now 1.17-3+deb10u3 amd64 [installed,local]
libgssrpc4/now 1.17-3+deb10u3 amd64 [installed,local]
libharfbuzz0b/now 2.3.1-1 amd64 [installed,local]
libheif1/now 1.3.2-2~deb10u1 amd64 [installed,local]
libhogweed4/now 3.4.1-1+deb10u1 amd64 [installed,local]
libice-dev/now 2:1.0.9-2 amd64 [installed,local]
libice6/now 2:1.0.9-2 amd64 [installed,local]
libicu-dev/now 63.1-6+deb10u3 amd64 [installed,local]
libicu63/now 63.1-6+deb10u3 amd64 [installed,local]
libidn2-0/now 2.0.5-1+deb10u1 amd64 [installed,local]
libidn2-dev/now 2.0.5-1+deb10u1 amd64 [installed,local]
libilmbase-dev/now 2.2.1-2 amd64 [installed,local]
libilmbase23/now 2.2.1-2 amd64 [installed,local]
libisl19/now 0.20-2 amd64 [installed,local]
libitm1/now 8.3.0-6 amd64 [installed,local]
libjbig-dev/now 2.1-3.1+b2 amd64 [installed,local]
libjbig0/now 2.1-3.1+b2 amd64 [installed,local]
libjpeg-dev/now 1:1.5.2-2+deb10u1 all [installed,local]
libjpeg62-turbo-dev/now 1:1.5.2-2+deb10u1 amd64 [installed,local]
libjpeg62-turbo/now 1:1.5.2-2+deb10u1 amd64 [installed,local]
libk5crypto3/now 1.17-3+deb10u3 amd64 [installed,local]
libkadm5clnt-mit11/now 1.17-3+deb10u3 amd64 [installed,local]
libkadm5srv-mit11/now 1.17-3+deb10u3 amd64 [installed,local]
libkdb5-9/now 1.17-3+deb10u3 amd64 [installed,local]
libkeyutils1/now 1.6-6 amd64 [installed,local]
libkrb5-3/now 1.17-3+deb10u3 amd64 [installed,local]
libkrb5-dev/now 1.17-3+deb10u3 amd64 [installed,local]
libkrb5support0/now 1.17-3+deb10u3 amd64 [installed,local]
libksba8/now 1.3.5-2 amd64 [installed,local]
liblcms2-2/now 2.9-3 amd64 [installed,local]
liblcms2-dev/now 2.9-3 amd64 [installed,local]
libldap-2.4-2/now 2.4.47+dfsg-3+deb10u7 amd64 [installed,local]
libldap-common/now 2.4.47+dfsg-3+deb10u7 all [installed,local]
liblqr-1-0-dev/now 0.4.2-2.1 amd64 [installed,local]
liblqr-1-0/now 0.4.2-2.1 amd64 [installed,local]
liblsan0/now 8.3.0-6 amd64 [installed,local]
libltdl-dev/now 2.4.6-9 amd64 [installed,local]
libltdl7/now 2.4.6-9 amd64 [installed,local]
liblz4-1/now 1.8.3-1+deb10u1 amd64 [installed,local]
liblzma-dev/now 5.2.4-1+deb10u1 amd64 [installed,local]
liblzma5/now 5.2.4-1+deb10u1 amd64 [installed,local]
liblzo2-2/now 2.10-0.1 amd64 [installed,local]
libmagic-mgc/now 1:5.35-4+deb10u2 amd64 [installed,local]
libmagic1/now 1:5.35-4+deb10u2 amd64 [installed,local]
libmagickcore-6-arch-config/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-6-headers/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmagickcore-6.q16-6-extra/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-6.q16-6/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-6.q16-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickcore-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmagickwand-6-headers/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmagickwand-6.q16-6/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickwand-6.q16-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 amd64 [installed,local]
libmagickwand-dev/now 8:6.9.10.23+dfsg-2.1+deb10u1 all [installed,local]
libmariadb-dev-compat/now 1:10.3.34-0+deb10u1 amd64 [installed,local]
libmariadb-dev/now 1:10.3.34-0+deb10u1 amd64 [installed,local]
libmariadb3/now 1:10.3.34-0+deb10u1 amd64 [installed,local]
libmaxminddb-dev/now 1.3.2-1+deb10u1 amd64 [installed,local]
libmaxminddb0/now 1.3.2-1+deb10u1 amd64 [installed,local]
libmnl0/now 1.0.4-2 amd64 [installed,local]
libmount-dev/now 2.33.1-0.1 amd64 [installed,local]
libmount1/now 2.33.1-0.1 amd64 [installed,local]
libmpc3/now 1.1.0-1 amd64 [installed,local]
libmpdec2/now 2.4.2-2 amd64 [installed,local]
libmpfr6/now 4.0.2-1 amd64 [installed,local]
libmpx2/now 8.3.0-6 amd64 [installed,local]
libncurses-dev/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncurses5-dev/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncurses6/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncursesw5-dev/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libncursesw6/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libnettle6/now 3.4.1-1+deb10u1 amd64 [installed,local]
libnghttp2-14/now 1.36.0-2+deb10u1 amd64 [installed,local]
libnpth0/now 1.6-1 amd64 [installed,local]
libnuma1/now 2.0.12-1 amd64 [installed,local]
libopenexr-dev/now 2.2.1-4.1+deb10u1 amd64 [installed,local]
libopenexr23/now 2.2.1-4.1+deb10u1 amd64 [installed,local]
libopenjp2-7-dev/now 2.3.0-2+deb10u2 amd64 [installed,local]
libopenjp2-7/now 2.3.0-2+deb10u2 amd64 [installed,local]
libp11-kit-dev/now 0.23.15-2+deb10u1 amd64 [installed,local]
libp11-kit0/now 0.23.15-2+deb10u1 amd64 [installed,local]
libpam-modules-bin/now 1.3.1-5 amd64 [installed,local]
libpam-modules/now 1.3.1-5 amd64 [installed,local]
libpam-runtime/now 1.3.1-5 all [installed,local]
libpam0g/now 1.3.1-5 amd64 [installed,local]
libpango-1.0-0/now 1.42.4-8~deb10u1 amd64 [installed,local]
libpangocairo-1.0-0/now 1.42.4-8~deb10u1 amd64 [installed,local]
libpangoft2-1.0-0/now 1.42.4-8~deb10u1 amd64 [installed,local]
libpcre16-3/now 2:8.39-12 amd64 [installed,local]
libpcre2-8-0/now 10.32-5 amd64 [installed,local]
libpcre3-dev/now 2:8.39-12 amd64 [installed,local]
libpcre32-3/now 2:8.39-12 amd64 [installed,local]
libpcre3/now 2:8.39-12 amd64 [installed,local]
libpcrecpp0v5/now 2:8.39-12 amd64 [installed,local]
libperl5.28/now 5.28.1-6+deb10u1 amd64 [installed,local]
libpixman-1-0/now 0.36.0-1 amd64 [installed,local]
libpixman-1-dev/now 0.36.0-1 amd64 [installed,local]
libpng-dev/now 1.6.36-6 amd64 [installed,local]
libpng16-16/now 1.6.36-6 amd64 [installed,local]
libpq-dev/now 11.16-0+deb10u1 amd64 [installed,local]
libpq5/now 11.16-0+deb10u1 amd64 [installed,local]
libprocps7/now 2:3.3.15-2 amd64 [installed,local]
libpsl5/now 0.20.2-2 amd64 [installed,local]
libpthread-stubs0-dev/now 0.4-1 amd64 [installed,local]
libpython-stdlib/now 2.7.16-1 amd64 [installed,local]
libpython2-stdlib/now 2.7.16-1 amd64 [installed,local]
libpython2.7-minimal/now 2.7.16-2+deb10u1 amd64 [installed,local]
libpython2.7-stdlib/now 2.7.16-2+deb10u1 amd64 [installed,local]
libpython3-stdlib/now 3.7.3-1 amd64 [installed,local]
libpython3.7-minimal/now 3.7.3-2+deb10u3 amd64 [installed,local]
libpython3.7-stdlib/now 3.7.3-2+deb10u3 amd64 [installed,local]
libquadmath0/now 8.3.0-6 amd64 [installed,local]
libreadline-dev/now 7.0-5 amd64 [installed,local]
libreadline7/now 7.0-5 amd64 [installed,local]
librsvg2-2/now 2.44.10-2.1 amd64 [installed,local]
librsvg2-common/now 2.44.10-2.1 amd64 [installed,local]
librsvg2-dev/now 2.44.10-2.1 amd64 [installed,local]
librtmp1/now 2.4+20151223.gitfa8646d.1-2 amd64 [installed,local]
libsasl2-2/now 2.1.27+dfsg-1+deb10u2 amd64 [installed,local]
libsasl2-modules-db/now 2.1.27+dfsg-1+deb10u2 amd64 [installed,local]
libseccomp2/now 2.3.3-4 amd64 [installed,local]
libselinux1-dev/now 2.8-1+b1 amd64 [installed,local]
libselinux1/now 2.8-1+b1 amd64 [installed,local]
libsemanage-common/now 2.8-2 all [installed,local]
libsemanage1/now 2.8-2 amd64 [installed,local]
libsepol1-dev/now 2.8-1 amd64 [installed,local]
libsepol1/now 2.8-1 amd64 [installed,local]
libserf-1-1/now 1.3.9-7+b10 amd64 [installed,local]
libsigsegv2/now 2.12-2 amd64 [installed,local]
libsm-dev/now 2:1.2.3-1 amd64 [installed,local]
libsm6/now 2:1.2.3-1 amd64 [installed,local]
libsmartcols1/now 2.33.1-0.1 amd64 [installed,local]
libsqlite3-0/now 3.27.2-3+deb10u1 amd64 [installed,local]
libsqlite3-dev/now 3.27.2-3+deb10u1 amd64 [installed,local]
libss2/now 1.44.5-1+deb10u3 amd64 [installed,local]
libssh2-1/now 1.8.0-2.1 amd64 [installed,local]
libssl-dev/now 1.1.1n-0+deb10u2 amd64 [installed,local]
libssl1.1/now 1.1.1n-0+deb10u2 amd64 [installed,local]
libstdc++-8-dev/now 8.3.0-6 amd64 [installed,local]
libstdc++6/now 8.3.0-6 amd64 [installed,local]
libsvn1/now 1.10.4-1+deb10u3 amd64 [installed,local]
libsystemd0/now 241-7~deb10u8 amd64 [installed,local]
libtasn1-6-dev/now 4.13-3 amd64 [installed,local]
libtasn1-6/now 4.13-3 amd64 [installed,local]
libtcl8.6/now 8.6.9+dfsg-2 amd64 [installed,local]
libthai-data/now 0.1.28-2 all [installed,local]
libthai0/now 0.1.28-2 amd64 [installed,local]
libtiff-dev/now 4.1.0+git191117-2~deb10u4 amd64 [installed,local]
libtiff5/now 4.1.0+git191117-2~deb10u4 amd64 [installed,local]
libtiffxx5/now 4.1.0+git191117-2~deb10u4 amd64 [installed,local]
libtinfo6/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
libtk8.6/now 8.6.9-2 amd64 [installed,local]
libtool/now 2.4.6-9 all [installed,local]
libtsan0/now 8.3.0-6 amd64 [installed,local]
libubsan1/now 8.3.0-6 amd64 [installed,local]
libudev1/now 241-7~deb10u8 amd64 [installed,local]
libunbound8/now 1.9.0-2+deb10u2 amd64 [installed,local]
libunistring2/now 0.9.10-1 amd64 [installed,local]
libutf8proc2/now 2.3.0-1 amd64 [installed,local]
libuuid1/now 2.33.1-0.1 amd64 [installed,local]
libwebp-dev/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwebp6/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwebpdemux2/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwebpmux3/now 0.6.1-2+deb10u1 amd64 [installed,local]
libwmf-dev/now 0.2.8.4-14 amd64 [installed,local]
libwmf0.2-7/now 0.2.8.4-14 amd64 [installed,local]
libx11-6/now 2:1.6.7-1+deb10u2 amd64 [installed,local]
libx11-data/now 2:1.6.7-1+deb10u2 all [installed,local]
libx11-dev/now 2:1.6.7-1+deb10u2 amd64 [installed,local]
libx265-165/now 2.9-4 amd64 [installed,local]
libxau-dev/now 1:1.0.8-1+b2 amd64 [installed,local]
libxau6/now 1:1.0.8-1+b2 amd64 [installed,local]
libxcb-render0-dev/now 1.13.1-2 amd64 [installed,local]
libxcb-render0/now 1.13.1-2 amd64 [installed,local]
libxcb-shm0-dev/now 1.13.1-2 amd64 [installed,local]
libxcb-shm0/now 1.13.1-2 amd64 [installed,local]
libxcb1-dev/now 1.13.1-2 amd64 [installed,local]
libxcb1/now 1.13.1-2 amd64 [installed,local]
libxdmcp-dev/now 1:1.1.2-3 amd64 [installed,local]
libxdmcp6/now 1:1.1.2-3 amd64 [installed,local]
libxext-dev/now 2:1.3.3-1+b2 amd64 [installed,local]
libxext6/now 2:1.3.3-1+b2 amd64 [installed,local]
libxft-dev/now 2.3.2-2 amd64 [installed,local]
libxft2/now 2.3.2-2 amd64 [installed,local]
libxml2-dev/now 2.9.4+dfsg1-7+deb10u4 amd64 [installed,local]
libxml2/now 2.9.4+dfsg1-7+deb10u4 amd64 [installed,local]
libxrender-dev/now 1:0.9.10-1 amd64 [installed,local]
libxrender1/now 1:0.9.10-1 amd64 [installed,local]
libxslt1-dev/now 1.1.32-2.2~deb10u1 amd64 [installed,local]
libxslt1.1/now 1.1.32-2.2~deb10u1 amd64 [installed,local]
libxss-dev/now 1:1.2.3-1 amd64 [installed,local]
libxss1/now 1:1.2.3-1 amd64 [installed,local]
libxt-dev/now 1:1.1.5-1+b3 amd64 [installed,local]
libxt6/now 1:1.1.5-1+b3 amd64 [installed,local]
libxtables12/now 1.8.2-4 amd64 [installed,local]
libyaml-0-2/now 0.2.1-1 amd64 [installed,local]
libyaml-dev/now 0.2.1-1 amd64 [installed,local]
libzstd1/now 1.3.8+dfsg-3+deb10u2 amd64 [installed,local]
linux-libc-dev/now 4.19.235-1 amd64 [installed,local]
login/now 1:4.5-1.1 amd64 [installed,local]
lsb-base/now 10.2019051400 all [installed,local]
m4/now 1.4.18-2 amd64 [installed,local]
make/now 4.2.1-1.2 amd64 [installed,local]
mariadb-common/now 1:10.3.34-0+deb10u1 all [installed,local]
mawk/now 1.3.3-17+b3 amd64 [installed,local]
mercurial-common/now 4.8.2-1+deb10u1 all [installed,local]
mercurial/now 4.8.2-1+deb10u1 amd64 [installed,local]
mime-support/now 3.62 all [installed,local]
mount/now 2.33.1-0.1 amd64 [installed,local]
mysql-common/now 5.8+1.0.5 all [installed,local]
ncurses-base/now 6.1+20181013-2+deb10u2 all [installed,local]
ncurses-bin/now 6.1+20181013-2+deb10u2 amd64 [installed,local]
netbase/now 5.6 all [installed,local]
nettle-dev/now 3.4.1-1+deb10u1 amd64 [installed,local]
openssh-client/now 1:7.9p1-10+deb10u2 amd64 [installed,local]
openssl/now 1.1.1n-0+deb10u2 amd64 [installed,local]
passwd/now 1:4.5-1.1 amd64 [installed,local]
patch/now 2.7.6-3+deb10u1 amd64 [installed,local]
perl-base/now 5.28.1-6+deb10u1 amd64 [installed,local]
perl-modules-5.28/now 5.28.1-6+deb10u1 all [installed,local]
perl/now 5.28.1-6+deb10u1 amd64 [installed,local]
pinentry-curses/now 1.1.0-2 amd64 [installed,local]
pkg-config/now 0.29-6 amd64 [installed,local]
procps/now 2:3.3.15-2 amd64 [installed,local]
python-minimal/now 2.7.16-1 amd64 [installed,local]
python2-minimal/now 2.7.16-1 amd64 [installed,local]
python2.7-minimal/now 2.7.16-2+deb10u1 amd64 [installed,local]
python2.7/now 2.7.16-2+deb10u1 amd64 [installed,local]
python2/now 2.7.16-1 amd64 [installed,local]
python3-distutils/now 3.7.3-1 all [installed,local]
python3-lib2to3/now 3.7.3-1 all [installed,local]
python3-minimal/now 3.7.3-1 amd64 [installed,local]
python3.7-minimal/now 3.7.3-2+deb10u3 amd64 [installed,local]
python3.7/now 3.7.3-2+deb10u3 amd64 [installed,local]
python3/now 3.7.3-1 amd64 [installed,local]
python/now 2.7.16-1 amd64 [installed,local]
readline-common/now 7.0-5 all [installed,local]
sed/now 4.7-1 amd64 [installed,local]
sensible-utils/now 0.0.12 all [installed,local]
shared-mime-info/now 1.10-1 amd64 [installed,local]
subversion/now 1.10.4-1+deb10u3 amd64 [installed,local]
sysvinit-utils/now 2.93-8 amd64 [installed,local]
tar/now 1.30+dfsg-6 amd64 [installed,local]
tcl-dev/now 8.6.9+1 amd64 [installed,local]
tcl8.6-dev/now 8.6.9+dfsg-2 amd64 [installed,local]
tcl8.6/now 8.6.9+dfsg-2 amd64 [installed,local]
tcl/now 8.6.9+1 amd64 [installed,local]
tk-dev/now 8.6.9+1 amd64 [installed,local]
tk8.6-dev/now 8.6.9-2 amd64 [installed,local]
tk8.6/now 8.6.9-2 amd64 [installed,local]
tk/now 8.6.9+1 amd64 [installed,local]
tzdata/now 2021a-0+deb10u5 all [installed,local]
ucf/now 3.0038+nmu1 all [installed,local]
unzip/now 6.0-23+deb10u2 amd64 [installed,local]
util-linux/now 2.33.1-0.1 amd64 [installed,local]
uuid-dev/now 2.33.1-0.1 amd64 [installed,local]
wget/now 1.20.1-1.1 amd64 [installed,local]
x11-common/now 1:7.7+19 all [installed,local]
x11proto-core-dev/now 2018.4-4 all [installed,local]
x11proto-dev/now 2018.4-4 all [installed,local]
x11proto-scrnsaver-dev/now 2018.4-4 all [installed,local]
x11proto-xext-dev/now 2018.4-4 all [installed,local]
xorg-sgml-doctools/now 1:1.11-1 all [installed,local]
xtrans-dev/now 1.3.5-1 all [installed,local]
xz-utils/now 5.2.4-1+deb10u1 amd64 [installed,local]
zlib1g-dev/now 1:1.2.11.dfsg-1+deb10u1 amd64 [installed,local]
zlib1g/now 1:1.2.11.dfsg-1+deb10u1 amd64 [installed,local]
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c frontend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt list
Listing... Done
adduser/now 3.118 all [installed,local]
apt/now 2.2.4 amd64 [installed,local]
base-files/now 11.1+deb11u3 amd64 [installed,local]
base-passwd/now 3.5.51 amd64 [installed,local]
bash/now 5.1-2+b3 amd64 [installed,local]
bsdutils/now 1:2.36.1-8+deb11u1 amd64 [installed,local]
ca-certificates/now 20210119 all [installed,local]
coreutils/now 8.32-4+b1 amd64 [installed,local]
curl/now 7.74.0-1.3+deb11u1 amd64 [installed,local]
dash/now 0.5.11+git20200708+dd9ef66-5 amd64 [installed,local]
debconf/now 1.5.77 all [installed,local]
debian-archive-keyring/now 2021.1.1 all [installed,local]
debianutils/now 4.11.2 amd64 [installed,local]
diffutils/now 1:3.7-5 amd64 [installed,local]
dpkg/now 1.20.10 amd64 [installed,local]
e2fsprogs/now 1.46.2-2 amd64 [installed,local]
findutils/now 4.8.0-1 amd64 [installed,local]
fontconfig-config/now 2.13.1-4.2 all [installed,local]
fonts-dejavu-core/now 2.37-2 all [installed,local]
gcc-10-base/now 10.2.1-6 amd64 [installed,local]
gcc-9-base/now 9.3.0-22 amd64 [installed,local]
gettext-base/now 0.21-4 amd64 [installed,local]
gpgv/now 2.2.27-2+deb11u1 amd64 [installed,local]
grep/now 3.6-1 amd64 [installed,local]
gzip/now 1.10-4+deb11u1 amd64 [installed,local]
hostname/now 3.23 amd64 [installed,local]
init-system-helpers/now 1.60 all [installed,local]
libacl1/now 2.2.53-10 amd64 [installed,local]
libapt-pkg6.0/now 2.2.4 amd64 [installed,local]
libattr1/now 1:2.4.48-6 amd64 [installed,local]
libaudit-common/now 1:3.0-2 all [installed,local]
libaudit1/now 1:3.0-2 amd64 [installed,local]
libblkid1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libbrotli1/now 1.0.9-2+b2 amd64 [installed,local]
libbsd0/now 0.11.3-1 amd64 [installed,local]
libbz2-1.0/now 1.0.8-4 amd64 [installed,local]
libc-bin/now 2.31-13+deb11u3 amd64 [installed,local]
libc6/now 2.31-13+deb11u3 amd64 [installed,local]
libcap-ng0/now 0.7.9-2.2+b1 amd64 [installed,local]
libcom-err2/now 1.46.2-2 amd64 [installed,local]
libcrypt1/now 1:4.4.18-4 amd64 [installed,local]
libcurl4/now 7.74.0-1.3+deb11u1 amd64 [installed,local]
libdb5.3/now 5.3.28+dfsg1-0.8 amd64 [installed,local]
libdebconfclient0/now 0.260 amd64 [installed,local]
libdeflate0/now 1.7-1 amd64 [installed,local]
libexpat1/now 2.2.10-2+deb11u3 amd64 [installed,local]
libext2fs2/now 1.46.2-2 amd64 [installed,local]
libffi7/now 3.3-6 amd64 [installed,local]
libfontconfig1/now 2.13.1-4.2 amd64 [installed,local]
libfreetype6/now 2.10.4+dfsg-1 amd64 [installed,local]
libgcc-s1/now 10.2.1-6 amd64 [installed,local]
libgcrypt20/now 1.8.7-6 amd64 [installed,local]
libgd3/now 2.3.0-2 amd64 [installed,local]
libgeoip1/now 1.6.12-7 amd64 [installed,local]
libgmp10/now 2:6.2.1+dfsg-1+deb11u1 amd64 [installed,local]
libgnutls30/now 3.7.1-5 amd64 [installed,local]
libgpg-error0/now 1.38-2 amd64 [installed,local]
libgssapi-krb5-2/now 1.18.3-6+deb11u1 amd64 [installed,local]
libhogweed6/now 3.7.3-1 amd64 [installed,local]
libicu67/now 67.1-7 amd64 [installed,local]
libidn2-0/now 2.3.0-5 amd64 [installed,local]
libjbig0/now 2.1-3.1+b2 amd64 [installed,local]
libjpeg62-turbo/now 1:2.0.6-4 amd64 [installed,local]
libk5crypto3/now 1.18.3-6+deb11u1 amd64 [installed,local]
libkeyutils1/now 1.6.1-2 amd64 [installed,local]
libkrb5-3/now 1.18.3-6+deb11u1 amd64 [installed,local]
libkrb5support0/now 1.18.3-6+deb11u1 amd64 [installed,local]
libldap-2.4-2/now 2.4.57+dfsg-3+deb11u1 amd64 [installed,local]
liblz4-1/now 1.9.3-2 amd64 [installed,local]
liblzma5/now 5.2.5-2.1~deb11u1 amd64 [installed,local]
libmd0/now 1.0.3-3 amd64 [installed,local]
libmount1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libnettle8/now 3.7.3-1 amd64 [installed,local]
libnghttp2-14/now 1.43.0-1 amd64 [installed,local]
libnsl2/now 1.3.0-2 amd64 [installed,local]
libp11-kit0/now 0.23.22-1 amd64 [installed,local]
libpam-modules-bin/now 1.4.0-9+deb11u1 amd64 [installed,local]
libpam-modules/now 1.4.0-9+deb11u1 amd64 [installed,local]
libpam-runtime/now 1.4.0-9+deb11u1 all [installed,local]
libpam0g/now 1.4.0-9+deb11u1 amd64 [installed,local]
libpcre2-8-0/now 10.36-2 amd64 [installed,local]
libpcre3/now 2:8.39-13 amd64 [installed,local]
libpng16-16/now 1.6.37-3 amd64 [installed,local]
libpsl5/now 0.21.0-1.2 amd64 [installed,local]
libreadline8/now 8.1-1 amd64 [installed,local]
librtmp1/now 2.4+20151223.gitfa8646d.1-2+b2 amd64 [installed,local]
libsasl2-2/now 2.1.27+dfsg-2.1+deb11u1 amd64 [installed,local]
libsasl2-modules-db/now 2.1.27+dfsg-2.1+deb11u1 amd64 [installed,local]
libseccomp2/now 2.5.1-1+deb11u1 amd64 [installed,local]
libselinux1/now 3.1-3 amd64 [installed,local]
libsemanage-common/now 3.1-1 all [installed,local]
libsemanage1/now 3.1-1+b2 amd64 [installed,local]
libsepol1/now 3.1-1 amd64 [installed,local]
libsmartcols1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libss2/now 1.46.2-2 amd64 [installed,local]
libssh2-1/now 1.9.0-2 amd64 [installed,local]
libssl1.1/now 1.1.1n-0+deb11u2 amd64 [installed,local]
libstdc++6/now 10.2.1-6 amd64 [installed,local]
libsystemd0/now 247.3-7 amd64 [installed,local]
libtasn1-6/now 4.16.0-2 amd64 [installed,local]
libtiff5/now 4.2.0-1+deb11u1 amd64 [installed,local]
libtinfo6/now 6.2+20201114-2 amd64 [installed,local]
libtirpc-common/now 1.3.1-1 all [installed,local]
libtirpc3/now 1.3.1-1 amd64 [installed,local]
libudev1/now 247.3-7 amd64 [installed,local]
libunistring2/now 0.9.10-4 amd64 [installed,local]
libuuid1/now 2.36.1-8+deb11u1 amd64 [installed,local]
libwebp6/now 0.6.1-2.1 amd64 [installed,local]
libx11-6/now 2:1.7.2-1 amd64 [installed,local]
libx11-data/now 2:1.7.2-1 all [installed,local]
libxau6/now 1:1.0.9-1 amd64 [installed,local]
libxcb1/now 1.14-3 amd64 [installed,local]
libxdmcp6/now 1:1.1.2-3 amd64 [installed,local]
libxml2/now 2.9.10+dfsg-6.7+deb11u2 amd64 [installed,local]
libxpm4/now 1:3.5.12-1 amd64 [installed,local]
libxslt1.1/now 1.1.34-4 amd64 [installed,local]
libxxhash0/now 0.8.0-2 amd64 [installed,local]
libzstd1/now 1.4.8+dfsg-2.1 amd64 [installed,local]
login/now 1:4.8.1-1 amd64 [installed,local]
logsave/now 1.46.2-2 amd64 [installed,local]
lsb-base/now 11.1.0 all [installed,local]
mawk/now 1.3.4.20200120-2 amd64 [installed,local]
mount/now 2.36.1-8+deb11u1 amd64 [installed,local]
ncurses-base/now 6.2+20201114-2 all [installed,local]
ncurses-bin/now 6.2+20201114-2 amd64 [installed,local]
nginx-module-geoip/now 1.23.0-1~bullseye amd64 [installed,local]
nginx-module-image-filter/now 1.23.0-1~bullseye amd64 [installed,local]
nginx-module-njs/now 1.23.0+0.7.5-1~bullseye amd64 [installed,local]
nginx-module-xslt/now 1.23.0-1~bullseye amd64 [installed,local]
nginx/now 1.23.0-1~bullseye amd64 [installed,local]
openssl/now 1.1.1n-0+deb11u2 amd64 [installed,local]
passwd/now 1:4.8.1-1 amd64 [installed,local]
perl-base/now 5.32.1-4+deb11u2 amd64 [installed,local]
readline-common/now 8.1-1 all [installed,local]
sed/now 4.7-1 amd64 [installed,local]
sensible-utils/now 0.0.14 all [installed,local]
sysvinit-utils/now 2.96-7+deb11u1 amd64 [installed,local]
tar/now 1.34+dfsg-1 amd64 [installed,local]
tzdata/now 2021a-1+deb11u4 all [installed,local]
ucf/now 3.0043 all [installed,local]
util-linux/now 2.36.1-8+deb11u1 amd64 [installed,local]
zlib1g/now 1:1.2.11.dfsg-2+deb11u1 amd64 [installed,local]
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# apt install update
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package update
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# ls -lha
total 420K
drwxr-xr-x 1 root root 4.0K Jul  4 12:30 .
drwxr-xr-x 1 root root 4.0K Jul  5 16:12 ..
-rw-r--r-- 1 root root   30 Jul  4 09:09 .env
-rw-r--r-- 1 root root   30 Jul  4 09:09 .env.example
-rw-r--r-- 1 root root  387 Jul  4 09:09 Dockerfile
drwxr-xr-x 2 root root 4.0K Jul  4 09:09 build
-rw-r--r-- 1 root root  344 Jul  4 09:09 demo.conf
-rw-r--r-- 1 root root  448 Jul  4 09:09 index.html
-rw-r--r-- 1 root root  344 Jul  4 09:09 item.html
drwxr-xr-x 2 root root 4.0K Jul  4 09:09 js
-rw-r--r-- 1 root root   80 Jul  4 09:09 list.json
-rw-r--r-- 1 root root 357K Jul  4 09:09 package-lock.json
-rw-r--r-- 1 root root 1.1K Jul  4 09:09 package.json
drwxr-xr-x 2 root root 4.0K Jul  4 09:09 static
drwxr-xr-x 3 root root 4.0K Jul  4 09:09 styles
-rw-r--r-- 1 root root 2.8K Jul  4 09:09 webpack.config.js
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod fb-pod-65b9777746-5ztxd 
Name:         fb-pod-65b9777746-5ztxd
Namespace:    default
Priority:     0
Node:         node1/10.128.0.23
Start Time:   Tue, 05 Jul 2022 20:12:55 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: 271035e70868fe385bb0d184b83dfb330b00ab2961805be7a1875c36c0ea443e
              cni.projectcalico.org/podIP: 10.233.90.8/32
              cni.projectcalico.org/podIPs: 10.233.90.8/32
Status:       Running
IP:           10.233.90.8
IPs:
  IP:           10.233.90.8
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://b09be2c662873735b4cff1273342f68cbf16c4cc977773a7f7ebcfa801c7e9bb
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 05 Jul 2022 20:12:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrdhr (ro)
  backend:
    Container ID:   containerd://e26ddfa7a7f6d3c2654c06a561672a97448b3fda9081505448e1c9d70aa223a7
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 05 Jul 2022 20:12:56 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrdhr (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-vrdhr:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ping 10.233.90.8
PING 10.233.90.8 (10.233.90.8) 56(84) bytes of data.
^C
--- 10.233.90.8 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1031ms

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP             NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          11h   10.233.96.12   node2   <none>           <none>
fb-pod-65b9777746-5ztxd   2/2     Running   0          12h   10.233.90.8    node1   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -i -t -- bash -il
db-0:/# 
db-0:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if19: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1430 qdisc noqueue state UP 
    link/ether 0e:e6:b4:ce:ff:22 brd ff:ff:ff:ff:ff:ff
    inet 10.233.96.12/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::ce6:b4ff:fece:ff22/64 scope link 
       valid_lft forever preferred_lft forever
db-0:/# 
db-0:/# curl 127.1:5432
bash: curl: command not found
db-0:/# 
db-0:/# apt install curl
bash: apt: command not found
db-0:/# 
db-0:/# cat /etc/*release
3.16.0
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.16.0
PRETTY_NAME="Alpine Linux v3.16"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
db-0:/# 
db-0:/# 
db-0:/# ap list
bash: ap: command not found
db-0:/# 
db-0:/# apt list
bash: apt: command not found
db-0:/# 
db-0:/# yum
bash: yum: command not found
db-0:/# 
db-0:/# ps -aux
ps: unrecognized option: u
BusyBox v1.35.0 (2022-05-09 17:27:12 UTC) multi-call binary.

Usage: ps [-o COL1,COL2=HEADER] [-T]

Show list of processes

	-o COL1,COL2=HEADER	Select columns for display
	-T			Show threads
db-0:/# 
db-0:/# ps
PID   USER     TIME  COMMAND
    1 postgres  0:00 postgres
   50 postgres  0:00 postgres: checkpointer 
   51 postgres  0:00 postgres: background writer 
   52 postgres  0:00 postgres: walwriter 
   53 postgres  0:00 postgres: autovacuum launcher 
   54 postgres  0:00 postgres: stats collector 
   55 postgres  0:00 postgres: logical replication launcher 
  766 root      0:00 bash -il
  789 root      0:00 ps
db-0:/# 
db-0:/# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-5ztxd -c backend -i -t -- bash -il
root@fb-pod-65b9777746-5ztxd:/app# 
root@fb-pod-65b9777746-5ztxd:/app# cd
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 10.233.96.12:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-5ztxd:~# curl 10.233.96.12:30159
curl: (7) Failed to connect to 10.233.96.12 port 30159: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping 10.233.0.124
PING 10.233.0.124 (10.233.0.124) 56(84) bytes of data.
64 bytes from 10.233.0.124: icmp_seq=1 ttl=64 time=0.074 ms
64 bytes from 10.233.0.124: icmp_seq=2 ttl=64 time=0.067 ms
^C
--- 10.233.0.124 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 22ms
rtt min/avg/max/mdev = 0.067/0.070/0.074/0.009 ms
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 10.233.0.124:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ^C
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping backend
ping: backend: Name or service not known
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# hostname
fb-pod-65b9777746-5ztxd
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping fb-pod
ping: fb-pod: Name or service not known
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# ping fb-pod-65b9777746-5ztxd
PING fb-pod-65b9777746-5ztxd (10.233.90.8) 56(84) bytes of data.
64 bytes from fb-pod-65b9777746-5ztxd (10.233.90.8): icmp_seq=1 ttl=64 time=0.020 ms
64 bytes from fb-pod-65b9777746-5ztxd (10.233.90.8): icmp_seq=2 ttl=64 time=0.043 ms
64 bytes from fb-pod-65b9777746-5ztxd (10.233.90.8): icmp_seq=3 ttl=64 time=0.037 ms
^C
--- fb-pod-65b9777746-5ztxd ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 49ms
rtt min/avg/max/mdev = 0.020/0.033/0.043/0.010 ms
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:9000
curl: (7) Failed to connect to 127.1 port 9000: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:9001
curl: (7) Failed to connect to 127.1 port 9001: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:8000
curl: (7) Failed to connect to 127.1 port 8000: Connection refused
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# curl 127.1:80
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# 
root@fb-pod-65b9777746-5ztxd:~# maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ host -t A google.com
google.com has address 216.58.211.14
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   24m   v1.24.2
node1   Ready    <none>          23m   v1.24.2
node2   Ready    <none>          23m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ ls -lha
итого 16K
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 .
drwxrwxr-x 4 maestro maestro 4,0K июн 28 10:45 ..
drwxrwxr-x 2 maestro maestro 4,0K июл  5 15:24 main
drwxrwxr-x 2 maestro maestro 4,0K июл  5 20:31 postgres
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest$ cd postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 24K
drwxrwxr-x 2 maestro maestro 4,0K июл  5 20:31 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  761 июл  5 20:31 db.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  774 июл  5 19:00 web-services.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mv web-services.yaml web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 24K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:16 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  761 июл  5 20:31 db.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  774 июл  5 19:00 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat web-app.yaml 
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: fb-app
  name: fb-pod
  namespace: default
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
        - image: zakharovnpa/k8s-backend:05.07.22
          imagePullPolicy: IfNotPresent
          name: backend
      terminationGracePeriodSeconds: 30

---
# Config Service
apiVersion: v1
kind: Service
metadata:
  name: fb-svc
  labels:
    app: fb
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 31000
  selector:
    app: fb


maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim web-app.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 28K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:31 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  761 июл  5 20:31 db.yaml
-rw-rw-r-- 1 maestro maestro  187 июл  6 12:20 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat db.yaml 
# Config PostgreSQL StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db-svc
  selector:
    matchLabels:
      app: db
  replicas: 1
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: zakharovnpa/k8s-database:05.07.22
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news    
                          
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: db-svc
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 32K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:35 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro  187 июл  6 12:20 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-app.yaml 
deployment.apps/fb-pod created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get po
NAME                      READY   STATUS    RESTARTS   AGE
fb-pod-65b9777746-4bnxq   2/2     Running   0          95s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   61m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe po fb-pod-65b9777746-4bnxq 
Name:         fb-pod-65b9777746-4bnxq
Namespace:    default
Priority:     0
Node:         node2/10.128.0.11
Start Time:   Wed, 06 Jul 2022 12:47:04 +0400
Labels:       app=fb-app
              pod-template-hash=65b9777746
Annotations:  cni.projectcalico.org/containerID: baf7cf62c528742c8e7b5e9ac4b054d06a4d70206304e9d5822b652097dbb954
              cni.projectcalico.org/podIP: 10.233.96.1/32
              cni.projectcalico.org/podIPs: 10.233.96.1/32
Status:       Running
IP:           10.233.96.1
IPs:
  IP:           10.233.96.1
Controlled By:  ReplicaSet/fb-pod-65b9777746
Containers:
  frontend:
    Container ID:   containerd://31553e0dc4b6d025d77dbfcfe279e486a2ee2331f9021d297e38e8f028887738
    Image:          zakharovnpa/k8s-frontend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-frontend@sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 06 Jul 2022 12:47:15 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8hbtd (ro)
  backend:
    Container ID:   containerd://1705f4cde30a711f7725a5f382af83d9f859b4776a62ac7fe8ad230fcb915b95
    Image:          zakharovnpa/k8s-backend:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-backend@sha256:68669891074cd1b4bf4f6a4492b9ef1b9b94460ad094d01f70522a345107a78f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 06 Jul 2022 12:47:42 +0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8hbtd (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-8hbtd:
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
  Normal  Scheduled  2m5s  default-scheduler  Successfully assigned default/fb-pod-65b9777746-4bnxq to node2
  Normal  Pulling    2m3s  kubelet            Pulling image "zakharovnpa/k8s-frontend:05.07.22"
  Normal  Pulled     114s  kubelet            Successfully pulled image "zakharovnpa/k8s-frontend:05.07.22" in 8.854779289s
  Normal  Created    114s  kubelet            Created container frontend
  Normal  Started    114s  kubelet            Started container frontend
  Normal  Pulling    114s  kubelet            Pulling image "zakharovnpa/k8s-backend:05.07.22"
  Normal  Pulled     87s   kubelet            Successfully pulled image "zakharovnpa/k8s-backend:05.07.22" in 26.723509834s
  Normal  Created    87s   kubelet            Created container backend
  Normal  Started    86s   kubelet            Started container backend
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.233.0.1   <none>        443/TCP   90m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -- curl backend
Defaulted container "frontend" out of: frontend, backend
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (6) Could not resolve host: backend
command terminated with exit code 6
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -- ip a
Defaulted container "frontend" out of: frontend, backend
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "93e84ed28571c2224cb417daea9abd3bbb8ce7965aa234a30caba96ea81838e4": OCI runtime exec failed: exec failed: unable to start container process: exec: "ip": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1430 qdisc noqueue state UP group default 
    link/ether 6e:f0:dc:0e:a4:85 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.233.96.1/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::6cf0:dcff:fe0e:a485/64 scope link 
       valid_lft forever preferred_lft forever
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c frontend -- ip a
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "69b8014037cd412577c88edda962552eb491547732f8590f148ba081b95b289a": OCI runtime exec failed: exec failed: unable to start container process: exec: "ip": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c frontend -- cat /etc/*release
cat: /etc/lsb-release: No such file or directory
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
command terminated with exit code 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- cat /etc/*release
cat: /etc/lsb-release: No such file or directory
PRETTY_NAME="Debian GNU/Linux 10 (buster)"
NAME="Debian GNU/Linux"
VERSION_ID="10"
VERSION="10 (buster)"
VERSION_CODENAME=buster
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
command terminated with exit code 1
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
100   448  100   448    0     0  16000      0 --:--:-- --:--:-- --:--:-- 16000
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1:9000
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (7) Failed to connect to 127.1 port 9000: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1:8000
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (7) Failed to connect to 127.1 port 8000: Connection refused
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- curl 127.1
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   448  100   448    0     0   109k      0 --:--:-- --:--:-- --:--:--  109k
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Список</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="/build/main.css" rel="stylesheet">
</head>
<body>
    <main class="b-page">
        <h1 class="b-page__title">Список</h1>
        <div class="b-page__content b-items js-list"></div>
    </main>
    <script src="/build/main.js"></script>
</body>
</html>maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -- ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=60 time=109 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=60 time=21.2 ms
^C
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c frontend -- ping 8.8.8.8
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "3586c8e7f729156009c70994dde4669353e99756cdfa34f2ba255f66729907b3": OCI runtime exec failed: exec failed: unable to start container process: exec: "ping": executable file not found in $PATH: unknown
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c frontend
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2022/07/06 08:47:15 [notice] 1#1: using the "epoll" event method
2022/07/06 08:47:15 [notice] 1#1: nginx/1.23.0
2022/07/06 08:47:15 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2022/07/06 08:47:15 [notice] 1#1: OS: Linux 5.4.0-121-generic
2022/07/06 08:47:15 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2022/07/06 08:47:15 [notice] 1#1: start worker processes
2022/07/06 08:47:15 [notice] 1#1: start worker process 30
2022/07/06 08:47:15 [notice] 1#1: start worker process 31
127.0.0.1 - - [06/Jul/2022:09:23:35 +0000] "GET / HTTP/1.1" 200 448 "-" "curl/7.64.0" "-"
127.0.0.1 - - [06/Jul/2022:09:24:04 +0000] "GET / HTTP/1.1" 200 448 "-" "curl/7.64.0" "-"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get po - o wide
Error from server (NotFound): pods "-" not found
Error from server (NotFound): pods "o" not found
Error from server (NotFound): pods "wide" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod - o wide
Error from server (NotFound): pods "-" not found
Error from server (NotFound): pods "o" not found
Error from server (NotFound): pods "wide" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
fb-pod-65b9777746-4bnxq   2/2     Running   0          88m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 32K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 12:37 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro  195 июл  6 12:37 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim db.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db.yaml 
statefulset.apps/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS              RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      0/1     ContainerCreating   0          7s    <none>        node1   <none>           <none>
fb-pod-65b9777746-4bnxq   2/2     Running             0          97m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          11s   10.233.90.2   node1   <none>           <none>
fb-pod-65b9777746-4bnxq   2/2     Running   0          97m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db-svc.yaml 
service/db-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod -o wide
NAME                      READY   STATUS    RESTARTS   AGE   IP            NODE    NOMINATED NODE   READINESS GATES
db-0                      1/1     Running   0          43s   10.233.90.2   node1   <none>           <none>
fb-pod-65b9777746-4bnxq   2/2     Running   0          97m   10.233.96.1   node2   <none>           <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE    SELECTOR
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   14s    app=db
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          158m   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs -c backend
error: expected 'logs [-f] [-p] (POD | TYPE/NAME) [-c CONTAINER]'.
POD or TYPE/NAME is a required argument for the logs command
See 'kubectl logs -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs -c backend
error: expected 'logs [-f] [-p] (POD | TYPE/NAME) [-c CONTAINER]'.
POD or TYPE/NAME is a required argument for the logs command
See 'kubectl logs -h' for help and examples
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   3m37s   app=db
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          161m    <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl 10.233.30.200:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl 10.233.30.200:31655
curl: (7) Failed to connect to 10.233.30.200 port 31655: Connection refused
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
command terminated with exit code 7
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          5m48s
fb-pod-65b9777746-4bnxq   2/2     Running   0          102m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe db-0
error: the server doesn't have a resource type "db-0"
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe po db-0
Name:         db-0
Namespace:    default
Priority:     0
Node:         node1/10.128.0.12
Start Time:   Wed, 06 Jul 2022 14:24:14 +0400
Labels:       app=db
              controller-revision-hash=db-58b74bf99f
              statefulset.kubernetes.io/pod-name=db-0
Annotations:  cni.projectcalico.org/containerID: 1dba360f4c89f0e98c6b849fff1df33295abd2d4b551aef4fe7d1439db7ab706
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://3c845496b80d15e55eddb95c3d872f130e627af0301cd3254e97a3813a47540c
    Image:          zakharovnpa/k8s-database:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-database@sha256:f58e501e198aed05774e84dc82048c61b48039afa69e73bc614ee66628a916b5
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 06 Jul 2022 14:24:24 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4666k (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4666k:
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
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  6m4s   default-scheduler  Successfully assigned default/db-0 to node1
  Normal  Pulling    6m3s   kubelet            Pulling image "zakharovnpa/k8s-database:05.07.22"
  Normal  Pulled     5m55s  kubelet            Successfully pulled image "zakharovnpa/k8s-database:05.07.22" in 7.96756096s
  Normal  Created    5m55s  kubelet            Created container db
  Normal  Started    5m55s  kubelet            Started container db
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe statefulsets.apps db 
Name:               db
Namespace:          default
CreationTimestamp:  Wed, 06 Jul 2022 14:24:14 +0400
Selector:           app=db
Labels:             <none>
Annotations:        <none>
Replicas:           1 desired | 1 total
Update Strategy:    RollingUpdate
  Partition:        0
Pods Status:        1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=db
  Containers:
   db:
    Image:      zakharovnpa/k8s-database:05.07.22
    Port:       <none>
    Host Port:  <none>
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:               <none>
  Volumes:                <none>
Volume Claims:            <none>
Events:
  Type    Reason            Age    From                    Message
  ----    ------            ----   ----                    -------
  Normal  SuccessfulCreate  7m29s  statefulset-controller  create Pod db-0 in StatefulSet db successful
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs po db-0
Error from server (NotFound): pods "po" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs pod db
Error from server (NotFound): pods "pod" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs db
Error from server (NotFound): pods "db" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs db-0
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-07-06 10:24:24.936 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-07-06 10:24:26.717 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-06 10:24:26.721 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-06 10:24:26.736 UTC [37] LOG:  database system was shut down at 2022-07-06 10:24:26 UTC
2022-07-06 10:24:26.743 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down....2022-07-06 10:24:27.157 UTC [36] LOG:  received fast shutdown request
2022-07-06 10:24:27.161 UTC [36] LOG:  aborting any active transactions
2022-07-06 10:24:27.163 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-07-06 10:24:27.163 UTC [38] LOG:  shutting down
2022-07-06 10:24:27.188 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-07-06 10:24:27.283 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-06 10:24:27.283 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-07-06 10:24:27.283 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-07-06 10:24:27.290 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-06 10:24:27.297 UTC [50] LOG:  database system was shut down at 2022-07-06 10:24:27 UTC
2022-07-06 10:24:27.303 UTC [1] LOG:  database system is ready to accept connections
2022-07-06 10:29:10.964 UTC [61] LOG:  invalid length of startup packet
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ psql -h 10.233.30.200 -U
Error: You must install at least one postgresql-client-<version> package
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# psql -h 10.233.30.200 -U
bash: psql: command not found
root@fb-pod-65b9777746-4bnxq:~# psql
bash: psql: command not found
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# apt install psql
Reading package lists... Done
Building dependency tree       
Reading state information... Done
E: Unable to locate package psql
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# type psql
bash: type: psql: not found
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# whereis psql
psql:
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# psql -h 10.233.30.200 -U
psql: option requires an argument: U
Try "psql --help" for more information.
db-0:/# psql -h 10.233.30.200
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# 
db-0:/# psql -h 10.233.30.200
Password for user root: 
psql: error: fe_sendauth: no password supplied
db-0:/# 
db-0:/# psql -h 10.233.30.200
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# 
db-0:/# sudo -i
bash: sudo: command not found
db-0:/# 
db-0:/# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
3: eth0@if9: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1430 qdisc noqueue state UP 
    link/ether 9a:1e:f7:9b:94:cd brd ff:ff:ff:ff:ff:ff
    inet 10.233.90.2/32 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::981e:f7ff:fe9b:94cd/64 scope link 
       valid_lft forever preferred_lft forever
db-0:/# 
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: fe_sendauth: no password supplied
db-0:/# 
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: FATAL:  password authentication failed for user "root"
db-0:/# 
db-0:/# psql -h 10.233.90.2
Password for user root: 
psql: error: fe_sendauth: no password supplied
db-0:/# 
db-0:/# psql 10.233.90.2
psql: error: FATAL:  role "root" does not exist
db-0:/# 
db-0:/# psql
psql: error: FATAL:  role "root" does not exist
db-0:/# 
db-0:/# psql --verson
psql: unrecognized option: verson
Try "psql --help" for more information.
db-0:/# type psql
psql is hashed (/usr/local/bin/psql)
db-0:/# 
db-0:/# whereis psql
bash: whereis: command not found
db-0:/# 
db-0:/# 
db-0:/# curl 127.1:5432
bash: curl: command not found
db-0:/# 
db-0:/# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=60 time=18.498 ms
64 bytes from 8.8.8.8: seq=1 ttl=60 time=18.170 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 18.170/18.334/18.498 ms
db-0:/# 
db-0:/# apt 
bash: apt: command not found
db-0:/# 
db-0:/# yum
bash: yum: command not found
db-0:/# 
db-0:/# cat /etc/*release
3.16.0
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.16.0
PRETTY_NAME="Alpine Linux v3.16"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
db-0:/# 
db-0:/# 
db-0:/# 
db-0:/# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME         ENDPOINTS          AGE
db-svc       10.233.90.2:5432   28m
kubernetes   10.128.0.30:6443   3h6m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl het svc
error: unknown command "het" for "kubectl"

Did you mean this?
	set
	get
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   28m
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          3h6m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc db-svc 
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
db-svc   NodePort   10.233.30.200   <none>        5432:31655/TCP   28m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc db-svc -o wide
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
db-svc   NodePort   10.233.30.200   <none>        5432:31655/TCP   29m   app=db
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe svc db-svc 
Name:                     db-svc
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=db
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.233.30.200
IPs:                      10.233.30.200
Port:                     <unset>  5432/TCP
TargetPort:               5432/TCP
NodePort:                 <unset>  31655/TCP
Endpoints:                10.233.90.2:5432
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe pod db-0 
Name:         db-0
Namespace:    default
Priority:     0
Node:         node1/10.128.0.12
Start Time:   Wed, 06 Jul 2022 14:24:14 +0400
Labels:       app=db
              controller-revision-hash=db-58b74bf99f
              statefulset.kubernetes.io/pod-name=db-0
Annotations:  cni.projectcalico.org/containerID: 1dba360f4c89f0e98c6b849fff1df33295abd2d4b551aef4fe7d1439db7ab706
              cni.projectcalico.org/podIP: 10.233.90.2/32
              cni.projectcalico.org/podIPs: 10.233.90.2/32
Status:       Running
IP:           10.233.90.2
IPs:
  IP:           10.233.90.2
Controlled By:  StatefulSet/db
Containers:
  db:
    Container ID:   containerd://3c845496b80d15e55eddb95c3d872f130e627af0301cd3254e97a3813a47540c
    Image:          zakharovnpa/k8s-database:05.07.22
    Image ID:       docker.io/zakharovnpa/k8s-database@sha256:f58e501e198aed05774e84dc82048c61b48039afa69e73bc614ee66628a916b5
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 06 Jul 2022 14:24:24 +0400
    Ready:          True
    Restart Count:  0
    Environment:
      POSTGRES_PASSWORD:  postgres
      POSTGRES_USER:      postgres
      POSTGRES_DB:        news
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-4666k (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-4666k:
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
  Normal  Scheduled  30m   default-scheduler  Successfully assigned default/db-0 to node1
  Normal  Pulling    30m   kubelet            Pulling image "zakharovnpa/k8s-database:05.07.22"
  Normal  Pulled     30m   kubelet            Successfully pulled image "zakharovnpa/k8s-database:05.07.22" in 7.96756096s
  Normal  Created    30m   kubelet            Created container db
  Normal  Started    30m   kubelet            Started container db
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep db-svc
Name:         db-svc
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-06T10:24:51Z
Subsets:
  Addresses:          10.233.90.2
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc -o wide
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE     SELECTOR
db-svc       NodePort    10.233.30.200   <none>        5432:31655/TCP   36m     app=db
kubernetes   ClusterIP   10.233.0.1      <none>        443/TCP          3h14m   <none>
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep -o wide
NAME         ENDPOINTS          AGE
db-svc       10.233.90.2:5432   36m
kubernetes   10.128.0.30:6443   3h14m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim ep-db-svc.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep db-svc -o yaml
apiVersion: v1
kind: Endpoints
metadata:
  annotations:
    endpoints.kubernetes.io/last-change-trigger-time: "2022-07-06T10:24:51Z"
  creationTimestamp: "2022-07-06T10:24:51Z"
  name: db-svc
  namespace: default
  resourceVersion: "16888"
  uid: 3d72e63b-d18e-4a9e-af1d-d0c571e50b91
subsets:
- addresses:
  - hostname: db-0
    ip: 10.233.90.2
    nodeName: node1
    targetRef:
      kind: Pod
      name: db-0
      namespace: default
      uid: 3031027c-ed4c-40f9-8778-770bcce5eb12
  ports:
  - port: 5432
    protocol: TCP
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get svc db-svc -o yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"db-svc","namespace":"default"},"spec":{"ports":[{"port":5432,"targetPort":5432}],"selector":{"app":"db"},"type":"NodePort"}}
  creationTimestamp: "2022-07-06T10:24:51Z"
  name: db-svc
  namespace: default
  resourceVersion: "16887"
  uid: 708ae447-ded6-4323-ad3e-da584b7a2b1c
spec:
  clusterIP: 10.233.30.200
  clusterIPs:
  - 10.233.30.200
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - nodePort: 31655
    port: 5432
    protocol: TCP
    targetPort: 5432
  selector:
    app: db
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cat db-svc.yaml 
---
# Config PostgreSQL StatefulSet Service
apiVersion: v1
kind: Service
metadata:
  name: db-svc
spec:
  selector:
    app: db
  type: NodePort
  ports:
    - port: 5432
      targetPort: 5432
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# cd
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl
curl: try 'curl --help' or 'curl --manual' for more information
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# ping 10.233.90.2
PING 10.233.90.2 (10.233.90.2) 56(84) bytes of data.
64 bytes from 10.233.90.2: icmp_seq=1 ttl=62 time=0.640 ms
64 bytes from 10.233.90.2: icmp_seq=2 ttl=62 time=0.613 ms
64 bytes from 10.233.90.2: icmp_seq=3 ttl=62 time=0.588 ms
64 bytes from 10.233.90.2: icmp_seq=4 ttl=62 time=0.533 ms
64 bytes from 10.233.90.2: icmp_seq=5 ttl=62 time=0.621 ms
^C
--- 10.233.90.2 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 87ms
rtt min/avg/max/mdev = 0.533/0.599/0.640/0.036 ms
root@fb-pod-65b9777746-4bnxq:~# 
root@fb-pod-65b9777746-4bnxq:~# exit
logout
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# shutdown -r now
bash: shutdown: command not found
db-0:/# 
db-0:/# reload now
bash: reload: command not found
db-0:/# 
db-0:/# restart
bash: restart: command not found
db-0:/# 
db-0:/# reboot
db-0:/# command terminated with exit code 137
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# reload
bash: reload: command not found
db-0:/# 
db-0:/# reboot
db-0:/# command terminated with exit code 137
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (7) Failed to connect to 10.233.90.2 port 5432: Connection refused
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# curl 10.233.90.2:5432
curl: (52) Empty reply from server
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# 
root@fb-pod-65b9777746-4bnxq:/app# exit
logout
command terminated with exit code 52
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-4bnxq -c backend
INFO:     Uvicorn running on http://0.0.0.0:9000 (Press CTRL+C to quit)
INFO:     Started reloader process [6] using statreload
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl --help
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources.
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL.

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh or fish)

Other Commands:
  alpha           Commands for features in alpha
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl api-resources
NAME                              SHORTNAMES   APIVERSION                             NAMESPACED   KIND
bindings                                       v1                                     true         Binding
componentstatuses                 cs           v1                                     false        ComponentStatus
configmaps                        cm           v1                                     true         ConfigMap
endpoints                         ep           v1                                     true         Endpoints
events                            ev           v1                                     true         Event
limitranges                       limits       v1                                     true         LimitRange
namespaces                        ns           v1                                     false        Namespace
nodes                             no           v1                                     false        Node
persistentvolumeclaims            pvc          v1                                     true         PersistentVolumeClaim
persistentvolumes                 pv           v1                                     false        PersistentVolume
pods                              po           v1                                     true         Pod
podtemplates                                   v1                                     true         PodTemplate
replicationcontrollers            rc           v1                                     true         ReplicationController
resourcequotas                    quota        v1                                     true         ResourceQuota
secrets                                        v1                                     true         Secret
serviceaccounts                   sa           v1                                     true         ServiceAccount
services                          svc          v1                                     true         Service
mutatingwebhookconfigurations                  admissionregistration.k8s.io/v1        false        MutatingWebhookConfiguration
validatingwebhookconfigurations                admissionregistration.k8s.io/v1        false        ValidatingWebhookConfiguration
customresourcedefinitions         crd,crds     apiextensions.k8s.io/v1                false        CustomResourceDefinition
apiservices                                    apiregistration.k8s.io/v1              false        APIService
controllerrevisions                            apps/v1                                true         ControllerRevision
daemonsets                        ds           apps/v1                                true         DaemonSet
deployments                       deploy       apps/v1                                true         Deployment
replicasets                       rs           apps/v1                                true         ReplicaSet
statefulsets                      sts          apps/v1                                true         StatefulSet
tokenreviews                                   authentication.k8s.io/v1               false        TokenReview
localsubjectaccessreviews                      authorization.k8s.io/v1                true         LocalSubjectAccessReview
selfsubjectaccessreviews                       authorization.k8s.io/v1                false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io/v1                false        SelfSubjectRulesReview
subjectaccessreviews                           authorization.k8s.io/v1                false        SubjectAccessReview
horizontalpodautoscalers          hpa          autoscaling/v2                         true         HorizontalPodAutoscaler
cronjobs                          cj           batch/v1                               true         CronJob
jobs                                           batch/v1                               true         Job
certificatesigningrequests        csr          certificates.k8s.io/v1                 false        CertificateSigningRequest
leases                                         coordination.k8s.io/v1                 true         Lease
bgpconfigurations                              crd.projectcalico.org/v1               false        BGPConfiguration
bgppeers                                       crd.projectcalico.org/v1               false        BGPPeer
blockaffinities                                crd.projectcalico.org/v1               false        BlockAffinity
caliconodestatuses                             crd.projectcalico.org/v1               false        CalicoNodeStatus
clusterinformations                            crd.projectcalico.org/v1               false        ClusterInformation
felixconfigurations                            crd.projectcalico.org/v1               false        FelixConfiguration
globalnetworkpolicies                          crd.projectcalico.org/v1               false        GlobalNetworkPolicy
globalnetworksets                              crd.projectcalico.org/v1               false        GlobalNetworkSet
hostendpoints                                  crd.projectcalico.org/v1               false        HostEndpoint
ipamblocks                                     crd.projectcalico.org/v1               false        IPAMBlock
ipamconfigs                                    crd.projectcalico.org/v1               false        IPAMConfig
ipamhandles                                    crd.projectcalico.org/v1               false        IPAMHandle
ippools                                        crd.projectcalico.org/v1               false        IPPool
ipreservations                                 crd.projectcalico.org/v1               false        IPReservation
kubecontrollersconfigurations                  crd.projectcalico.org/v1               false        KubeControllersConfiguration
networkpolicies                                crd.projectcalico.org/v1               true         NetworkPolicy
networksets                                    crd.projectcalico.org/v1               true         NetworkSet
endpointslices                                 discovery.k8s.io/v1                    true         EndpointSlice
events                            ev           events.k8s.io/v1                       true         Event
flowschemas                                    flowcontrol.apiserver.k8s.io/v1beta2   false        FlowSchema
prioritylevelconfigurations                    flowcontrol.apiserver.k8s.io/v1beta2   false        PriorityLevelConfiguration
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
ingresses                         ing          networking.k8s.io/v1                   true         Ingress
networkpolicies                   netpol       networking.k8s.io/v1                   true         NetworkPolicy
runtimeclasses                                 node.k8s.io/v1                         false        RuntimeClass
poddisruptionbudgets              pdb          policy/v1                              true         PodDisruptionBudget
podsecuritypolicies               psp          policy/v1beta1                         false        PodSecurityPolicy
clusterrolebindings                            rbac.authorization.k8s.io/v1           false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io/v1           false        ClusterRole
rolebindings                                   rbac.authorization.k8s.io/v1           true         RoleBinding
roles                                          rbac.authorization.k8s.io/v1           true         Role
priorityclasses                   pc           scheduling.k8s.io/v1                   false        PriorityClass
csidrivers                                     storage.k8s.io/v1                      false        CSIDriver
csinodes                                       storage.k8s.io/v1                      false        CSINode
csistoragecapacities                           storage.k8s.io/v1                      true         CSIStorageCapacity
storageclasses                    sc           storage.k8s.io/v1                      false        StorageClass
volumeattachments                              storage.k8s.io/v1                      false        VolumeAttachment
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl api-resources | grep dns
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl api-resources | grep name
namespaces                        ns           v1                                     false        Namespace
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help
Display one or many resources.

 Prints a table of the most important information about the specified resources. You can filter the list using a label
selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current
namespace unless you pass --all-namespaces.

 By specifying the output as 'template' and providing a Go template as the value of the --template flag, you can filter
the attributes of the fetched resources.

Use "kubectl api-resources" for a complete list of supported resources.

Examples:
  # List all pods in ps output format
  kubectl get pods
  
  # List all pods in ps output format with more information (such as node name)
  kubectl get pods -o wide
  
  # List a single replication controller with specified NAME in ps output format
  kubectl get replicationcontroller web
  
  # List deployments in JSON output format, in the "v1" version of the "apps" API group
  kubectl get deployments.v1.apps -o json
  
  # List a single pod in JSON output format
  kubectl get -o json pod web-pod-13je7
  
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get -f pod.yaml -o json
  
  # List resources from a directory with kustomization.yaml - e.g. dir/kustomization.yaml
  kubectl get -k dir/
  
  # Return only the phase value of the specified pod
  kubectl get -o template pod/web-pod-13je7 --template={{.status.phase}}
  
  # List resource information in custom columns
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  
  # List all replication controllers and services together in ps output format
  kubectl get rc,services
  
  # List one or more resources by their type and names
  kubectl get rc/web service/frontend pods/web-pod-13je7
  
  # List status subresource for a single pod.
  kubectl get pod web-pod-13je7 --subresource status

Options:
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even
	if specified with --namespace.

    --allow-missing-template-keys=true:
	If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
	golang and jsonpath output formats.

    --chunk-size=500:
	Return large lists in chunks rather than all at once. Pass 0 to disable. This flag is beta and may change in
	the future.

    --field-selector='':
	Selector (field query) to filter on, supports '=', '==', and '!='.(e.g. --field-selector
	key1=value1,key2=value2). The server only supports a limited number of field queries per type.

    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.

    --ignore-not-found=false:
	If the requested object does not exist the command will return exit code 0.

    -k, --kustomize='':
	Process the kustomization directory. This flag can't be used together with -f or -R.

    -L, --label-columns=[]:
	Accepts a comma separated list of labels that are going to be presented as columns. Names are case-sensitive.
	You can also use multiple flag options like -L label1 -L label2...

    --no-headers=false:
	When using the default or custom-column output format, don't print headers (default print headers).

    -o, --output='':
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
	jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns
	[https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template
	[http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template
	[https://kubernetes.io/docs/reference/kubectl/jsonpath/].

    --output-watch-events=false:
	Output watch event objects when --watch or --watch-only is used. Existing objects are output as initial ADDED
	events.

    --raw='':
	Raw URI to request from the server.  Uses the transport specified by the kubeconfig file.

    -R, --recursive=false:
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
	organized within the same directory.

    -l, --selector='':
	Selector (label query) to filter on, supports '=', '==', and '!='.(e.g. -l key1=value1,key2=value2). Matching
	objects must satisfy all of the specified label constraints.

    --server-print=true:
	If true, have the server return the appropriate table output. Supports extension APIs and CRDs.

    --show-kind=false:
	If present, list the resource type for the requested object(s).

    --show-labels=false:
	When printing, show all labels as the last column (default hide labels column)

    --show-managed-fields=false:
	If true, keep the managedFields when printing objects in JSON or YAML format.

    --sort-by='':
	If non-empty, sort list types using this field specification.  The field specification is expressed as a
	JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath
	expression must be an integer or a string.

    --subresource='':
	If specified, gets the subresource of the requested object. Must be one of [status scale]. This flag is alpha
	and may change in the future.

    --template='':
	Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
	is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    -w, --watch=false:
	After listing/getting the requested object, watch for changes.

    --watch-only=false:
	Watch for changes to the requested object(s), without listing/getting first.

Usage:
  kubectl get
[(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide]
(TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help | grep dns
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help | grep DNS
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get --help | grep name
 Prints a table of the most important information about the specified resources. You can filter the list using a label selector and the --selector flag. If the desired resource type is namespaced you will only see results in your current namespace unless you pass --all-namespaces.
  # List all pods in ps output format with more information (such as node name)
  # List a pod identified by type and name specified in "pod.yaml" in JSON output format
  kubectl get pod test-pod -o custom-columns=CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image
  # List one or more resources by their type and names
    -A, --all-namespaces=false:
	If present, list the requested object(s) across all namespaces. Namespace in current context is ignored even if specified with --namespace.
    -f, --filename=[]:
	Filename, directory, or URL to files identifying the resource to get from a server.
	Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath, jsonpath-as-json, jsonpath-file, custom-columns, custom-columns-file, wide). See custom columns [https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns], golang template [http://golang.org/pkg/text/template/#pkg-overview] and jsonpath template [https://kubernetes.io/docs/reference/kubectl/jsonpath/].
	Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests organized within the same directory.
	If non-empty, sort list types using this field specification.  The field specification is expressed as a JSONPath expression (e.g. '{.metadata.name}'). The field in the API resource specified by this JSONPath expression must be an integer or a string.
  kubectl get [(-o|--output=)json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-as-json|jsonpath-file|custom-columns|custom-columns-file|wide] (TYPE[.VERSION][.GROUP] [NAME | -l label] | TYPE[.VERSION][.GROUP]/NAME ...) [flags] [options]
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ cd
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ vim .kube/config 
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ kubectl get nodes
NAME    STATUS   ROLES           AGE   VERSION
cp1     Ready    control-plane   18m   v1.24.2
node1   Ready    <none>          16m   v1.24.2
node2   Ready    <none>          16m   v1.24.2
maestro@PC-Ubuntu:~$ 
maestro@PC-Ubuntu:~$ cd learning-kubernetes/Betta/manifest/postgres/
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ ls -lha
итого 36K
drwxrwxr-x 2 maestro maestro 4,0K июл  6 15:02 .
drwxrwxr-x 4 maestro maestro 4,0K июл  5 15:30 ..
-rw-rw-r-- 1 maestro maestro  597 июн 28 10:19 backend.yml
-rw-rw-r-- 1 maestro maestro  194 июл  6 12:33 db-svc.yaml
-rw-rw-r-- 1 maestro maestro  566 июл  6 12:35 db.yaml
-rw-rw-r-- 1 maestro maestro    2 июл  6 15:02 ep-db-svc.yaml
-rw-rw-r-- 1 maestro maestro  195 июл  6 12:37 fb-svc.yaml
-rw-rw-r-- 1 maestro maestro  805 июл  5 16:23 frontend.yml
-rw-rw-r-- 1 maestro maestro  586 июл  6 12:31 web-app.yaml
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ mc

maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ vim fb-svc.yaml 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db.yaml 
statefulset.apps/db created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f db-svc.yaml 
service/db-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME   READY   STATUS    RESTARTS   AGE
db-0   1/1     Running   0          22s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME         ENDPOINTS          AGE
db-svc       10.233.90.1:5432   18s
kubernetes   10.128.0.11:6443   29m
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
```
### Логи контейнера с БД

```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs db-0 
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
2022-07-07 02:14:51.431 UTC [30] WARNING:  no usable system locales were found
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2022-07-07 02:14:52.742 UTC [36] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-07 02:14:52.748 UTC [36] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-07 02:14:52.773 UTC [37] LOG:  database system was shut down at 2022-07-07 02:14:52 UTC
2022-07-07 02:14:52.782 UTC [36] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down...2022-07-07 02:14:53.190 UTC [36] LOG:  received fast shutdown request
.2022-07-07 02:14:53.194 UTC [36] LOG:  aborting any active transactions
2022-07-07 02:14:53.194 UTC [36] LOG:  background worker "logical replication launcher" (PID 43) exited with exit code 1
2022-07-07 02:14:53.195 UTC [38] LOG:  shutting down
2022-07-07 02:14:53.215 UTC [36] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2022-07-07 02:14:53.317 UTC [1] LOG:  starting PostgreSQL 13.7 on x86_64-pc-linux-musl, compiled by gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219, 64-bit
2022-07-07 02:14:53.317 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2022-07-07 02:14:53.317 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2022-07-07 02:14:53.330 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2022-07-07 02:14:53.341 UTC [50] LOG:  database system was shut down at 2022-07-07 02:14:53 UTC
2022-07-07 02:14:53.347 UTC [1] LOG:  database system is ready to accept connections
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
```
### Подключение к БД в нутри контейнера с БД
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# psql 127.1
psql: error: FATAL:  role "root" does not exist
db-0:/# 
db-0:/# psql -h 127.1:5432 -U postgres
psql: error: could not translate host name "127.1:5432" to address: Name does not resolve
db-0:/# 
db-0:/# psql -h 127.0.0.1:5432 -U postgres
psql: error: could not translate host name "127.0.0.1:5432" to address: Name does not resolve
db-0:/# 
db-0:/# exit
logout
command terminated with exit code 2
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
```
* Endpoints, работающие в кластере
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get ep
NAME         ENDPOINTS          AGE
db-svc       10.233.90.1:5432   4m32s
kubernetes   10.128.0.11:6443   34m
```
* Endpoints describe
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl describe ep db-svc 
Name:         db-svc
Namespace:    default
Labels:       <none>
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-07-07T02:14:51Z
Subsets:
  Addresses:          10.233.90.1
  NotReadyAddresses:  <none>
  Ports:
    Name     Port  Protocol
    ----     ----  --------
    <unset>  5432  TCP

Events:  <none>
```
### Подключение к БД из контейнера с БД.
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec db-0 -c db -i -t -- bash -il
db-0:/# 
db-0:/# psql -h 10.233.90.1:5432 -U postgres
psql: error: could not translate host name "10.233.90.1:5432" to address: Name does not resolve
db-0:/# 
db-0:/# psql -h db-svc 10.233.90.1:5432 -U postgres -d news
psql: warning: extra command-line argument "10.233.90.1:5432" ignored
Password for user postgres: 
psql (13.7)
Type "help" for help.

news=# exit
db-0:/# 
db-0:/# exit
logout
```
### Запуск создания deployments для подя с контейнерами Frontend, Backend
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f web-app.yaml 
deployment.apps/fb-pod created
```
### Запуск создания сервиса для 
```
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl apply -f fb-svc.yaml 
service/fb-svc created
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS              RESTARTS   AGE
db-0                      1/1     Running             0          10m
fb-pod-65b9777746-lcflx   0/2     ContainerCreating   0          21s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS              RESTARTS   AGE
db-0                      1/1     Running             0          10m
fb-pod-65b9777746-lcflx   0/2     ContainerCreating   0          26s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS              RESTARTS   AGE
db-0                      1/1     Running             0          10m
fb-pod-65b9777746-lcflx   0/2     ContainerCreating   0          33s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl get pod
NAME                      READY   STATUS    RESTARTS   AGE
db-0                      1/1     Running   0          10m
fb-pod-65b9777746-lcflx   2/2     Running   0          40s
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl logs fb-pod-65b9777746-lcflx -c backend
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
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-4bnxq -c backend -i -t -- bash -il
Error from server (NotFound): pods "fb-pod-65b9777746-4bnxq" not found
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ 
maestro@PC-Ubuntu:~/learning-kubernetes/Betta/manifest/postgres$ kubectl exec fb-pod-65b9777746-lcflx -c backend -i -t -- bash -il
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# ping frontend
ping: frontend: Name or service not known
root@fb-pod-65b9777746-lcflx:/app# 
root@fb-pod-65b9777746-lcflx:/app# 
```
