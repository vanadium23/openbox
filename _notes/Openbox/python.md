---
{"toc":true,"dg-publish":true,"date":"2022-06-06T09:04:28+03:00","modified_at":"2023-08-02T16:03:12+03:00","dg-path":"/python.md","permalink":"/python/","dgPassFrontmatter":true}
---


> "Python is a second best language for all" (c) don't know

Язык программирования разработанный Гвидо ван Россумом в качестве ответа на запрос простоты яыка в среде математиков.
Хорош исходя из описание для всего, но в первую очередь используется в качестве языка для [[backend\|backend]] разработки, для [[Life/Education/competencies/machine learning\|machine learning]] и для написания [[cli\|cli]] утилит.

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

Удаление кеша от CPython, но лучше настроить себе [[Openbox/makefile\|makefile]]:

```shell
find . -type f -name "*.py[co]" -delete
find . -type d -name "__pycache__" -delete
```

## Сниппеты

Настройка логов в консоль для всего:
```python
import logging.config

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

Дебаг всех http запросов:
```python
import requests
import logging

# These two lines enable debugging at httplib level (requests->urllib3->http.client)
# You will see the REQUEST, including HEADERS and DATA, and RESPONSE with HEADERS but without DATA.
# The only thing missing will be the response.body which is not logged.
try:
    import http.client as http_client
except ImportError:
    # Python 2
    import httplib as http_client
http_client.HTTPConnection.debuglevel = 1

# You must initialize logging, otherwise you'll not see debug output.
logging.basicConfig()
logging.getLogger().setLevel(logging.DEBUG)
requests_log = logging.getLogger("requests.packages.urllib3")
requests_log.setLevel(logging.DEBUG)
requests_log.propagate = True

```

## Типовые структуры данных

- collections.defaultdict - словарь для которого устанавливаются дефолтные значения в случае отсутствия
- collections.deque - оптимизированная двухсторонная очередь (stack + queue)
- heapq.heapify - priority queue на основе хипа
