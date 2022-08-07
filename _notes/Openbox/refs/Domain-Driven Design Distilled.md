---
{"dg-publish":true,"up":[["Books"]],"tags":["books/inbox"],"category":"book","rating":3,"modified_at":"2022-08-07T12:20:28+03:00","date":"2022-05-03T12:57:45+03:00","permalink":"/refs/domain-driven-design-distilled/","dgHomeLink":false,"dgPassFrontmatter":true}
---




[[понимать предметную область|понимать предметную область]] - необходимый навык для построения [[архитектура сервиса|архитектура сервиса]]. Для описания предметной области существует разные подходы и одним из них является [[domain driven design|domain driven design]], изначально изложенный Крисом Эвансом в книге 2003 года. Как и с книгой "Design Patterns", в книге были заложено много хороший подходов, при избыточном использовании которых, можно получить плохо расширяемую кодовую базу.

Книгу можно мысленно поделить на три части:
1. как структурировать информацию? (_прим._ частично пересекается с [[How to make sense of any mess|How to make sense of any mess]], которую читал в это же время)
2. какие есть способы взаимодействия сервисов?
3. как подойти к созданию структуры в уже имеющемся процессе?

Для структурирования информации необходимо выработать общий словарь. Правда, перед созданием общего словаря стоит договориться о [[понятийный минимум|понятийный минимум]]. В книге речь идёт о минимуме необходимом в рамках концепции [[domain driven design|domain driven design]]:
- Domain Expert
- Ubitiquous Language
- Bounded Context
    - Context mapping
- Domain
    - Sub-domain
        - Core
        - Generic
        - Supportive
- Models
    - Event
    - Aggregate
    - View

Чтобы быстрее получить новые знания в рамках этого подхода можно воспользоваться подходом [[event storming|event storming]].

## Quotes

- [[202205081256|202205081256]]: Don't limit Domain to nouns
- [[202205081303|202205081303]]: Innovation does not end, when maintenance begins.
- [[202205081312|202205081312]]: Subdomain must be within one Domain
- [[202205081318|202205081318]]: Признаки Big Ball of Mud
- [[202205081322|202205081322]]: Avoid Integration Train Wrecks
- [[202205291022|202205291022]]: Aggregate forms a transactional consistency boundary
- [[202205291024|202205291024]]: Aggregate Rules of Thumb
- [[202205291040|202205291040]]: Difference between command and event
- [[202205291041|202205291041]]: Time based event need naming
- [[202205291220|202205291220]]: Estimate tasks based on component type


## Tasks

- [x] #task Обработать все выдержки из книги из quotes. 📅 2022-06-01 ✅ 2022-06-01
- [x] #task Написать выдержку из книги. 📅 2022-06-05 ✅ 2022-06-07
- [x] #task Отредактировать выдержку в большее количество информации. 📅 2022-08-07 ✅ 2022-08-07
- [ ] #task Подумать над основными мыслями, которые я достал из книги.
