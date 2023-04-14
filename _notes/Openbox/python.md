---
{"dg-publish":true,"date":"2022-06-06T09:04:28+03:00","modified_at":"2023-04-14T10:19:06+04:00","permalink":"/python/","dgPassFrontmatter":true}
---


> "Python is a second best language for all" (c) don't know

Язык программирования разработанный Гвидо ван Россумом в качестве ответа на запрос простоты яыка в среде математиков.
Хорош исходя из описание для всего, но в первую очередь используется в качестве языка для [[backend]] разработки, для [[machine learning]] и для написания [[cli]] утилит.

## Менеджмент зависимостей

```shell
python -m venv .venv # создание виртуальной среды
# с помощью pip
pip install lib
pip freeze > requirements.txt
# с помощью pip-tools
echo lib >> requirements.in
pip-compile -o requirements.txt requirements.in
pip install -r requirements.txt
# дописать poetry
```

## Полезности

Удаление кеша от CPython, но лучше настроить себе [[makefile#Python]]:

```shell
find . -type f -name "*.py[co]" -delete
find . -type d -name "__pycache__" -delete
```

## Сниппеты

Настройка логов в консоль для всего:
```python
LOGGING = {
    "version": 1,
    "formatters": {
        "verbose": {
            "format": ("P%(process)d;%(levelname)s;%(asctime)s;%(module)s;%(message)s")
        }
    },
    "handlers": {"console": {"class": "logging.StreamHandler", "formatter": "verbose"}},
    "root": {"level": "DEBUG", "handlers": ["console"]},
}

logging.config.dictConfig(LOGGING)
```

Использование стека вместо рекурсии:
```python
work = [create_initial_work()]
while work:
    work_item = work.pop()
    result = process(work_item)
    if is_done(result):
        return result
    work.push(result.pieces[0])
    work.push(result.pieces[1])
```

Случайная строка:
```python
import random
import string

def get_random_string(length):
    # choose from all lowercase letter
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    return result_str
```

## Типовые структуры данных

- collections.defaultdict - словарь для которого устанавливаются дефолтные значения в случае отсутствия
- collections.deque - оптимизированная двухсторонная очередь (stack + queue)
- heapq.heapify - priority queue на основе хипа
