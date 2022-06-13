# Домашнее задание к занятию "12.2 Команды для работы с Kubernetes" - Захаров Сергей Николаевич

Кластер — это сложная система, с которой крайне редко работает один человек. Квалифицированный devops умеет наладить работу всей команды, занимающейся каким-либо сервисом.
После знакомства с кластером вас попросили выдать доступ нескольким разработчикам. Помимо этого требуется служебный аккаунт для просмотра логов.

## Задание 1: Запуск пода из образа в деплойменте
Для начала следует разобраться с прямым запуском приложений из консоли. Такой подход поможет быстро развернуть инструменты отладки в кластере. Требуется запустить деплоймент на основе образа из hello world уже через deployment. Сразу стоит запустить 2 копии приложения (replicas=2). 

Требования:
 * пример из hello world запущен в качестве deployment
 * количество реплик в deployment установлено в 2
 * наличие deployment можно проверить командой kubectl get deployment
 * наличие подов можно проверить командой kubectl get pods


**Ответ:**

#### Запуск приложения
1. Находимся на ноде `minikube`:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get nodes
NAME       STATUS   ROLES                  AGE     VERSION
minikube   Ready    control-plane,master   6d20h   v1.23.3
```
2. Создаем деплой командой `kubectl create deployment <app_name> --image=name_repo/name_image:tagged`:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl create deployment k8s-hello-world --namespace default --image=zakharovnpa/k8s-hello-world:05.06.22
deployment.apps/k8s-hello-world created
```
3. Деплой создан `k8s-hello-world`:
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get deployments
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
k8s-hello-world   1/1     1            1           18h
```
4. Один инстас приложения уже работает. Для масштабирования запускаем приложение командой `kubectl scale deployment k8s-hello-world --replicas=2`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl scale deployment k8s-hello-world --replicas=2
deployment.apps/k8s-hello-world scaled
```

5. Просмотр количества подов командой `kubectl get pods -l app=k8s-hello-world`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods
NAME                               READY   STATUS             RESTARTS        AGE
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0               45h
k8s-hello-world-6969845fcf-tbtzv   1/1     Running            0               14m
```


## Задание 2: Просмотр логов для разработки
Разработчикам крайне важно получать обратную связь от штатно работающего приложения и, еще важнее, об ошибках в его работе. 
Требуется создать пользователя и выдать ему доступ на чтение конфигурации и логов подов в app-namespace.

Требования: 
 * создан новый токен доступа для пользователя
 * пользователь прописан в локальный конфиг (~/.kube/config, блок users)
 * пользователь может просматривать логи подов и их конфигурацию (kubectl logs pod <pod_id>, kubectl describe pod <pod_id>)


## Задание 3: Изменение количества реплик 
Поработав с приложением, вы получили запрос на увеличение количества реплик приложения для нагрузки. Необходимо изменить запущенный deployment, увеличив количество реплик до 5. Посмотрите статус запущенных подов после увеличения реплик. 

Требования:
 * в deployment из задания 1 изменено количество реплик на 5
 * проверить что все поды перешли в статус running (kubectl get pods)

**Ответ:**

1. Один инстас приложения уже работает. Для масштабирования запускаем приложение командой `kubectl scale deployment k8s-hello-world --replicas=2`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl scale deployment k8s-hello-world --replicas=2
deployment.apps/k8s-hello-world scaled
```

2. Просмотр количества подов командой `kubectl get pods -l app=k8s-hello-world`
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods
NAME                               READY   STATUS             RESTARTS        AGE
k8s-hello-world-6969845fcf-5v7xk   1/1     Running            0               45h
k8s-hello-world-6969845fcf-tbtzv   1/1     Running            0               14m
```
3. Масштабируем приложение до 5 инстансов
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl scale deployment k8s-hello-world --replicas=5
deployment.apps/k8s-hello-world scaled
```
4. Работает 5 экземпляров приложения
```
maestro@PC-Ubuntu:~/Рабочий стол$ kubectl get pods -l app=k8s-hello-world
NAME                               READY   STATUS    RESTARTS   AGE
k8s-hello-world-6969845fcf-4lp47   1/1     Running   0          5s
k8s-hello-world-6969845fcf-5v7xk   1/1     Running   0          5d11h
k8s-hello-world-6969845fcf-bv6kp   1/1     Running   0          5s
k8s-hello-world-6969845fcf-lwncw   1/1     Running   0          5s
k8s-hello-world-6969845fcf-tbtzv   1/1     Running   0          3d14h
```

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
