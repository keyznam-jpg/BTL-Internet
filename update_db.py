from app import app, db, DatPhong

with app.app_context():
    # Update database schema
    db.create_all()
    print("Database schema updated successfully!")

    # Check if 'waiting' status exists in any booking
    waiting_count = DatPhong.query.filter_by(trang_thai='waiting').count()
    print(f"Current waiting bookings: {waiting_count}")