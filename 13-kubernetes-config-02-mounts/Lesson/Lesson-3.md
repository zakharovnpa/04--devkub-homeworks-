## Попытка №3 выполнить вопрос №2 ДЗ "13.2 разделы и монтирование"

### 1. Берем исходные файлы и ДЗ "13.1 контейнеры, поды, deployment, statefulset, services, endpoints". Добавляем к ним в спецификацию параметры запроса тома

#### 1.1 Тестовая среда

* Исходники манифестов для деплоя приложения в различных подах для тестовой среды

  * Frontend и Backend [stage-front-back.yaml](/13-kubernetes-config-01-objects/Files/stage-front-back.yaml)


* Измененные манифесты

  * Frontend и Backend [stage-front-back.yaml](/13-kubernetes-config-02-mounts/mount-stage-front-back.yaml)



#### 1.2 Продуктовая среда

* Исходники манифестов для деплоя приложений в различных подах для продуктовой среды

  * Frontend [prod-frontend.yaml](/13-kubernetes-config-01-objects/Files/prod-frontend.yaml)
  * Backend [prod-backend.yaml](/13-kubernetes-config-01-objects/Files/prod-backend.yaml)

* Измененные манифесты

  * Frontend [prod-frontend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-frontend.yaml)
  * Backend [prod-backend.yaml](/13-kubernetes-config-02-mounts/Files/mount-prod-backend.yaml)

