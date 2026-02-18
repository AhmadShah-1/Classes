# Q7
x = 1
L = []
while x:
    if x % 2 == 0:
        L.append(x)
    else:
        L.append("abc")
    x = x - 1
    print(L)  # Expected: ['abc']
