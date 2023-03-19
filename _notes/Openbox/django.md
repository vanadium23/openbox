---
{"dg-publish":true,"date":"2023-01-27T17:40:44+04:00","modified_at":"2023-03-19T10:02:44+04:00","title":"django","permalink":"/django/","dgPassFrontmatter":true}
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

## Админка

Добавить новый url в админку
```python
from django.contrib import admin
from django.template.response import TemplateResponse
from django.urls import path

class MyModelAdmin(admin.ModelAdmin):
    def get_urls(self):
        urls = super().get_urls()
        my_urls = [
            path('my_view/', self.admin_site.admin_view(self.my_view))
        ]
        return my_urls + urls

    def my_view(self, request):
        # ...
        context = dict(
           # Include common variables for rendering the admin template.
           self.admin_site.each_context(request),
           # Anything else you want in the context...
           key=value,
        )
        return TemplateResponse(request, "sometemplate.html", context)
```

## Переводы

Переводы в django сделаны с помощью библиотеки gnu gettext. С помощью команд `makemessages` собираются все переводы в файл `locale/{locale}/LC_MESSAGES/django.po`. Компания `compilemessages` генерируют из .po файлы .mo.

Для редактирования переводов в случае монолита удобно использоваться django-rosetta. В случае компании и нескольких проектов себя зарекомендовал weblate. Основная засада в том, как переводить сущности в базе. Есть modeltranslations, но масштабируется на десяток языков так себе.

>[!WARNING]
> При переезде дефолтного языка `settings.LANGUAGE_CODE` необходимо убедиться, что для старого языка есть файл переводов.
> 
