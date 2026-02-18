---
source_lecture: Lecture 3.md
class: AAI551_EngineeringProgrammingPython
topics:
  - Python Basics
  - Data Types
  - Control Structures
  - Functions
  - Error Handling
generated: true
model: 'openai:gpt-4o-mini'
---
# Lecture 3: Introduction to Python Programming Concepts

## Overview of Topics Covered
1. Python Basics
2. Data Types
3. Control Structures
4. Functions
5. Error Handling

## Detailed Walkthrough

### 1. Python Basics
- **Key Terms and Definitions**:
  - **Python**: A high-level programming language known for its readability and simplicity.
  - **Interpreter**: A program that executes Python code line by line.

### 2. Data Types
- **Key Terms and Definitions**:
  - **Data Types**: Categories of data that determine the type of operations that can be performed on them.
  - Common data types in Python include:
    - **int**: Integer numbers (e.g., 1, 2, 3)
    - **float**: Floating-point numbers (e.g., 1.0, 2.5)
    - **str**: Strings, or sequences of characters (e.g., "Hello, World!")
    - **bool**: Boolean values, representing True or False.

- **Concepts and Principles**:
  - **Type Casting**: Converting one data type to another (e.g., `int(3.5)` converts a float to an integer).

### 3. Control Structures
- **Key Terms and Definitions**:
  - **Control Structures**: Constructs that control the flow of execution in a program.
  - **if statement**: Used for conditional execution.
  - **for loop**: Used for iterating over a sequence (like a list or string).

- **Example**:
  - **if statement**:
    ```python
    x = 10
    if x > 5:
        print("x is greater than 5")
    ```
  - **for loop**:
    ```python
    for i in range(5):
        print(i)
    ```

### 4. Functions
- **Key Terms and Definitions**:
  - **Function**: A block of reusable code that performs a specific task.
  - **Parameters**: Variables that are passed into a function.
  - **Return Value**: The value that a function outputs after execution.

- **Example**:
  - Defining a function:
    ```python
    def add(a, b):
        return a + b
    ```
  - Calling a function:
    ```python
    result = add(5, 3)  # result will be 8
    ```

### 5. Error Handling
- **Key Terms and Definitions**:
  - **Error Handling**: The process of responding to and recovering from error conditions in a program.
  - **try/except block**: A construct used to handle exceptions.

- **Example**:
  ```python
  try:
      x = 1 / 0  # This will raise a ZeroDivisionError
  except ZeroDivisionError:
      print("You can't divide by zero!")
  ```

## Summary of Main Points
- Python is a versatile programming language with a focus on readability.
- Understanding data types is crucial for effective programming.
- Control structures allow for decision-making and iteration in code.
- Functions promote code reusability and organization.
- Error handling is essential for creating robust applications.

## Practice Problems
1. Write a function that takes two numbers as parameters and returns their product.
2. Create a loop that prints all even numbers from 1 to 20.
3. Implement error handling for a function that converts a string to an integer, catching any ValueError exceptions.
