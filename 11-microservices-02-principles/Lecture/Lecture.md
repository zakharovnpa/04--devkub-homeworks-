## Лекция по теме  "Микросервисы: принципы"

Михаил
ТриполитовМихаил Триполитов
Technical Lead
Михаил Триполитов

### 2План занятия
1. Проектирование системы
2. Разделение на сервисы
3. Взаимодействие между сервисами
4. Двенадцать факторов
5. Итоги
6. Домашнее задание

### 3Проектирование системы

### 4Архитектура
- Используется
  - Правила
  - Принципы
  - Практики
  - Ограничения
- Не используется
  - Детальный план - предоставляют командаам
  - Подробная документация

### 5Стратегические цели      - 00:07:00
Бизнес
стратегия
Соотносятся
Технологическая
стратегия

![mikroservise-6](/11-microservices-02-principles/Files/mikroservice-6.png)

### 6Принципы     - 00:08:50
Цели
Практики
Принципы

![mikroservise-7](/11-microservices-02-principles/Files/mikroservice-7.png)

### 7Практики      - 00:12:15
Цели
Масштабирование
бизнеса
Сокращение
используемого
операторами
программного
обеспечения
Оптимизация
ресурсов и затрат
Принципы
Обеспечивать
согласованные
интерфейсы и потоки
данных
Выбирать решения с
быстрым циклом
обратной связи
Уменьшать
избыточную
сложность, заменяя
дублирующие
системы
Практики
Использовать HTTP для
межсервисных интеграций
Исключать интеграционные
базы данных
Использовать независимые
сервисы
Применять непрерывную
интеграцию и постоянное
развертывание
Использовать мониторинг
для получения состояния
сервисов
Автоматически генерировать
клиентские библиотеки для
всех публикуемых
интерфейсов

![mikroservise-8](/11-microservices-02-principles/Files/mikroservice-8.png)

### 8Практики: необходимый минимум       - 00:15:00
- Централизованный мониторинг
- Централизованный сбор логов
- Ограниченный набор допустимых интерфейсов
- Безопасное поведение

### 9Разделение на сервисы       - 00:21:00

### 10Признаки хорошего сервиса
* Loose Coupling - Слабая связность. Минимизировать влияние изменений в одном сервисе на всю систему
* High Cohesion - Сильное зацепление. Минимизировать необходимость менять несколько сервисов при изменении поведения системы

![mikroservise-9](/11-microservices-02-principles/Files/mikroservice-9.png)


### 11Bounded Context        - 00:26:20

![mikroservise-10](/11-microservices-02-principles/Files/mikroservice-10.png)

Ограниченные области, каждая которая описывает свой ограниченный контекст.
Ограниченный контекст - это четкие границы ответственности модели, которая оона описывает.

![mikroservise-11](/11-microservices-02-principles/Files/mikroservice-11.png)

Имея такое измерение можно использовать границы контекста как границы сервисов
- 00:28:00 - пояснение про гораниченный контекст. Это использование каждым сервисом из всей полноты характеристик товара (сущности) только тех,
которые необходимы для данного сервиса.

### 12Bounded Context
Интернет-магазин

![mikroservise-12](/11-microservices-02-principles/Files/mikroservice-12.png)

### 13Один контекст. Один сервис. Одна команда.     - 00:32:00
Ограниченный контекст - это:
- Отдельная команда
- Отдельный репозиторий
- Отдельная схема базы данных
- Отдельная процедура тестирования
- Отдельная процедура выкладки

### 14Причины уменьшать размеры микросервисов       - 00:33:10

* Размер миеросервиса не должен быть метрикой или фактором, по которому разделяют систему на микросервисы.
* Важно уделять внимание тем целям, ради которых систему делят на микросервисы.
* Хороший вариант - это начать делить на сервисы, выделяя каждый ограниченный контекст
* Могут быть причины для того, чтобы делить на более мелкие сервисы для того, чтобы решить ту или иную задачу, например:
  * Частота изменений

- Частота изменений
- Масштабирование
- Независимость
- Сложность

### 15Bounded Context (ограниченный контекст)        - 00:35:40
Использование ограниченных контекстов для разбиения системы
на сервисы позволит обеспечить слабую связность и сильное
зацепление, соблюдая баланс размера сервисов.

### 16Взаимодействие между сервисами

### 17Выбор        - 00:35:30

Выбор способа интеграции - один из наиважнейших аспектов в успехе построения системы, основанной на микросервисной архитектуре.
Но вариантов - огромное количество.

Какой протокол выбрать?
- XML-RPC
- JSON-RPC
- gRPC
- REST
- GraphQL
- SOAP
...
Что еще выбрать? Способы взаимодействия.
- Синхронно / Асинхронно
- Оркестрация / Хореография
- RPC / Команды и события
….

### 18Выбор протоколов      - 00:39:20
Заваисит от того какие задачи решает система и какие требования перед ней ставятся.
- Обратная совместимость
- Технологическая независимость
- Забота о потребителях
- Четкий интерфейс

### 19Обратная совместимость       - 00:40:27


Избегайте обратно несовместимых изменений.
Обратная совместимость - это, например, при добавлении какого-то нового функционала в один сервис не приводит к необходимости изменять другие сервисв.
Есть протоколы, которые позволяют, есть которые не позволяют.

### 20Технологическая независимость      - 00:41:45
Избегайте интеграционных технологий и подходов, которые
привязаны к какой-то конкретной технологической платформе

### 21Забота о потребителях        - 00:43:55
Стремитесь снизить требования к клиентам и упростить использование интерфейсов
- Документация
- Простое и понятное API
- Готовые клиентские библиотеки

- 00:44:20 - о тех инструментах, для автогенерации документацию.
  - OpenAPI, 
  - для .NET это  NGen. 
  - Swagger для REST.
  - Playground
  - Altair

### 22Четкий интерфейс        - 00:45:56
Прячьте детали реализации от потребителей интерфейсов.
Избегайте интеграционных подходов и технологий, которые
раскрывают детали внутренней реализации потребителям.

### 23Выбор
- Обратная совместимость
- Технологическая независимость
- Забота о потребителях
- Четкий интерфейс

### 24Общая база данных        - 00:46:59
Пример того как не надо делать: нельзя объединять сервисы через одну и туже БД.
* Избегайте использование общей БД для межсервисной интеграции

![mikroservise-13](/11-microservices-02-principles/Files/mikroservice-13.png)

### 25Синхронное или асинхронное взаимодействие        - 00:56:30

![mikroservise-14](/11-microservices-02-principles/Files/mikroservice-14.png)

### 26Запрос / Ответ или События       - 00:57:55
- Запрос / Ответ - RPC
  - Проще для понимания
  - Синхронное и асинхронное взаимодействие
  - Централизует бизнес логику
  - Увеличивает связность 


- Событийная модель (асинхронная), также один из способов достижения слабой связности
  - Уменьшает связность
  - Децентрализация логики
  - Простота расширения системы
  - Общая сложность системы
  - Только асинхронный подход
 


![mikroservise-15](/11-microservices-02-principles/Files/mikroservice-15.png)

### 27Оркестрация или Хореография     - 00:59:52
Корзина
Заказы Корзина Заказы
Доставка Оплата Доставка
Оркестратор
Оплата

Какой сервис выбрать в каком порядке. Какие данные в него передать.
Два подхода.
- Оркестрация - наличие уаправляющего сервиса
- Хореография - система знает в какой момент времени какая система должна работать на достижение общей задачи. Это похоже на танцоров балета
  - Системы построенные на хореографии (и событийной модели) обладают меньшей связанностью и могут быть более гибкими. В них легче вносить изменения.
  - Но такие системы сложны для понимания и требуют дополнительных инструментов мониторинга для отслеживания корректности выполнения процессов

Поэтому лучше пользоваться оркестрацией, чем нырять в историю с хареографией. Оркестратор можно при разрастании системы поделить на несколько процессов, живущих в разных сервисах.

![mikroservise-16](/11-microservices-02-principles/Files/mikroservice-16.png)

### 28Remote Procedure Calls       - 01:02:40

Это техника вызова локальных функций

* Детали реализации недоступны другим сервисам
* При правильном выборе технологии потребители не ограничены одним стеком
* Простота использования
* Расширение моделей возможно только через добавление полей
* Ограниченная поддержка инфраструктурными инструментами

Примеры:   JRPC для Go,  .NET

Удаленный вызов не отличается от локального. Выглядят они одинаково.

### 29REST ( REpresentation State Transfer )        - 01:04:12
- Детали реализации недоступны другим сервисам
- Потребители не ограничены одним стеком
- Простота использования
- Хорошая поддержка инфраструктурными инструментами
- Текстовый формат данных JSON, XML
- Расширение моделей возможно только через добавление полей
- Не всегда возможно описать модель в терминах протокола HTTP

### 30GraphQL      - 01:06:40
Это протокол, который решает проблемы REST. Он основан на том, что есть описание модели.
Всегда возвращает предсказуемый результат, т.к. клиент сам составляет запрос что ему вернуть. Так проще работать с обратной совместимостью.
- Детали реализации недоступны другим сервисам
- Потребители не ограничены одним стеком
- Возможность получить несколько ресурсов одним запросом
- Возможность указать необходимые данные
- Расширение моделей возможно только через добавление полей
- Нет поддержки кэширования со стороны инфраструктуры

### 31Событийная модель        - 01:08:28
Для такой модели сервис должен делать сообщения, а клиенты могут подписываться на эти сообщения.
Для такой модели нужен Брокер соощений (на основе JMS, Kafka, брокер реализующий протокол MTP)
Брокер - это способ передать сообщение от одного сервиса к другому. Брокер должен заниматься только доставкой. Обработкой сообщений занимаются сервисы, которые подписаны на этого брокера.
Выбор событийной модели должен быть оправдан задачами, которые решает система.

- Детали реализации недоступны другим сервисам
- Потребители не ограничены одним стеком
- Возможность получить несколько ресурсов одним запросом
- Низкая общая связность решения
- Высокая гибкость и способность к расширению
- Потребители ограничены выбранной технологией
- Высокая общая сложность системы
- Повышенные требования к инфраструктуре

### 32Версионирование: SemVer

![mikroservise-17](/11-microservices-02-principles/Files/mikroservice-17.png)

### 33Версионирование: версии эндпоинтов        - 01:11:50

![mikroservise-18](/11-microservices-02-principles/Files/mikroservice-18.png)

### 34Версионирование: версии сервисов       - 01:12:43

Разные версии сервисов могут работать с одной и той же БД
![mikroservise-19](/11-microservices-02-principles/Files/mikroservice-19.png)

### 35API Gateway     - 01:13:30
Подход, позволяющий предоставить единую точку входа для всех клиентов системы, построенной на принципах микросервисной архитектуры
![mikroservise-20](/11-microservices-02-principles/Files/mikroservice-20.png)

### 36Backend for frontend       - 01:15:10
Это три разных APIGateway
![mikroservise-21](/11-microservices-02-principles/Files/mikroservice-21.png)

### 37Выводы
- Не используйте интеграцию через общую базу данных
- Начинайте с REST для request/response интеграций
- оркестрация  предпочтительнее чем Хореография
- Избегайте обратно несовместимых изменений и
необходимости версионировать эндпоинты

### 38Двенадцать факторов      - 01:19:15

### 39Двенадцать факторов
Читать тут: https://12factor.net/ru/


I. Кодовая база
Одна кодовая база, отслеживаемая в системе контроля версий, –
множество развёртываний
II. Зависимости
Явно объявляйте и изолируйте зависимости
III. Конфигурация
Сохраняйте конфигурацию в среде выполнения
IV. Сторонние службы (Backing Services)
Считайте сторонние службы (backing services) подключаемыми
ресурсами
V. Сборка, релиз, выполнение
Строго разделяйте стадии сборки и выполнения
VI. Процессы
Запускайте приложение как один или несколько процессов не
сохраняющих внутреннее состояние (stateless)
VII. Привязка портов (Port binding)
Экспортируйте сервисы через привязку портов
VIII. Параллелизм
Масштабируйте приложение с помощью процессов
IX. Утилизируемость (Disposability)
Максимизируйте надёжность с помощью быстрого запуска и
корректного завершения работы
X. Паритет разработки/работы приложения
Держите окружения разработки, промежуточного развёртывания
(staging) и рабочего развёртывания (production) максимально похожими
XI. Журналирование (Logs)
Рассматривайте журнал как поток событий
XII. Задачи администрирования
Выполняйте задачи администрирования/управления с помощью разовых
процессов

### 43Итоги
- Разобрались с вариантами разбиения системы на сервисы
- Узнали какие бывают варианты организации взаимодействия
между сервисами
- Познакомились с принципами создания независимых
приложений

### 44Домашнее задание
Давайте посмотрим ваше домашнее задание.
- Вопросы по домашней работе задавайте в чате мессенджера Slack.
- Задачи можно сдавать по частям.
- Зачёт по домашней работе проставляется после того, как приняты
все задачи.

### 45Задавайте вопросы и
пишите отзыв о лекции!
Михаил Триполитов
Михаил Триполитов
