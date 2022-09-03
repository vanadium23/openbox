---
layout: page
title: Курсы
id: courses
permalink: /courses/
---

# Курсы

{% assign courses = site.notes | where_exp:"item","item.tags contains 'courses'" | sort: 'modified_at' | reverse %}
{% for note in courses %}
- <span>{{ note.modified_at | date: "%Y-%m-%d" }}</span>&nbsp;<a href="{{ note.url | absolute_url }}">{{ note.title }}</a>
{% endfor %}
