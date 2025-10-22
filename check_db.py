from app import app, db

with app.app_context():
    print('Direct database check for auto_confirmed_at column')

    # Get database connection
    engine = db.engine
    connection = engine.raw_connection()
    cursor = connection.cursor()

    try:
        # Check if column exists
        cursor.execute('DESCRIBE datphong')
        columns = cursor.fetchall()
        column_names = [col[0] for col in columns]

        if 'auto_confirmed_at' in column_names:
            print('✓ auto_confirmed_at column exists in database')

            # Check current data
            cursor.execute("SELECT COUNT(*) FROM datphong WHERE trang_thai = 'waiting' AND auto_confirmed_at IS NOT NULL")
            auto_confirmed_count = cursor.fetchone()[0]
            print(f'Auto-confirmed waiting bookings: {auto_confirmed_count}')

            cursor.execute("SELECT COUNT(*) FROM datphong WHERE trang_thai = 'waiting'")
            waiting_count = cursor.fetchone()[0]
            print(f'Total waiting bookings: {waiting_count}')

        else:
            print('✗ auto_confirmed_at column does not exist in database')

    except Exception as e:
        print(f'Error: {e}')
    finally:
        cursor.close()
        connection.close()