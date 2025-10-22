# Hệ Thống Quản Lý Khách Sạn PTIT

## Mô tả dự án

Đây là một hệ thống quản lý khách sạn toàn diện được phát triển bằng Python Flask, cho phép quản lý các hoạt động hàng ngày của khách sạn như đặt phòng, nhận/trả phòng, thanh toán, quản lý dịch vụ, giao tiếp với khách hàng qua chat và email, quản lý nhân viên và lương, chấm công, và báo cáo doanh thu.

Hệ thống hỗ trợ cả giao diện web cho nhân viên quản lý và khách hàng đặt phòng online.

## 🚀 Cải thiện hiệu suất (T10/2025)

### Tối ưu hóa đã triển khai:
- ✅ **Compression**: Flask-Compress để nén response HTTP (giảm bandwidth)
- ✅ **Database Pooling**: SQLAlchemy connection pool (10 connections, 20 overflow)
- ✅ **Query Optimization**: Thêm joinedload cho các relationship phức tạp
- ✅ **Static Files Caching**: Cache-Control headers cho static files (1 giờ)
- ✅ **Connection Recycling**: Pool recycle mỗi giờ để tránh stale connections

### Hiệu suất ước tính sau tối ưu:
- **Thời gian tải trang**: Giảm 30-50% nhờ compression và caching
- **Database connections**: Tái sử dụng thay vì tạo mới
- **Memory usage**: Giảm nhờ connection pooling
- **Scalability**: Hỗ trợ tốt hơn 100+ concurrent users

## Tính năng chính

### 🏨 Quản lý phòng
- Sơ đồ phòng trực quan với trạng thái real-time
- Phân loại phòng (Tiêu chuẩn, Superior, Deluxe, Suite)
- Theo dõi trạng thái phòng (trống, đã đặt, đang ở, quá giờ)

### 📅 Đặt phòng
- Đặt phòng offline (nhân viên)
- Đặt phòng online (khách hàng tự đặt)
- Hỗ trợ thuê theo ngày hoặc giờ
- Tính tiền cọc tự động (30% giá phòng)

### 💳 Thanh toán
- Thanh toán tiền mặt hoặc chuyển khoản QR (VietQR)
- Tích hợp QR code cho thanh toán online
- Quản lý session thanh toán với timeout 5 phút
- Xác nhận thanh toán tự động

### 🛎️ Dịch vụ bổ sung
- Quản lý danh mục dịch vụ (ăn uống, giặt ủi, spa, v.v.)
- Đặt dịch vụ trong phòng
- Thanh toán dịch vụ riêng biệt

### 💬 Giao tiếp
- Chat real-time giữa khách hàng và nhân viên
- Hệ thống tin nhắn với token riêng cho mỗi đặt phòng
- Upload file trong chat (ảnh, tài liệu)

### 📧 Email tự động
- Template email có thể tùy chỉnh
- Gửi email thông báo trạng thái đặt phòng
- Lịch sử gửi email

### 🎫 Voucher
- Tạo voucher tự động cho khách hàng
- Cấu hình tỷ lệ giảm giá và thời hạn
- Quản lý voucher đã sử dụng

### 👥 Quản lý nhân viên
- Phân quyền admin/nhân viên
- Chấm công hàng ngày
- Phê duyệt chấm công (admin)
- Quản lý lương cơ bản và phụ cấp
- Tính thưởng theo doanh thu

### 📊 Báo cáo và thống kê
- Thống kê doanh thu theo tháng/năm
- Báo cáo khách hàng
- Xuất báo cáo Excel/PDF

### ⚙️ Cài đặt hệ thống
- Cấu hình email SMTP
- Cài đặt thông số voucher
- Quản lý cấu hình hệ thống

## Công nghệ sử dụng

### Backend
- **Python 3.x**
- **Flask** - Web framework
- **Flask-SQLAlchemy** - ORM cho database
- **Flask-Login** - Quản lý authentication
- **Flask-SocketIO** - Real-time communication
- **Flask-Caching** - Caching
- **Flask-Migrate** - Database migrations
- **Flask-Compress** - Compression

### Database
- **MySQL** với PyMySQL driver
- Schema được định nghĩa trong `schema.sql`

### Frontend
- **HTML5**, **CSS3**, **JavaScript**
- **Font Awesome** - Icons
- **FullCalendar** - Lịch đặt phòng
- **QRCode** - Tạo QR code

### Thư viện khác
- **pandas** - Xử lý dữ liệu
- **openpyxl** - Xuất Excel
- **reportlab** - Tạo PDF
- **APScheduler** - Lên lịch tác vụ
- **qrcode[pil]** - Tạo QR code
- **python-dotenv** - Quản lý biến môi trường

## Cài đặt và chạy

### Yêu cầu hệ thống
- Python 3.8+
- MySQL 5.7+
- Git

### 1. Clone repository
```bash
git clone https://github.com/keyznam-jpg/BTL-Internet.git
cd BTL-Internet
```

### 2. Cài đặt dependencies
```bash
pip install -r requirements.txt
```

### 3. Cấu hình database
- Tạo database MySQL tên `Internet`
- Import schema từ file `schema_internet.sql`
- Cấu hình biến môi trường trong file `.env`:
```env
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DB=Internet
SECRET_KEY=your_secret_key
PUBLIC_BASE_URL=http://localhost:5000

# Cấu hình VietQR (tùy chọn)
VIETQR_BANK_ID=970423
VIETQR_ACCOUNT_NO=99992162001
VIETQR_BANK_NAME=TPBank
VIETQR_ACCOUNT_NAME=Khách sạn PTIT
DEPOSIT_PERCENT=0.3

# Cấu hình email SMTP (tùy chọn)
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your_email@gmail.com
SMTP_PASSWORD=your_app_password
```

### 4. Chạy ứng dụng
- Sử dụng file `run.bat` (Windows):
```cmd
run.bat
```
- Hoặc chạy thủ công:
```bash
python app.py
```
- Ứng dụng sẽ chạy tại `http://127.0.0.1:5000`

### 5. Backup database
- Sử dụng file `backup.bat` để backup database tự động

## Cấu trúc thư mục

```
BTL-Internet/
├── app.py                      # File chính của ứng dụng Flask
├── schema_internet.sql         # Schema database MySQL
├── requirements.txt            # Dependencies Python
├── run.bat                     # Script chạy ứng dụng (Windows)
├── backup.bat                  # Script backup database
├── static/                     # Static files (CSS, JS, images)
│   ├── css/
│   │   ├── style.css           # CSS chính
│   │   ├── dashboard.css       # CSS dashboard
│   │   ├── login.css           # CSS trang đăng nhập
│   │   └── ...                 # CSS khác
│   ├── js/
│   │   ├── payments.js         # JS xử lý thanh toán
│   │   ├── voucher_check.js    # JS kiểm tra voucher
│   │   └── ...
│   └── img/                    # Hình ảnh
├── templates/                  # Templates HTML
│   ├── base.html               # Template cơ sở
│   ├── dashboard.html          # Trang dashboard
│   ├── login.html              # Trang đăng nhập
│   ├── dat_phong.html          # Trang đặt phòng
│   ├── so_do_phong.html        # Sơ đồ phòng
│   ├── tin_nhan.html           # Trang tin nhắn
│   └── ...                     # Các template khác
└── Phần mềm cần cài đặt/       # Tài liệu hướng dẫn cài đặt
```

## Tài khoản mặc định

### Admin
- Username: `admin`
- Password: `admin`

### Nhân viên mẫu
- Username: `nam`, Password: `123`
- Username: `keyz`, Password: `123`
- Username: `hoang`, Password: `123`
- Username: `hung`, Password: `123`

## API Endpoints chính

### Authentication
- `GET/POST /login` - Đăng nhập
- `GET /logout` - Đăng xuất

### Dashboard
- `GET /dashboard` - Trang chủ với thống kê

### Quản lý phòng
- `GET /so-do-phong` - Sơ đồ phòng
- `GET/POST /dat-phong` - Đặt phòng offline
- `GET/POST /dat-phong-online` - Đặt phòng online
- `GET/POST /nhan-phong` - Nhận/trả phòng

### Thanh toán
- `GET /thanh-toan-chua-hoan-tat` - Danh sách thanh toán chưa hoàn tất
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

## Socket.IO Events

### Chat
- `join_room` - Tham gia phòng chat
- `send_message` - Gửi tin nhắn
- `receive_message` - Nhận tin nhắn

## Database Schema

### Bảng chính
- `nguoidung` - Người dùng (nhân viên, admin)
- `loaiphong` - Loại phòng
- `phong` - Phòng
- `khachhang` - Khách hàng
- `datphong` - Đặt phòng
- `dichvu` - Dịch vụ
- `sudungdv` - Sử dụng dịch vụ
- `tinnhan` - Tin nhắn
- `email_log` - Lịch sử email
- `voucher` - Voucher
- `attendance` - Chấm công
- `luongnhanvien` - Lương nhân viên
- `hethongcauhinh` - Cấu hình hệ thống

## Bảo mật

- Rate limiting với Flask-Limiter
- Session timeout cho thanh toán
- Authentication với Flask-Login
- Sanitize input và SQL injection protection qua SQLAlchemy
- CSRF protection (nếu cần)

## Phát triển thêm

### Tính năng có thể mở rộng
- API RESTful cho mobile app
- Tích hợp thanh toán online (VNPay, Momo)
- Push notification
- Đa ngôn ngữ
- Phân tích dữ liệu nâng cao
- Tích hợp AI chatbot

### Đóng góp
1. Fork repository
2. Tạo branch feature mới
3. Commit changes
4. Push và tạo Pull Request

## Giấy phép

Dự án này được phát triển cho mục đích học tập và nghiên cứu.

## Liên hệ

- **Tác giả**: Hoàng Anh Nam
- **Trường**: Học viện Công nghệ Bưu chính Viễn thông (PTIT)
- **Môn học**: Internet và Giao thức
- **Năm**: 2025

---

*Hệ thống được thiết kế để đáp ứng các yêu cầu quản lý khách sạn hiện đại với giao diện thân thiện và chức năng toàn diện.*