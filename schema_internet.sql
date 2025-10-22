CREATE DATABASE IF NOT EXISTS `Internet` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `Internet`;

DROP TABLE IF EXISTS email_log;
DROP TABLE IF EXISTS emailtemplate;
DROP TABLE IF EXISTS tinnhan;
DROP TABLE IF EXISTS sudungdv;
DROP TABLE IF EXISTS datphong;
DROP TABLE IF EXISTS voucher;
DROP TABLE IF EXISTS dichvu;
DROP TABLE IF EXISTS dichvuloai;
DROP TABLE IF EXISTS luongnhanvien;
DROP TABLE IF EXISTS luongthuongcauhinh;
DROP TABLE IF EXISTS phong;
DROP TABLE IF EXISTS loaiphong;
DROP TABLE IF EXISTS khachhang;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS hethongcauhinh;
DROP TABLE IF EXISTS nguoidung;

CREATE TABLE nguoidung(
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten_dang_nhap VARCHAR(50) UNIQUE NOT NULL,
  mat_khau VARCHAR(128) NOT NULL,
  loai VARCHAR(20) DEFAULT 'nhanvien',
  ten VARCHAR(100) NOT NULL,
  ngay_vao_lam DATE,
  anh_dai_dien VARCHAR(255) DEFAULT NULL
);
CREATE INDEX idx_nguoidung_loai ON nguoidung(loai);

CREATE TABLE loaiphong(
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(100) NOT NULL,
  so_nguoi_toi_da INT DEFAULT 2 CHECK (so_nguoi_toi_da > 0),
  gia BIGINT DEFAULT 0 CHECK (gia >= 0)
);

CREATE TABLE phong(
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(50) UNIQUE NOT NULL,
  trang_thai VARCHAR(20) DEFAULT 'trong' CHECK (trang_thai IN ('trong', 'da_dat', 'dang_o', 'qua_gio')),
  loai_id INT NOT NULL,
  FOREIGN KEY (loai_id) REFERENCES loaiphong(id)
);
CREATE INDEX idx_phong_trang_thai ON phong(trang_thai);
CREATE INDEX idx_phong_loai_id ON phong(loai_id);
-- Bảng chấm công
CREATE TABLE attendance (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  checkin_time DATETIME NOT NULL,
  status VARCHAR(20) DEFAULT 'pending', -- pending, approved, rejected
  note VARCHAR(255),
  approved_by INT,
  approved_time DATETIME,
  FOREIGN KEY (user_id) REFERENCES nguoidung(id),
  FOREIGN KEY (approved_by) REFERENCES nguoidung(id)
);

CREATE TABLE khachhang(
  id INT PRIMARY KEY AUTO_INCREMENT,
  ho_ten VARCHAR(100) NOT NULL,
  cmnd VARCHAR(30) UNIQUE NOT NULL,
  sdt VARCHAR(30),
  email VARCHAR(120),
  dia_chi VARCHAR(200)
);
CREATE INDEX idx_khachhang_cmnd ON khachhang(cmnd);
CREATE INDEX idx_khachhang_email ON khachhang(email);
CREATE TABLE IF NOT EXISTS voucher (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(20) UNIQUE NOT NULL,
  khachhang_id INT NOT NULL,
  is_used BOOLEAN DEFAULT FALSE,
  created_at DATETIME,
  expires_at DATETIME,
  discount_percent INT DEFAULT 10 CHECK (discount_percent >= 0 AND discount_percent <= 100),
  used_at DATETIME,
  FOREIGN KEY (khachhang_id) REFERENCES khachhang(id),
  CHECK (expires_at >= created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE INDEX idx_voucher_khachhang_id ON voucher(khachhang_id);
CREATE INDEX idx_voucher_code ON voucher(code);

CREATE TABLE datphong(
  id INT PRIMARY KEY AUTO_INCREMENT,
  khachhang_id INT NOT NULL,
  phong_id INT NOT NULL,
  nhanvien_id INT NULL,
  hinh_thuc_thue VARCHAR(10) DEFAULT 'ngay' CHECK (hinh_thuc_thue IN ('ngay', 'gio')),
  ngay_nhan DATETIME NOT NULL,
  ngay_tra  DATETIME NOT NULL,
  thuc_te_nhan DATETIME NULL,
  thuc_te_tra  DATETIME NULL,
  so_dem INT DEFAULT 1 CHECK (so_dem >= 1),
  trang_thai VARCHAR(20) DEFAULT 'dat' CHECK (trang_thai IN ('dat', 'nhan', 'da_thanh_toan', 'huy', 'cho_xac_nhan', 'huy_timeout', 'waiting')),
  chat_token VARCHAR(36) UNIQUE NULL,
  payment_token VARCHAR(36) UNIQUE NULL,
  tien_coc BIGINT DEFAULT 0 CHECK (tien_coc >= 0),
  tien_phat BIGINT DEFAULT 0 CHECK (tien_phat >= 0),
  tien_phong BIGINT DEFAULT 0 CHECK (tien_phong >= 0),
  tien_dv BIGINT DEFAULT 0 CHECK (tien_dv >= 0),
  tong_thanh_toan BIGINT DEFAULT 0 CHECK (tong_thanh_toan >= 0),
  phuong_thuc_coc VARCHAR(20) DEFAULT NULL CHECK (phuong_thuc_coc IN ('cash', 'qr')),
  coc_da_thanh_toan BOOLEAN DEFAULT FALSE,
  phuong_thuc_thanh_toan VARCHAR(20) DEFAULT NULL CHECK (phuong_thuc_thanh_toan IN ('cash', 'qr')),
  voucher_id INT NULL,
  auto_confirmed_at DATETIME NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (khachhang_id) REFERENCES khachhang(id),
  FOREIGN KEY (phong_id) REFERENCES phong(id),
  FOREIGN KEY (nhanvien_id) REFERENCES nguoidung(id),
  FOREIGN KEY (voucher_id) REFERENCES voucher(id)
);
CREATE INDEX idx_datphong_trang_thai ON datphong(trang_thai);
CREATE INDEX idx_datphong_ngay_nhan ON datphong(ngay_nhan);
CREATE INDEX idx_datphong_khachhang_id ON datphong(khachhang_id);
CREATE INDEX idx_datphong_phong_id ON datphong(phong_id);
CREATE INDEX idx_datphong_chat_token ON datphong(chat_token);
CREATE TABLE dichvuloai(
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(100) NOT NULL
);

CREATE TABLE dichvu(
  id INT PRIMARY KEY AUTO_INCREMENT,
  ten VARCHAR(150) NOT NULL,
  gia BIGINT DEFAULT 0 CHECK (gia >= 0),
  loai_id INT NOT NULL,
  FOREIGN KEY (loai_id) REFERENCES dichvuloai(id)
);

CREATE TABLE sudungdv(
  id INT PRIMARY KEY AUTO_INCREMENT,
  datphong_id INT NOT NULL,
  dichvu_id INT NOT NULL,
  so_luong INT DEFAULT 1 CHECK (so_luong >= 1),
  thoi_gian DATETIME DEFAULT CURRENT_TIMESTAMP,
  trang_thai VARCHAR(20) DEFAULT 'chua_thanh_toan' CHECK (trang_thai IN ('chua_thanh_toan', 'cho_xac_nhan', 'da_thanh_toan')),
  FOREIGN KEY (datphong_id) REFERENCES datphong(id),
  FOREIGN KEY (dichvu_id) REFERENCES dichvu(id)
);

CREATE TABLE hethongcauhinh (
  id INT PRIMARY KEY AUTO_INCREMENT,
  `key` VARCHAR(100) UNIQUE NOT NULL,
  `value` VARCHAR(255),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tinnhan(
  id INT PRIMARY KEY AUTO_INCREMENT,
  datphong_id INT NOT NULL,
  nguoidung_id INT NULL,
  nguoi_gui VARCHAR(10) NOT NULL,
  noi_dung TEXT NOT NULL,
  thoi_gian DATETIME DEFAULT CURRENT_TIMESTAMP,
  trang_thai VARCHAR(20) DEFAULT 'chua_doc',
  FOREIGN KEY (datphong_id) REFERENCES datphong(id),
  FOREIGN KEY (nguoidung_id) REFERENCES nguoidung(id)
);
CREATE INDEX idx_tinnhan_datphong_id ON tinnhan(datphong_id);
CREATE INDEX idx_tinnhan_nguoi_gui ON tinnhan(nguoi_gui);

-- Bảng lưu lịch sử gửi email
CREATE TABLE IF NOT EXISTS email_log(
  id INT PRIMARY KEY AUTO_INCREMENT,
  recipient_email VARCHAR(255) NOT NULL,
  recipient_name VARCHAR(255),
  template_key VARCHAR(50),
  subject VARCHAR(255) NOT NULL,
  body TEXT,
  status VARCHAR(20) DEFAULT 'success' CHECK (status IN ('success', 'failed', 'pending')),
  error_message TEXT,
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  sent_by INT,
  datphong_id INT,
  khachhang_id INT,
  FOREIGN KEY (sent_by) REFERENCES nguoidung(id),
  FOREIGN KEY (datphong_id) REFERENCES datphong(id),
  FOREIGN KEY (khachhang_id) REFERENCES khachhang(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS emailtemplate(
  id INT PRIMARY KEY AUTO_INCREMENT,
  `key` VARCHAR(50) UNIQUE NOT NULL,
  subject VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO nguoidung(ten_dang_nhap,mat_khau,loai,ten,ngay_vao_lam) VALUES
('admin','admin','admin','Quản trị','2025-10-19'),
('nam','123','nhanvien','Hoàng Anh Nam','2025-10-19'),
('hoang','123','nhanvien','Nguyễn Bảo Hoàng','2025-10-19'),
('hung','123','nhanvien','Nguyễn Thế Hùng','2025-10-19');

INSERT INTO loaiphong(ten, so_nguoi_toi_da, gia) VALUES
('Phòng Tiêu chuẩn (Standard)', 2, 1500000),
('Phòng Hạng sang (Superior)', 3, 3000000),
('Phòng Cao cấp (Deluxe)', 4, 8000000),
('Phòng Tổng thống (Suite)', 5, 15000000);

INSERT INTO phong(ten,loai_id) VALUES
('Phòng 102',1),('Phòng 103',1),('Phòng 104',1),('Phòng 105',1),
('Phòng 106',1),('Phòng 201',1),('Phòng 202',1),('Phòng 203',1),
('Phòng 204',1),('Phòng 205',1),('Phòng 206',1),('Phòng 207',1),
('Phòng 208',1),('Phòng 209',1),('Phòng 301',2),('Phòng 302',2),
('Phòng 303',2),('Phòng 304',2),('Phòng 305',2),('Phòng 306',2),
('Phòng 307',2),('Phòng 308',2),('Phòng 309',2),('Phòng 401',3),
('Phòng 402',3),('Phòng 403',3),('Phòng 404',3),('Phòng 405',3),
('Phòng 406',3),('Phòng 407',3),('Phòng 408',3),('Phòng 409',3),
('Phòng 501',4),('Phòng 502',4),('Phòng 503',4),('Phòng 504',4),
('Phòng 505',4),('Phòng 506',4),('Phòng 507',4),('Phòng 508',4);
INSERT INTO dichvuloai(ten) VALUES ('Ăn uống'),('Giặt ủi'),('Khác');
INSERT INTO dichvu(ten,gia,loai_id) VALUES
('Mì xào bò', 80000, 1),
('Mực xào nấm', 150000, 1),
('Bia 333', 20000, 1),
('Bia Hà Nội', 20000, 1),
('Nước khoáng (500ml)', 10000, 1),
('Giặt ủi nhanh', 100000, 2),
('Đặt hoa (Phụ phí đặt hoa)', 50000, 3);

CREATE TABLE IF NOT EXISTS luongthuongcauhinh(
  id INT PRIMARY KEY AUTO_INCREMENT,
  moc_duoi BIGINT NOT NULL DEFAULT 0 CHECK (moc_duoi >= 0),
  moc_tren BIGINT NULL,
  ty_le DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (ty_le >= 0 AND ty_le <= 100),
  ghi_chu VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS luongnhanvien(
  id INT PRIMARY KEY AUTO_INCREMENT,
  nguoidung_id INT NOT NULL UNIQUE,
  luong_co_ban BIGINT DEFAULT 0 CHECK (luong_co_ban >= 0),
  phu_cap BIGINT DEFAULT 0 CHECK (phu_cap >= 0),
  FOREIGN KEY (nguoidung_id) REFERENCES nguoidung(id) ON DELETE CASCADE
);


INSERT INTO emailtemplate(`key`, subject, body) VALUES
-- 1. EMAIL XÁC NHẬN ĐẶT PHÒNG
('booking_confirmation', 
 'Xác nhận đặt phòng #{{ ma_dat_phong }} - {{ ten_khach_san }}', 
 '<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận đặt phòng</title>
</head>
<body style="margin: 0; padding: 0; font-family: ''Segoe UI'', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f4;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden;">
                    <tr>
                        <td style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 30px; text-align: center;">
                            <h1 style="color: #ffffff; margin: 0; font-size: 28px; font-weight: 600;">✅ Xác Nhận Đặt Phòng</h1>
                            <p style="color: #ffffff; margin: 10px 0 0 0; font-size: 16px; opacity: 0.95;">{{ ten_khach_san }}</p>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 40px 30px;">
                            <p style="font-size: 16px; color: #333333; margin: 0 0 20px 0; line-height: 1.6;">
                                Kính thưa <strong style="color: #667eea;">{{ ten_khach_hang }}</strong>,
                            </p>
                            <p style="font-size: 15px; color: #555555; margin: 0 0 30px 0; line-height: 1.6;">
                                Cảm ơn quý khách đã tin tưởng và đặt phòng tại <strong>{{ ten_khach_san }}</strong>!
                            </p>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8f9fa; border-radius: 8px; border-left: 4px solid #667eea; margin-bottom: 25px;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h2 style="color: #667eea; margin: 0 0 15px 0; font-size: 18px;">📋 Thông Tin Đặt Phòng</h2>
                                        <table width="100%" cellpadding="8" cellspacing="0">
                                            <tr>
                                                <td style="color: #666666; font-size: 14px;">Mã đặt phòng:</td>
                                                <td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">#{{ ma_dat_phong }}</td>
                                            </tr>
                                            <tr>
                                                <td style="color: #666666; font-size: 14px;">Phòng:</td>
                                                <td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ ten_phong }}{% if loai_phong %} ({{ loai_phong }}){% endif %}</td>
                                            </tr>
                                            <tr>
                                                <td style="color: #666666; font-size: 14px;">Check-in:</td>
                                                <td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ thoi_gian_nhan }}</td>
                                            </tr>
                                            <tr>
                                                <td style="color: #666666; font-size: 14px;">Check-out:</td>
                                                <td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ thoi_gian_tra }}</td>
                                            </tr>
                                            {% set so_luu_tru_value = so_luong_luu_tru or so_dem %}{% set don_vi_luu_tru_display = don_vi_luu_tru or ("đêm" if so_luu_tru_value else "") %}{% set nhan_luu_tru_display = nhan_luu_tru or "Số đêm lưu trú" %}{% if so_luu_tru_value %}<tr><td style="color: #666666; font-size: 14px;">{{ nhan_luu_tru_display }}:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ so_luu_tru_value }}{% if don_vi_luu_tru_display %} {{ don_vi_luu_tru_display }}{% endif %}</td></tr>{% endif %}
                                            {% if tien_coc %}<tr><td style="color: #666666; font-size: 14px;">Tiền cọc:</td><td style="color: #28a745; font-size: 14px; font-weight: 600; text-align: right;">{{ tien_coc }}</td></tr>{% endif %}
                                            <tr style="border-top: 2px solid #dee2e6;"><td style="color: #333333; font-size: 15px; font-weight: 600; padding: 10px 0 5px 0;">Tổng tiền:</td><td style="color: #667eea; font-size: 18px; font-weight: 700; text-align: right; padding: 10px 0 5px 0;">{{ tong_tien }}</td></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #e7f3ff; border-radius: 8px;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #0066cc; margin: 0 0 12px 0; font-size: 16px;">📞 Liên Hệ</h3>
                                        <p style="margin: 5px 0; color: #333333; font-size: 14px;"><strong>Hotline:</strong> {{ so_dien_thoai_khach_san }}</p>
                                        <p style="margin: 5px 0; color: #333333; font-size: 14px;"><strong>Địa chỉ:</strong> {{ dia_chi_khach_san }}</p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: #f8f9fa; padding: 25px 30px; text-align: center; border-top: 1px solid #dee2e6;">
                            <p style="margin: 0 0 5px 0; color: #666666; font-size: 14px;">Trân trọng,</p>
                            <p style="margin: 0; color: #333333; font-size: 16px; font-weight: 600;">{{ ten_khach_san }}</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>'),

-- 2. EMAIL THÔNG BÁO CHECK-IN
('checkin_notification', 
 'Chào mừng đến với {{ ten_khach_san }} 🏨', 
 '<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chào mừng check-in</title>
</head>
<body style="margin: 0; padding: 0; font-family: ''Segoe UI'', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f4;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden;">
                    <tr>
                        <td style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 40px 30px; text-align: center;">
                            <h1 style="color: #ffffff; margin: 0; font-size: 32px; font-weight: 600;">🎉 Chào Mừng!</h1>
                            <p style="color: #ffffff; margin: 10px 0 0 0; font-size: 18px; opacity: 0.95;">Đã nhận phòng thành công</p>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 40px 30px;">
                            <p style="font-size: 16px; color: #333333; margin: 0 0 15px 0; line-height: 1.6;">
                                Kính thưa <strong style="color: #f5576c;">{{ ten_khach_hang }}</strong>,
                            </p>
                            <p style="font-size: 15px; color: #555555; margin: 0 0 30px 0; line-height: 1.6;">
                                Chúng tôi rất vui được chào đón quý khách! Chúc quý khách có kỳ nghỉ tuyệt vời! 🎊
                            </p>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background: linear-gradient(135deg, #d4fc79 0%, #96e6a1 100%); border-radius: 12px; margin-bottom: 25px;">
                                <tr>
                                    <td style="padding: 25px; text-align: center;">
                                        <div style="font-size: 48px; margin-bottom: 10px;">✅</div>
                                        <h2 style="color: #2d5016; margin: 0 0 8px 0; font-size: 20px; font-weight: 700;">Đã Nhận Phòng</h2>
                                        <p style="color: #3d6622; margin: 0; font-size: 14px;">Mã: <strong>#{{ ma_dat_phong }}</strong></p>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8f9fa; border-radius: 8px; margin-bottom: 25px;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #333333; margin: 0 0 15px 0; font-size: 16px;">🏨 Thông Tin</h3>
                                        <table width="100%" cellpadding="6" cellspacing="0;">
                                            <tr><td style="color: #666666; font-size: 14px;">Phòng:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ ten_phong }}{% if loai_phong %} ({{ loai_phong }}){% endif %}</td></tr>
                                            <tr><td style="color: #666666; font-size: 14px;">Nhận phòng:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ thoi_gian_nhan_thuc_te }}</td></tr>
                                            <tr><td style="color: #666666; font-size: 14px;">Dự kiến trả:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ thoi_gian_tra }}</td></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #e3f2fd; border-radius: 8px;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #1976d2; margin: 0 0 12px 0; font-size: 16px;">📱 Hỗ Trợ</h3>
                                        <p style="margin: 5px 0; color: #333333; font-size: 13px;">� Quét QR trong phòng để chat</p>
                                        <p style="margin: 5px 0; color: #333333; font-size: 13px;">☎️ Gọi lễ tân: Nhấn <strong>0</strong></p>
                                        <p style="margin: 5px 0; color: #333333; font-size: 13px;">📞 Hotline: {{ so_dien_thoai_khach_san }}</p>
                                    </td>
                                </tr>
                            </table>
                            {% if voucher_moi %}<table width="100%" cellpadding="0" cellspacing="0" style="background: linear-gradient(135deg, #fff5d7 0%, #f9d787 100%); border-radius: 8px; border-left: 4px solid #f39c12; margin-bottom: 25px;"><tr><td style="padding: 20px;"><h3 style="color: #b36b00; margin: 0 0 12px 0; font-size: 16px;">🎁 Ưu đãi dành riêng cho bạn</h3><p style="margin: 5px 0; color: #5d3b00; font-size: 14px;">Mã voucher: <strong>{{ voucher_moi_code }}</strong></p>{% if voucher_moi_discount %}<p style="margin: 5px 0; color: #5d3b00; font-size: 14px;">Giảm giá: <strong>{{ voucher_moi_discount }}%</strong></p>{% endif %}{% if voucher_moi_han %}<p style="margin: 5px 0; color: #5d3b00; font-size: 14px;">Hạn sử dụng: <strong>{{ voucher_moi_han }}</strong></p>{% endif %}<p style="margin: 10px 0 0 0; color: #5d3b00; font-size: 13px;">Giữ lại mã này và nhập khi đặt phòng lần tiếp theo để nhận ưu đãi.</p></td></tr></table>{% endif %}
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: #f8f9fa; padding: 25px 30px; text-align: center; border-top: 1px solid #dee2e6;">
                            <p style="margin: 0 0 5px 0; color: #666666; font-size: 14px;">Trân trọng,</p>
                            <p style="margin: 0; color: #333333; font-size: 16px; font-weight: 600;">{{ ten_khach_san }}</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>'),

-- 3. EMAIL THÔNG BÁO HÓA ĐƠN
('invoice_notice', 
 'Hóa đơn thanh toán #{{ ma_dat_phong }} - {{ ten_khach_san }}', 
 '<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa đơn thanh toán</title>
</head>
<body style="margin: 0; padding: 0; font-family: ''Segoe UI'', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f4;">
    <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f4f4f4; padding: 20px 0;">
        <tr>
            <td align="center">
                <table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); overflow: hidden;">
                    <tr>
                        <td style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 30px; text-align: center;">
                            <div style="font-size: 48px; margin-bottom: 10px;">💰</div>
                            <h1 style="color: #ffffff; margin: 0; font-size: 28px; font-weight: 600;">HÓA ĐƠN THANH TOÁN</h1>
                            <p style="color: #ffffff; margin: 10px 0 0 0; font-size: 18px; opacity: 0.95;">#{{ ma_dat_phong }}</p>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 40px 30px;">
                            <p style="font-size: 16px; color: #333333; margin: 0 0 15px 0; line-height: 1.6;">
                                Kính thưa <strong style="color: #667eea;">{{ ten_khach_hang }}</strong>,
                            </p>
                            <p style="font-size: 15px; color: #555555; margin: 0 0 30px 0; line-height: 1.6;">
                                Cảm ơn quý khách đã sử dụng dịch vụ của <strong>{{ ten_khach_san }}</strong>!
                            </p>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #f8f9fa; border-radius: 8px; margin-bottom: 20px;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #333333; margin: 0 0 15px 0; font-size: 16px;">📋 Thông Tin</h3>
                                        <table width="100%" cellpadding="6" cellspacing="0">
                                            <tr><td style="color: #666666; font-size: 14px;">Phòng:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ ten_phong }}{% if loai_phong %} ({{ loai_phong }}){% endif %}</td></tr>
                                            <tr><td style="color: #666666; font-size: 14px;">Check-in:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ thoi_gian_nhan }}</td></tr>
                                            <tr><td style="color: #666666; font-size: 14px;">Check-out:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ thoi_gian_tra }}</td></tr>
                                            {% set so_luu_tru_value = so_luong_luu_tru or so_dem %}{% set don_vi_luu_tru_display = don_vi_luu_tru or ("đêm" if so_luu_tru_value else "") %}{% set nhan_luu_tru_display = nhan_luu_tru or "Số đêm lưu trú" %}{% if so_luu_tru_value %}<tr><td style="color: #666666; font-size: 14px;">{{ nhan_luu_tru_display }}:</td><td style="color: #333333; font-size: 14px; font-weight: 600; text-align: right;">{{ so_luu_tru_value }}{% if don_vi_luu_tru_display %} {{ don_vi_luu_tru_display }}{% endif %}</td></tr>{% endif %}
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); border-radius: 8px; margin-bottom: 20px;">
                                <tr>
                                    <td style="padding: 25px;">
                                        <h3 style="color: #2c3e50; margin: 0 0 20px 0; font-size: 18px; text-align: center;">💵 Chi Tiết</h3>
                                        <table width="100%" cellpadding="10" cellspacing="0">
                                            {% if tien_phong %}<tr><td style="color: #34495e; font-size: 15px; padding: 8px 0; border-bottom: 1px solid #bdc3c7;">Tiền phòng</td><td style="color: #2c3e50; font-size: 15px; font-weight: 600; text-align: right; padding: 8px 0; border-bottom: 1px solid #bdc3c7;">{{ tien_phong }}</td></tr>{% endif %}
                                            {% if tien_dich_vu and tien_dich_vu != "0 ₫" %}<tr><td style="color: #34495e; font-size: 15px; padding: 8px 0; border-bottom: 1px solid #bdc3c7;">Dịch vụ</td><td style="color: #2c3e50; font-size: 15px; font-weight: 600; text-align: right; padding: 8px 0; border-bottom: 1px solid #bdc3c7;">{{ tien_dich_vu }}</td></tr>{% endif %}
                                            {% if tien_phat and tien_phat != "0 ₫" %}<tr><td style="color: #34495e; font-size: 15px; padding: 8px 0; border-bottom: 1px solid #bdc3c7;">Phí phát sinh</td><td style="color: #e74c3c; font-size: 15px; font-weight: 600; text-align: right; padding: 8px 0; border-bottom: 1px solid #bdc3c7;">{{ tien_phat }}</td></tr>{% endif %}
                                            <tr style="background-color: rgba(255,255,255,0.3);"><td style="color: #2c3e50; font-size: 17px; font-weight: 700; padding: 12px 0;">TỔNG CỘNG</td><td style="color: #27ae60; font-size: 20px; font-weight: 700; text-align: right; padding: 12px 0;">{{ tong_tien }}</td></tr>
                                            {% if tien_coc and tien_coc != "0 ₫" %}<tr><td style="color: #34495e; font-size: 15px; padding: 8px 0; border-top: 2px dashed #bdc3c7;">Đã cọc trước</td><td style="color: #27ae60; font-size: 15px; font-weight: 600; text-align: right; padding: 8px 0; border-top: 2px dashed #bdc3c7;">-{{ tien_coc }}</td></tr>{% endif %}{% if tien_dich_vu_da_thanh_toan %}<tr><td style="color: #34495e; font-size: 15px; padding: 8px 0;">Đã thanh toán dịch vụ</td><td style="color: #27ae60; font-size: 15px; font-weight: 600; text-align: right; padding: 8px 0;">-{{ tien_dich_vu_da_thanh_toan }}</td></tr>{% endif %}
                                            {% if con_lai and con_lai != "0 ₫" %}<tr style="background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);"><td style="color: #ffffff; font-size: 18px; font-weight: 700; padding: 15px 10px; border-radius: 6px;">CÒN LẠI</td><td style="color: #ffffff; font-size: 22px; font-weight: 700; text-align: right; padding: 15px 10px; border-radius: 6px;">{{ con_lai }}</td></tr>{% endif %}
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            {% if chi_tiet_dich_vu and chi_tiet_dich_vu != "Không sử dụng dịch vụ" %}<table width="100%" cellpadding="0" cellspacing="0" style="background-color: #e8f5e9; border-radius: 8px; border-left: 4px solid #4caf50; margin-bottom: 25px;"><tr><td style="padding: 20px;"><h3 style="color: #2e7d32; margin: 0 0 12px 0; font-size: 16px;">📋 Dịch Vụ</h3><div style="color: #1b5e20; font-size: 13px; line-height: 1.8; white-space: pre-line;">{{ chi_tiet_dich_vu }}</div></td></tr></table>{% endif %}
                            <table width="100%" cellpadding="0" cellspacing="0" style="background: linear-gradient(135deg, #ffeaa7 0%, #fdcb6e 100%); border-radius: 8px; margin-bottom: 20px;">
                                <tr>
                                    <td style="padding: 20px; text-align: center;">
                                        <p style="margin: 0; color: #8b4513; font-size: 16px; font-weight: 600; line-height: 1.8;">⭐ Cảm ơn quý khách!<br>⭐ Rất mong được phục vụ lại!</p>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%" cellpadding="0" cellspacing="0" style="background-color: #e3f2fd; border-radius: 8px;">
                                <tr>
                                    <td style="padding: 20px;">
                                        <h3 style="color: #1976d2; margin: 0 0 12px 0; font-size: 16px;">📞 Liên Hệ</h3>
                                        <p style="margin: 5px 0; color: #333333; font-size: 14px;"><strong>Hotline:</strong> {{ so_dien_thoai_khach_san }}</p>
                                        <p style="margin: 5px 0; color: #333333; font-size: 14px;"><strong>Địa chỉ:</strong> {{ dia_chi_khach_san }}</p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="background-color: #f8f9fa; padding: 25px 30px; text-align: center; border-top: 1px solid #dee2e6;">
                            <p style="margin: 0 0 5px 0; color: #666666; font-size: 14px;">Trân trọng,</p>
                            <p style="margin: 0 0 3px 0; color: #333333; font-size: 16px; font-weight: 600;">{{ ten_khach_san }}</p>
                            <p style="margin: 0; color: #999999; font-size: 13px;">📞 {{ so_dien_thoai_khach_san }} | 📍 {{ dia_chi_khach_san }}</p>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>');
