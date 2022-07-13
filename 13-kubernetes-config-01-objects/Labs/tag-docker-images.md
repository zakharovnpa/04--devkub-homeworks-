### Тегирование образов для дальнейшего пуша в Docker-registry
  

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker image tag --help

Usage:  docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
```

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker image list | grep zakharovnpa_
zakharovnpa_backend                                                 latest            5d97bf6ad02f   24 hours ago    1.07GB
zakharovnpa_frontend                                                latest            5438a0c5806b   9 days ago      142MB
```

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker image list | grep zakharovnpa/
zakharovnpa/k8s-database                                            12.07.22          817aba5aa2ec   23 hours ago    213MB
zakharovnpa/k8s-frontend                                            12.07.22          dc84bb688414   23 hours ago    142MB
zakharovnpa/k8s-backend                                             12.07.22          5d97bf6ad02f   24 hours ago    1.07GB
zakharovnpa/k8s-backend                                             05.07.22          bf58e470d5a5   9 days ago      1.07GB
zakharovnpa/k8s-frontend                                            05.07.22          5438a0c5806b   9 days ago      142MB
zakharovnpa/k8s-database                                            05.07.22          2bb8cea1e0bb   3 weeks ago     213MB
zakharovnpa/k8s-hello-world                                         05.06.22          ce35230a77b3   5 weeks ago     660MB
registry.gitlab.com/zakharovnpa/gitlablesson/python-api             latest            b79a8a0840b1   2 months ago    427MB
registry.gitlab.com/zakharovnpa/gitlablesson                        latest            e87a0e154f99   2 months ago    427MB
registry.gitlab.com/zakharovnpa/gitlablesson/python-api             <none>            e87a0e154f99   2 months ago    427MB
```

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker image tag zakharovnpa_backend:latest zakharovnpa/k8s-backend:13.07.22
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker image tag zakharovnpa_frontend:latest zakharovnpa/k8s-frontend:13.07.22
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker image list | grep zakharovnpa/
zakharovnpa/k8s-database                                            12.07.22          817aba5aa2ec   23 hours ago    213MB
zakharovnpa/k8s-frontend                                            12.07.22          dc84bb688414   23 hours ago    142MB
zakharovnpa/k8s-backend                                             12.07.22          5d97bf6ad02f   24 hours ago    1.07GB
zakharovnpa/k8s-backend                                             13.07.22          5d97bf6ad02f   24 hours ago    1.07GB
zakharovnpa/k8s-backend                                             05.07.22          bf58e470d5a5   9 days ago      1.07GB
zakharovnpa/k8s-frontend                                            05.07.22          5438a0c5806b   9 days ago      142MB
zakharovnpa/k8s-frontend                                            13.07.22          5438a0c5806b   9 days ago      142MB
zakharovnpa/k8s-database                                            05.07.22          2bb8cea1e0bb   3 weeks ago     213MB
zakharovnpa/k8s-hello-world                                         05.06.22          ce35230a77b3   5 weeks ago     660MB
registry.gitlab.com/zakharovnpa/gitlablesson/python-api             latest            b79a8a0840b1   2 months ago    427MB
registry.gitlab.com/zakharovnpa/gitlablesson                        latest            e87a0e154f99   2 months ago    427MB
registry.gitlab.com/zakharovnpa/gitlablesson/python-api             <none>            e87a0e154f99   2 months ago    427MB
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker push zakharovnpa/k8s-backend:13.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-backend]
cd406ffca89d: Layer already exists 
5a687269d92d: Layer already exists 
a21cff5f2b09: Layer already exists 
615bf7a85334: Layer already exists 
bbd65b77c862: Layer already exists 
843f990feb92: Layer already exists 
70dce5ebf427: Layer already exists 
aba5ac262080: Layer already exists 
2df8715307ad: Layer already exists 
e6fd4ebbaaab: Layer already exists 
261e5d6450d3: Layer already exists 
65d22717bade: Layer already exists 
3abde9518332: Layer already exists 
0c8724a82628: Layer already exists 
13.07.22: digest: sha256:3dc17ecbe40bda123426b20274b539f72123d51fb8a3d7880b5755a4e50dbc99 size: 3264
```
```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/Test-13-46# docker push zakharovnpa/k8s-frontend:13.07.22
The push refers to repository [docker.io/zakharovnpa/k8s-frontend]
352d627bd336: Layer already exists 
a5b05b1f6d07: Layer already exists 
cf2af7b6ae79: Layer already exists 
649f9ccbcc97: Layer already exists 
e7344f8a29a3: Layer already exists 
44193d3f4ea2: Layer already exists 
41451f050aa8: Layer already exists 
b2f82de68e0d: Layer already exists 
d5b40e80384b: Layer already exists 
08249ce7456a: Layer already exists 
13.07.22: digest: sha256:e33314ba8661fcee936716a673d5a7e10837d9349971a6b91b5483ec9677a45a size: 2401

```
