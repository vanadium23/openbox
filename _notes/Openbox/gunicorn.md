---
{"dg-publish":true,"date":"2024-03-28T15:43:19+03:00","modified_at":"2024-05-30T12:07:27+03:00","dg-path":"/gunicorn.md","permalink":"/gunicorn/","dgPassFrontmatter":true}
---


Gunicorn - web сервер для [[Openbox/python\|python]] приложений, как правило, используется в связки с [[Openbox/django\|django]]. У него WSGI интерфейс, поэтому с asyncio не работает (работает через uvicorn воркер). Сейчас в статусе unmaintained, но security патчи завозят. Хорош тем, что просто как пробка.

Типовая конфигурация:
```python
import psycogreen.gevent

# https://github.com/psycopg/psycogreen/blob/39a258cb4040b88b60a7600f6942e651a28db9a7/README.rst#module-psycogreengevent
psycogreen.gevent.patch_psycopg()

import os
import multiprocessing

default_worker_count = multiprocessing.cpu_count() * 2 + 1

# https://docs.gunicorn.org/en/stable/settings.html
backlog = int(os.getenv("GUNICORN_BACKLOG", "2048"))
workers = int(os.getenv("GUNICORN_WORKERS", default_worker_count))
worker_class = os.getenv("GUNICORN_WORKER_CLASS", "gevent")
worker_connections = int(os.getenv("GUNICORN_WORKER_CONNECTIONS", "50"))
timeout = int(os.getenv("GUNICORN_TIMEOUT", "300"))
keepalive = int(os.getenv("GUNICORN_KEEPALIVE", "2"))
threads = int(os.getenv("GUNICORN_THREADS", "1"))
max_requests = int(os.getenv("GUNICORN_MAX_REQUESTS", "2000"))
max_requests_jitter = int(os.getenv("GUNICORN_MAX_REQUESTS_JITTER", "1000"))
graceful_timeout = int(os.getenv("GUNICORN_GRACEFUL_TIMEOUT", "30"))

errorlog = "-"
loglevel = os.getenv("GUNICORN_LOG_LEVEL", "info")
accesslog = "-"
access_log_format = (
    f'{{"message": "%(r)s", "status": %(s)s, '
    f'"length": "%(b)s", "referer": "%(f)s", "user_agent": "%(a)s", '
    f'"time": %(L)s, "date": "%(t)s"}}'
)
```

Что точно стоит ставить:
* accesslog в `-`, чтобы шли в stdout
* max_requests - чтобы был перезапуск гуникорн от утечек памяти
