import csv
import sys

def extract_unique_categories(file_path):
    # Create a set to store unique categories
    unique_categories = set()

    try:
        # Open the CSV file
        with open(file_path, 'r', newline='', encoding='utf-8') as csv_file:
            # Create a CSV reader object
            csv_reader = csv.DictReader(csv_file)

            # Iterate through each row in the CSV data
            for row in csv_reader:
                # Add the category to the set of unique categories
                unique_categories.add(row['Category'])

        # Print the unique categories
        print("Unique categories:")
        for category in sorted(unique_categories):
            print(category)

    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
    except csv.Error as e:
        print(f"Error reading CSV file: {e}")
    except KeyError:
        print("Error: The CSV file does not have a 'Category' column.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script_name.py <path_to_csv_file>")
    else:
        file_path = sys.argv[1]
        extract_unique_categories(file_path)