---
{"dg-publish":true,"date":"2023-05-25T10:21:54+04:00","modified_at":"2024-02-16T10:14:30+03:00","dg-path":"/tree structure.md","permalink":"/tree-structure/","dgPassFrontmatter":true}
---


Дерево - это частный вид [[Openbox/graph\|графа]], а именно связный и ацикличный. Благодаря этим свойствам, его можно использовать для решения задач поиска. Первый элемент называется корнем, узел без связей - листок.  

## Binary tree

Бинарное дерево - частный вид дерева, где у каждого узла не более двух потомков. Таким образом, такое дерево можно проходить кроме bfs и dfs, ещё тремя следующими способами:
- preorder - root, left, right
- inorder - left, root, right
- postorder - left, right, root

### Конструирование бинарного дерева из разных представлений

```python
def buildTree(preorder, inorder):
    if not preorder or not inorder:
        return None

    # The first element in preorder list is the root
    root = TreeNode(preorder[0])
    
    # Find the index of the root in inorder list
    mid = inorder.index(preorder[0])

    # Elements before `mid` in inorder list form the left subtree
    root.left = buildTree(preorder[1:mid+1], inorder[:mid])

    # Elements after `mid` in inorder list form the right subtree
    root.right = buildTree(preorder[mid+1:], inorder[mid+1:])

    return root
```

### Превращение дерева в [[Openbox/linked list\|linked list]]

```python
def flatten(root: TreeNode) -> None:
    # inplace
    # Handle the null scenario
    if not root:
        return None
    
    node = root
    while node:
        
        # If the node has a left child
        if node.left:
            
            # Find the rightmost node
            rightmost = node.left
            while rightmost.right:
                rightmost = rightmost.right
            
            # rewire the connections
            rightmost.right = node.right
            node.right = node.left
            node.left = None
        
        # move on to the right side of the tree
        node = node.right
```
