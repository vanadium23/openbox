---
{"dg-publish":true,"date":"2023-01-27T17:40:44+04:00","modified_at":"2023-01-27T17:48:31+04:00","permalink":"/django/","dgPassFrontmatter":true}
---


Один из web-фреймворков на [[python]]. Отличается тем, что внутри есть всё для типичного сайта: авторизация, админка, работа с путями и шаблонами. Дополнительно можно обвесить [[drf]] или [[celery]]. 

Основная документация лежит на сайте [docs djangoproject](https://docs.djangoproject.com/).

## ORM

Типичные CRUD операции можно выполнять с помощью встроенного ORMa, но переход на сырой SQL потом требует много вложений. Начиная где-то с версии 2.х, авторы решили переносить все возможность SQL в ORM: https://docs.djangoproject.com/en/4.1/ref/models/expressions/.

Из наиболее используемого, теперь можно фильтровать prefetch на уровне запроса, а не цикла:

```python
from django.db.models import Prefetch
vegetarian_pizzas = Pizza.objects.filter(vegetarian=True)
Restaurant.objects.prefetch_related(
        Prefetch('pizzas', to_attr='menu'),
        Prefetch('pizzas', queryset=vegetarian_pizzas, to_attr='vegetarian_menu'))
```
