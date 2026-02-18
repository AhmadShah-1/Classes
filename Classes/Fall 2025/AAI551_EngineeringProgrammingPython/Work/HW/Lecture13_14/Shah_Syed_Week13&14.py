import numpy as np
import pandas as pd
import pytest

# Define paths
raw_data = "rawData-1.xlsx"
validated_file = "validatedData.xlsx"
computed_Statistics = "computedStatistics.xlsx"

# Load Data
def load_data(file_path):
    # Try to load the data, if the path is wrong, print an error message
    # If the error is uncaught, display the error message
    try:
        df = pd.read_excel(file_path)
        return df
    except FileNotFoundError:
        print("File not found")
    except Exception as e:
        print(f"Error loading data: {e}")
        return None


# Validate Data
def validate_data(df):
    try:
        df = df.copy()

        # Convert data to numeric, if it can't be converted, set it to NaN
        df["Age"] = pd.to_numeric(df["Age"], errors="coerce")
        df["Salary"] = pd.to_numeric(df["Salary"], errors="coerce")
        df["Employment Since"] = pd.to_numeric(df["Employment Since"], errors="coerce")

        # Drop rows with NaN values
        df = df.dropna(subset=["Age", "Salary", "Employment Since"])

        # validity rules
        df = df[df["Salary"] >= 0]  # Salary can't be negative
        df = df[(df["Age"] >= 0) & (df["Age"] <= 122)]  # Age can't be negative or greater than 122 (oldest person to have ever lived)

        return df

    except TypeError as e:
        print(f"Type error: {e}")
        return pd.DataFrame()
    except ValueError as e:
        print(f"Value error: {e}")
        return pd.DataFrame()
    except Exception as e:
        print(f"Unexpected error: {e}")
        return pd.DataFrame()


def compute_statistics(df):
    '''
    Compute mean, max, min, and standard deviation of salary
    '''
    try:
        salaries = df["Salary"].to_numpy(dtype=float)

        # Check if there is any salary data, as it may be empty, or validation removed all rows, just skip to raise an error
        if salaries.size == 0:
            raise ZeroDivisionError("No salary data available")

        return {
            "mean": float(np.mean(salaries)),
            "max": float(np.max(salaries)),
            "min": float(np.min(salaries)),
            "std": float(np.std(salaries, ddof=0)),
        }
    except ZeroDivisionError as e:
        print(f"Zero division error: {e}")
        return None
    except Exception as e:
        print(f"Unexpected error: {e}")
        return None

def employee_ten_years(df):
    '''
    This function curates a list of employees who have been employed for at least 10 years
    '''
    try:
        current_year = pd.Timestamp.today().year

        # Calculate the number of years each employee has been employed
        years_employed = current_year - df["Employment Since"]
        # Create a new df with employees who have been employed for at least 10 years
        copy = df[years_employed >= 10].copy()
        # Add a new column to the df with the number of years each employee has been employed
        copy["YearsOfService"] = years_employed[years_employed >= 10].astype(int).values

        return copy

    except Exception as e:
        print(f"Unexpected error: {e}")
        return None


# PYTEST FUNCTIONS
# TEST STATS
def test_single_salary_data():
    '''
    This function tests the compute_statistics function with a single salary data
    '''
    df = pd.DataFrame({"FirstName": ["John"], "Employment Since": [2010], "Salary": [100000]})
    stats = compute_statistics(df)

    # STD should be 0.0 because there is only one salary data
    assert stats["std"] == 0.0

def test_no_salary_data():
    '''
    This function tests the compute_statistics function with no salary data
    '''
    # No salary data, should return None
    df = pd.DataFrame({"FirstName": ["John"], "Employment Since": [2010]})
    stats = compute_statistics(df)
    assert stats is None

# TEST YEARS OF SERVICE
class TestYearsOfService:
    def test_10_years_boundary(self):
        # Tests employees with exactly 10 years (2015 for 2025)
        df = pd.DataFrame({"FirstName": ["John"], "Employment Since": [2015]})
        result = employee_ten_years(df)
        assert len(result) == 1

    def test_invalid_employment_year_filtered_out(self):
        # Future years should be filtered out (no 10+ years)
        df = pd.DataFrame({"FirstName": ["John"], "Employment Since": [2030]})
        result = employee_ten_years(df)
        assert result is None or len(result) == 0



def main():
    '''
    This function is the main function that loads the data, validates it, computes the statistics, and saves the data to an excel file
    '''
    try:
        df = load_data(raw_data)

        validated_df = validate_data(df)
        validated_df.to_excel(validated_file, index=False)

        stats = compute_statistics(validated_df)
        ten_years = employee_ten_years(validated_df)



        # SAVE IN NEW EXCEL FILE
        # Prepare employees DataFrame
        if ten_years is None or ten_years.empty:
            employees_df = pd.DataFrame(columns=validated_df.columns)
        else:
            employees_df = ten_years.copy()
        
        # Create statistics DataFrame
        num_rows = len(employees_df) if not employees_df.empty else 1
        
        if stats:
            # Names in first row, Stats at end, empty strings for remaining rows
            stats_data = {
                'Statistics': [''] * num_rows,
                'Mean': [stats['mean']] + [''] * (num_rows - 1),
                'Max': [stats['max']] + [''] * (num_rows - 1),
                'Min': [stats['min']] + [''] * (num_rows - 1),
                'STD': [stats['std']] + [''] * (num_rows - 1)
            }
        else:
            stats_data = {
                'Statistics': [''] * num_rows,
                'Mean': [''] * num_rows,
                'Max': [''] * num_rows,
                'Min': [''] * num_rows,
                'STD': [''] * num_rows
            }
        
        stats_df = pd.DataFrame(stats_data)
        
        # Include FirstName, Employment Since, and YearsOfService so that HR may appropriately use data 
        selected_columns = ["FirstName", "Employment Since", "YearsOfService"]

        if not employees_df.empty and selected_columns:
            employees_selected = employees_df[selected_columns]
        else:
            employees_selected = pd.DataFrame(columns=selected_columns)

        # Combine employees and statistics horizontally and save
        result_df = pd.concat([employees_selected, stats_df], axis=1)
        result_df.to_excel(computed_Statistics, index=False)

        # Open file, and print the data
        final_df = pd.read_excel(computed_Statistics)
        print(final_df)
        
    except Exception as e:
        print(f"Unexpected error: {e}")
        return None

if __name__ == "__main__":
    main()
    # Run pytest tests
    pytest.main([__file__, "-v"])  