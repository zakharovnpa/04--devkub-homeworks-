## Материалы по изучению Jsonnet

### Проект Grafana Tanka
#### 1. [Графана Танка. Гибкая, многократно используемая и лаконичная конфигурация для Kubernetes](https://tanka.dev/)
> Grafana Tanka — это надежная утилита для настройки вашего кластера Kubernetes , работающая на уникальном языке Jsonnet.
#### 2. [Обзор языка](https://tanka.dev/jsonnet/overview)
> [Jsonnet](https://jsonnet.org/) — это язык шаблонов данных, который Tanka использует для выражения того, что должно быть развернуто в вашем кластере Kubernetes. 
> Понимание Jsonnet имеет решающее значение для эффективного использования Tanka.

> На этой странице рассматривается сам язык Jsonnet. Дополнительные сведения о том, как использовать Jsonnet с Kubernetes, [см . в руководстве](https://tanka.dev/tutorial/jsonnet) . 
> Существует также [официальное руководство по Jsonnet](https://jsonnet.org/learning/tutorial.html), в котором представлен более подробный обзор возможностей языка.

#### 3. [Использование Jsonnet](https://tanka.dev/tutorial/jsonnet)
> Самая мощная часть Tanka — это язык шаблонов данных Jsonnet . Jsonnet — это надмножество JSON, в которое добавлены переменные, функции, исправления (глубокое слияние), арифметика, условные операторы и многое другое.

> Он имеет много общего с более реальными языками программирования, такими как JavaScript, чем с языками разметки, тем не менее он предназначен специально для представления данных и конфигурации. В отличие от JSON (и YAML) это язык, предназначенный для людей, а не для компьютеров.


### Стартовый скрипт

```
wget https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz && \
tar -zxvf qbec-linux-amd64.tar.gz && \
cp qbec jsonnet-qbec /usr/local/bin && \
cd /usr/local/bin/ && \
./qbec && \
qbec init demo && cd demo && \
qbec show -O default

```
