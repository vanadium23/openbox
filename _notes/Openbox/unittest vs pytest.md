---
{"dg-publish":true,"date":"2022-07-04T21:38:20+03:00","modified_at":"2022-07-19T08:55:44+03:00","permalink":"/unittest-vs-pytest/","dgHomeLink":false,"dgPassFrontmatter":true}
---


В [[python]] есть несколько библиотек для написания тестов. Двумя наиболее популярными являются pytest и unittest [1]. При этом pytest в популярности сильно превосходит стандартную библиотеку, но имеет ряд минусов.

Минусы pytest:
1. Подход [фикстур](https://docs.pytest.org/en/6.2.x/fixture.html#back-to-fixtures) с неявной передачей через аргументы функции. Это вызывает проблему с поиском фикстуры: IDE/LSP - не подхватывает аргументы как импорты, а сами фикстуры могут быть размазаны по десяткам файлам.
2. Использование декораторов для добавление нового поведения. Это происходит из-за того, что предполагается использование функций в качестве тестов.
3. Неявное переопределение assert'ов, что не всегда соответствует ожидаемому поведению. Чтобы уточнить поведения всё равно требуется использовать дополнительные функции вида `pytest.approx`. [2]

Плюсы pytest:
- Более подробные ответы в случае ошибок на тестах.
- Возможность распараллеливания тестов.

Когда стоит использовать pytest?
1. При разработки с помощью асинхронных фреймворков. В pytest есть готовый набор фикстур для работы с event loop и короутинами по аналогии с синхронными функциями.

**TL;DR: В большинстве случаев unittest будет достаточным для решения повседневных задач.**


[1]: https://lp.jetbrains.com/python-developers-survey-2021/#FrameworksLibraries
[2]: https://github.com/pytest-dev/pytest/issues/4736
