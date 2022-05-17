---
layout: page
title: Debug times
id: debug
permalink: /debug
---

## Таблица заметок с датами

{% assign latest_notes = site.notes | sort: 'modified_at' | reverse %}
| title | date | modified_at | last_modified_at |
|-------|------|-------------|------------------|
{% for note in latest_notes limit:15 -%}
| <a href="{{ note.url | absolut_url }}">{{ note.title }}</a> | {{ note.date }} | {{ note.modified_at }} | {{ note.last_modified_at }} |
{% endfor %}
