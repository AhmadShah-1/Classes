
'''
2. 
This code is a pytest example for validating square roots
'''

import math
import pytest
from ms_sqrt import mySqrt

class Test_Sqrt:
    def setup_method(self):
        print("Setting Up Numbers")
        # Initialize the numbers list
        self.numbers = [1, 4, 9, 16, 25]
        self.sqrt = [1, 2, 3, 4, 5]

    def teardown_method(self):
        # Reset the numbers and sqrt lists
        print("Tearing Down Numbers")
        self.numbers = None
        self.sqrt = None

    def test_sqrt(self):
        # Test the square root of each number in the list
        assert math.sqrt(1) == 1
        assert math.sqrt(0) == 0
        assert math.sqrt(4) == 2

        # Also call the other methods for tests
        self.setup_method()
        for index, number in enumerate(self.numbers):
            assert math.sqrt(number) == self.sqrt[index]
        self.teardown_method()

