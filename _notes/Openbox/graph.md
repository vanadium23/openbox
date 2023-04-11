---
{"dg-publish":true,"date":"2023-02-18T09:57:29+04:00","modified_at":"2023-02-18T10:08:12+04:00","alias":["граф"],"permalink":"/graph/","dgPassFrontmatter":true}
---


Граф - структура данных, в которой есть вершины и рёбра, которые их соединяют. Граф подразделяют с помощью разных видов ребёр:
- наличие направления - направленные / ненаправленный
    - отдельно стоят графы с циклами и без циклов (DAGs)
- наличие весов на рёбрах

Типовые действия над графом:
- Найти несвязные подграфы. Решается с помощью disjoint set.
- Обойти весь граф в глубину (сначала один путь до конца) или в ширину (нарезая как бы по уровням).
- Найти кратчайшее расстояние между двумя вершинами. Здесь помогает алгоритм Дийкстры, алгоритм Bellman Ford и A*.
- Отсортировать граф топологически. Звучит сложно, но факту это составить дерево зависимостей или убедиться что это нельзя сделать из-за цикла.

## Где потренироваться

- [[Leetcode Detailed Graph]]