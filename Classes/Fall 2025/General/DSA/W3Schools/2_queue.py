'''
Queue = First in First Out FIFO

The first person to stand in line is also the first who can pay and leave the supermarket.

Basic operations we can do on a queue are:
Enqueue: Adds a new element to the queue.
Dequeue: Removes and returns the first (front) element from the queue.
Peek: Returns the first element in the queue.
isEmpty: Checks if the queue is empty.
Size: Finds the number of elements in the queue.
Queues can be implemented by using arrays or linked lists.



Reasons for using linked lists to implement queues:
Dynamic size: The queue can grow and shrink dynamically, unlike with arrays.
No shifting: The front element of the queue can be removed (enqueue) without having to shift other elements in the memory.

Reasons for not using linked lists to implement queues:
Extra memory: Each queue element must contain the address to the next element (the next linked list node).
Readability: The code might be harder to read and write for some because it is longer and more complex.

'''


class Node:
    def __init__(self, value):
        self.value = value
        self.next = None

class Queue:
    def __init__(self):
        self.front = None
        self.back = None
        self.length = 0

    def enqueue(self, element):
        new_node = Node(element)
        if self.back is None:
            self.front = self.back = new_node
            self.length += 1
            return

        self.back.next = new_node
        self.back = new_node
        self.length += 1

    def peek(self):
        if self.isEmpty():
            return "Empty Queue"
        print(self.front.value)

    def isEmpty(self):
        return self.length == 0

    def dequeue(self):
        if self.isEmpty():
            return "Empty Qeueu"

        temp = self.front
        self.front = self.front.next
        self.length -= 1

        if self.front is None:
            self.back = None

        return temp.value

    def size(self):
        return self.length

    def printQueue(self):
        hold_pos = self.front
        while hold_pos != None:
            print(hold_pos.value)
            hold_pos = hold_pos.next



# Create a queue
myQueue = Queue()

myQueue.enqueue('A')
myQueue.enqueue('B')
myQueue.enqueue('C')

print("Queue: ", end="")
myQueue.printQueue()
print("Peek: ", myQueue.peek())
print("Dequeue: ", myQueue.dequeue())
print("Queue after Dequeue: ", end="")
myQueue.printQueue()
print("isEmpty: ", myQueue.isEmpty())
print("Size: ", myQueue.size())
