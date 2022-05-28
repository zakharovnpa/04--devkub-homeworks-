## Лекция по теме "Микросервисы: подходы"


Михаил
ТриполитовМихаил Триполитов
Technical Lead
Михаил Триполитов

### 2План занятия
1. Развертывание
2. Тестирование
3. Безопасность
4. Мониторинг
5. Итоги
6. Домашнее задание

### 3Развертывание
### 4Непрерывная интеграция
Сборка
Сервер
непрерывной
интеграции
Система
контроля
версий
Тестирование
Результат
Commit
Результат
Команда разработки

### 5Непрерывная интеграция и микросервисы
Система хранения версий
Сервер непрерывной
интеграции
Service 1 Code Service 1 Build
Service 2 Code Service 2 Build
Service 3 Code Service 3 Build
Код каждого сервиса
хранится в отдельном
репозитории
Система хранения артефактов
Service 1
Version 1.2.3
Service 2
Version 2.0.7
Service 3
Version 1.0.1
Для каждого сервиса собирается
отдельный артефакт

### 6Непрерывная поставка
Код
Авто
Сборка
Авто
Тесты
●
●
●
●
Авто
Вруч
ную
Приёмка
Выкладка
Установка на тестовый контур
Интеграционные тесты
Нагрузочные тесты
Ручные тесты

### 7Непрерывная установка
Код
Авто
Сборка
Авто
Тесты
●
●
●
Авто
Авто
Приёмка
Выкладка
Установка на тестовый контур
Автоматические интеграционные тесты
Автоматические нагрузочные тесты

### 8Стенды / Контура
Стенд для
приемочного
тестирования
Стенд для команды
разработки
CI
Dev
Непрерывная сборка
● Сборка кода
● Unit-тесты
● Публикация артефактов сборки
Integration
UAT
Стенд для
интеграционного
тестирования
между командами
Production
Боевой стенд

### 9Непрерывное развертывание
● Recreate
● Rolling deployment
● Blue-Green deployment
● Canary releases
● A/B testing
● Shadow

### 10Recreate
До После
v1.0 v2.0

### 11Мультисервис Recreate
До
v1.0
v2.7
После
v1.3
v3.8
v1.1
v2.8
v1.5
v4.0

### 12Rolling deployment
После
До
1 Node
2 Nodes
OK?
v1.0
4 Nodes
3 Nodes
OK?
5 Nodes
OK?
6 Nodes
OK?
v2.0

### 13Blue Green deployment
До
После
Stand by Live Live Stand by
v1.2 v1.1 v1.2 v1.1

### 14Canary deployment
До
После
10% запросов
70% запросов
OK?
v1.0
v1.1
v1.0
100% запросов
OK?
v1.1
v1.0
v1.1

### 15A/B Testing
После
До
v1.2(B)
71%
v1.3 (D)
73%
v1.2 (C)
63%
v1.0
v1.0 (A) = 71%
v1.3

### 16Shadow
До
v1.0
После
v1.0
v2.0

### 17Непрерывное развертывание
Стратегия Отсутствие
остановки Тестирование
на реальных
запросах Тестирование
действий
пользователей Стоимость Длительность
отката Влияние на
пользователей Recreate ❌ ❌ ❌ 💲 🕔🕔🕔 󰣻󰣻󰣻 Rolling ✔ ❌ ❌ 💲 🕔🕔🕔 󰣻 🔬
Blue Green ✔ ❌ ❌ 💲💲💲 󰣻󰣻 🔬🔬
Canary ✔ ✔ ❌ 💲 🕔 󰣻 🔬
A/B Testing ✔ ✔ ✔ 💲 🕔 󰣻 🔬🔬🔬
Shadow ✔ ✔ ❌ 💲💲💲
Сложность
🔬🔬🔬

### 18Тестирование

### 19Типы тестов
Бизнес
Ручные
Автоматизация
Приемочные тесты
Функциональные тесты
Регрессионные тесты
Тесты на соответствие
●
●
●
●
●
●
●
Исследовательские тесты
Юзабилити тесты
A/B тесты
Разработка
Автоматизация
Ручные
Продукт
●
●
●
●
Unit тесты
Интеграционные тесты
Тесты API совместимости
Форматы данных
●
●
●
●
●
Тесты производительности
Нагрузочные тесты
Тесты на проникновение
Тесты атрибутов качества
Тесты масштабируемости
Специализирова
нные
инструменты
Автоматизация
Технологии

### 20Пирамида тестирования
Медленные
Ширина пирамиды
отражает относительное
количество тестов
Дорогие
End
to
End
Service
Unit Test
Быстрые
Дешевые

### 21Тесты - часть процесса развертывания
Unit Tests
Service Tests
End to End Tests
Цепочка-сборка
прерывается как
можно раньше, чтобы
сократить время
обратной связи.

### 22Безопасность

### 23Аутентификация и авторизация
● Идентификация - процедура выявления
идентификатора субъекта в системе
● Аутентификация - процедура проверки
подлинности
● Авторизация - процедура проверки прав на
выполнение определенных операций

### 24Single Sign On
Login 1 Service 1 Service 1
Login 2 Service 2 Service 2
SSO
Login 3 Service 3 Service 3
Login 4 Service 4 Service 4

### 25Межсервисная аутентификация и авторизация
2. Пользовательский токен
1. Без авторизации
4. OAuth
3. Простая HTTP авторизация
Service 1
Service 2
5. Client Certiﬁcates
6. HMAC
7. API Keys

### 26Без аутентификации
schema://host:port
Service 1
Service 2

### 27Propagate User Identity
login + password
schema://host:port
SSO
Client Token
Service 1
Service 2

### 8HTTP Basic Auth
https://host:port
Authorization: Basic base64(<username>:<password>)
Service 1
Service 2
HTTPS Server
Certiﬁcate
Private Key
Поиск логина и пароля в Базе Данных

### 29OAuth2
Client Credentials
OAuth2 Service
access_token
Service 1
Service 2
https://host:port
Authorization: Bearer <access_token>

### 30Client Certiﬁcates
Certiﬁcate Authority
Verify Server Certiﬁcate
Client
Certiﬁcate Server
Certiﬁcate
Public Key Public Key
Service 1
Service 2
Server
Certiﬁcate
Client
Certiﬁcate
Private
Key
Verify Client Certiﬁcate
https://host:port
Private
Key

### 31Hash-based Message Authentication Code (HMAC)
https://host:port
Authorization: HMAC-SHA256 <id>:<signature>
Service 1
Service 2
id
secret
id
id secret
id
id secret
secret
secret
CanonicalRequest
Timestamp
+ HTTP Verb
+ Canonical URL
+ Canonical Query String
+ Canonical Headers
+ Signed Headers
+ hash(SHA256, Payload)
Signature Calculation
StringToSign
“HMAC”
+ Timestamp
+ hex(hash(SHA256, CanonicalRequest))
Signature
hex(hmac(SHA256, secret, StringToSign))

### 32API Keys
1. Заголовок
https://host:port
X-API-Key: 2fb96c97-d401-475a-8f12-ed7b9346fedb
2. Строка запроса
https://host:port?api_key=2fb96c97-d401-475a-8f12-ed7b9346fedb
Service 1
Service 2
Верификация API Key по Базе Данных

  
### 33Межсервисная аутентификация и авторизация
1. Без авторизации
2. Пользовательский токен
3. Простая HTTP авторизация
4. OAuth
5. Client Certiﬁcates
6. HMAC
7. API Keys

### 34Мониторинг

### 35Сбор метрик
Host 1
Host 2
Каждый сервис
публикует метрики
Host N
На регулярной основе
считывает и сохраняет
значения метрик
http://host/metrics
Prometheus
Graphana
InﬂuxDb

### 36Сбор логов
Host 1 Host 2 Host N
Application
log Application
log Application
log
Logstash Logstash Logstash
Elastic Search Kibana

### 37Сбор трассировки
Host 1 Host 2 Host N
Jaegеr Agent Jaegеr Agent Jaegеr Agent
Jaegеr Collector
Cassandra
Jaegеr UI

### 38Мониторинг
1. Сбор метрик
2. Сбор логов
3. Сбор трассировки
Важно стандартизировать метрики, логи и трассировку
для всех сервисов.

### 39Итоги
● Узнали важность непрерывной поставки для микросервисной
архитектуры
● Познакомились со способами развертывания микросервисов
● Узнали про разные виды тестирования и изучили влияние пирамиды
тестирования на результат
● Разобрали разные способы обеспечения аутентификации и авторизации
● Познакомились со способами мониторинга: метрики, логи, трассировка

### 40Домашнее задание
Давайте посмотрим ваше домашнее задание.
● Вопросы по домашней работе задавайте в чате мессенджера Slack.
● Задачи можно сдавать по частям.
● Зачёт по домашней работе проставляется после того, как приняты
все задачи.

### 41Задавайте вопросы и
пишите отзыв о лекции!
Михаил Триполитов
Михаил Триполитов
