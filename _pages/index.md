---
layout: page
title: Крышка
id: home
permalink: /
---

# Открытый ящик Чернова

Вы находитесь на главной странице моего [[цифровой архив|цифрового архива]]. Здесь собраны материалы из интернетов и упакованы в формат [[Digital Garden]]. Можно подробнее почитать [[o причинах ведения архива]].

## Последние обновления

{% assign latest_notes = site.notes | sort: 'modified_at' | reverse %}
{% for note in latest_notes limit:15 %}
- <a href="{{ note.url | absolute_url }}">{{ note.title }}</a>
{% endfor %}
