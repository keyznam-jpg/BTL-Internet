-- Thêm cột co_voucher vào bảng loaiphong (nếu chưa có)
ALTER TABLE loaiphong
ADD COLUMN IF NOT EXISTS co_voucher BOOLEAN DEFAULT FALSE COMMENT 'Có tặng voucher khi đặt phòng loại này';

-- Đánh dấu các loại phòng hiện có kèm voucher
UPDATE loaiphong
SET co_voucher = TRUE
WHERE LOWER(ten) LIKE '%cao cấp%' OR LOWER(ten) LIKE '%tổng thống%';

-- Kiểm tra kết quả
SELECT id, ten, co_voucher FROM loaiphong ORDER BY ten;
