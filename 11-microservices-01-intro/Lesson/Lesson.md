# Ход выполнения ДЗ к занятию "11.01 Введение в микросервисы"

## Задача 1: Интернет Магазин

Руководство крупного интернет магазина у которого постоянно растёт пользовательская база и количество заказов рассматривает возможность переделки своей внутренней ИТ системы на основе микросервисов. 

Вас пригласили в качестве консультанта для оценки целесообразности перехода на микросервисную архитектуру. 

Опишите какие выгоды может получить компания от перехода на микросервисную архитектуру и какие проблемы необходимо будет решить в первую очередь.


**Ответ:**
* Основная цель должна быть в увеличении автономности команд разработки и ускорения доставки
* Разделить всю предметную область на составные части ### 11Bounded Context        - 00:27:45 из лекции 2.
  - Витрина
  - Цены
  - Корзина
  - Заказы
  - Склад
  - Доставка
* Имея такое измерение можно использовать границы контекста как границы сервисов
* Хороший вариант - это начать делить на сервисы, выделяя каждый ограниченный контекст
* Могут быть причины для того, чтобы делить на более мелкие сервисы для того, чтобы решить ту или иную задачу.
* Выбор способа интеграции - один из наиважнейших аспектов в успехе построения системы, основанной на микросервисной архитектуре
* Нужна система для бестрой интеграции, поставки ПО и быстрой установки ПО

1. Разделим процесс работы нашего магазиныа на конктрентые бизнес-задачи
2. Определить структуру организации
3. Будем использовать какой-нибудь один стэк технологий (Язык программирования, например)
4. Определить какой из сервисов чаще вызывается, какой больше испытывает нагрузку

Во избежание увеличения проблем не использовать микросервисную архитектуру, если:
5. Есть ручное тестирование
6. Есть ручная выкладка
7. Есть высокая сложность кода
8. Есть большой технический долг

9. Есть ли команда, которая будет разрабатывать и поддерживать микросервисы
10. Нужно чтобы каждое ограничение контекста описывал один сервис
11. Какой будет тип межсервисного взаиможействия - синхронное или асинхронное
12. Оркестрация или хореография
13. Какие протоколы внутренние для межсервисного взаимодействия
14. Какие протоколы для взаимодействия с клиентами
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
