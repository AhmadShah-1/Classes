---
source_lecture: Lecture 2.md
class: AAI551_EngineeringProgrammingPython
topics:
  - Python Basics
  - Data Types
  - Control Structures
  - Functions
  - Error Handling
  - File I/O
generated: true
model: 'openai:gpt-4o-mini'
---
# Lecture 2: Introduction to Python Programming Concepts

## Overview of Topics Covered
1. Python Basics
2. Data Types
3. Control Structures
4. Functions
5. Error Handling
6. File I/O

## Detailed Walkthrough

### 1. Python Basics
- **Key Terms and Definitions**:
  - **Python**: A high-level programming language known for its readability and simplicity.
  - **Interpreter**: A program that executes Python code line by line.

### 2. Data Types
- **Concepts and Principles**:
  - Python has several built-in data types, including:
    - **Integers**: Whole numbers (e.g., `5`, `-3`).
    - **Floats**: Decimal numbers (e.g., `3.14`, `-0.001`).
    - **Strings**: Sequences of characters (e.g., `"Hello, World!"`).
    - **Booleans**: Represents `True` or `False`.

- **Example**:
  ```python
  x = 5          # Integer
  y = 3.14       # Float
  name = "Alice" # String
  is_student = True # Boolean
  ```

### 3. Control Structures
- **Concepts and Principles**:
  - Control structures allow for decision-making in code.
  - **If statements**: Execute a block of code if a condition is true.
  
- **Example**:
  ```python
  age = 20
  if age >= 18:
      print("You are an adult.")
  else:
      print("You are a minor.")
  ```

### 4. Functions
- **Key Terms and Definitions**:
  - **Function**: A reusable block of code that performs a specific task.

- **Example**:
  ```python
  def greet(name):
      return f"Hello, {name}!"

  print(greet("Alice"))  # Output: Hello, Alice!
  ```

### 5. Error Handling
- **Concepts and Principles**:
  - Error handling is crucial for managing exceptions that may occur during program execution.
  - Use `try` and `except` blocks to handle errors gracefully.

- **Example**:
  ```python
  try:
      result = 10 / 0
  except ZeroDivisionError:
      print("You cannot divide by zero!")
  ```

### 6. File I/O
- **Concepts and Principles**:
  - File Input/Output allows programs to read from and write to files.
  
- **Example**:
  ```python
  # Writing to a file
  with open('example.txt', 'w') as file:
      file.write("Hello, World!")

  # Reading from a file
  with open('example.txt', 'r') as file:
      content = file.read()
      print(content)  # Output: Hello, World!
  ```

## Summary of Main Points
- Python is a versatile programming language with simple syntax.
- Understanding data types is essential for effective programming.
- Control structures enable decision-making in code.
- Functions promote code reusability.
- Error handling is vital for robust applications.
- File I/O allows interaction with external data.

## Practice Problems
1. Write a function that takes a number as input and returns whether it is even or odd.
2. Create a program that reads a list of names from a file and prints a greeting for each name.
3. Implement error handling in a program that divides two numbers input by the user.
