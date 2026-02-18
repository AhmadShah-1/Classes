'''
Linear search for linked lists works the same as for arrays. A list of unsorted values are traversed from the head node until 
the node with the specific value is found. Time complexity is O(n).

Binary search is not possible for linked lists because the algorithm is based on jumping directly to different array elements, 
and that is not possible with linked lists.

Sorting algorithms have the same time complexities as for arrays, and these are explained earlier in this tutorial. But remember, 
sorting algorithms that are based on directly accessing an array element based on an index, do not work on linked lists.



'''



def traverseAndPrint(head):
  currentNode = head
  while currentNode:
    print(currentNode.data, end=" -> ")
    currentNode = currentNode.next
  print("null")


# Find the Lowest Value in a Linked List
class Node:
  def __init__(self, data):
    self.data = data
    self.next = None

def findLowestValue(head):
  minValue = head.data
  currentNode = head.next
  while currentNode:
    if currentNode.data < minValue:
      minValue = currentNode.data
    currentNode = currentNode.next
  return minValue

node1 = Node(7)
node2 = Node(11)
node3 = Node(3)
node4 = Node(2)
node5 = Node(9)
node1.next = node2
node2.next = node3
node3.next = node4
node4.next = node5
print("The lowest value in the linked list is:", findLowestValue(node1))


# Delete a Node in a linked list
def delete_node_at_index(head, delete1):
    if head == delete1:
        return head.next

    current = head
    while current.next and current.next != delete1:
        current = current.next

    if current.next == None:
        return head

    current.next = current.next.next
    return head


# Insert a Node into a linked list
def insert_node_at_index(head, node, position):
    if position == 0:
        node.next = head
        return node

    current = head  
    for _ in range(position - 1):
        if current == None:
            return head
        current = current.next

    if current == None:
        return head

    moved = current.next
    current.next = node
    node.next = moved

    return head


node1 = Node(7)
node2 = Node(3)
node3 = Node(2)
node4 = Node(9)
node1.next = node2
node2.next = node3
node3.next = node4

print("Original list:")
traverseAndPrint(node1)

# Insert a new node with value 97 at position 2
newNode = Node(97)
node1 = insert_node_at_index(node1, newNode, 2)

print("\nAfter insertion:")
traverseAndPrint(node1)












# Reverse a Linked List
def reverse_list(head):
  prev = None
  curr = head
  while curr:
    next_node = curr.next
    curr.next = prev
    prev = curr
    curr = next_node

  return prev



# Swap Every other pair
def swapPairs(head):
  dummy = head.next
  curr = head
  prev = None
  
  while curr and curr.next:
    second = curr.next
    third = curr.next.next

    second.next = curr
    curr.next = third

    if prev:
      prev.next = second

    prev = curr
    curr = third

  return dummy


# Example usage
node1 = Node(7)
node2 = Node(3)
node3 = Node(2)
node4 = Node(9)
node1.next = node2
node2.next = node3
node3.next = node4

print("Original list:")
traverseAndPrint(node1)

new_head = swapPairs(node1)

print("After swapping pairssss:")
traverseAndPrint(new_head)