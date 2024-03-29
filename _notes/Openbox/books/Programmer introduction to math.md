---
{"dg-publish":true,"up":"[[Books]]","title":"programmer introduction to math","category":"book","status":"Discarded","tags":["books"],"rating":2,"date":"2023-01-14","modified_at":"2023-10-27T12:36:02+04:00","dg-path":"/books/Programmer introduction to math.md","permalink":"/books/programmer-introduction-to-math/","dgPassFrontmatter":true}
---




> [!error]
> В общем, я не справился с книжкой, хотя в начале было интересно сколько всего из математики перенеслось на реальный мир.

Полиномом называют только уравнение с целыми степенями и вещественными числами/real numbers в коэффициентах. Для любого набора из N точек, где нет одинаковых точек, можно найти уникальный N-1 полином, который через него будет проходить.

С помощью полиномов от двух переменных можно реализовать булеву логику:
- AND(x, y) = x\*y
- NOT(x) = 1 - x
- OR(x, y) = 1 - (1-x)(1-y) или NOT(NOT(x), NOT(y)) - похоже на правило де Моргана

Теорема Эйлера - если два числа a,n coprime/взаимнопростые, то остаток от деления для выражения a^fi(n) всегда равна единице. Где fi(n) - это функция всех взаимнопростых чисел для числа n > 1.

Забавный факт, что в математике используется такая короткая нотация для записи рвзных вещей, потому что мы ограничены школьной доской. То есть раньше была беда с размещением всей требуемой информации для полноты.

В главе про множества основной темой являлись стыки или как их принято называть в математике функции. Функции по отношению к двум множествам могут быть два важных свойства: инъекция (когда каждому члену х есть пара у), сурьекция (когда каждому члену у есть свой х). И если выполняются обо свойства, то называется биекцией. В случае биекции можем гарантировать наличие обратной функции, причём уникальной. Иногда решение задачки может быть в переходе от одного множества к другому, где ле мы уже знаем свойства. А для корректности перехода необходимо будет доказать свойство функции как инъекции или сурьекции.


## Цитаты

- [[Openbox/quotes/202307041000\|202307041000]]: every convention is a edge case
- [[Openbox/quotes/202307061454\|202307061454]]: math language to code conversion
- [[Openbox/quotes/202307061520\|202307061520]]: to understand definition write examples
- [[Openbox/quotes/202307101043\|202307101043]]: sets and functions are models for math
- [[Openbox/quotes/202307111012\|202307111012]]: anti-coordination problem
- [[Openbox/quotes/202308011018\|202308011018]]: definition of math proof


## Задачи

- [x] #task Обработать все выдержки из книги в рамках Zettels ✅ 2023-10-27
- [x] #task Написать выдержку из книги ✅ 2023-10-27
- [-] #task Доработать свои заметки на основе идей из книг ✅ 2023-10-27
