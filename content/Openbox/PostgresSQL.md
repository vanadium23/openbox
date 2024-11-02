---
{"dg-publish":true,"date":"2022-06-14T10:11:13+04:00","modified_at":"2024-02-07T09:42:19+03:00","dg-path":"/PostgresSQL.md","permalink":"/postgres-sql/","dgPassFrontmatter":true}
---



## Snippets

создание пользователя и базы:

```sql
create database mydb;
create user myuser with encrypted password 'mypass';
grant all privileges on database mydb to myuser;

-- если база данных уже была, то надо выдать ещё ко всем таблицам и sequence, не забыв сменить базу
\c mydb;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO my_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO my_user;

--- выдать доступ ко всем таблицам
GRANT SELECT ON ALL TABLES IN SCHEMA public TO user;

-- чтобы не добавлять каждый раз
ALTER DEFAULT PRIVILEGES
IN SCHEMA app
GRANT SELECT ON TABLES TO scraper;
ALTER DEFAULT PRIVILEGES
IN SCHEMA app
GRANT EXECUTE ON FUNCTIONS TO scraper;
```


## Общее устройство

MVCC

## Indexes

Цикл статей: https://habr.com/ru/company/postgrespro/blog/326096/

`Create index [concurrently] on table(field) [using gist]`

Индексы в PostgreSQL — специальные объекты базы данных, предназначенные в основном для ускорения доступа к данным. Это вспомогательные структуры: любой индекс можно удалить и восстановить заново по информации в таблице. Иногда приходится слышать, что СУБД может работать и без индексов, просто медленно. Однако это не так, ведь индексы служат также для поддержки некоторых ограничений целостности.
Нужно понимать, что за это мы платим скоростью вставки в таблицу.

* Index Scan: когда идёт поиск по совпадению поля
* Bitmap Index Scan: когда идёт поиск по нескольким значениям
    * Может дополнительно появится Recheck Condition, если битовая маска не влезает в work_mem
* Index **Only** Scan: когда данные, которые надо вернуть, есть полностью в индексе

Кроме индекса на поле в postgresql можно делать:
* составной (несколько полей) 
* функциональный (функция над полем или полями)
* частичный (фильтр условие)

Для создания индекса устанавливается exclusive lock, но моно создавать конкурентно и тогда запросы не блокируются, но при этом происходит два чтения таблицы.

Системная таблица pg_am предоставляет информацию о том, какие виды индексов и с какими свойствами доступны для использования. Подробее о системных каталогах можно прочитать тут: https://postgrespro.ru/docs/postgresql/9.6/catalogs.html

### Хэш-индекс

При вставке в индекс вычислим [хеш-функцию для ключа](https://git.postgresql.org/gitweb/?p=postgresql.git;a=blob;f=src/backend/access/hash/hashfunc.c;hb=HEAD). Хеш-функции в PostgreSQL всегда возвращают тип integer, что соответствует диапазону 232 ≈ 4 миллиарда значений. Число корзин изначально равно двум и увеличивается динамически, подстраиваясь под объем данных; номер корзины можно вычислить по хеш-коду с помощью битовой арифметики. В эту корзину и положим наш TID.

Заметим, что хеш-индекс не умеет уменьшаться в размере. Если удалить часть проиндексированных строк, однажды выделенные страницы уже не возвращаются операционной системе, а только переиспользуются для новых данных после очистки (VACUUM). Единственный вариант уменьшить физический размер индекса — перестроить его с нуля командой REINDEX или VACUUM FULL.

### Btree

Индекс btree, он же B-дерево, пригоден для данных, которые можно отсортировать. Иными словами, для типа данных должны быть определены операторы «больше», «больше или равно», «меньше», «меньше или равно» и «равно». Заметьте, что одни и те же данные иногда можно сортировать разными способами, что возвращает нас к концепции семейства операторов.

Как всегда, индексные записи B-дерева упакованы в страницы. В листовых страницах эти записи содержат индексируемые данные (ключи) и ссылки на строки таблицы (TID-ы); во внутренних страницах каждая запись ссылается на дочернюю страницу индекса и содержит минимальное значение ключа в этой странице.

B-деревья обладают несколькими важными свойствами:
* Они сбалансированы, то есть любую листовую страницу отделяет от корня одно и то же число внутренних страниц. Поэтому поиск любого значения занимает одинаковое время.
* Они сильно ветвисты, то есть каждая страница (как правило, 8 КБ) содержит сразу много (сотни) TID-ов. За счет этого глубина B-деревьев получается небольшой; на практике до 4–5 для очень больших таблиц.
* Данные в индексе упорядочены по неубыванию (как между страницами, так и внутри каждой страницы), а страницы одного уровня связаны между собой двунаправленным списком. Поэтому получить упорядоченный набор данных мы можем, просто проходя по списку в одну или в другую сторону, не возвращаясь каждый раз к корню.

### GiST

GiST — сокращение от «generalized search tree». Это сбалансированное дерево поиска, точно так же, как и рассмотренный ранее b-tree.

В чем же разница? Индекс b-tree жестко привязан к семантике сравнения: поддержка операторов «больше», «меньше», «равно» — это все, на что он способен (зато способен очень хорошо!). Но в современных базах хранятся и такие типы данных, для которых эти операторы просто не имеют смысла: геоданные, текстовые документы, картинки.
Кроме условия на вхождения интервалов, GiST можно использовать как исключающий индекс.

Пример использование: 
* R-дерево для точек на плоскости или интервалов.
* RD-дерево для полноценного поиска (Идея RD-деревьев в том, чтобы вместо ограничивающего прямоугольника взять ограничивающее множество — то есть множество, содержащее все элементы дочерних множеств.)

### SP-GiST

Вначале немного о названии. Слово «GiST» намекает на определенную схожесть с одноименным методом. Схожесть действительно есть: и тот, и другой — generalized search trees, обобщенные деревья поиска, предоставляющие каркас для построения разных методов доступа.

«SP» расшифровывается как space partitioning, разбиение пространства. В роли пространства часто выступает именно то, что мы и привыкли называть пространством — например, двумерная плоскость. Но, как мы увидим, имеется в виду любое пространство поиска, по сути произвольная область значений.

SP-GiST подходит для структур, в которых пространство рекурсивно разбивается на непересекающиеся области. В этот класс входят деревья квадрантов (quadtree), k-мерные деревья (k-D tree), префиксные деревья (trie).

### GIN

GIN расшифровывается как Generalized Inverted Index — это так называемый обратный индекс. Он работает с типами данных, значения которых не являются атомарными, а состоят из элементов. При этом индексируются не сами значения, а отдельные элементы; каждый элемент ссылается на те значения, в которых он встречается.

Таким образом, индекс GIN состоит из B-дерева элементов, к листовым записям которого привязаны B-деревья или плоские списки TID-ов.

#### GiST vs GIN
Для многих типов данных существуют классы операторов и для GiST, и для GIN, что вызывает вопрос: чем же пользоваться? Пожалуй, уже можно сделать какие-то выводы.

Как правило, GIN выигрывает в точности и скорости поиска у GiST. Если данные изменяются не часто, а искать надо быстро — скорее всего выбор падет на GIN.

С другой стороны, если данные изменяются активно, накладные расходы на обновление GIN могут оказаться слишком велики. В этом случае придется сравнивать оба варианта и выбирать тот, чьи показатели будут лучше сбалансированы.

### BRIN

В отличие от индексов, с которыми мы уже познакомились, идея BRIN не в том, чтобы быстро найти нужные строки, а в том, чтобы избежать просмотра заведомо ненужных. Это всегда неточный индекс: он вообще не содержит TID-ов табличных строк.
Работает это следующим образом. Таблица разбивается на зоны (range) размером в несколько страниц (или блоков, что то же самое) — отсюда и название: Block Range Index, BRIN. Для каждой зоны в индексе сохраняется сводная информация о данных в этой зоне. Как правило, это минимальное и максимальное значения, но бывает и иначе, как мы увидим дальше. Если при выполнении запроса, содержащего условие на столбец, искомые значения не попадают в диапазон, то всю зону можно смело пропускать; если же попадают — все строки во всех блоках зоны придется просмотреть и выбрать среди них подходящие.
При удалении строки… ничего не происходит. Можно заметить, что в каких-то случаях будет удалено минимальное или максимальное значение, и тогда диапазон можно было бы уменьшить. Но чтобы это определить, пришлось бы прочитать все значения в зоне, а это накладно.

### Bloom

Классический фильтр Блума — структура данных, позволяющая быстро проверить принадлежность элемента множеству. Фильтр очень компактен, но допускает ложные срабатывания: он имеет право ошибиться и счесть элемент принадлежащим множеству (false positive), но не имеет права сказать, что элемента нет в множестве, если на самом деле он там присутствует (false negative).

Фильтр представляет собой битовый массив (называемый также сигнатурой) длиной m бит, изначально заполненный нулями. Выбираются k различных хеш-функций, которые отображают любой элемент множества в k битов сигнатуры. Чтобы добавить элемент в множество, нужно установить в сигнатуре каждый из этих битов в единицу. Следовательно, если все соответствующие элементу биты установлены в единицу — элемент может присутствовать в множестве; если хотя бы один бит равен нулю — элемент точно отсутствует.

## Planner

### Hints

Since 9.2:
```
Increasing the length limit for a varchar or varbit column, or removing the limit altogether, no longer requires a table rewrite. Similarly, increasing the allowable precision of a numeric column, or changing a column from constrained numeric to unconstrained numeric, no longer requires a table rewrite. Table rewrites are also avoided in similar cases involving the interval, timestamp, and timestamptz types.
```

### PgStatistics

This table (pg_statistic) is, of course, described [the docs](http://www.postgresql.org/docs/current/interactive/catalog-pg-statistic.html). But it is pretty cryptic. Of course, you can find very precise explanation in [sources](http://git.postgresql.org/gitweb/?p=postgresql.git;a=blob;f=src/include/catalog/pg_statistic.h), but that's not (usually) best solution.

## Explain

### Bitmap index scan

Let's assume your table has 100000 pages (that would be ~ 780MB). Bitmap Index Scan would create a bitmap where there would be one bit for every page in your table. So in this case, we'd get memory block of 100,000 bits ~ 12.5kB. All these bits would be set to 0. Then Bitmap Index Scan, would set some bits to 1, depending on which page in table might contain row that should be returned.

### Sort

While it is simple, it has some cool logic inside. For starters – if memory used for sorting would be more than work_mem, it will switch to using disk based sorting. In explain this is written in sort method.

### HashAggregate

HashAggregate does something like this: for every row it gets, it finds GROUP BY “key" (in this case relkind). Then, in hash (associative array, dictionary), puts given row into bucket designated by given key. Now, if you understand it, you should see potential problem: well, what about case when there are millions of rows? The hash will be too big to fit in memory. And here, again, we'll be using work_mem. If generated hash is too big, it will “spill" to disk (again in the $PGDATA/base/pgsql_tmp).

### Hash join

It works like this – first Hash Join calls “Hash", which in turns calls something else (Seq Scan on pg_namespace in our case). Then, Hash makes a memory (or disk, depending on size) hash/associative-array/dictionary with rows from the source, hashed using whatever is used to join the data (in our case, it's OID column in pg_namespace).

### Nested Loop

So, the processing looks like this:
1. Nested Loop runs one side of join, once. Let's name it “A".
2. For every row in “A", it runs second operation (let's name it “B")
3. if “B" didn't return any rows – data from “A" is ignored
4. if “B" did return rows, for every row it returned, new row is returned by Nested Loop, based on current row from A, and current row from B

### Merge Join

The procedure looks like this:
1. if join column on right side is the same as join column on left side:
    - return new joined row, based on current rows on the right and left sides
    - get next row from right side (or, if there are no more rows, on left side)
    - go to step 1
2. if join column on right side is “smaller" than join column on left side:
    - get next row from right side (if there are no more rows, finish processing)
    - go to step 1
3. if join column on right side is “larger" than join column on left side:
	- get next row from left side (if there are no more rows, finish processing)
	- go to step 1

### Materialize

Long story short – Materialize gets data from underlying operation and stores it in memory (or partially in memory) so that it can be used faster, or with additional features that underlying operation doesn't provide.

### Unique

Removes non-unique data from sorted rows.

### Append

Just concatinate plans, when union is used

### GroupAggregate

Similar to HashAggregate but on set of columns(n).

### HashSetOp

This operation is used by INTERSECT/EXCEPT operations (with optional “ALL" modifier).

### CTE Scan

Same as Materialize, but for window function.



## Источники

- Серия expain analyze: [1](https://www.depesz.com/2013/04/16/explaining-the-unexplainable/), [2](https://www.depesz.com/2013/04/27/explaining-the-unexplainable-part-2/), [3](https://www.depesz.com/2013/05/09/explaining-the-unexplainable-part-3/), [4](https://www.depesz.com/2013/05/19/explaining-the-unexplainable-part-4/), [5](https://www.depesz.com/2013/05/30/explaining-the-unexplainable-part-5/).
- https://gist.github.com/cpursley/c8fb81fe8a7e5df038158bdfe0f06dbb
- 
