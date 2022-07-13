### Лог создания образа Database

```
root@PC-Ubuntu:~/netology-project/devkub-homeworks/13-kubernetes-config/database# docker build -t zakharovnpa/k8s-database:12.07.22 .
Sending build context to Docker daemon  3.072kB
Step 1/4 : FROM postgres:13-alpine
 ---> 2bb8cea1e0bb
Step 2/4 : ENV POSTGRES_PASSWORD: postgres
 ---> Running in 8bbe971de1a6
Removing intermediate container 8bbe971de1a6
 ---> 621b4b3729c1
Step 3/4 : ENV POSTGRES_USER: postgres
 ---> Running in 15442c8310d7
Removing intermediate container 15442c8310d7
 ---> efcc95e7a13e
Step 4/4 : ENV POSTGRES_DB: news
 ---> Running in 772a9c7ef018
Removing intermediate container 772a9c7ef018
 ---> 817aba5aa2ec
Successfully built 817aba5aa2ec
Successfully tagged zakharovnpa/k8s-database:12.07.22

```
