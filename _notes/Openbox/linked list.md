---
{"title":"linked list","dg-publish":true,"date":"2021-09-23T08:57:26+03:00","modified_at":"2023-01-27T17:51:11+04:00","alias":"linked list","permalink":"/linked-list/","dgPassFrontmatter":true}
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

## Представление

<style>
.container {font-family: sans-serif; text-align: center;}
.button-wrapper button {z-index: 1;height: 40px; width: 100px; margin: 10px;padding: 5px;}
.excalidraw .App-menu_top .buttonList { display: flex;}
.excalidraw-wrapper { height: 800px; margin: 50px; position: relative;}
:root[dir="ltr"] .excalidraw .layer-ui__wrapper .zen-mode-transition.App-menu_bottom--transition-left {transform: none;}
</style><script src="https://unpkg.com/react@17/umd/react.production.min.js"></script><script src="https://unpkg.com/react-dom@17/umd/react-dom.production.min.js"></script><script type="text/javascript" src="https://unpkg.com/@excalidraw/excalidraw@0.12.0/dist/excalidraw.production.min.js"></script><div id="linked_listexcalidraw.md1"></div><script>(function(){const InitialData={"type":"excalidraw","version":2,"source":"https://excalidraw.com","elements":[{"id":"6U-mh75DSDJgFoOjbjCGE","type":"rectangle","x":-340.25,"y":-260.5,"width":193,"height":58,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":1243713440,"version":216,"versionNonce":1622922848,"isDeleted":false,"boundElements":[{"type":"arrow","id":"VCqQYWrGlHZ7aQA8kCklz"},{"type":"arrow","id":"rCYA7N-w9J9-tet5P4JAh"}]},{"id":"uHXZiBt12w87OeBKbmDt3","type":"rectangle","x":27.25,"y":-263.5,"width":193,"height":58,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":2147092384,"version":249,"versionNonce":1685911136,"isDeleted":false,"boundElements":[{"type":"arrow","id":"VCqQYWrGlHZ7aQA8kCklz"},{"type":"arrow","id":"NWlED4Obl-7lGrEgbaBUG"},{"type":"arrow","id":"eQCuGUw8fx7SRVy2iyuTG"}]},{"id":"VCqQYWrGlHZ7aQA8kCklz","type":"arrow","x":-142.25,"y":-228.45046928026306,"width":166.5,"height":1.7805700341832562,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":1493981088,"version":447,"versionNonce":1084000,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[166.5,-1.7805700341832562]],"lastCommittedPoint":null,"startBinding":{"elementId":"6U-mh75DSDJgFoOjbjCGE","focus":0.1238619948054741,"gap":5},"endBinding":{"elementId":"uHXZiBt12w87OeBKbmDt3","focus":-0.10671611042439236,"gap":3},"startArrowhead":null,"endArrowhead":"arrow"},{"id":"rCYA7N-w9J9-tet5P4JAh","type":"arrow","x":-219.74267603145225,"y":-318.5,"width":26.477798225468092,"height":52.8322826039539,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":1736755808,"version":456,"versionNonce":1394603616,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[-26.477798225468092,52.8322826039539]],"lastCommittedPoint":null,"startBinding":{"elementId":"AVDTR0qT","focus":0.25942890607434366,"gap":2},"endBinding":{"elementId":"6U-mh75DSDJgFoOjbjCGE","focus":-0.1764705882352944,"gap":5.167717396046044},"startArrowhead":null,"endArrowhead":"arrow"},{"id":"AVDTR0qT","type":"text","x":-228.25,"y":-345.5,"width":46,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":728737376,"version":149,"versionNonce":1249329760,"isDeleted":false,"text":"head","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"boundElements":[{"type":"arrow","id":"rCYA7N-w9J9-tet5P4JAh"}],"containerId":null,"rawText":"head","originalText":"head"},{"id":"CuiHjMdP","type":"text","x":141.75,"y":-371.5,"width":34,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":1053490784,"version":150,"versionNonce":716758944,"isDeleted":false,"text":"tail","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"boundElements":[{"type":"arrow","id":"eQCuGUw8fx7SRVy2iyuTG"}],"containerId":null,"rawText":"tail","originalText":"tail"},{"id":"eQCuGUw8fx7SRVy2iyuTG","type":"arrow","x":133.84095066785812,"y":-347.8203118205071,"width":56.26283836364746,"height":77.12934837341311,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":792402528,"version":433,"versionNonce":9713248,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[-56.26283836364746,77.12934837341311]],"lastCommittedPoint":null,"startBinding":{"elementId":"CuiHjMdP","focus":0.6414632713838976,"gap":7.909049332141876},"endBinding":{"elementId":"uHXZiBt12w87OeBKbmDt3","focus":-0.6168218108695366,"gap":7.190963447093964},"startArrowhead":null,"endArrowhead":"arrow"},{"id":"ijpm8Gqt","type":"text","x":-274.25,"y":-244.5,"width":71,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":47852128,"version":206,"versionNonce":553563040,"isDeleted":false,"boundElementIds":null,"text":"element","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"containerId":null,"rawText":"element","originalText":"element"},{"id":"7oggRpZ3","type":"text","x":82.25,"y":-245,"width":71,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":1567375264,"version":299,"versionNonce":139226016,"isDeleted":false,"boundElementIds":null,"text":"element","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"containerId":null,"rawText":"element","originalText":"element"},{"id":"EU0_6hwB42hkRl7MTGeqd","type":"rectangle","x":-361.25,"y":-424.5,"width":693,"height":244,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":330108512,"version":303,"versionNonce":1743868832,"isDeleted":false,"boundElementIds":null},{"id":"YjENpHoM","type":"text","x":-104.25,"y":-459.5,"width":112,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":1646739360,"version":68,"versionNonce":7172704,"isDeleted":false,"boundElementIds":null,"text":"single linked","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"containerId":null,"rawText":"single linked","originalText":"single linked"},{"id":"WAKZmc4pwWyZc9v9vTMQN","type":"rectangle","x":-350.75,"y":51,"width":193,"height":58,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":1483768416,"version":322,"versionNonce":1860603488,"isDeleted":false,"boundElements":[{"type":"arrow","id":"d-yYhMq6WpihGUrbHwt_x"},{"type":"arrow","id":"K1YycpmI0D1Bd4OPeYENH"},{"type":"arrow","id":"xXquA0Gq0tdhTM-3eEvWm"}]},{"id":"1f6Hq9Y5cXguONp_I54by","type":"rectangle","x":16.75,"y":48,"width":193,"height":58,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":110580640,"version":355,"versionNonce":1093720672,"isDeleted":false,"boundElements":[{"type":"arrow","id":"d-yYhMq6WpihGUrbHwt_x"},{"type":"arrow","id":"NWlED4Obl-7lGrEgbaBUG"},{"type":"arrow","id":"CxM1rbr5qVh3uHeXIBrWC"},{"type":"arrow","id":"xXquA0Gq0tdhTM-3eEvWm"}]},{"id":"d-yYhMq6WpihGUrbHwt_x","type":"arrow","x":-152.75,"y":83.04953071973694,"width":166.5,"height":1.7805700341832562,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":1341208160,"version":756,"versionNonce":1690169248,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[166.5,-1.7805700341832562]],"lastCommittedPoint":null,"startBinding":{"elementId":"WAKZmc4pwWyZc9v9vTMQN","focus":0.13768599484297273,"gap":5},"endBinding":{"elementId":"1f6Hq9Y5cXguONp_I54by","focus":-0.10671611042439247,"gap":3},"startArrowhead":null,"endArrowhead":"arrow"},{"id":"K1YycpmI0D1Bd4OPeYENH","type":"arrow","x":-230.24267603145222,"y":-7,"width":26.477798225468092,"height":52.8322826039539,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":1269555104,"version":765,"versionNonce":410945440,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[-26.477798225468092,52.8322826039539]],"lastCommittedPoint":null,"startBinding":{"elementId":"i3pTyX2K","focus":0.24691118514196642,"gap":2},"endBinding":{"elementId":"WAKZmc4pwWyZc9v9vTMQN","focus":-0.17647058823529432,"gap":5.1677173960461005},"startArrowhead":null,"endArrowhead":"arrow"},{"id":"i3pTyX2K","type":"text","x":-238.75,"y":-34,"width":46,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":2101045856,"version":253,"versionNonce":1469582944,"isDeleted":false,"text":"head","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"boundElements":[{"type":"arrow","id":"K1YycpmI0D1Bd4OPeYENH"}],"containerId":null,"rawText":"head","originalText":"head"},{"id":"9PtmFCkl","type":"text","x":131.25,"y":-60,"width":34,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":374270880,"version":254,"versionNonce":686814816,"isDeleted":false,"text":"tail","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"boundElements":[{"type":"arrow","id":"CxM1rbr5qVh3uHeXIBrWC"}],"containerId":null,"rawText":"tail","originalText":"tail"},{"id":"CxM1rbr5qVh3uHeXIBrWC","type":"arrow","x":123.34095066785812,"y":-36.32031182050707,"width":56.26283836364746,"height":77.12934837341311,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":1797201504,"version":742,"versionNonce":385425312,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[-56.26283836364746,77.12934837341311]],"lastCommittedPoint":null,"startBinding":{"elementId":"9PtmFCkl","focus":0.6414632713838976,"gap":7.909049332141876},"endBinding":{"elementId":"1f6Hq9Y5cXguONp_I54by","focus":-0.6168218108695366,"gap":7.190963447093964},"startArrowhead":null,"endArrowhead":"arrow"},{"id":"5inLkElT","type":"text","x":-284.75,"y":67,"width":71,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":816871328,"version":308,"versionNonce":1194445728,"isDeleted":false,"boundElementIds":null,"text":"element","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"containerId":null,"rawText":"element","originalText":"element"},{"id":"jnkshGbW","type":"text","x":71.75,"y":66.5,"width":71,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":1248612960,"version":401,"versionNonce":1448754784,"isDeleted":false,"boundElementIds":null,"text":"element","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"containerId":null,"rawText":"element","originalText":"element"},{"id":"d4AvGHfNDOdcwON8oZi5S","type":"rectangle","x":-371.75,"y":-113,"width":693,"height":244,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":520127392,"version":405,"versionNonce":37181344,"isDeleted":false,"boundElementIds":null},{"id":"jWClB9FQ","type":"text","x":-114.75,"y":-148,"width":121,"height":25,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"dotted","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"sharp","seed":838010464,"version":176,"versionNonce":4848224,"isDeleted":false,"boundElementIds":null,"text":"double linked","fontSize":20,"fontFamily":1,"textAlign":"left","verticalAlign":"top","baseline":18,"containerId":null,"rawText":"double linked","originalText":"double linked"},{"id":"xXquA0Gq0tdhTM-3eEvWm","type":"arrow","x":12.75,"y":94.5,"width":167,"height":2,"angle":0,"strokeColor":"#000000","backgroundColor":"transparent","fillStyle":"hachure","strokeWidth":1,"strokeStyle":"solid","roughness":1,"opacity":100,"groupIds":[],"strokeSharpness":"round","seed":769371744,"version":48,"versionNonce":1129842592,"isDeleted":false,"boundElementIds":null,"points":[[0,0],[-167,2]],"lastCommittedPoint":null,"startBinding":{"elementId":"1f6Hq9Y5cXguONp_I54by","focus":-0.5404090548054011,"gap":4},"endBinding":{"elementId":"WAKZmc4pwWyZc9v9vTMQN","focus":0.5868745035742653,"gap":3.5},"startArrowhead":null,"endArrowhead":"arrow"}],"appState":{"theme":"light","viewBackgroundColor":"#ffffff"},"files":{}};InitialData.scrollToContent=true;App=()=>{const e=React.useRef(null),t=React.useRef(null),[n,i]=React.useState({width:void 0,height:void 0});return React.useEffect(()=>{i({width:t.current.getBoundingClientRect().width,height:t.current.getBoundingClientRect().height});const e=()=>{i({width:t.current.getBoundingClientRect().width,height:t.current.getBoundingClientRect().height})};return window.addEventListener("resize",e),()=>window.removeEventListener("resize",e)},[t]),React.createElement(React.Fragment,null,React.createElement("div",{className:"excalidraw-wrapper",ref:t},React.createElement(ExcalidrawLib.Excalidraw,{ref:e,width:n.width,height:n.height,initialData:InitialData,viewModeEnabled:!0,zenModeEnabled:!0,gridModeEnabled:!1})))},excalidrawWrapper=document.getElementById("linked_listexcalidraw.md1");ReactDOM.render(React.createElement(App),excalidrawWrapper);})();</script>

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
