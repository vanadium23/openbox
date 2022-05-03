---
layout: page
title: Крышка
id: home
permalink: /
---

# Открытый ящик Чернова

Вы находитесь на главной странице моего [[цифровой архив|цифрового архива]]. Здесь собраны материалы из интернетов и упакованы в формат [[Digital Garden]].

## Последние обновления

{% for note in site.notes limit:5 %}
- <a href="{{ note.url }}">{{ note.title }}</a>
{% endfor %}

---

## Граф заметок

{% include notes_graph.html %}
