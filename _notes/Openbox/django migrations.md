---
{"dg-publish":true,"date":"2024-02-13T10:41:55+03:00","modified_at":"2024-02-13T10:42:17+03:00","dg-path":"/django migrations.md","permalink":"/django-migrations/","dgPassFrontmatter":true}
---


Для того, чтобы писать безопасные миграции в [[Openbox/django\|django]] достаточно придерживаться двух принципов:
1. обратная совместимость
2. отсутствие длительный эксклюзивных блокировок, то есть запрет на чтение данных

Обратная совместимость нам нужна, потому что наш процесс деплоя устроен таким образом, что во время применения миграций на проде живут контейнеры со старой версией. Таким образом, они могут обращаться к старой схеме данных. Или другим образом, если вы дропнули колонку, то мы можем лежать на проде.

Следующий важный критерий для безопасности миграций - понимать сколько данных будет изменено. Если речь идёт о маленькой таблице (<100_000 строк данных), то проблемы будут встречаться реже, а вот если таблица на порядок больше, то уже требуются костыли. Для удобства ревью миграций будет полезно указать сколько строк в продакшен базе будет изменено, нужна цифра достаточная чтобы понять порядок. 

Часть проблем идёт из механизма миграций Django, например: добавление поля с дефолтным значением делает следующую миграцию:
```sql
ALTER TABLE example ADD column TEXT DEFAULT "default";
ALTER TABLE example ALTER column DROP DEFAUT;
```
То есть джанга удаляет дефолтное значение из базы и подставляет его только из кода. Из-за этого старый код не может вставить строчку в таблицу, потому что нарушается `NOT NULL`. Правда, эта проблему можно решить или через библиотеку [django-add-default-value](https://pypi.org/project/django-add-default-value/), а в django 5.0 писать [правильные миграции](https://docs.djangoproject.com/en/dev/releases/5.0/#database-computed-default-values).   

Хорошая миграция - та, которая проходит быстро, и скоро мы это автоматизируем с помощью: `set statement timeout`.

### Таблица операций

|Операция |Безопасность |Комментарий|
|:--|:--:|:--|
|ADD table |✅ |Желательно делать одной миграцией в рамках задачи.|
|ADD nullable field|✅ |Нужно понимать, что в бизнес логике появляется ветвление на null. Если она не требуется, смотри секцию "как писать сложные изменения".|
|ADD field with default|⚠️|Да, но только через SeparateStateAndDatabase, чтобы дефолт был на уровне базы. |
|ALTER field NOT NULL |⚠️|Да, но только для маленьких таблиц. Для больших таблиц делаем через CHECK CONSTRAINT. |
|CREATE INDEX|⚠️ |Да, но для больших таблиц надо делать через CONCURRENTLY.|
|ADD CONSTRAINT |⚠️ |Для больших таблиц добавляем NOT VALID, а потом делаем RECHECK.|
|DROP column|⚠️ |Да, но в несколько этапов.|
|DROP table|⚠️|Да, по аналогии с колонкой. И предварительно убедиться что есть бекапы. |
|ALTER field TYPE|❌ |Небезопасно, кроме нескольких случаев; но нам они не интересует.|
|RENAME field |❌ |Никогда не безопасно. |
|RENAME table|❌|Никогда не безопасно. |


### Как писать сложные изменения

#### SeparateStateAndDatabase

В django можно писать сырой SQL и указывать ему операцию. Это позволяет добавлять дефолтное значение в базе:
```python
migrations.RunSQL(
    "ALTER TABLE musician ADD COLUMN name varchar(255) DEFAULT 'Ivan' NOT NULL;",
    state_operations=[
        migrations.AddField(
            "musician",
            "name",
            models.CharField(max_length=255, default="Ivan"),
        ),
    ],
)
```

#### Non atomic migrations

В случае изменение большого количества данных (UPDATE, INDEX, CONTRAINT) стоит делать неатомарными миграциями. Для этого ставим `atomic = False`, и **сами** начинаем транзакцию:
```python
def gen_uuid(apps, schema_editor):
    MyModel = apps.get_model("myapp", "MyModel")
    while MyModel.objects.filter(uuid__isnull=True).exists():
        with transaction.atomic():
            for row in MyModel.objects.filter(uuid__isnull=True)[:1000]:
                row.uuid = uuid.uuid4()
                row.save()

class Migration(migrations.Migration):
    atomic = False

    operations = [
        migrations.RunPython(code=gen_uuid, reverse_code=migrations.RunPython.noop),
    ]
```

Если идёт много UPDATE и допустимо их обновлять в фоне, то можно сделать once_ комманду.

#### Удаление старых колонок

Основная проблема в том, чтобы старый код перестал читать колонку. Поэтому нам будет необходимо разделить изменение модели и применение миграции. Общий алгоритм такой:
1. удаляем колонку из модели, убеждаемся что по коду она нигде не используется и создаём MR
    * **важно!** если колонка not null, то надо сначала её сделать nullable.
1. мёржим MR и деплоим в прод
    * в этот момент у нас будут warning на django check, так как не все миграции будут в коде
1. создаём миграцию с удалением колонки, создаём MR, деплоим ветку, убеждаемся что мастер параллельно не сломался
1. мёржим MR и деплоим в прод
    * в этот момент все линтеры должны стать зелёными


## Источники

- https://github.com/3YOURMIND/django-migration-linter/blob/main/docs/incompatibilities.md
- https://docs.djangoproject.com/en/4.2/ref/migration-operations/#django.db.migrations.operations.SeparateDatabaseAndState
- https://github.com/tbicr/django-pg-zero-downtime-migrations#django-migrations-hacks
- https://gist.github.com/majackson/493c3d6d4476914ca9da63f84247407b
- https://yowcon.com/sydney-2022/sessions/2373/migrations-the-hardest-actual-problem-in-computer-science
- https://medium.com/3yourmind/keeping-django-database-migrations-backward-compatible-727820260dbb
- https://www.citusdata.com/blog/2018/02/15/when-postgresql-blocks/
