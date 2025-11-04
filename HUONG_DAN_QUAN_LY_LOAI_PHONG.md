# 📖 HƯỚNG DẪN QUẢN LÝ LOẠI PHÒNG - HỆ THỐNG KHÁCH SẠN PTIT

<div align="center">

**Tài liệu hướng dẫn tính năng Quản lý Loại phòng**

*Phiên bản 2.0 - Cập nhật tháng 11/2025*

---

</div>

## 📋 MỤC LỤC

1. [Tổng quan](#-tổng-quan)
2. [Yêu cầu hệ thống](#-yêu-cầu-hệ-thống)
3. [Cài đặt & Cấu hình](#-cài-đặt--cấu-hình)
4. [Hướng dẫn sử dụng](#-hướng-dẫn-sử-dụng)
5. [Tính năng nâng cao](#-tính-năng-nâng-cao)
6. [Giao diện & Thiết kế](#-giao-diện--thiết-kế)
7. [API Backend](#-api-backend)
8. [Troubleshooting](#-troubleshooting)
9. [Changelog](#-changelog)

---

## 🎯 TỔNG QUAN

### Giới thiệu

Tính năng **Quản lý Loại phòng** cho phép admin/nhân viên quản lý các loại phòng trong khách sạn một cách trực quan và hiệu quả, bao gồm:
- ➕ Thêm loại phòng mới
- ✏️ Chỉnh sửa thông tin loại phòng
- 🗑️ Xóa loại phòng (nếu chưa sử dụng)
- 📝 Quản lý mô tả chi tiết
- 🎁 Cấu hình voucher tự động

### Điểm nổi bật

- ✅ **Modal hiện đại**: Không cần reload trang
- 📱 **Responsive**: Hoạt động mượt mà trên mọi thiết bị
- 🎨 **UI/UX đẹp**: Thiết kế Material Design
- ⚡ **Real-time validation**: Kiểm tra dữ liệu ngay lập tức
- 🔒 **Bảo mật**: CSRF protection, permission-based
- 📊 **Grid layout**: Hiển thị dạng card trực quan

### Vị trí trong hệ thống

```
Dashboard
  └─ Quản lý Phòng
       ├─ Sơ đồ phòng
       ├─ Đặt phòng
       └─ Quản lý Phòng 
            └─ [Nút: Quản lý Loại Phòng] ← Tính năng này
```

---

## � YÊU CẦU HỆ THỐNG

### Phần mềm

| Thành phần | Phiên bản tối thiểu | Ghi chú |
|------------|-------------------|---------|
| Python | 3.8+ | Backend framework |
| MySQL | 5.7+ | Database |
| Flask | 3.0.0 | Web framework |
| Browser | Chrome 90+, Firefox 88+ | Modern browsers |

### Quyền truy cập

- 🔐 **Yêu cầu đăng nhập**: Phải login với tài khoản staff
- 🔑 **Permission cần thiết**: `room_types.manage`
- 👤 **Role cho phép**: Admin hoặc Staff có quyền

---

## 🚀 CÀI ĐẶT & CẤU HÌNH

### Bước 1: Cập nhật Database Schema

Tính năng này yêu cầu cột `mo_ta` trong bảng `loaiphong`.

**Option 1: Chạy file SQL có sẵn**
```bash
# PowerShell (Windows)
Get-Content add_co_voucher_column.sql | mysql -u root -p Internet

# Bash (Linux/Mac)
mysql -u root -p Internet < add_co_voucher_column.sql
```

**Option 2: Chạy query trực tiếp**
```sql
USE Internet;

-- Thêm cột mô tả nếu chưa có
ALTER TABLE loaiphong 
ADD COLUMN IF NOT EXISTS mo_ta TEXT NULL 
COMMENT 'Mô tả chi tiết về loại phòng';

-- Kiểm tra structure
DESCRIBE loaiphong;
```

**Kết quả mong đợi:**
```
+------------------+--------------+------+-----+---------+-------+
| Field            | Type         | Null | Key | Default | Extra |
+------------------+--------------+------+-----+---------+-------+
| id               | int          | NO   | PRI | NULL    | AI    |
| ten              | varchar(100) | NO   |     | NULL    |       |
| so_nguoi_toi_da  | int          | YES  |     | 2       |       |
| gia              | bigint       | YES  |     | 0       |       |
| mo_ta            | text         | YES  |     | NULL    |       |
| co_voucher       | tinyint(1)   | YES  |     | 0       |       |
+------------------+--------------+------+-----+---------+-------+
```

### Bước 2: Kiểm tra Models

File `models.py` hoặc `app.py` phải có class `LoaiPhong` với trường `mo_ta`:

```python
class LoaiPhong(db.Model):
    __tablename__ = "loaiphong"
    id = db.Column(db.Integer, primary_key=True)
    ten = db.Column(db.String(100), nullable=False)
    so_nguoi_toi_da = db.Column(db.Integer, default=2)
    gia = db.Column(db.BIGINT, default=0)
    mo_ta = db.Column(db.Text, nullable=True)  # ← Trường mới
    co_voucher = db.Column(db.Boolean, default=False)
    phongs = db.relationship("Phong", backref="loai", lazy=True)
```

### Bước 3: Khởi động lại Server

```bash
# Stop server nếu đang chạy (Ctrl + C)

# Start lại
python app.py
```

### Bước 4: Kiểm tra Permissions

Đảm bảo user có quyền `room_types.manage`:

```sql
-- Kiểm tra permissions của role
SELECT r.name, rp.permission 
FROM role r
JOIN role_permission rp ON r.id = rp.role_id
WHERE rp.permission LIKE '%room%';

-- Thêm permission nếu chưa có (cho admin role)
INSERT INTO role_permission (role_id, permission) 
VALUES (1, 'room_types.manage')
ON DUPLICATE KEY UPDATE permission = permission;
```

---

## 📖 HƯỚNG DẪN SỬ DỤNG

### Truy cập Tính năng

**Bước 1**: Đăng nhập hệ thống
```
URL: http://localhost:5000/login
Username: admin
Password: admin
```

**Bước 2**: Vào trang Quản lý Phòng
```
Menu → Quản lý Phòng → Quản lý Phòng
hoặc trực tiếp: /quan-li-phong
```

**Bước 3**: Mở Modal Quản lý Loại Phòng
```
Click nút "Quản lý Loại Phòng" ở góc trên bên phải
```

### Thêm Loại phòng Mới

**Các bước thực hiện:**

1. **Mở form thêm mới**
   - Click nút "+ Thêm Loại Phòng Mới" trong modal
   - Form sẽ hiện ra với các trường trống

2. **Điền thông tin**
   ```
   ┌─────────────────────────────────────────────┐
   │ Tên Loại Phòng *                            │
   │ ┌─────────────────────────────────────────┐ │
   │ │ VIP Suite Ocean View                    │ │
   │ └─────────────────────────────────────────┘ │
   │                                             │
   │ Giá (VNĐ/đêm) *                            │
   │ ┌─────────────────────────────────────────┐ │
   │ │ 2500000                                 │ │
   │ └─────────────────────────────────────────┘ │
   │                                             │
   │ Số Người Tối Đa *                          │
   │ ┌─────────────────────────────────────────┐ │
   │ │ 4                                       │ │
   │ └─────────────────────────────────────────┘ │
   │                                             │
   │ Mô Tả                                      │
   │ ┌─────────────────────────────────────────┐ │
   │ │ Phòng VIP với view biển, diện tích     │ │
   │ │ 60m2, có ban công riêng, jacuzzi...    │ │
   │ └─────────────────────────────────────────┘ │
   │                                             │
   │ ☑ Tặng voucher khi đặt loại phòng này     │
   │                                             │
   │ [Hủy]  [Lưu Loại Phòng]                   │
   └─────────────────────────────────────────────┘
   
   * = Bắt buộc
   ```

3. **Validation tự động**
   - Tên: Không được trống, không trùng
   - Giá: Phải là số > 0
   - Số người: 1-10 người
   - Mô tả: Tùy chọn, tối đa 1000 ký tự

4. **Lưu**
   - Click "Lưu Loại Phòng"
   - Hệ thống kiểm tra và lưu
   - Hiển thị thông báo thành công
   - Tự động refresh danh sách

### Sửa Loại phòng

**Các bước thực hiện:**

1. **Chọn loại phòng cần sửa**
   - Tìm card của loại phòng trong danh sách
   - Click nút "✏️ Sửa"

2. **Form sẽ load sẵn dữ liệu**
   ```
   Tên: Deluxe Room
   Giá: 800000
   Số người: 2
   Mô tả: Phòng cao cấp với đầy đủ tiện nghi...
   ```

3. **Chỉnh sửa thông tin**
   - Cập nhật các trường cần thay đổi
   - Validation real-time

4. **Lưu thay đổi**
   - Click "Cập Nhật Loại Phòng"
   - Confirm thay đổi
   - Hiển thị thông báo

### Xóa Loại phòng

**Các bước thực hiện:**

1. **Chọn loại phòng cần xóa**
   - Click nút "🗑️ Xóa" trên card

2. **Confirm dialog**
   ```
   ┌───────────────────────────────────────┐
   │ ⚠️  Xác nhận xóa                      │
   ├───────────────────────────────────────┤
   │ Bạn có chắc muốn xóa loại phòng      │
   │ "Deluxe Room" không?                 │
   │                                       │
   │ Lưu ý: Không thể xóa nếu đang có    │
   │ phòng sử dụng loại này.              │
   │                                       │
   │ [Hủy]  [Xác nhận xóa]                │
   └───────────────────────────────────────┘
   ```

3. **Xử lý**
   - Nếu không có phòng nào sử dụng → Xóa thành công
   - Nếu đang có phòng sử dụng → Hiển thị lỗi

---

## 🎨 GIAO DIỆN & THIẾT KẾ

### Modal Layout

```
╔═══════════════════════════════════════════════════════════════╗
║                    QUẢN LÝ LOẠI PHÒNG                         ║
╠═══════════════════════════════════════════════════════════════╣
║                                                               ║
║  [+ Thêm Loại Phòng Mới]                      [✖ Đóng]      ║
║                                                               ║
║  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ ║
║  │ 🏨 Tiêu chuẩn   │  │ ⭐ Superior     │  │ 💎 Deluxe    │ ║
║  │ 400,000 VNĐ/đêm │  │ 600,000 VNĐ/đêm │  │ 900,000 VNĐ  │ ║
║  │ 👥 2 người      │  │ 👥 2 người      │  │ 👥 3 người   │ ║
║  │ Phòng cơ bản... │  │ Phòng cao cấp...│  │ Phòng VIP... │ ║
║  │ [✏️ Sửa] [🗑️ Xóa]│  │ [✏️ Sửa] [🗑️ Xóa]│  │ [✏️ Sửa] [🗑️]│ ║
║  └─────────────────┘  └─────────────────┘  └──────────────┘ ║
║                                                               ║
║  ┌─────────────────┐                                         ║
║  │ 👑 Suite         │                                         ║
║  │ 1,500,000 VNĐ/đêm│                                         ║
║  │ 👥 4 người       │                                         ║
║  │ Phòng cao cấp... │                                         ║
║  │ [✏️ Sửa] [🗑️ Xóa] │                                         ║
║  └─────────────────┘                                         ║
╚═══════════════════════════════════════════════════════════════╝
```

### Màu sắc & Theme

**Color Palette:**
```css
--primary-color: #0f766e;      /* Teal Dark */
--primary-light: #14b8a6;      /* Teal Light */
--primary-hover: #0d9488;      /* Teal Hover */

--danger-color: #dc2626;       /* Red */
--danger-hover: #b91c1c;       /* Red Dark */

--background: #ffffff;         /* White */
--background-light: #f8fafc;   /* Gray 50 */

--border: #e2e8f0;            /* Gray 200 */
--border-focus: #0f766e;      /* Teal */

--text-dark: #0f172a;         /* Slate 900 */
--text-normal: #1f2937;       /* Gray 800 */
--text-light: #64748b;        /* Slate 500 */
```

### Responsive Breakpoints

```css
/* Desktop: > 1024px */
.modal-content {
    max-width: 900px;
}
.room-type-grid {
    grid-template-columns: repeat(3, 1fr);
}

/* Tablet: 768px - 1024px */
@media (max-width: 1024px) {
    .modal-content {
        max-width: 90%;
    }
    .room-type-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

/* Mobile: < 768px */
@media (max-width: 768px) {
    .modal-content {
        max-width: 95%;
        margin: 10px;
    }
    .room-type-grid {
        grid-template-columns: 1fr;
    }
    .form-row {
        flex-direction: column;
    }
}
```

### Hiệu ứng & Animations

**Modal Transitions:**
```css
/* Fade in backdrop */
.modal-backdrop {
    animation: fadeIn 0.3s ease-in-out;
}

/* Scale up modal */
.modal-content {
    animation: scaleUp 0.3s ease-out;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes scaleUp {
    from { 
        opacity: 0;
        transform: scale(0.9);
    }
    to { 
        opacity: 1;
        transform: scale(1);
    }
}
```

**Card Hover Effects:**
```css
.room-type-card {
    transition: all 0.3s ease;
}

.room-type-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
    border-color: var(--primary-color);
}
```

**Button Effects:**
```css
button {
    transition: all 0.2s ease;
}

button:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

button:active {
    transform: translateY(0);
}
```

---

## ⚙️ API BACKEND

### Routes & Endpoints

#### 1. GET /quan-li-loai-phong
**Mục đích**: Lấy danh sách tất cả loại phòng

**Response:**
```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "ten": "Tiêu chuẩn",
      "gia": 400000,
      "so_nguoi_toi_da": 2,
      "mo_ta": "Phòng cơ bản với đầy đủ tiện nghi",
      "co_voucher": false,
      "so_phong_su_dung": 5
    },
    // ...
  ]
}
```

#### 2. POST /quan-li-loai-phong
**Mục đích**: Thêm loại phòng mới

**Request Body:**
```json
{
  "ten": "VIP Suite",
  "gia": 2500000,
  "so_nguoi_toi_da": 4,
  "mo_ta": "Phòng VIP cao cấp nhất",
  "co_voucher": true
}
```

**Validation:**
- `ten`: Required, unique, max 100 chars
- `gia`: Required, integer > 0
- `so_nguoi_toi_da`: Required, integer 1-10
- `mo_ta`: Optional, max 1000 chars
- `co_voucher`: Boolean, default false

**Response Success:**
```json
{
  "status": "success",
  "message": "Thêm loại phòng thành công",
  "data": {
    "id": 5,
    "ten": "VIP Suite",
    "gia": 2500000
  }
}
```

**Response Error:**
```json
{
  "status": "error",
  "message": "Tên loại phòng đã tồn tại"
}
```

#### 3. POST /quan-li-loai-phong/sua/<loai_id>
**Mục đích**: Cập nhật thông tin loại phòng

**URL Params:**
- `loai_id`: ID của loại phòng

**Request Body:** Giống POST /quan-li-loai-phong

**Response:** Tương tự thêm mới

#### 4. POST /quan-li-loai-phong/xoa/<loai_id>
**Mục đích**: Xóa loại phòng

**Business Logic:**
```python
# Kiểm tra có phòng nào đang sử dụng
phong_count = Phong.query.filter_by(loai_id=loai_id).count()

if phong_count > 0:
    return {
        "status": "error",
        "message": f"Không thể xóa. Có {phong_count} phòng đang sử dụng loại này"
    }

# Xóa nếu không có phòng nào
db.session.delete(loai_phong)
db.session.commit()
```

**Response Success:**
```json
{
  "status": "success",
  "message": "Xóa loại phòng thành công"
}
```

### Database Schema

```sql
CREATE TABLE loaiphong (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(100) NOT NULL UNIQUE,
  so_nguoi_toi_da INT DEFAULT 2 CHECK (so_nguoi_toi_da > 0),
  gia BIGINT DEFAULT 0 CHECK (gia >= 0),
  mo_ta TEXT NULL COMMENT 'Mô tả chi tiết về loại phòng',
  co_voucher BOOLEAN DEFAULT FALSE COMMENT 'Tặng voucher khi đặt'
);

-- Indexes
CREATE INDEX idx_loaiphong_gia ON loaiphong(gia);
CREATE INDEX idx_loaiphong_ten ON loaiphong(ten);
```

---

## 🐛 TROUBLESHOOTING

### Lỗi thường gặp

#### 1. Modal không mở được

**Triệu chứng**: Click nút "Quản lý Loại Phòng" không có phản ứng

**Nguyên nhân & Giải pháp:**
```javascript
// Kiểm tra JavaScript errors trong Console
// Đảm bảo jQuery đã load
if (typeof jQuery === 'undefined') {
    console.error('jQuery chưa được load!');
}

// Kiểm tra modal element tồn tại
if ($('#roomTypeModal').length === 0) {
    console.error('Modal element không tồn tại trong DOM!');
}
```

#### 2. Database error: Unknown column 'mo_ta'

**Nguyên nhân**: Chưa chạy migration script

**Giải pháp:**
```sql
-- Kiểm tra cấu trúc bảng
DESCRIBE loaiphong;

-- Nếu thiếu cột mo_ta, chạy:
ALTER TABLE loaiphong ADD COLUMN mo_ta TEXT NULL;
```

#### 3. Permission denied

**Triệu chứng**: Error 403 hoặc "Bạn không có quyền truy cập"

**Giải pháp:**
```sql
-- Kiểm tra permission của user
SELECT u.ten_dang_nhap, r.name as role, rp.permission
FROM nguoidung u
LEFT JOIN role r ON u.role_id = r.id
LEFT JOIN role_permission rp ON r.id = rp.role_id
WHERE u.ten_dang_nhap = 'your_username';

-- Thêm permission nếu thiếu
INSERT INTO role_permission (role_id, permission)
VALUES (1, 'room_types.manage');
```

#### 4. Validation errors

**Triệu chứng**: Form không submit được

**Debug checklist:**
- ✅ Tất cả trường required đã điền?
- ✅ Giá > 0?
- ✅ Số người từ 1-10?
- ✅ Tên không trùng với loại phòng khác?

**Check trong browser console:**
```javascript
// Xem form data trước khi submit
$('#roomTypeForm').on('submit', function(e) {
    e.preventDefault();
    console.log($(this).serialize());
});
```

#### 5. Không thể xóa loại phòng

**Triệu chứng**: "Không thể xóa, đang có phòng sử dụng"

**Giải pháp:**
```sql
-- Kiểm tra phòng nào đang dùng loại này
SELECT * FROM phong WHERE loai_id = <id_loai_phong>;

-- Option 1: Đổi phòng sang loại khác
UPDATE phong SET loai_id = <id_khac> WHERE loai_id = <id_can_xoa>;

-- Option 2: Xóa phòng (cẩn thận!)
DELETE FROM phong WHERE loai_id = <id_can_xoa>;

-- Sau đó mới xóa loại phòng
```

### Debug Mode

**Bật Flask debug:**
```python
# app.py
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
```

**Xem SQL queries:**
```python
# app.py
import logging
logging.basicConfig()
logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)
```

---

## 📝 CHANGELOG

### Version 2.0 (Tháng 11/2025)
- ✨ Cập nhật toàn bộ tài liệu với format mới
- 📚 Thêm phần API Backend chi tiết
- 🎨 Mô tả giao diện và responsive design
- 🐛 Thêm phần Troubleshooting đầy đủ
- 💡 Bổ sung Tips & Best practices

### Version 1.0 (Tháng 10/2025)
- ✨ Phát hành tính năng Quản lý Loại phòng
- 🎨 Modal design với Material UI
- 📝 Thêm trường `mo_ta` cho loại phòng
- ✅ CRUD operations đầy đủ
- 🔒 Permission-based access control

---

## 💡 TIPS & BEST PRACTICES

### 1. Đặt tên Loại phòng

**Nên:**
- ✅ "Standard Double Room"
- ✅ "Deluxe Twin with Sea View"
- ✅ "Executive Suite"

**Không nên:**
- ❌ "Phòng 1" (quá chung chung)
- ❌ "STANDARD" (viết hoa toàn bộ)
- ❌ "phong-standard" (dùng ký tự đặc biệt)

### 2. Pricing Strategy

```
Tiêu chuẩn:    400,000 VNĐ (baseline)
Superior:      600,000 VNĐ (+50%)
Deluxe:        900,000 VNĐ (+125%)
Suite:       1,500,000 VNĐ (+275%)
```

### 3. Mô tả Loại phòng

**Template tốt:**
```
📐 Diện tích: 30m²
🛏️ Giường: 1 giường đôi King size
👥 Sức chứa: 2 người lớn + 1 trẻ em
🏖️ View: Hướng biển
✨ Tiện nghi:
   - Smart TV 55"
   - Minibar
   - Safe box
   - Wifi tốc độ cao
   - Điều hòa 2 chiều
```

### 4. Voucher Settings

**Khi nào nên bật "Tặng voucher":**
- ✅ Loại phòng cao cấp (Deluxe, Suite)
- ✅ Khuyến mãi đặc biệt
- ✅ Chương trình tri ân khách hàng

**Khi nào không nên:**
- ❌ Loại phòng giá rẻ (ảnh hưởng lợi nhuận)
- ❌ Peak season (đã đủ khách)

### 5. Bảo trì Database

**Định kỳ:**
```sql
-- Backup bảng loaiphong
mysqldump -u root -p Internet loaiphong > loaiphong_backup.sql

-- Optimize table
OPTIMIZE TABLE loaiphong;

-- Check orphaned records
SELECT * FROM phong p
LEFT JOIN loaiphong lp ON p.loai_id = lp.id
WHERE lp.id IS NULL;
```

---

## 🎓 KẾT LUẬN

Tính năng **Quản lý Loại phòng** là một phần quan trọng trong hệ thống, giúp:
- ⚡ Tăng tốc độ quản lý
- 📊 Tổ chức dữ liệu tốt hơn
- 💰 Linh hoạt trong pricing
- 🎯 Cá nhân hóa dịch vụ

**Lợi ích:**
- 🚀 Không cần reload trang
- 📱 Responsive trên mọi thiết bị
- 🔒 Bảo mật cao
- 🎨 Giao diện hiện đại

---

<div align="center">

### 📞 HỖ TRỢ

Nếu gặp vấn đề hoặc có câu hỏi:

📧 **Email**: support@hotelptit.com
🐛 **Issues**: [GitHub Issues](https://github.com/keyznam-jpg/BTL-Internet/issues)
📚 **Wiki**: [Documentation](https://github.com/keyznam-jpg/BTL-Internet/wiki)

---

**© 2024-2025 Hệ thống Quản lý Khách sạn PTIT**

*Made with ❤️ by Hoàng Anh Nam @ PTIT*

</div>
