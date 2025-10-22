import mysql.connector
import os

# Database connection parameters
config = {
    'user': 'root',
    'password': '',  # Add password if needed
    'host': 'localhost',
    'database': 'internet',
    'charset': 'utf8mb4'
}

try:
    # Connect to MySQL
    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()

    # Read and execute SQL file
    with open('schema_internet.sql', 'r', encoding='utf-8') as f:
        sql_content = f.read()

    # Split SQL commands and execute them
    sql_commands = sql_content.split(';')
    for command in sql_commands:
        command = command.strip()
        if command:
            print(f"Executing: {command[:50]}...")
            cursor.execute(command)
            print("Success")

    conn.commit()
    print("Database schema created successfully!")

except mysql.connector.Error as err:
    print(f"Error: {err}")

finally:
    if 'cursor' in locals():
        cursor.close()
    if 'conn' in locals():
        conn.close()