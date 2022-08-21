## ЛР-220821-0820. Знакомство с Qbec и Jsonnet

- [ЛР-220821-0820. Знакомство с Qbec и Jsonnet](/13-kubernetes-config-05-qbec/Labs/labs-220821-0820-acquaintance-qbec-and-jsonnet.md)

### Источники информации:
1. Проект [Grafana Tanka](https://tanka.dev/tutorial/jsonnet) - очень похож на Qbec, но работает на Grafana & Promrtheus

#### Уроки по Grafana Tanka
- [Руководство](https://tanka.dev/tutorial/overview)/. Учимся пользоваться Танкой

> Добро пожаловать в учебник Танка! В следующих разделах объясняется, как развернуть пример стека 
> ( Grafana и Prometheus ) в Kubernetes. Мы также разберемся с параметрами, различиями devи prodтем, 
> как перестать волноваться и полюбить библиотеки.

Для этого у нас есть следующие шаги:

1. [Развертывание сначала без Tanka](https://tanka.dev/tutorial/refresher) : Использование старого доброго, kubectlчтобы понять, что Tanka сделает для нас.
2. [Использование Jsonnet](https://tanka.dev/tutorial/jsonnet) : делаем то же самое еще раз, но на этот раз с Tanka и Jsonnet.
3. [Параметризация](https://tanka.dev/tutorial/parameters) : использование переменных для предотвращения дублирования данных.
4. [Абстракция](https://tanka.dev/tutorial/abstraction) : разделение компонентов на отдельные части.
5. [Среды](https://tanka.dev/tutorial/environments) : работа с различиями между devи prod.
6. [k.libsonnet](https://tanka.dev/tutorial/k-lib): Избегайте необходимости запоминать ресурсы API.
Завершение этого дает твердое знание основ Tanka. Давайте начнем!
