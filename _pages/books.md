---
layout: page
title: Книги
id: books
permalink: /books/
---

# Книги

Пояснение по emoji статусам:
- ✅ - прочитал и есть выдержка
- 🏗️ - пишу выдержку
- ❌ - не дочитал
- ⏳ - читаю

Рейтинг строиться от 1 до 5 на основе заметки [[система оценок]]. 

{% assign books = site.notes | where_exp:"item","item.category contains 'book'" | sort: 'date' | reverse %}
<table>
<thead>
    <tr>
        <th>Книга</th>
        <th>Статус</th>
        <th>Рейтинг</th>
    </tr>
</thead>
<tbody>
{% for note in books %}
<tr>
    <td><a href="{{ note.url | absolute_url }}"> {{ note.title }}</a></td>
    <td>{% case note.status %}{% when "Completed" %}✅{% when "Discarded" %}❌{% when "Reviewing" %}🏗️{% else %}⏳
{% endcase %}</td>
    <td>{% case note.rating %}{% when 5 %}⭐⭐⭐⭐⭐{% when 4 %}⭐⭐⭐⭐{% when 3 %}⭐⭐⭐{% when 2 %}⭐⭐{% when 1 %}🏴{% endcase %}</td>
</tr>
{% endfor %}
</tbody>
</table>