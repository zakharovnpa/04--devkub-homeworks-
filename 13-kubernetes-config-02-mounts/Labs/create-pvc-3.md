### Логи по Ручное управление Persistent Volume

```
controlplane $ kubectl get po
No resources found in default namespace.
controlplane $ 
controlplane $ cd My-Project/    
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
pod    0/1     Pending   0          81s
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wnlkh (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-wnlkh:
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
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  3m38s  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   0/1     Pending   0          4m1s

NAME                        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Pending                                                     10s
controlplane $ 
controlplane $ kubectl describe po,pvc
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-wnlkh (ro)
Conditions:
  Type           Status
  PodScheduled   False 
Volumes:
  my-volume:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  pvc
    ReadOnly:   false
  kube-api-access-wnlkh:
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
  Type     Reason            Age    From               Message
  ----     ------            ----   ----               -------
  Warning  FailedScheduling  4m41s  default-scheduler  0/2 nodes are available: 2 persistentvolumeclaim "pvc" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
  Warning  FailedScheduling  50s    default-scheduler  running PreFilter plugin "VolumeBinding": %!!(MISSING)w(<nil>)


Name:          pvc
Namespace:     default
StorageClass:  
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   <none>
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       pod
Events:
  Type    Reason         Age               From                         Message
  ----    ------         ----              ----                         -------
  Normal  FailedBinding  6s (x4 over 50s)  persistentvolume-controller  no persistent volumes available for this claim and no storage class is set
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pv.yaml  
persistentvolume/pv created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          6m48s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           2m57s
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          7m3s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           3m12s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           97s
controlplane $ 
controlplane $ 
controlplane $   
controlplane $ 
controlplane $ kubectl delete -f .
pod "pod" deleted
persistentvolume "pv" deleted
persistentvolumeclaim "pvc" deleted
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
No resources found
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Available                                   5s
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           5s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           21s
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          4s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           35s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           51s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          2m13s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           2m44s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           3m
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f .
pod "pod" deleted
persistentvolume "pv" deleted
persistentvolumeclaim "pvc" deleted
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
No resources found
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec.containers[0].volumeMounts[0].name: Not found: "my-volume"
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          5s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pv       
pv.yaml   pvc.yaml  
controlplane $ kubectl apply -f pv.yaml 
persistentvolume/pv created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          34s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Available                                   5s
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          48s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           4s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           19s
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-sqzgd", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-sqzgd", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-sqzgd", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-sqzgd", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          4m30s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           3m46s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           4m1s
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f pvc.yaml 
persistentvolumeclaim "pvc" deleted
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-sqzgd", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-sqzgd", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f pv.yaml  
persistentvolume "pv" deleted
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-sqzgd", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-sqzgd", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-sqzgd", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-sqzgd", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ kuectl delete -f .
kuectl: command not found
controlplane $ 
controlplane $ kubectl delete -f .
pod "pod" deleted
Error from server (NotFound): error when deleting "pv.yaml": persistentvolumes "pv" not found
Error from server (NotFound): error when deleting "pvc.yaml": persistentvolumeclaims "pvc" not found
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod configured
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
-       Volumes: []core.Volume{
-               {
-                       Name:         "my-volume",
-                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{...}},
-               },
-               {
-                       Name:         "kube-api-access-wqnf9",
-                       VolumeSource: core.VolumeSource{Projected: &core.ProjectedVolumeSource{...}},
-               },
-       },
+       Volumes:        nil,
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
-                       VolumeMounts: []core.VolumeMount{
-                               {Name: "my-volume", MountPath: "/static"},
-                               {
-                                       Name:      "kube-api-access-wqnf9",
-                                       ReadOnly:  true,
-                                       MountPath: "/var/run/secrets/kubernetes.io/serviceaccount",
-                               },
-                       },
+                       VolumeMounts:  nil,
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f pov.yaml 
pod "pod" deleted
controlplane $ 
controlplane $ kubectl get po,pvc,pv
No resources found
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          7s
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod unchanged
controlplane $ 
controlplane $ 
controlplane $ kubectl get po pod -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cni.projectcalico.org/containerID: 09ed7436ffba6b2b752244bc0d08fffab7cbdf1abd574edfa3e070c4d845e7c3
    cni.projectcalico.org/podIP: 192.168.1.7/32
    cni.projectcalico.org/podIPs: 192.168.1.7/32
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"pod","namespace":"default"},"spec":{"containers":[{"image":"nginx","name":"nginx"}]}}
  creationTimestamp: "2022-07-15T04:51:28Z"
  name: pod
  namespace: default
  resourceVersion: "19975"
  uid: 98b4d21c-be9c-4d95-8e58-041a5a9348e6
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-72rp4
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: node01
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
  - name: kube-api-access-72rp4
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
    lastTransitionTime: "2022-07-15T04:51:28Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2022-07-15T04:51:30Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2022-07-15T04:51:30Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2022-07-15T04:51:28Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://6ddc544d31e7335c6d9937328de528ff583303c0f3321354316bab2bdbe88489
    image: docker.io/library/nginx:latest
    imageID: docker.io/library/nginx@sha256:db345982a2f2a4257c6f699a499feb1d79451a1305e8022f16456ddc3ad6b94c
    lastState: {}
    name: nginx
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2022-07-15T04:51:29Z"
  hostIP: 172.30.2.2
  phase: Running
  podIP: 192.168.1.7
  podIPs:
  - ip: 192.168.1.7
  qosClass: BestEffort
  startTime: "2022-07-15T04:51:28Z"
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pv.yaml  
persistentvolume/pv created
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          2m40s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Available                                   7s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pvc.yaml 
persistentvolumeclaim/pvc created
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          2m51s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           4s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           18s
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-72rp4", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-72rp4", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
The Pod "pod" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes: []core.Volume{
+               {
+                       Name:         "my-volume",
+                       VolumeSource: core.VolumeSource{PersistentVolumeClaim: &core.PersistentVolumeClaimVolumeSource{ClaimName: "pvc"}},
+               },
                {Name: "kube-api-access-72rp4", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}},
        },
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 7 identical fields
                        Env:       nil,
                        Resources: {},
                        VolumeMounts: []core.VolumeMount{
+                               {Name: "my-volume", MountPath: "/static"},
                                {Name: "kube-api-access-72rp4", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"},
                        },
                        VolumeDevices: nil,
                        LivenessProbe: nil,
                        ... // 10 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 26 identical fields
  }

controlplane $ 
controlplane $ 
controlplane $ kubectl delete -f pov.yaml 
pod "pod" deleted
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get po,pvc,pv
NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          9s

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           2m1s

NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           2m15s
controlplane $ 
controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod -- sh -c "echo 42 > /static/42.txt"
controlplane $ 
controlplane $ 
controlplane $ ssh node01
Last login: Fri Oct  8 17:04:36 2021 from 10.32.0.22
node01 $ 
node01 $ ls -la /data/pv
total 12
drwxr-xr-x 2 root root 4096 Jul 15 05:02 .
drwxr-xr-x 3 root root 4096 Jul 15 04:34 ..
-rw-r--r-- 1 root root    3 Jul 15 05:02 42.txt
node01 $ 
node01 $ 
node01 $ cat /data/pv/42.txt
42
node01 $ 
node01 $ 
node01 $ echo 43 | sudo tee /data/pv/43.txt
43
node01 $ 
node01 $ 
node01 $ kubectl exec pod -c nginx -- ls -la /static
The connection to the server localhost:8080 was refused - did you specify the right host or port?
node01 $ exit
logout
Connection to node01 closed.
controlplane $ 
controlplane $ kubectl exec pod -c nginx -- ls -la /static
total 16
drwxr-xr-x 2 root root 4096 Jul 15 05:05 .
drwxr-xr-x 1 root root 4096 Jul 15 04:56 ..
-rw-r--r-- 1 root root    3 Jul 15 05:02 42.txt
-rw-r--r-- 1 root root    3 Jul 15 05:05 43.txt
controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod -c nginx -- cat /static/43.txt
43
controlplane $ 
controlplane $ 
controlplane $ kubectl delete po pod
pod "pod" deleted
controlplane $ 
controlplane $ 
controlplane $ ssh node01
Last login: Fri Jul 15 05:03:39 2022 from 10.244.7.145
node01 $ 
node01 $ ls -la /data/pv
total 16
drwxr-xr-x 2 root root 4096 Jul 15 05:05 .
drwxr-xr-x 3 root root 4096 Jul 15 04:34 ..
-rw-r--r-- 1 root root    3 Jul 15 05:02 42.txt
-rw-r--r-- 1 root root    3 Jul 15 05:05 43.txt
node01 $ 
node01 $ 
node01 $ exit
logout
Connection to node01 closed.
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv,pvc
NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           14m

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           14m
controlplane $ 
controlplane $ 
controlplane $ kubectl apply -f pov.yaml 
pod/pod created
controlplane $ 
controlplane $ 
controlplane $ kubectl get pv,pvc,po
NAME                  CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM         STORAGECLASS   REASON   AGE
persistentvolume/pv   2Gi        RWO            Retain           Bound    default/pvc                           15m

NAME                        STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/pvc   Bound    pv       2Gi        RWO                           15m

NAME      READY   STATUS    RESTARTS   AGE
pod/pod   1/1     Running   0          8s
controlplane $ 
controlplane $ 
controlplane $ kubectl exec pod -- ls -la /static
total 16
drwxr-xr-x 2 root root 4096 Jul 15 05:05 .
drwxr-xr-x 1 root root 4096 Jul 15 05:09 ..
-rw-r--r-- 1 root root    3 Jul 15 05:02 42.txt
-rw-r--r-- 1 root root    3 Jul 15 05:05 43.txt
controlplane $ 
```
