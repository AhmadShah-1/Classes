---
source_lecture: Lecture 1.md
class: AAI551_EngineeringProgrammingPython
topics:
  - Overview of Python
  - Basic Syntax and Structure
  - Data Types and Variables
  - Control Structures
  - Functions and Modules
  - Error Handling
  - Basic Input/Output
generated: true
model: 'openai:gpt-4o-mini'
---
# Introduction to Engineering Programming with Python

## Overview of Topics Covered
1. Overview of Python
2. Basic Syntax and Structure
3. Data Types and Variables
4. Control Structures
5. Functions and Modules
6. Error Handling
7. Basic Input/Output

## Detailed Walkthrough

### 1. Overview of Python
- **Python** is a high-level programming language known for its readability and simplicity. It is widely used in engineering, data analysis, artificial intelligence, and web development.

### 2. Basic Syntax and Structure
- Python uses indentation to define blocks of code. This is different from many other programming languages that use braces `{}`.
- A simple print statement in Python can be written as:
  ```python
  print("Hello, World!")
  ```

### 3. Data Types and Variables
- Python has several built-in data types:
  - **Integers**: Whole numbers, e.g., `x = 5`
  - **Floats**: Decimal numbers, e.g., `y = 3.14`
  - **Strings**: Text data, e.g., `name = "Alice"`
  - **Booleans**: True or False values, e.g., `is_valid = True`
  
- Variables in Python do not require explicit declaration. They are created when a value is assigned.

### 4. Control Structures
- Control structures allow for decision-making in code:
  - **If Statements**:
    ```python
    if x > 10:
        print("x is greater than 10")
    elif x < 10:
        print("x is less than 10")
    else:
        print("x is equal to 10")
    ```
  - **For Loops**:
    ```python
    for i in range(5):
        print(i)
    ```
  - **While Loops**:
    ```python
    while x < 10:
        x += 1
    ```

### 5. Functions and Modules
- Functions are defined using the `def` keyword:
  ```python
  def greet(name):
      return f"Hello, {name}!"
  ```
- Modules allow for code organization and reuse. You can import a module using:
  ```python
  import math
  ```

### 6. Error Handling
- Python uses `try` and `except` blocks to handle errors gracefully:
  ```python
  try:
      result = 10 / 0
  except ZeroDivisionError:
      print("You cannot divide by zero!")
  ```

### 7. Basic Input/Output
- Input can be taken from the user using the `input()` function:
  ```python
  user_input = input("Enter your name: ")
  print(f"Hello, {user_input}!")
  ```

## Summary of Main Points
- Python is a versatile programming language suitable for various applications.
- Understanding basic syntax, data types, control structures, functions, and error handling is crucial for effective programming in Python.
- Input and output operations are fundamental for interacting with users.

## Practice Problems
1. Write a Python program that takes two numbers as input and prints their sum.
2. Create a function that checks if a number is even or odd.
3. Implement a loop that prints all numbers from 1 to 100 that are divisible by 3.
