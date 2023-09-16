---
{"dg-publish":true,"up":"[[Books]]","title":"A Philosophy of Software Design","category":"book","status":"Completed","tags":["books"],"rating":5,"date":"2023-04-22","modified_at":"2023-09-16T11:36:45+03:00","dg-path":"/books/A Philosophy of Software Design.md","permalink":"/books/a-philosophy-of-software-design/","dgPassFrontmatter":true}
---




Книга посвящена созданию хорошего дизайна при разработке программного обеспечения. В основе лежит два списка правил:
1. как делать хорошо
2. как понять, что сделано плохо

Проще начать с описания того, что считается плохим кодом: это связанная паста из кода, которая не имеет чёткой зоны ответственности и документации. В связи с чем использование кода приводит к трудностям к получению результата. Для того, чтобы выявить такой код можно ознакомиться со списком [[Openbox/quotes/202305310928\|красных флагов]]. И тут принципиально ничего нового по сравнению с остальными книгами вида "Clean Code", "Refactoring" и так далее ничего нового не привноситься.

А вот как писать хорошо - здесь уже появляются новые мысли. Полный список принципов можно глянуть [[Openbox/quotes/202305310927\|здесь]], но я бы хотел остановится на главной концепции: Shallow vs Deep modules. Под shallow модулем будем понимать такой модуль, интерфейс которого широк, а вот реализация прямолинейна и проста. В таких модулях происходит нарушение сразу нескольких принципов: это и плохое [[разделение отвественности\|разделение отвественности]], и высокая [[сплочённость\|сплочённость]], а так же отсутствие [[скрытие информации\|скрытие информации]]. И дальше мы выходим на критику стандартного правила про "не больше N строчек на функцию". Ведь именно разделение на простые прямолинейные куски может привести к появлению таких модулей. В книге же наоборот подразумевается, что хороший модуль имеет простой интерфейс и сложную реализацию. Именно за счёт этого мы можем собирать более сложный код, как кубики к этим абстракциям, которые скрывают за собой информацию и сложность.

Отдельно хочется отметить главы про документацию и комментарии к коду. В них раскрывается тема, что документация должна находится как можно ближе к коду, чтобы можно было обновлять её синхронно. А так же что комментарий по отношению к коду, такая же абстракция как код над процессами. Это наводит нас на практику [[Readme Driven Development\|Readme Driven Development]], только через код.

Стоит отметить тот факт, что все приложенные принципы требует большого времени на подготовительном этапе разработки. Прежде чем приходить к добавлению функциональности нужно задумать о том, нужна ли она нам. Сколько лишних возможностей она введёт или она будет изолированно и сделана в единственном роде. Это всё будет проходить на стадии до написания кода, и даже занимать больше времени, чем сбор всех требований.

Так же видны некоторые пересечения в том, что все возможные правила к автоматизации должны быть автоматизированы. И это напоминает идею фитнес функций из [[Openbox/books/Building Evolutionary Architectures\|Building Evolutionary Architectures]]. 

Наверное, лучшая книга по [[Openbox/competencies/software engineering\|software engineering]] на данный момент.

## Цитаты

- [[Openbox/quotes/202305090925\|202305090925]]: recognize code more complicated than needs to be
- [[Openbox/quotes/202305090936\|202305090936]]: recognize complexity is a crucial design skill
- [[Openbox/quotes/202305090937\|202305090937]]: practical definition of complexity
- [[Openbox/quotes/202305090951\|202305090951]]: cognitive load is how much you need to know in prior
- [[Openbox/quotes/202305090957\|202305090957]]: unknown unknowns are the worst
- [[Openbox/quotes/202305100914\|202305100914]]: complexity accumulates rapidly, but hard to eliminate
- [[Openbox/quotes/202305100922\|202305100922]]: to manage deps you introduce interface
- [[Openbox/quotes/202305100923\|202305100923]]: best modules are those whose interfaces are much simpler than their implementations
- [[Openbox/quotes/202305100927\|202305100927]]: deep and shallow modules
- [[Openbox/quotes/202305110916\|202305110916]]: information leakage
- [[Openbox/quotes/202305100932\|202305100932]]: shallow module
- [[Openbox/quotes/202305110925\|202305110925]]: information hiding and deep modules are closely related
- [[Openbox/quotes/202305120920\|202305120920]]: module needs simple interface, and not implementation
- [[Openbox/quotes/202305130845\|202305130845]]: indications that two pieces of code are related
- [[Openbox/quotes/202305131153\|202305131153]]: exceptions are part of interface
- [[Openbox/quotes/202305140921\|202305140921]]: comment is an abstraction to code
- [[Openbox/quotes/202305140913\|202305140913]]: design it twice
- [[Openbox/quotes/202305140924\|202305140924]]: comments capture information from designer mind
- [[Openbox/quotes/202305230914\|202305230914]]: comments can fill missing details
- [[Openbox/quotes/202305230925\|202305230925]]: Implementation Documentation Contaminates Interface
- [[Openbox/quotes/202305250826\|202305250826]]: bug about variable naming
- [[Openbox/quotes/202305250828\|202305250828]]: names are a form of abstraction
- [[Openbox/quotes/202305250836\|202305250836]]: comment driven development
- [[Openbox/quotes/202305300907\|202305300907]]: the design of a mature system is determined more by changes made during the system’s evolution
- [[Openbox/quotes/202305300909\|202305300909]]: comments close to code for transactional update
- [[Openbox/quotes/202305300912\|202305300912]]: enforce convention through automation
- [[Openbox/quotes/202305300913\|202305300913]]: When in Rome, do as the Romans do.
- [[Openbox/quotes/202305300918\|202305300918]]: increments of development should be abstractions
- [[Openbox/quotes/202305310916\|202305310916]]: expensive operations for today
- [[Openbox/quotes/202305310926\|202305310926]]: good designer spend more time in design phase
- [[Openbox/quotes/202305310927\|202305310927]]: the most important software design principles
- [[Openbox/quotes/202305310928\|202305310928]]: list of red flags in code


## Задачи

- [x] #task Обработать все выдержки из книги в рамках Zettels ⏳ 2023-08-09 ✅ 2023-08-11
- [x] #task Написать выдержку из книги ⏳ 2023-09-10 ✅ 2023-09-11
- [ ] #task Доработать свои заметки на основе идей из книг
