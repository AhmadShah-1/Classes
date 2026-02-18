'''
Stack = Last in First Out LIFO


'''



# You can use a stack with a python list:
stack = []

# Replicates Push
stack.append('A')
stack.append('B')

# Replicates Pop
top_item = stack.pop()
print(top_item)

# Replicates Peek
top_item = stack[-1]
print(top_item)

# Replicates isEmpty
if not stack:
    print("Stack is empty")
else:
    print("Stack is not empty")






# You can also create a dedicated stack class
class Stack:
    def __init__(self):
        self.stack = []

    def push(self, item):
        self.stack.append(item)

    def pop(self):
        if self.isEmpty():
            return "Stack is empty"

        return self.stack.pop()

    def peek(self):
        if self.isEmpty():
            return "Stack is empty"

    def isEmpty(self):
        return len(self.stack) == 0

    def size(self):
        return len(self.stack)
    

myStack = Stack()

myStack.push('A')
myStack.push('B')

print(myStack.peek())
print(myStack.pop())
print(myStack.size())
print(myStack.isEmpty())



i = input('ss')
# We can also use a stack with a linked list 
'''
Elements, or nodes, can be inserted or deleted in constant time, no shifting operations in memory needed.
But you cannot access an element in the middle of the stack without traversing the entire stack.
'''

class Node:
    def __init__(self, value):
        self.value = value
        self.next = None

class Stack:
    def __init__(self):
        self.head = None
        self.size = 0

    def push(self, value):
        new_node = Node(value)
        if self.head:
            new_node.next = self.head
    
        self.head = new_node
        self.size += 1

    def isEmpty(self):
        return self.size == 0

    def peek(self):
        if self.isEmpty():
            return "Stack is empty"
        return self.head.value
        
    def pop(self):
        if self.isEmpty():
            return "Stack is empty"

        popped_node = self.head
        self.head = self.head.next
        self.size -= 1
        return popped_node.value

    def stackSize(self):
        return self.size

    def traverseAndPrint(self):
        current = self.head
        while current != None:
            read = current.value
            print(read)
            current = current.next


            

        
myStack = Stack()
myStack.push('A')
myStack.push('B')
myStack.push('C')

print("LinkedList: ", end="")
myStack.traverseAndPrint()

'''
print("Peek: ", myStack.peek())
print("Pop: ", myStack.pop())
print("LinkedList after Pop: ", end="")
myStack.traverseAndPrint()
print("isEmpty: ", myStack.isEmpty())
print("Size: ", myStack.stackSize())

'''




