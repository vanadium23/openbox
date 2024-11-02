---
{"title":"linked list","dg-publish":true,"date":"2021-09-23T08:57:26+03:00","modified_at":"2023-01-27T17:51:11+04:00","permalink":"/linked-list/","dgPassFrontmatter":true}
---


Связные списки - это одна из самых базовых [[data structures|структур данных]], которую можно придумать в [[programming]]. Суть её заключается в том, что мы имеем узлы, в которых хранится значение, а ещё ссылки на другие элементы из списка. Списки бывают односвязные (мы знаем только следующий элемент) и двусвязные (мы знаем предыдущий и следующий элемент). Как правило, можно сделать интерпретацию массива в список и наоборот. При этом массив имеет O(1) скорость доступа к нужному элементу, а в списке O(n). Правда, список мы можем расширять сколько угодно по памяти, а массив выделяется.

```go
struct ListNode {
    Val int
    Next *ListNode
}
```

Для частичных оптимизаций делают ещё одну структуру, которая позволяет держаться длину и начало/конец списка.
```go
struct LinkedList {
   Head *ListNode
   Length int
}
```

## Типичные операции над связными списками

Удаление элемента из односвязного списка:
```go
element.Val = element.Next.Val
element.Next = element.Next.Next
```

Разворот односвязного списка:
```go
prev = nil
current = head
for current != nil {
    next := current.Next
    current.Next = prev
    prev = current
    current = next
}
```

Периодически для того, чтобы найти циклы или как-то обойти быстрее по списку применяют технику двойных указателей:
```python
class Solution:
    def hasCycle(self, head: ListNode) -> bool:
        if head is None:
            return False
        slow = head
        fast = head.next
        while slow != fast:
            if fast is None or fast.next is None:
                return False
            slow = slow.next
            fast = fast.next.next
        return True
```


Найти k-ый элемент с конца списка:
```
ListNode slow, fast;
slow = fast = head;
while (k > 0) {
    fast = fast.next;
    k--;
}

while (fast != null) {
    slow = slow.next;
    fast = fast.next;
}
return slow;
```

Найти ноду с которой начинается пересечение двух одновязных списков. Алгоритм строиться на том, что если мы дошли до конца, то мы должны с другой ветки начать и тогда рано или поздно математика сойдётся потому они оба пройдут буть в 2*(a+b+c).
```
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func getIntersectionNode(headA, headB *ListNode) *ListNode { 
    curA := headA
    curB := headB
    
    for curA != curB {
        if curA == nil {
            curA = headB
        } else {
            curA = curA.Next
        }
        if curB == nil {
            curB = headA
        } else {
            curB = curB.Next
        }
    }
    
    return curA
}
```

Удалить Nth элемент с конца:
```
func removeNthFromEnd(head *ListNode, n int) *ListNode {
	dummy := &ListNode{Val: 0, Next: head}
	current := dummy
    tailer := dummy
    i := -1
    
    for tailer != nil {
        tailer = tailer.Next
        if i == n {
            current = current.Next
        } else {
            i++
        }
    }
    
	current.Next = current.Next.Next
	return dummy.Next
}
```

It is similar to what we have learned in an array. But it can be trickier and error-prone. There are several things you should pay attention:
1. Always examine if the node is null before you call the next field.

Getting the next node of a null node will cause the null-pointer error. For example, before we run fast = fast.next.next, we need to examine both fast and fast.next is not null.
2. Carefully define the end conditions of your loop.

Run several examples to make sure your end conditions will not result in an endless loop. And you have to take our first tip into consideration when you define your end conditions.



## Источники

- [Reverse a linked list](https://github.com/labuladong/fucking-algorithm/blob/english/data_structure/reverse_part_of_a_linked_list_via_recursion.md)
- [Double pointer](https://github.com/labuladong/fucking-algorithm/blob/english/think_like_computer/double_pointer.md)
- [[Education Leetcode Easy Interview Questions]]
