---
{"dg-publish":true,"date":"2024-08-13T14:11:38+03:00","modified_at":"2024-08-13T14:25:34+03:00","dg-path":"/component based decomposition.md","permalink":"/component-based-decomposition/","dgPassFrontmatter":true}
---


Способ для [[Openbox/декомпозиция монолита|декомпозиции монолита]] на основе текущей кодовой базы. Был предложен Нилом Фордом в книге [[Openbox/books/Software Architecture  the Hard Parts|Software Architecture  the Hard Parts]]. 

Общие шаги выделена на картинке:
![Pasted image 20240813141446.png](/openbox/assets/img/Pasted%20image%2020240813141446.png)


Для выявление размера компонентов используется подход с подсчётом операций/statements вместо строк кодов или символов. Дальше мы находим выбросы с помощью трёх стандартных отклонений. Здесь стоит дальше закопаться в том, что обычно в таких компонентах и есть проблема с логикой.


> [!NOTE] 
> Операции/statements - хороший переход, потому что они являются логической единицей в рамках представления кода.

Дальше мы ищем общие куски между разными компонентами и начинаем их выносить на уровень выше. Важно, что мы строим дерево этих компонентов так, чтобы только в узлах был код, а в промежутках кода было минимально или вообще не было.

Так как мы укрупнили наши компоненты, то поиск связей между ними будет идти легче. Нам не требуется находить все связи 1-1 к одному, скорее связи между приложениями первого/второго уровня. Это ответит нам на вопрос о доменных связях.

Собственно, дальше уже перепроверка через [[Openbox/domain driven design|domain driven design]] и разбитие на сервисы.