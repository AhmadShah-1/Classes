'''

A Hash Table is a data structure designed to be fast to work with.

The reason Hash Tables are sometimes preferred instead of arrays or linked lists is because searching for, adding, and deleting
data can be done really quickly, even for large amounts of data.

In a Linked List, finding a person "Bob" takes time because we would have to go from one node to the next, checking each node, 
until the node with "Bob" is found.

And finding "Bob" in an list/array could be fast if we knew the index, but when we only know the name "Bob", we need to compare 
each element and that takes time.

With a Hash Table however, finding "Bob" is done really fast because there is a way to go directly to where "Bob" is stored, 
using something called a hash function.

https://www.w3schools.com/python/python_dsa_hashtables.asp



Hash Tables Summarized
Hash Table elements are stored in storage containers called buckets.

A hash function takes the key of an element to generate a hash code.

The hash code says what bucket the element belongs to, so now we can go directly to that Hash Table element: to modify it, or to delete it, or just to check if it exists.

A collision happens when two Hash Table elements have the same hash code, because that means they belong to the same bucket.

Collision can be solved by Chaining by using lists to allow more than one element in the same bucket.


'''


