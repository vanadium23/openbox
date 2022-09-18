---
{"dg-publish":true,"date":"2022-06-06T09:04:28+03:00","modified_at":"2022-08-10T08:56:24+03:00","permalink":"/python/","dgHomeLink":false,"dgPassFrontmatter":true}
---


> "Python is a second best language for all" (c) don't know

Язык программирования разработанный Гвидо ван Россумом в качестве ответа на запрос простоты яыка в среде математиков.
Хорош исходя из описание для всего, но в первую очередь используется в качестве языка для [[backend|backend]] разработки, для [[machine learning|machine learning]] и для написания [[cli|cli]] утилит.

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

Удаление кеша от CPython:

```shell
find . -type f -name "*.py[co]" -delete
find . -type d -name "__pycache__" -delete
```

## Сниппеты

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