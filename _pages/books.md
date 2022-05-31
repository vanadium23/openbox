---
layout: page
title: Книги
id: books
permalink: /books/
---

# Книги

{% assign latest_quotes = site.notes | where_exp:"item","item.category contains 'book'" | sort: 'modified_at' | reverse %}
{% for note in latest_quotes limit:15 %}
- <span>{{ note.modified_at | date: "%Y-%m-%d" }}</span>&nbsp;<a href="{{ note.url | absolute_url }}">{{ note.title }}</a>
{% endfor %}
