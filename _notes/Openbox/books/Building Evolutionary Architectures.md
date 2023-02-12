---
{"status":"Waiting","dg-publish":true,"up":[["Books"]],"title":"Building Evolutionary Architectures","category":"book","tags":["books"],"rating":3,"date":"2022-08-29T11:04:30+04:00","modified_at":"2023-01-03T12:11:28+04:00","permalink":"/books/building-evolutionary-architectures/","dgPassFrontmatter":true}
---




Книга рассказывает о построение эволюционной [[архитектура сервиса|архитектуры сервиса]]. Под эволюционной архитектурой подразумевается способность к адаптации при внешних изменений. Для этого вводиться понятие [[202209031505|фитнес функции]] по аналогии с генетическими алгоритмами. Для выбора верных фитнес функций архитектор должен определиться со списком возможностей/потребностей/-ilites сервиса - [[202209071935]].

В книге всячески пытаются привести к мысле, что микросервисы наше всё, а вот монолит рано или поздно развалиться. Происходит это потому что количество требований к сервису возрастут, а большое количество требований приведёт к конфликтам. Конфликты будут в любом случае, но вопрос в их количестве.

Для [[декомпозиция монолита]] необходимо правильно соотнести для каких целей мы это делаем, и какие характеристики должны получить в конце. Перед тем, как приступать к этой задаче, стоит улучшить разделение на модули внутри монолита.

## Цитаты

- [[202209022221|202209022221]]: Architects must determine the most important -ilities.
- [[202209022226|202209022226]]: Place changeability into the architecture
- [[202209022228|202209022228]]: Capability of evolutionary architecture
- [[202209022229|202209022229]]: Incremental change divide in build and deploy
- [[202209022232|202209022232]]: Boundaries depends on the purpose of the discussion.
- [[202209022234|202209022234]]: Common dimensions that affect evolvability
- [[202209022238|202209022238]]: Conway law on architectural goals
- [[202209031505|202209031505]]: An architectural fitness function
- [[202209031506|202209031506]]: System is the product of the interactions
- [[202209031514|202209031514]]: Fitness function categories
- [[202209031515|202209031515]]: A fitness function review
- [[202209032145|202209032145]]: Version Services Internally
- [[202209032147|202209032147]]: 2D diagram need to be specific
- [[202209032149|202209032149]]: Unit test for architecture violations
- [[202209032153|202209032153]]: QA in Production with feature toggles
- [[202209032200|202209032200]]: Discover conflicts early for better decisions
- [[202209052221|202209052221]]: Before restructuring, try to improve modularization
- [[202209052223|202209052223]]: The microkernel architecture
- [[202209071935|202209071935]]: The list of -ilities
- [[202209161031|202209161031]]: Old data schema couples to the past
- [[202209181540|202209181540]]: Adding evolvability to existing architectures depends on three factors
- [[202209181542|202209181542]]: Architectural verification as fitness functions
- [[202209181625|202209181625]]: Finding the correct service granularity is key for decomposing.
- [[202209181637|202209181637]]: Remove feature flags aggressively
- [[202212041703|202212041703]]: Architecture tends toward always adding, never removing, or decommissioning.
- [[202212050948|202212050948]]: Always fully understand at least one abstraction layer below
- [[202212061755|202212061755]]: When coupling points impede evolution, break by forking or duplication
- [[202212061800|202212061800]]: Different stacks to avoid coupling
- [[202212270911|202212270911]]: Need less layer between running code and developer
- [[202301021531|202301021531]]: Culture questions from architect
- [[202301021535|202301021535]]: Spike and stabilize
- [[202301021552|202301021552]]: Ecosystems changes companies in established industries


## Задачи

- [x] #task Обработать все выдержки из книги в рамках Zettels ✅ 2023-01-03
- [ ] #task Написать выдержку из книги
- [ ] #task Доработать свои заметки на основе идей из книг
