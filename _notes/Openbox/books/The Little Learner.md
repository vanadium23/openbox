---
{"dg-publish":true,"up":"[[Books]]","title":"The Little Learner","category":"book","status":"Completed","tags":["books"],"rating":2,"date":"2023-02-20","modified_at":"2023-07-23T21:46:22+03:00","dg-path":"/books/The Little Learner.md","permalink":"/books/the-little-learner/","dgPassFrontmatter":true}
---




Кажется, что это будет книга без цитат. Она выполнена в режиме диалога между учителей и учеником. 

Первая глава посвящена языку Schemish (подмножество Racket / lisp). Рассказали про присвоение переменных, вызов функции и используют только рекурсию вместо циклов.

Вторая глава посвящена тензорам. В ней мы сначала говорим о линейной функции y = a\*x + b. А потом заворачиваем параметры в вектор. Вектор оказывается скаляром первого ранга, а нулевым рангом считаем обычные числа / скаляр. Для тензора мы утверждаем, что на одном уровне у нас всегда одинаковое количество элементов:
```
[ [ [1] [2] [3] ] [ [4] [5] [6] ] ]
```
У тензора есть два важных параметра - `rank` и `shape`.

Для того, чтобы провести линейную регрессию мы находим насколько далеко находятся наши точки от линейной функции с входными параметрами. А потом мы меняем параметры с помощью оценки относительной величины между увеличением ошибки и текущим значением параметров. 

Функция l2-loss из [[Openbox/quotes/202304101724\|202304101724]] принимает на вход функцию для того, чтобы быть независимой от размерности, которую мы пытаемся аппроксимировать.

Вся попытка заключается в том, чтобы разделить три вещи: входные и выходные координаты, функцию к которой приближаем и параметры этой функции. Параметры как правило прячут за греческую букву θ. А большой обозначают параметр функции для нахождения параметров - Θ.

Для того, чтобы точно попасть в наши координаты нам необходимо замедляться по мере достижения локального оптимума. Здесь лежит беда переобучения, которая была упомянута в [[Openbox/books/Верховный алгоритм\|Верховный алгоритм]]. Для этого мы используем дополнительные параметр со скоростью и коэффициентом, который обычно лежит в диапазоне от 0 до 1 и начинается с 0.9.

Вторая половина книги начала описывать подход к построению [[Openbox/нейронная сеть\|нейронных сетей]]. Основный блоком в нейронной сети является функция активации, которая раскладывается на набор включенных и выключенных линейный функций. Под включением и выключением мы понимаем, что в каком-то диапазоне абсцисс наша функция даёт константу. Такими функциями мы можем нарезать любой график. 

В дизайне нейронных сетей складываются три параметра: количество входных данных (т.е. размерность входящей матрицы), количество выходных данных и количество нейронов. При разработке стоит начинать с выхода, так как здесь мы уже поймём сколько нам надо взять на финальном этапе и дальше разворачивать это до входа. 

Вопрос в том, как заложить начальные веса. Здесь мы сталкиваемся с набором проблем:
1. веса не могут быть одинаковыми, иначе у нас получится так, что мы не сможем различить ответы, когда они пройдут через слои нейросети
2. веса не могут быть очень большими, потому что тогда они будут любой входящий сигнал приводить в шум
3. веса не могут быть очень маленькими, потому что тогда они потеряют совсем входящий параметр

Где-то в конце на обучение с помощью фильтров я уже начал теряться. Мне стало понятно, что нейрон это линейная функция и нелинейный фильтра, а это означает что нам надо найти когда какой нейрон включать и почему, но прям прикладной пример меня выбил из колеи. Не могу рекомендовать, чтобы это книжка была первой по [[Life/Education/competencies/machine learning\|machine learning]], [[Openbox/books/Верховный алгоритм\|Верховный алгоритм]] справляется с этой задачей лучше.

## Цитаты

- [[Openbox/quotes/202304021732\|202304021732]]: steps for recursive functions
- [[Openbox/quotes/202304101724\|202304101724]]: l2 loss on lisp
- [[Openbox/quotes/202304101732\|202304101732]]: the law of revision
- [[Openbox/quotes/202305150945\|202305150945]]: The Rule of Artificial Neurons
- [[Openbox/quotes/202305170956\|202305170956]]: neurons initialized randomly for diversity
- [[Openbox/quotes/202305161024\|202305161024]]: The Law of Dense Layers
- [[Openbox/quotes/202305170953\|202305170953]]: hyperparameters come from experimenting
- [[Openbox/quotes/202305180950\|202305180950]]: 20% of the data set reserved for testing
- [[Openbox/quotes/202305191315\|202305191315]]: The Law of Correlation
- [[Openbox/quotes/202305191319\|202305191319]]: The Law of Skip Connections
- [[Openbox/quotes/202305191324\|202305191324]]: attention-based networks


## Задачи

- [x] #task Обработать все выдержки из книги в рамках Zettels ⏳ 2023-07-22 ✅ 2023-07-23
- [x] #task Написать выдержку из книги ⏳ 2023-07-23 ✅ 2023-07-23
- [ ] #task Доработать свои заметки на основе идей из книг