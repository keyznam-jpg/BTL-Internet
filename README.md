# 🏨 HỆ THỐNG QUẢN LÝ KHÁCH SẠN PTIT - PHIÊN BẢN NÂNG CAP 2025

## 📋 TỔNG QUAN DỰ ÁN

Hệ Thống Quản Lý Khách Sạn PTIT là một giải pháp phần mềm toàn diện, được phát triển bằng công nghệ web hiện đại nhất với Python Flask 3.0.0 làm backend và các công nghệ frontend tiên tiến. Đây không chỉ là một công cụ quản lý đơn thuần mà còn là một hệ sinh thái hoàn chỉnh, tích hợp mọi khía cạnh vận hành của một khách sạn hiện đại - từ quản lý đặt phòng, thanh toán điện tử, giao tiếp khách hàng, đến quản trị nhân sự và phân tích kinh doanh.

### 🎯 Đối tượng sử dụng

Hệ thống được thiết kế cho ba nhóm người dùng chính:

1. **Quản trị viên (Admin)**: Toàn quyền kiểm soát hệ thống, bao gồm cấu hình, phân quyền, quản lý nhân sự, và truy cập mọi báo cáo
2. **Nhân viên (Staff)**: Xử lý các nghiệp vụ hàng ngày như đặt phòng, check-in/out, dịch vụ, thanh toán với quyền hạn được phân cấp linh hoạt
3. **Khách hàng (Customer)**: Tự đặt phòng online, thanh toán, chat với lễ tân, sử dụng dịch vụ trong phòng thông qua giao diện riêng biệt

### 🌟 Điểm nổi bật

- **Kiến trúc hiện đại**: MVC pattern với Flask, SQLAlchemy ORM, MySQL database với connection pooling tối ưu
- **Bảo mật cao**: Role-based access control (RBAC) đa cấp, mã hóa mật khẩu, CSRF protection, session management
- **Real-time Communication**: WebSocket-based chat giữa khách hàng và nhân viên
- **Thanh toán đa dạng**: Hỗ trợ tiền mặt và chuyển khoản QR (VietQR) với xác thực tự động
- **Email Marketing**: Hệ thống email tự động với templates tùy chỉnh cho mọi sự kiện
- **Responsive Design**: Giao diện thân thiện, hoạt động mượt mà trên mọi thiết bị
- **Báo cáo thông minh**: Thống kê, biểu đồ trực quan, xuất Excel/PDF
- **Loyalty Program**: Hệ thống tích điểm và voucher khuyến mãi tự động
- **Quản lý nhân sự**: Chấm công, tính lương, thưởng theo doanh thu
- **Tối ưu hiệu suất**: Caching, compression, database indexing

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
- **qrcode[pil]**: Tạo QR code VietQR
- **python-dotenv**: Quản lý environment variables
- **werkzeug**: Password hashing và utilities
- **email**: Gửi email với MIME support
- **unicodedata**: Xử lý tiếng Việt
- **calendar**: Tính toán ngày tháng

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
*Danh sách các booking online đang chờ xác nhận từ nhân viên*

### 12. Dịch vụ và thanh toán
![Dịch vụ và thanh toán](screenshots/dichvu.png)
*Giao diện các dịch vụ khách hàng có thể sử dụng ở khách sạn*

### 13. Lịch sử email
![Lịch sử email](screenshots/lichsuemail.png)
*Theo dõi và quản lý các email đã gửi tự động*

### 14. Thanh toán chưa hoàn tất
![Thanh toán chưa hoàn tất](screenshots/thanhtoanchuahoantat.png)
*Danh sách các thanh toán đang pending hoặc chưa hoàn tất*

### 15. Giao diện 404
![Giao diện 404](screenshots/giaodien404.png)
*Trang lỗi 404 khi truy cập đường dẫn không tồn tại*

### 16. Giao diện cảm ơn
![Giao diện cảm ơn](screenshots/giaodiencamon.png)
*Trang cảm ơn sau khi hoàn tất đặt phòng hoặc thanh toán*

### 17. Giao diện quản lý dịch vụ
![Giao diện quản lý dịch vụ](screenshots/giaodienquanlydichvu.png)
*Quản lý các dịch vụ bổ sung và giá cả*

### 18. Hồ sơ cá nhân
![Hồ sơ cá nhân](screenshots/hosocanhan.png)
*Thông tin cá nhân của nhân viên với avatar và thông tin liên hệ*

### 19. Lương và thưởng cá nhân
![Lương và thưởng cá nhân](screenshots/Luongvathuongcanhan.png)
*Xem lương cơ bản, phụ cấp và thưởng theo doanh thu*

### 20. Nhận và trả phòng
![Nhận và trả phòng](screenshots/nhanvatraphong.png)
*Giao diện nhận phòng và trả phòng cho khách hàng*

### 21. Quét QR xác nhận thanh toán
![Quét QR xác nhận thanh toán](screenshots/quetqrxacnhacthanhtoan.png)

*Khách hàng quét QR để xác nhận thanh toán online*

### 22. Thanh toán trả phòng
![Thanh toán trả phòng](screenshots/thanhtoantraphong.png)
*Thanh toán cuối cùng khi trả phòng với tổng chi phí*

### 23. Giao diện hóa đơn thanh toán
![Giao diện hóa đơn thanh toán](screenshots/giaodienhoadonthanhtoan.png)

*Hiển thị chi tiết hóa đơn và thanh toán cho khách hàng*

### 24. Đăng nhập khách hàng
![Đăng nhập khách hàng](screenshots/Dangnhapkhachhang.png)

*Giao diện đăng nhập dành cho khách hàng với form đăng ký và đăng nhập*

### 25. Trang khách hàng
![Trang khách hàng](screenshots/Trangkhachhang.png)

*Giao diện chính cho khách hàng với các chức năng đặt phòng và quản lý tài khoản*

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

# Security
SECRET_KEY=your_secret_key
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
mysqldump -u root -p Internet > backup_$(date +%Y%m%d_%H%M%S).sql
```
Hoặc tạo script backup.bat với nội dung:
```cmd
@echo off
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set datetime=%datetime:~0,8%_%datetime:~8,6%
mysqldump -u root -p Internet > backup_%datetime%.sql
echo Backup completed: backup_%datetime%.sql
pause
```

## 👤 Tài khoản mặc định

### Admin
- **Username**: `admin`
- **Password**: `admin`

### Nhân viên mẫu
- **Username**: `nam`, **Password**: `123`
- **Username**: `hoang`, **Password**: `123`
- **Username**: `hung`, **Password**: `123`

## 🔗 Routes chính (Web Interface)

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
- `GET /quan-ly-booking-cho` - Quản lý booking chờ

### Thanh toán
- `GET /thanh-toan-chua-hoan-tat` - Danh sách thanh toán pending
- `GET/POST /thanh-toan-dv/<id>` - Thanh toán dịch vụ
- `GET /dich-vu-thanh-toan` - Dịch vụ & thanh toán

### Khách hàng & Giao tiếp
- `GET /tin-nhan` - Quản lý tin nhắn
- `GET /khach-hang` - Danh sách khách hàng
- `GET /quan-ly-tai-khoan-khach-hang` - Tài khoản khách hàng

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
- `GET /quan-ly-vai-tro` - Quản lý vai trò
- `GET /quan-li-dich-vu` - Quản lý dịch vụ
- `GET /lich-su-email` - Lịch sử email

## 🔒 Bảo mật

- **Authentication**: Flask-Login với session management
- **Authorization**: Role-based access control với permissions chi tiết
- **Password Hashing**: werkzeug.security cho mật khẩu
- **Input Validation**: Sanitize và validate tất cả user input
- **SQL Injection Protection**: SQLAlchemy parameterized queries
- **CSRF Protection**: Token validation cho forms
- **Session Security**: Timeout cho sensitive operations (5 phút cho thanh toán)
- **File Upload Security**: Secure filename và type validation
- **Payment Sessions**: Token-based với expiration time

## 📝 Giấy phép

Dự án này được phát triển cho mục đích học tập và nghiên cứu tại Học viện Công nghệ Bưu chính Viễn thông (PTIT).

## 📞 Liên hệ

- **Tác giả**: Hoàng Anh Nam
- **Trường**: Học viện Công nghệ Bưu chính Viễn thông (PTIT)
- **Môn học**: Internet và Giao thức
- **Năm**: 2025
- **GitHub**: [https://github.com/keyznam-jpg/BTL-Internet]

---

*Hệ thống được thiết kế để đáp ứng các yêu cầu quản lý khách sạn hiện đại với giao diện thân thiện, bảo mật cao và khả năng mở rộng tốt. Cảm ơn bạn đã quan tâm đến dự án!* 🚀
