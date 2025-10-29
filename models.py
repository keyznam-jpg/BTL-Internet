# -*- coding: utf-8 -*-
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

db = SQLAlchemy()

class Role(db.Model):
    __tablename__ = "role"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)
    slug = db.Column(db.String(50), unique=True, nullable=False)
    description = db.Column(db.String(255))
    is_system = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.now)
    users = db.relationship("NguoiDung", backref="role", lazy=True)
    permissions = db.relationship(
        "RolePermission",
        backref="role",
        lazy=True,
        cascade="all, delete-orphan"
    )

    def __repr__(self):
        return f"<Role {self.slug}>"


class RolePermission(db.Model):
    __tablename__ = "role_permission"
    id = db.Column(db.Integer, primary_key=True)
    role_id = db.Column(db.Integer, db.ForeignKey("role.id", ondelete="CASCADE"), nullable=False)
    permission = db.Column(db.String(100), nullable=False)

    __table_args__ = (
        db.UniqueConstraint("role_id", "permission", name="uq_role_permission"),
    )

    def __repr__(self):
        return f"<RolePermission role={self.role_id} perm={self.permission}>"


class UserPermission(db.Model):
    __tablename__ = "user_permission"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("nguoidung.id", ondelete="CASCADE"), nullable=False)
    permission = db.Column(db.String(100), nullable=False)

    __table_args__ = (
        db.UniqueConstraint("user_id", "permission", name="uq_user_permission"),
    )

    def __repr__(self):
        return f"<UserPermission user={self.user_id} perm={self.permission}>"


class NguoiDung(UserMixin, db.Model):
    __tablename__ = "nguoidung"
    id = db.Column(db.Integer, primary_key=True)
    ten_dang_nhap = db.Column(db.String(50), unique=True, nullable=False)
    mat_khau = db.Column(db.String(128), nullable=False)
    loai = db.Column(db.String(20), default="nhanvien")
    role_id = db.Column(db.Integer, db.ForeignKey("role.id"))
    ten  = db.Column(db.String(100), nullable=False)
    ngay_vao_lam = db.Column(db.Date)
    anh_dai_dien = db.Column(db.String(255))
    personal_permissions = db.relationship(
        "UserPermission",
        backref="user",
        lazy=True,
        cascade="all, delete-orphan"
    )
    def get_id(self): return str(self.id)

    @property
    def avatar_path(self):
        if self.anh_dai_dien:
            return self.anh_dai_dien.replace('\\', '/')
        return "img/ttcn.png"

    @property
    def role_slug(self):
        if self.role and self.role.slug:
            return self.role.slug
        return self.loai

    @property
    def role_name(self):
        if self.role and self.role.name:
            return self.role.name
        default_labels = {
            'admin': 'Quản trị viên',
            'nhanvien': 'Nhân viên',
        }
        if not self.loai:
            return ''
        return default_labels.get(self.loai, self.loai.replace('_', ' ').title())

    def has_permission(self, permission_key):
        if not permission_key:
            return True
        # Admin (system) role always allowed
        if self.role and self.role.is_system:
            return True
        if self.loai == 'admin':
            return True
        # Check personal allowances first
        if any(up.permission == permission_key for up in self.personal_permissions):
            return True
        if not self.role:
            return False
        return any(rp.permission == permission_key for rp in self.role.permissions)

class LoaiPhong(db.Model):
    __tablename__ = "loaiphong"
    id = db.Column(db.Integer, primary_key=True)
    ten = db.Column(db.String(100), nullable=False)
    so_nguoi_toi_da = db.Column(db.Integer, default=2)
    gia  = db.Column(db.BIGINT, default=0)
    phongs = db.relationship("Phong", backref="loai", lazy=True)

class Phong(db.Model):
    __tablename__ = "phong"
    id = db.Column(db.Integer, primary_key=True)
    ten = db.Column(db.String(50), unique=True, nullable=False)
    trang_thai = db.Column(db.String(20), default="trong")
    loai_id = db.Column(db.Integer, db.ForeignKey("loaiphong.id"), nullable=False)

class KhachHang(db.Model):
    __tablename__ = "khachhang"
    id = db.Column(db.Integer, primary_key=True)
    ho_ten = db.Column(db.String(100), nullable=False)
    cmnd   = db.Column(db.String(30), unique=True, nullable=False)
    sdt    = db.Column(db.String(30))
    email  = db.Column(db.String(120))
    dia_chi = db.Column(db.String(200))

class DatPhong(db.Model):
    __tablename__ = "datphong"
    id = db.Column(db.Integer, primary_key=True)
    khachhang_id = db.Column(db.Integer, db.ForeignKey("khachhang.id"), nullable=False)
    phong_id = db.Column(db.Integer, db.ForeignKey("phong.id"), nullable=False)
    nhanvien_id = db.Column(db.Integer, db.ForeignKey("nguoidung.id"))
    hinh_thuc_thue = db.Column(db.String(10), default='ngay', nullable=False)
    ngay_nhan = db.Column(db.DateTime, nullable=False)
    ngay_tra  = db.Column(db.DateTime, nullable=False)
    thuc_te_nhan = db.Column(db.DateTime)
    thuc_te_tra  = db.Column(db.DateTime)
    so_dem = db.Column(db.Integer, default=1)
    trang_thai = db.Column(db.String(20), default="dat")
    chat_token = db.Column(db.String(36), unique=True)
    payment_token = db.Column(db.String(36), unique=True)
    tien_coc = db.Column(db.BIGINT, default=0)
    tien_phat = db.Column(db.BIGINT, default=0)
    tien_phong = db.Column(db.BIGINT, default=0)
    tien_dv = db.Column(db.BIGINT, default=0)
    tong_thanh_toan = db.Column(db.BIGINT, default=0)
    phuong_thuc_thanh_toan = db.Column(db.String(20))
    phuong_thuc_coc = db.Column(db.String(20))
    coc_da_thanh_toan = db.Column(db.Boolean, default=False)
    voucher_id = db.Column(db.Integer, db.ForeignKey("voucher.id"), nullable=True)
    auto_confirmed_at = db.Column(db.DateTime)
    created_at = db.Column(db.DateTime, default=datetime.now)
    voucher = db.relationship("Voucher")
    khachhang = db.relationship("KhachHang")
    phong = db.relationship("Phong")
    nhanvien = db.relationship("NguoiDung")

class DichVuLoai(db.Model):
    __tablename__ = "dichvuloai"
    id = db.Column(db.Integer, primary_key=True)
    ten = db.Column(db.String(100), nullable=False)
    dichvus = db.relationship("DichVu", backref="loai", lazy=True)

class DichVu(db.Model):
    __tablename__ = "dichvu"
    id = db.Column(db.Integer, primary_key=True)
    ten = db.Column(db.String(150), nullable=False)
    gia = db.Column(db.BIGINT, default=0)
    loai_id = db.Column(db.Integer, db.ForeignKey("dichvuloai.id"), nullable=False)

class SuDungDichVu(db.Model):
    __tablename__ = "sudungdv"
    id = db.Column(db.Integer, primary_key=True)
    datphong_id = db.Column(db.Integer, db.ForeignKey("datphong.id"), nullable=False)
    dichvu_id   = db.Column(db.Integer, db.ForeignKey("dichvu.id"), nullable=False)
    so_luong = db.Column(db.Integer, default=1)
    thoi_gian = db.Column(db.DateTime, default=datetime.now)
    trang_thai = db.Column(db.String(20), default='chua_thanh_toan')
    datphong = db.relationship("DatPhong")
    dichvu   = db.relationship("DichVu")

class TinNhan(db.Model):
    __tablename__ = "tinnhan"
    id = db.Column(db.Integer, primary_key=True)
    datphong_id = db.Column(db.Integer, db.ForeignKey("datphong.id"), nullable=False)
    nguoidung_id = db.Column(db.Integer, db.ForeignKey("nguoidung.id"))
    nguoi_gui = db.Column(db.String(10), nullable=False)
    noi_dung = db.Column(db.Text, nullable=False)
    thoi_gian = db.Column(db.DateTime, default=datetime.now)
    trang_thai = db.Column(db.String(20), default='chua_doc')
    datphong = db.relationship("DatPhong")
    nguoidung = db.relationship("NguoiDung")

class PaymentSession(db.Model):
    __tablename__ = "payment_session"
    id = db.Column(db.Integer, primary_key=True)
    token = db.Column(db.String(64), unique=True, nullable=False, index=True)
    kind = db.Column(db.String(20), nullable=False)
    payload = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.now)

class LuongThuongCauHinh(db.Model):
    __tablename__ = "luongthuongcauhinh"
    id = db.Column(db.Integer, primary_key=True)
    moc_duoi = db.Column(db.BIGINT, nullable=False, default=0)
    moc_tren = db.Column(db.BIGINT)
    ty_le = db.Column(db.Float, nullable=False, default=0.0)
    ghi_chu = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, default=datetime.now)

class LuongNhanVien(db.Model):
    __tablename__ = "luongnhanvien"
    id = db.Column(db.Integer, primary_key=True)
    nguoidung_id = db.Column(db.Integer, db.ForeignKey("nguoidung.id"), unique=True, nullable=False)
    luong_co_ban = db.Column(db.BIGINT, default=0)
    phu_cap = db.Column(db.BIGINT, default=0)
    nguoidung = db.relationship("NguoiDung", backref=db.backref("thong_tin_luong", uselist=False))

class Voucher(db.Model):
    __tablename__ = "voucher"
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(20), unique=True, nullable=False)
    khachhang_id = db.Column(db.Integer, db.ForeignKey("khachhang.id"), nullable=False)
    is_used = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.now)
    expires_at = db.Column(db.DateTime)
    discount_percent = db.Column(db.Integer, default=10)  # 10% mặc định
    used_at = db.Column(db.DateTime)
    khachhang = db.relationship("KhachHang")

class HeThongCauHinh(db.Model):
    __tablename__ = "hethongcauhinh"
    id = db.Column(db.Integer, primary_key=True)
    key = db.Column(db.String(100), unique=True, nullable=False)
    value = db.Column(db.String(255))
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)

class EmailTemplate(db.Model):
    __tablename__ = "emailtemplate"
    id = db.Column(db.Integer, primary_key=True)
    key = db.Column(db.String(50), unique=True, nullable=False)
    subject = db.Column(db.String(255), nullable=False)
    body = db.Column(db.Text, nullable=False)
    updated_at = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)

class EmailLog(db.Model):
    __tablename__ = "email_log"
    id = db.Column(db.Integer, primary_key=True)
    recipient_email = db.Column(db.String(255), nullable=False)
    recipient_name = db.Column(db.String(255))
    template_key = db.Column(db.String(50))
    subject = db.Column(db.String(255), nullable=False)
    body = db.Column(db.Text)
    status = db.Column(db.String(20), default='success')  # success, failed, pending
    error_message = db.Column(db.Text)
    sent_at = db.Column(db.DateTime, default=datetime.now)
    sent_by = db.Column(db.Integer, db.ForeignKey("nguoidung.id"))
    datphong_id = db.Column(db.Integer, db.ForeignKey("datphong.id"))
    khachhang_id = db.Column(db.Integer, db.ForeignKey("khachhang.id"))
    
    # Relationships
    sender = db.relationship("NguoiDung", foreign_keys=[sent_by])
    booking = db.relationship("DatPhong", foreign_keys=[datphong_id])
    customer = db.relationship("KhachHang", foreign_keys=[khachhang_id])

class Attendance(db.Model):
    __tablename__ = "attendance"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("nguoidung.id"), nullable=False)
    checkin_time = db.Column(db.DateTime, nullable=False, default=datetime.now)
    status = db.Column(db.String(20), default="pending") # pending, approved, rejected
    note = db.Column(db.String(255))
    approved_by = db.Column(db.Integer, db.ForeignKey("nguoidung.id"))
    approved_time = db.Column(db.DateTime)
    user = db.relationship("NguoiDung", foreign_keys=[user_id])
    approver = db.relationship("NguoiDung", foreign_keys=[approved_by])
