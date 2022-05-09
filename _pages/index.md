---
layout: page
title: Крышка
id: home
permalink: /
---

# Открытый ящик Чернова

Вы находитесь на главной странице моего [[цифровой архив|цифрового архива]]. Здесь собраны материалы из интернетов и упакованы в формат [[Digital Garden]]. Можно подробнее почитать [[o причинах ведения архива]].

## Последние обновления

{% assign latest_notes = site.notes | sort: 'last_modified_at' | reverse %}
{% for note in latest_notes limit:5 %}
- <a href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
{% endfor %}

---

## Граф заметок

{% include notes_graph.html %}
