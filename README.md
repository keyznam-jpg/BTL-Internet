# Hệ Thống Quản Lý Khách Sạn PTIT

## 📋 Mô tả dự án

Đây là một hệ thống quản lý khách sạn toàn diện được phát triển bằng Python Flask, cho phép quản lý hiệu quả tất cả các hoạt động hàng ngày của khách sạn. Hệ thống hỗ trợ cả giao diện web cho nhân viên quản lý và khách hàng đặt phòng online, với các tính năng hiện đại như chat real-time, thanh toán QR, email tự động và báo cáo thống kê.

Hệ thống được thiết kế để đáp ứng nhu cầu của các khách sạn từ nhỏ đến lớn, với giao diện thân thiện, bảo mật cao và khả năng mở rộng tốt.

## 🚀 Tính năng chính

### 🏨 Quản lý phòng
- **Sơ đồ phòng trực quan**: Hiển thị trạng thái phòng real-time với màu sắc phân biệt
- **Phân loại phòng**: 4 loại phòng (Tiêu chuẩn, Superior, Deluxe, Suite) với giá khác nhau
- **Theo dõi trạng thái**: Trống, đã đặt, đang ở, quá giờ
- **Quản lý số lượng**: Hỗ trợ từ 1-5 người/phòng

### 📅 Đặt phòng
- **Đặt phòng offline**: Nhân viên đặt cho khách tại quầy
- **Đặt phòng online**: Khách hàng tự đặt qua website
- **Hỗ trợ thuê theo**: Ngày hoặc giờ linh hoạt
- **Tiền cọc tự động**: 30% giá phòng, có thể điều chỉnh

### 💳 Thanh toán
- **Phương thức đa dạng**: Tiền mặt hoặc chuyển khoản QR (VietQR)
- **QR code tích hợp**: Tạo QR tự động cho thanh toán online
- **Session bảo mật**: Timeout 5 phút, tránh thất thoát
- **Xác nhận tự động**: Kiểm tra thanh toán và cập nhật trạng thái

### 🛎️ Dịch vụ bổ sung
- **Danh mục dịch vụ**: Ăn uống, giặt ủi, spa, dịch vụ khác
- **Đặt dịch vụ trong phòng**: Tích hợp với booking
- **Thanh toán riêng biệt**: Quản lý chi phí dịch vụ độc lập
- **Báo cáo chi tiết**: Theo dõi doanh thu từ dịch vụ

### 💬 Giao tiếp khách hàng
- **Chat real-time**: WebSocket cho giao tiếp tức thời
- **Upload file**: Hỗ trợ ảnh, tài liệu, video trong chat
- **QR chat trong phòng**: Khách quét QR để chat với nhân viên
- **Lịch sử tin nhắn**: Lưu trữ và quản lý cuộc hội thoại

### 📧 Email tự động
- **Template email**: HTML responsive với thiết kế đẹp
- **Gửi tự động**: Thông báo trạng thái booking, check-in/out
- **Cấu hình SMTP**: Hỗ trợ Gmail, Outlook, custom server
- **Lịch sử gửi**: Theo dõi và quản lý email đã gửi

### 🎫 Voucher & khuyến mãi
- **Tạo voucher tự động**: Cho khách hàng sau check-out
- **Cấu hình tỷ lệ giảm**: 10% mặc định, có thể tùy chỉnh
- **Thời hạn sử dụng**: 60 ngày mặc định
- **Quản lý voucher**: Theo dõi sử dụng và hiệu quả

### 👥 Quản lý nhân viên
- **Phân quyền**: Admin và nhân viên với quyền hạn khác nhau
- **Chấm công**: Hàng ngày với phê duyệt của admin
- **Quản lý lương**: Cơ bản + phụ cấp + thưởng theo doanh thu
- **Thông tin cá nhân**: Avatar, thông tin liên hệ

### 📊 Thống kê & báo cáo
- **Dashboard tổng quan**: Chỉ số chính (check-in/out, phòng trống, tin nhắn)
- **Thống kê doanh thu**: Theo tháng/năm với biểu đồ
- **Báo cáo khách hàng**: Phân tích hành vi khách
- **Xuất báo cáo**: Excel/PDF với dữ liệu chi tiết

### ⚙️ Cấu hình hệ thống
- **Email SMTP**: Cấu hình server gửi email
- **Thông số voucher**: Tỷ lệ giảm giá, thời hạn
- **Lương thưởng**: Cấu hình thưởng theo mức doanh thu
- **Cài đặt chung**: Thông tin khách sạn, logo

## 🛠️ Công nghệ sử dụng

### Backend
- **Python 3.8+**: Ngôn ngữ lập trình chính
- **Flask 3.0.0**: Web framework nhẹ và linh hoạt
- **Flask-SQLAlchemy 3.1.1**: ORM cho database với query optimization
- **Flask-Login 0.6.3**: Quản lý authentication và session
- **Flask-SocketIO**: Real-time communication cho chat
- **Flask-Caching 2.1.0**: Caching để tối ưu hiệu suất
- **Flask-Compress 1.13**: Nén HTTP response
- **Flask-Migrate 4.0.5**: Database migrations

### Database
- **MySQL 5.7+**: Database chính với PyMySQL driver
- **Connection Pooling**: 10 connections + 20 overflow
- **Schema tối ưu**: 15 bảng với indexes và constraints

### Frontend
- **HTML5**: Semantic markup
- **CSS3**: Responsive design với custom styles
- **JavaScript**: ES6+ với DOM manipulation
- **Font Awesome 6.4.0**: Icon library
- **FullCalendar**: Lịch đặt phòng interactive

### Thư viện bổ sung
- **pandas**: Xử lý dữ liệu cho báo cáo
- **openpyxl**: Xuất Excel
- **reportlab**: Tạo PDF
- **APScheduler**: Background jobs
- **qrcode[pil]**: Tạo QR code
- **python-dotenv**: Quản lý environment variables
- **email**: Gửi email với MIME support

## 📸 Ảnh chụp demo dự án

### 1. Trang đăng nhập
![Trang đăng nhập](screenshots/login.png)
*Giao diện đăng nhập với form validation và responsive design*

### 2. Dashboard tổng quan
![Dashboard](screenshots/dashboard.png)
*Trang chủ hiển thị các thống kê chính: check-in/out hôm nay, phòng có khách, tin nhắn mới*

### 3. Sơ đồ phòng
![Sơ đồ phòng](screenshots/room_map.png)
*Hiển thị trực quan trạng thái tất cả phòng với màu sắc phân biệt*

### 4. Đặt phòng offline
![Đặt phòng](screenshots/booking.png)
*Form đặt phòng với calendar picker và tính tiền tự động*

### 5. Đặt phòng online
![Đặt phòng online](screenshots/online_booking.png)
*Giao diện khách hàng tự đặt phòng với QR thanh toán*

### 6. Chat real-time
![Chat](screenshots/chat.png)
*Giao diện chat giữa khách hàng và nhân viên với upload file*

### 7. Quản lý nhân viên
![Nhân viên](screenshots/employees.png)
*Danh sách nhân viên với thông tin chi tiết và chức năng chấm công*

### 8. Thống kê doanh thu
![Thống kê](screenshots/statistics.png)
*Biểu đồ doanh thu theo tháng với khả năng xuất báo cáo*

### 9. Chấm công
![Chấm công](screenshots/chamcong.png)
*Giao diện chấm công hàng ngày cho nhân viên*

### 10. Phê duyệt chấm công
![Phê duyệt chấm công](screenshots/pheduyetchamcong.png)
*Admin phê duyệt các yêu cầu chấm công của nhân viên*

### 11. Đặt phòng online chờ xác nhận
![Đặt phòng online chờ xác nhận](screenshots/datphongonlinechoxacnhan.png)
*Danh sách các booking online đang chờ xác nhận từ admin*

### 12. Quản lý dịch vụ
![Quản lý dịch vụ](screenshots/dichvu.png)
*Giao diện quản lý các dịch vụ bổ sung của khách sạn*

### 13. Lịch sử email
![Lịch sử email](screenshots/lichsuemail.png)
*Theo dõi và quản lý các email đã gửi tự động*

### 14. Thanh toán chưa hoàn tất
![Thanh toán chưa hoàn tất](screenshots/thanhtoanchuahoantat.png)
*Danh sách các thanh toán đang pending hoặc chưa hoàn tất*

### Yêu cầu hệ thống
- **Python**: 3.8 hoặc cao hơn
- **MySQL**: 5.7 hoặc cao hơn
- **Git**: Để clone repository
- **Web Browser**: Chrome, Firefox, Safari, Edge

### 1. Clone repository
```bash
git clone https://github.com/keyznam-jpg/BTL-Internet.git
cd BTL-Internet
```

### 2. Tạo môi trường ảo (khuyến nghị)
```bash
python -m venv venv
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Linux/Mac
```

### 3. Cài đặt dependencies
```bash
pip install -r requirements.txt
```

### 4. Cấu hình database
- Tạo database MySQL tên `Internet`
- Import schema từ file `schema_internet.sql`:
```sql
mysql -u root -p Internet < schema_internet.sql
```

### 5. Cấu hình biến môi trường
Tạo file `.env` trong thư mục gốc:
```env
# Database
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DB=Internet

# Email SMTP (tùy chọn)
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your_email@gmail.com
SMTP_PASSWORD=your_app_password
```

### 6. Chạy ứng dụng
```bash
python app.py
```
Hoặc sử dụng file batch (Windows):
```cmd
run.bat
```

Ứng dụng sẽ chạy tại: `http://127.0.0.1:5000`

### 7. Backup database (khuyến nghị)
```cmd
backup.bat
```

## 👤 Tài khoản mặc định

### Admin
- **Username**: `admin`
- **Password**: `admin`

### Nhân viên mẫu
- **Username**: `nam`, **Password**: `123`
- **Username**: `hoang`, **Password**: `123`
- **Username**: `hung`, **Password**: `123`

## 🔗 API Endpoints chính

### Authentication
- `GET/POST /login` - Đăng nhập hệ thống
- `GET /logout` - Đăng xuất

### Dashboard
- `GET /dashboard` - Trang tổng quan với thống kê

### Quản lý phòng
- `GET /so-do-phong` - Sơ đồ phòng
- `GET/POST /dat-phong` - Đặt phòng offline
- `GET/POST /dat-phong-online` - Đặt phòng online
- `GET/POST /nhan-phong` - Nhận/trả phòng

### Thanh toán
- `GET /thanh-toan-chua-hoan-tat` - Danh sách thanh toán pending
- `GET/POST /thanh-toan-dv/<id>` - Thanh toán dịch vụ

### Khách hàng & Giao tiếp
- `GET /tin-nhan` - Quản lý tin nhắn
- `GET /khach-hang` - Danh sách khách hàng

### Báo cáo
- `GET /thong-ke-doanh-thu` - Thống kê doanh thu
- `GET /thong-ke-khach` - Thống kê khách hàng

### Quản lý nhân viên
- `GET/POST /attendance` - Chấm công
- `GET /attendance/admin` - Phê duyệt chấm công
- `GET /nhan-vien` - Danh sách nhân viên
- `GET /luong-thuong` - Quản lý lương thưởng

### Cài đặt
- `GET /cai-dat-email` - Cấu hình email
- `GET /cai-dat-luong-thuong` - Cấu hình lương thưởng

## 🔒 Bảo mật

- **Authentication**: Flask-Login với session management
- **Authorization**: Role-based access control (admin/nhanvien)
- **Input Validation**: Sanitize và validate tất cả user input
- **SQL Injection Protection**: SQLAlchemy parameterized queries
- **CSRF Protection**: Token validation cho forms
- **Rate Limiting**: Flask-Limiter chống brute force
- **Session Security**: Timeout cho sensitive operations
- **File Upload Security**: Secure filename và type validation

## 📝 Giấy phép

Dự án này được phát triển cho mục đích học tập và nghiên cứu tại Học viện Công nghệ Bưu chính Viễn thông (PTIT).

## 📞 Liên hệ

- **Tác giả**: Hoàng Anh Nam
- **Trường**: Học viện Công nghệ Bưu chính Viễn thông (PTIT)
- **Môn học**: Internet và Giao thức
- **Năm**: 2025
- **GitHub**: [https://github.com/keyznam-jpg]

---

*Hệ thống được thiết kế để đáp ứng các yêu cầu quản lý khách sạn hiện đại với giao diện thân thiện, bảo mật cao và khả năng mở rộng tốt. Cảm ơn bạn đã quan tâm đến dự án!* 🚀