---
{"dg-publish":true,"date":"2023-06-07T15:10:10+03:00","modified_at":"2023-06-19T17:51:41+03:00","dg-path":"/software/obsidian-templater.md","permalink":"/software/obsidian-templater/","dgPassFrontmatter":true}
---


Templater - это продвинутые шаблоны для [[Openbox/software/obsidian\|obsidian]]. Ключевое отличия следующие:
1. расширенный функционал встроенных переменных
2. возможность написания js внутри шаблона
3. возможность писать свои функции на js

## Мои пользовательские скрипты

Очистка имени файла - [скрипт](https://gist.github.com/vanadium23/70d3645d424f7792f9bd68aacc0d86b0).

```js
let filename = 'Some file: with colons';
filename = tp.user.sanitaze_filename(filename);
tp.file.rename(filename);
```

Переместить файл при создании (команда `create new note from template`) - [скрипт](https://gist.github.com/vanadium23/ed65f9190a3c1037edc0dc4c6d12660e).

```js
const filename = await tp.user.move_new_file(tp.file, "Path/to/folder", tp);
```
