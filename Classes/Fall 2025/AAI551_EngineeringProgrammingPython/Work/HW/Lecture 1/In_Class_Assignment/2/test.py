'''
print("Provide two numbers to receive a sum")
number1 = int(input("Enter first number: \n"))
number2 = int(input("Enter second number: \n"))
sum = number1 + number2
print(f"The sum of {number1} and {number2} is {sum}")

'''

print("Provide two numbers to receive a sum")

while(True):
    number1 = input("Enter first number: \n")
    if number1.isdigit():
        break
    else:
        print("You entered a string, please enter a number")

while(True):
    number2 = input("Enter second number: \n")
    if number2.isdigit():
        break
    else:
        print("You entered a string, please enter a number")
        
sum = int(number1) + int(number2)
print(f"The sum of {number1} and {number2} is {sum}")



