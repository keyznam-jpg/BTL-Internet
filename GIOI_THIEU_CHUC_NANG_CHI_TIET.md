# GIỚI THIỆU CHI TIẾT CÁC CHỨC NĂNG CỦA HỆ THỐNG QUẢN LÝ KHÁCH SẠN PTIT

## LỜI MỞ ĐẦU

Chào mừng bạn đến với hệ thống quản lý khách sạn PTIT - một giải pháp toàn diện và hiện đại cho việc quản lý các hoạt động hàng ngày của một khách sạn. Hệ thống này được phát triển bằng công nghệ web tiên tiến, sử dụng Python Flask làm backend và HTML/CSS/JavaScript cho frontend, kết hợp với cơ sở dữ liệu MySQL để lưu trữ dữ liệu một cách an toàn và hiệu quả.

Hệ thống được thiết kế để phục vụ cả hai đối tượng chính: nhân viên quản lý khách sạn và khách hàng muốn đặt phòng online. Với giao diện thân thiện, dễ sử dụng và các chức năng phong phú, hệ thống giúp tối ưu hóa quy trình làm việc, tăng hiệu quả kinh doanh và nâng cao trải nghiệm khách hàng.

Trong tài liệu này, chúng tôi sẽ giới thiệu chi tiết từng chức năng của hệ thống, từ những tính năng cơ bản như đăng nhập, quản lý phòng, đến các tính năng nâng cao như chat real-time, thanh toán QR, quản lý lương thưởng và báo cáo thống kê. Mỗi chức năng sẽ được mô tả một cách chi tiết, bao gồm cách truy cập, giao diện, các bước thực hiện và các lưu ý quan trọng.

## 1. HỆ THỐNG ĐĂNG NHẬP VÀ PHÂN QUYỀN

### 1.1. Tổng quan về hệ thống đăng nhập

Hệ thống đăng nhập là cửa ngõ đầu tiên mà người dùng phải trải qua để truy cập vào các chức năng quản lý của khách sạn. Hệ thống sử dụng Flask-Login để quản lý phiên đăng nhập một cách an toàn, với cơ chế bảo mật cao để ngăn chặn các cuộc tấn công như brute force hay session hijacking.

Có hai loại tài khoản chính trong hệ thống:
- **Admin**: Có quyền truy cập đầy đủ tất cả các chức năng
- **Nhân viên**: Có quyền hạn chế dựa trên phân quyền chi tiết

### 1.2. Giao diện đăng nhập

Trang đăng nhập có thiết kế đơn giản nhưng chuyên nghiệp với:
- Logo khách sạn PTIT ở phía trên
- Form đăng nhập với hai trường: Tên đăng nhập và Mật khẩu
- Nút "Đăng Nhập" với hiệu ứng hover
- Link "Đặt phòng với tư cách khách" cho khách hàng không có tài khoản

### 1.3. Quy trình đăng nhập

1. Truy cập URL gốc của hệ thống
2. Hệ thống tự động chuyển hướng đến trang đăng nhập nếu chưa đăng nhập
3. Nhập tên đăng nhập và mật khẩu
4. Click nút "Đăng Nhập" hoặc nhấn Enter
5. Nếu thông tin đúng, hệ thống chuyển đến trang dashboard
6. Nếu sai, hiển thị thông báo lỗi màu đỏ

### 1.4. Tài khoản mặc định

Hệ thống cung cấp các tài khoản mẫu để dễ dàng testing:
- Admin: username "admin", password "admin"
- Nhân viên: "nam"/"123", "hoang"/"123", "hung"/"123"

### 1.5. Bảo mật đăng nhập

- Mật khẩu được hash bằng werkzeug.security trước khi lưu vào database
- Session timeout tự động sau một thời gian không hoạt động
- CSRF protection cho các form
- Role-based access control với permissions chi tiết

### 1.6. Đăng xuất

Để đăng xuất, click vào tên người dùng ở góc phải trên cùng của sidebar và chọn "Đăng xuất". Hệ thống sẽ xóa session và chuyển về trang đăng nhập.

## 2. DASHBOARD - TRANG TỔNG QUAN

### 2.1. Mục đích của dashboard

Dashboard là trang chủ của hệ thống, cung cấp cái nhìn tổng quan về tình hình hoạt động của khách sạn trong ngày. Đây là nơi nhân viên có thể nhanh chóng nắm bắt các thông tin quan trọng như số lượng check-in/check-out, phòng đang sử dụng, tin nhắn mới, v.v.

### 2.2. Các thành phần chính của dashboard

#### 2.2.1. Thẻ thống kê (Stats Cards)

Dashboard hiển thị 4 thẻ thống kê chính:

1. **Check-in hôm nay**: Hiển thị số lượng khách check-in trong ngày
   - Icon: Biểu tượng mũi tên vào
   - Màu: Xanh dương
   - Link: Chuyển đến trang nhận phòng

2. **Check-out hôm nay**: Hiển thị số lượng khách check-out trong ngày
   - Icon: Biểu tượng mũi tên ra
   - Màu: Cam
   - Link: Chuyển đến trang nhận phòng

3. **Phòng có khách**: Hiển thị tỷ lệ phòng đang sử dụng
   - Icon: Biểu tượng ngôi nhà
   - Màu: Xanh lá
   - Hiển thị dạng "X/Y phòng" (đang dùng/tổng số)
   - Link: Chuyển đến sơ đồ phòng

4. **Tin nhắn mới**: Hiển thị số tin nhắn chưa đọc
   - Icon: Biểu tượng chat
   - Màu: Tím
   - Hiển thị danh sách 3 tin nhắn gần nhất
   - Link: Chuyển đến trang tin nhắn

#### 2.2.2. Danh sách tin nhắn gần đây

Phần này hiển thị các tin nhắn chưa đọc gần nhất, bao gồm:
- Tên phòng
- Thời gian gửi
- Nội dung tin nhắn (cắt ngắn nếu quá dài)

### 2.3. Sidebar điều hướng

Sidebar bên trái chứa menu điều hướng với các nhóm chức năng:

1. **Tổng quan**
   - Bảng điều khiển (Dashboard)
   - Chấm công
   - Phê duyệt chấm công (chỉ admin)

2. **Quản lý Phòng**
   - Sơ đồ phòng
   - Đặt phòng
   - Đặt phòng online
   - Nhận & Trả phòng
   - Booking chờ

3. **Khách hàng**
   - Tin nhắn
   - Quản lý Khách hàng
   - Tài khoản khách hàng

4. **Dịch vụ & Tài chính**
   - Dịch vụ & Thanh toán
   - Quản lý Hóa đơn
   - Thanh toán chưa hoàn tất

5. **Quản trị Nhân sự**
   - Quản lý Nhân viên
   - Cài đặt lương thưởng

6. **Vận hành & Cấu hình**
   - Quản lý Vai trò
   - Cấu hình Email
   - Lịch sử Email
   - Quản lý Dịch vụ

7. **Thống kê & Báo cáo**
   - Thống kê Doanh thu
   - Thống kê Khách hàng

### 2.4. Thông báo toast

Hệ thống sử dụng toast notifications để hiển thị các thông báo quan trọng như:
- Thành công: Màu xanh lá
- Cảnh báo: Màu vàng
- Lỗi: Màu đỏ

Toast tự động biến mất sau vài giây hoặc có thể đóng bằng nút X.

## 3. QUẢN LÝ PHÒNG

### 3.1. Sơ đồ phòng

#### 3.1.1. Mục đích

Trang sơ đồ phòng cung cấp cái nhìn trực quan về trạng thái tất cả các phòng trong khách sạn. Nhân viên có thể nhanh chóng biết được phòng nào còn trống, phòng nào đang có khách, phòng nào đã được đặt trước.

#### 3.1.2. Giao diện

- Hiển thị dạng lưới với các ô vuông đại diện cho từng phòng
- Mỗi phòng hiển thị:
  - Số phòng (ví dụ: Phòng 102)
  - Loại phòng (Tiêu chuẩn, Superior, Deluxe, Suite)
  - Trạng thái (màu sắc khác nhau)
  - Giá phòng

#### 3.1.3. Màu sắc trạng thái phòng

- **Xanh lá**: Phòng trống
- **Xanh dương**: Đã đặt
- **Đỏ**: Đang ở
- **Cam**: Quá giờ

#### 3.1.4. Chức năng tương tác

- Click vào phòng để xem chi tiết đặt phòng
- Bộ lọc theo trạng thái phòng
- Bộ lọc theo loại phòng
- Tìm kiếm theo số phòng

#### 3.1.5. Thông tin chi tiết phòng

Khi click vào một phòng, hiển thị popup với:
- Thông tin phòng: số, loại, giá
- Thông tin đặt phòng hiện tại (nếu có)
- Lịch sử đặt phòng
- Nút hành động: Đặt phòng, Nhận phòng, Trả phòng

### 3.2. Đặt phòng offline

#### 3.2.1. Quy trình đặt phòng

1. Chọn phòng từ sơ đồ hoặc danh sách
2. Nhập thông tin khách hàng:
   - Họ tên
   - CMND/CCCD
   - Số điện thoại
   - Email
   - Địa chỉ
3. Chọn thời gian:
   - Ngày nhận phòng
   - Ngày trả phòng
   - Hình thức thuê (ngày/giờ)
4. Tính toán tiền cọc (30% giá phòng)
5. Xác nhận đặt phòng

#### 3.2.2. Tính năng nâng cao

- Tự động kiểm tra trùng lịch
- Tính giá theo loại phòng và số đêm
- Tạo token chat riêng cho mỗi đặt phòng
- Gửi email xác nhận tự động

### 3.3. Đặt phòng online

#### 3.3.1. Giao diện khách hàng

Trang đặt phòng online dành cho khách hàng không có tài khoản, với:
- Form chọn ngày nhận/trả
- Hiển thị phòng trống theo ngày
- Thông tin giá cả
- Form thông tin cá nhân

#### 3.3.2. Quy trình đặt phòng online

1. Khách hàng chọn ngày ở
2. Hệ thống hiển thị phòng trống
3. Khách hàng chọn phòng và nhập thông tin
4. Tính tiền cọc và tạo QR thanh toán
5. Khách hàng thanh toán cọc
6. Nhân viên xác nhận thanh toán
7. Gửi email xác nhận

#### 3.3.3. Quản lý đặt phòng online (Admin/Nhân viên)

- Danh sách đặt phòng chờ xác nhận
- Xem chi tiết từng đặt phòng
- Xác nhận hoặc từ chối
- Gửi tin nhắn cho khách hàng

## 4. QUẢN LÝ NHẬN/TRẢ PHÒNG

### 4.1. Trang nhận phòng

#### 4.1.1. Chức năng chính

- Hiển thị danh sách đặt phòng hôm nay
- Check-in khách hàng
- Cập nhật trạng thái phòng
- Tạo hóa đơn tạm thời

#### 4.1.2. Quy trình check-in

1. Chọn đặt phòng từ danh sách
2. Xác nhận thông tin khách hàng
3. Cập nhật thời gian nhận phòng thực tế
4. Đổi trạng thái phòng thành "đang ở"
5. Tạo chat room cho khách hàng

### 4.2. Trang trả phòng

#### 4.2.1. Chức năng chính

- Hiển thị danh sách phòng đang ở
- Tính toán tiền phòng và dịch vụ
- Check-out khách hàng
- Xuất hóa đơn

#### 4.2.2. Quy trình check-out

1. Chọn phòng cần trả
2. Tính toán tổng tiền:
   - Tiền phòng
   - Tiền dịch vụ bổ sung
   - Phạt quá giờ (nếu có)
3. Chọn phương thức thanh toán
4. In/xuất hóa đơn
5. Cập nhật trạng thái phòng thành "trống"

### 4.3. Quản lý phạt và phụ thu

- Tự động tính phạt quá giờ
- Thêm phụ thu thủ công
- Lưu lịch sử phạt

## 5. HỆ THỐNG THANH TOÁN

### 5.1. Phương thức thanh toán

Hệ thống hỗ trợ hai phương thức thanh toán chính:

#### 5.1.1. Tiền mặt
- Thanh toán trực tiếp tại quầy
- Ghi nhận thủ công bởi nhân viên
- In hóa đơn ngay lập tức

#### 5.1.2. Chuyển khoản QR (VietQR)
- Tích hợp với các ngân hàng Việt Nam
- Tạo QR code tự động
- Xác nhận thanh toán real-time

### 5.2. Quản lý session thanh toán

- Mỗi thanh toán có session riêng với timeout 5 phút
- Token unique cho mỗi giao dịch
- Bảo mật cao, ngăn chặn replay attacks

### 5.3. Các loại thanh toán

#### 5.3.1. Thanh toán cọc
- 30% giá phòng (có thể cấu hình)
- Thanh toán online qua QR
- Xác nhận thủ công bởi nhân viên

#### 5.3.2. Thanh toán đầy đủ
- Thanh toán khi check-out
- Bao gồm tiền phòng + dịch vụ
- Hỗ trợ thanh toán một phần

#### 5.3.3. Thanh toán dịch vụ
- Thanh toán riêng cho dịch vụ bổ sung
- Có thể thanh toán nhiều lần
- Lưu lịch sử thanh toán

### 5.4. Hóa đơn và biên lai

- Tự động tạo hóa đơn PDF
- Xuất Excel cho báo cáo
- Lưu trữ điện tử
- In ấn trực tiếp

## 6. QUẢN LÝ DỊCH VỤ BỔ SUNG

### 6.1. Danh mục dịch vụ

#### 6.1.1. Cấu trúc dịch vụ

- Phân loại dịch vụ (ăn uống, giặt ủi, khác)
- Tên dịch vụ
- Giá cả
- Mô tả

#### 6.1.2. Quản lý danh mục

- Thêm/sửa/xóa dịch vụ
- Phân loại dịch vụ
- Cập nhật giá

### 6.2. Đặt dịch vụ trong phòng

#### 6.2.1. Quy trình đặt dịch vụ

1. Chọn phòng đang ở
2. Chọn dịch vụ từ danh mục
3. Nhập số lượng
4. Xác nhận đặt

#### 6.2.2. Trạng thái dịch vụ

- Chưa thanh toán
- Đã thanh toán

### 6.3. Thanh toán dịch vụ

- Thanh toán riêng biệt với tiền phòng
- Tích lũy vào tổng hóa đơn
- Lưu lịch sử sử dụng

## 7. HỆ THỐNG GIAO TIẾP

### 7.1. Chat real-time

#### 7.1.1. Công nghệ sử dụng

- Flask-SocketIO cho real-time communication
- WebSocket protocol
- Room-based chat (mỗi đặt phòng có room riêng)

#### 7.1.2. Giao diện chat

- Danh sách phòng có tin nhắn
- Cửa sổ chat với lịch sử tin nhắn
- Input box để gửi tin nhắn
- Upload file (ảnh, tài liệu)

#### 7.1.3. Chức năng chat

- Gửi tin nhắn text
- Upload file
- Hiển thị trạng thái đã đọc/chưa đọc
- Notification cho tin nhắn mới

### 7.2. Quản lý tin nhắn

#### 7.2.1. Trang tin nhắn

- Danh sách tất cả phòng có chat
- Số tin nhắn chưa đọc
- Thời gian tin nhắn gần nhất

#### 7.2.2. Chi tiết tin nhắn

- Lịch sử chat đầy đủ
- Thông tin khách hàng
- Nút hành động: Gửi tin nhắn, Đóng chat

## 8. HỆ THỐNG EMAIL TỰ ĐỘNG

### 8.1. Template email

#### 8.1.1. Các loại template

- Xác nhận đặt phòng
- Nhắc nhở thanh toán
- Thông báo check-in
- Cảm ơn sau khi ở
- Voucher khuyến mãi

#### 8.1.2. Tùy chỉnh template

- Editor HTML cho nội dung
- Biến động (tên khách, số phòng, v.v.)
- Preview trước khi gửi

### 8.2. Cấu hình SMTP

- Server SMTP (Gmail, Outlook, v.v.)
- Port và bảo mật (SSL/TLS)
- Tài khoản gửi email
- Mật khẩu ứng dụng

### 8.3. Gửi email tự động

- Trigger theo sự kiện (đặt phòng, thanh toán, v.v.)
- Gửi hàng loạt
- Lịch sử gửi email

### 8.4. Lịch sử email

- Danh sách email đã gửi
- Trạng thái (thành công/thất bại)
- Nội dung email
- Thời gian gửi

## 9. HỆ THỐNG VOUCHER

### 9.1. Cấu hình voucher

#### 9.1.1. Thông số chung

- Tỷ lệ giảm giá mặc định (10%)
- Thời hạn voucher (60 ngày)
- Tự động tạo voucher cho khách hàng

#### 9.1.2. Quy tắc tạo voucher

- Tạo sau khi check-out thành công
- Code unique ngẫu nhiên
- Hạn sử dụng tự động

### 9.2. Quản lý voucher

#### 9.2.1. Danh sách voucher

- Tất cả voucher của hệ thống
- Lọc theo trạng thái (chưa dùng/đã dùng/hết hạn)
- Tìm kiếm theo code hoặc tên khách

#### 9.2.2. Chi tiết voucher

- Thông tin khách hàng
- Mã voucher
- Tỷ lệ giảm giá
- Ngày tạo và hết hạn
- Trạng thái sử dụng

### 9.3. Áp dụng voucher

- Kiểm tra tính hợp lệ của voucher
- Tính toán giảm giá
- Cập nhật trạng thái sau khi sử dụng

## 10. QUẢN LÝ NHÂN VIÊN

### 10.1. Danh sách nhân viên

#### 10.1.1. Thông tin nhân viên

- Tên đăng nhập
- Tên đầy đủ
- Ngày vào làm
- Ảnh đại diện
- Vai trò (admin/nhanvien)

#### 10.1.2. Chức năng quản lý

- Thêm nhân viên mới
- Sửa thông tin
- Xóa nhân viên
- Upload ảnh đại diện

### 10.2. Hệ thống chấm công

#### 10.2.1. Chấm công hàng ngày

- Form chấm công đơn giản
- Ghi nhận thời gian check-in
- Thêm ghi chú (nếu có)

#### 10.2.2. Phê duyệt chấm công (Admin)

- Danh sách chấm công chờ duyệt
- Duyệt hoặc từ chối
- Thêm ghi chú phê duyệt

#### 10.2.3. Lịch sử chấm công

- Lịch chấm công cá nhân
- Thống kê số ngày làm việc
- Báo cáo chấm công

### 10.3. Quản lý lương thưởng

#### 10.3.1. Lương cơ bản

- Lương cơ bản cho từng nhân viên
- Phụ cấp (nếu có)

#### 10.3.2. Tính thưởng

- Cấu hình mức thưởng theo doanh thu
- Tự động tính thưởng hàng tháng
- Công thức tính thưởng linh hoạt

#### 10.3.3. Báo cáo lương

- Lương tháng cho từng nhân viên
- Chi tiết thành phần lương
- Xuất báo cáo lương

## 11. HỆ THỐNG BÁO CÁO VÀ THỐNG KÊ

### 11.1. Thống kê doanh thu

#### 11.1.1. Báo cáo theo thời gian

- Doanh thu theo ngày/tháng/năm
- Biểu đồ trực quan
- Xuất Excel/PDF

#### 11.1.2. Chi tiết doanh thu

- Doanh thu từ phòng
- Doanh thu từ dịch vụ
- Doanh thu theo loại phòng

### 11.2. Thống kê khách hàng

#### 11.2.1. Thông tin khách hàng

- Danh sách tất cả khách hàng
- Lịch sử đặt phòng
- Tổng chi tiêu

#### 11.2.2. Phân tích khách hàng

- Khách hàng thường xuyên
- Doanh thu theo khách hàng
- Thống kê theo vùng miền

### 11.3. Báo cáo phòng

- Tỷ lệ lấp đầy phòng
- Doanh thu theo phòng
- Lịch sử sử dụng phòng

### 11.4. Báo cáo dịch vụ

- Dịch vụ được sử dụng nhiều nhất
- Doanh thu theo dịch vụ
- Thống kê theo thời gian

## 12. CÀI ĐẶT HỆ THỐNG

### 12.1. Cài đặt email

#### 12.1.1. Cấu hình SMTP

- Server và port
- Tài khoản email
- Mật khẩu ứng dụng
- Test gửi email

#### 12.1.2. Quản lý template

- Danh sách template
- Chỉnh sửa nội dung
- Preview template

### 12.2. Cài đặt lương thưởng

#### 12.2.1. Cấu hình thưởng

- Mức thưởng theo doanh thu
- Công thức tính thưởng
- Áp dụng cho tháng sau

#### 12.2.2. Quản lý lương cơ bản

- Cập nhật lương nhân viên
- Thêm phụ cấp
- Lịch sử thay đổi lương

### 12.3. Cài đặt voucher

- Tỷ lệ giảm giá mặc định
- Thời hạn voucher
- Tự động tạo voucher

### 12.4. Quản lý vai trò

- Tạo và chỉnh sửa vai trò
- Phân quyền chi tiết cho từng vai trò
- Gán vai trò cho nhân viên

### 12.5. Quản lý dịch vụ

- Thêm/sửa/xóa danh mục dịch vụ
- Quản lý loại dịch vụ
- Cập nhật giá dịch vụ

## 13. BẢO MẬT VÀ AN TOÀN

### 13.1. Bảo mật dữ liệu

- Mã hóa mật khẩu (werkzeug.security)
- SQLAlchemy parameterized queries chống SQL injection
- CSRF protection cho forms
- Input validation và sanitization

### 13.2. Quản lý phiên

- Session timeout tự động
- Flask-Login session management
- Secure token cho payment sessions

### 13.3. Phân quyền

- Role-based access control
- Permission-based system
- Personal permissions cho từng user

### 13.4. Giám sát hệ thống

- Log các hoạt động quan trọng
- Error handling
- File upload security

## 14. HƯỚNG DẪN SỬ DỤNG CHI TIẾT

### 14.1. Quy trình làm việc hàng ngày

#### 14.1.1. Buổi sáng

1. Đăng nhập hệ thống
2. Kiểm tra dashboard để nắm tình hình
3. Xem tin nhắn mới từ khách hàng
4. Chuẩn bị cho check-in

#### 14.1.2. Trong ngày

1. Xử lý đặt phòng online
2. Check-in khách hàng
3. Theo dõi tình trạng phòng
4. Phục vụ dịch vụ cho khách
5. Xử lý thanh toán

#### 14.1.3. Buổi tối

1. Check-out khách hàng
2. Xuất báo cáo ngày
3. Sao lưu dữ liệu
4. Đăng xuất

### 14.2. Xử lý tình huống đặc biệt

#### 14.2.1. Khách hàng đến muộn

- Vẫn giữ phòng nếu đã thanh toán cọc
- Thông báo qua chat/email
- Tính phụ thu nếu quá giờ quy định

#### 14.2.2. Phòng bị hỏng

- Chuyển khách sang phòng khác
- Cập nhật trạng thái phòng
- Thông báo bảo trì

#### 14.2.3. Khiếu nại dịch vụ

- Ghi nhận khiếu nại
- Xử lý kịp thời
- Bồi thường nếu cần

### 14.3. Mẹo và thủ thuật

#### 14.3.1. Tăng hiệu quả làm việc

- Sử dụng shortcut keys
- Tùy chỉnh dashboard
- Thiết lập notification

#### 14.3.2. Quản lý thời gian

- Ưu tiên task quan trọng
- Sử dụng reminder
- Phân công công việc

## 15. PHỤ LỤC

### 15.1. Database schema chi tiết

#### Bảng chính:
- **role**: Quản lý vai trò và quyền
- **role_permission**: Liên kết quyền với vai trò
- **user_permission**: Quyền cá nhân của user
- **nguoidung**: Thông tin nhân viên
- **loaiphong**: Loại phòng (Tiêu chuẩn, Superior, Deluxe, Suite)
- **phong**: Thông tin phòng
- **khachhang**: Thông tin khách hàng
- **datphong**: Đặt phòng
- **dichvuloai**: Loại dịch vụ
- **dichvu**: Danh mục dịch vụ
- **sudungdv**: Sử dụng dịch vụ
- **tinnhan**: Chat messages
- **payment_session**: Session thanh toán
- **luongthuongcauhinh**: Cấu hình thưởng
- **luongnhanvien**: Lương nhân viên
- **voucher**: Mã giảm giá
- **hethongcauhinh**: Cấu hình hệ thống
- **emailtemplate**: Template email
- **email_log**: Lịch sử email
- **attendance**: Chấm công

#### Các trường quan trọng:
- **datphong**: id, khachhang_id, phong_id, nhanvien_id, ngay_nhan, ngay_tra, trang_thai, tien_coc, tien_phong, tien_dv, tong_thanh_toan, chat_token, payment_token, voucher_id
- **khachhang**: id, ho_ten, cmnd, sdt, email, dia_chi, mat_khau_hash, diem_tich_luy
- **nguoidung**: id, ten_dang_nhap, mat_khau, loai, role_id, ten, ngay_vao_lam, anh_dai_dien

### 15.2. Cấu hình production

#### Environment variables
```bash
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DB=Internet
SECRET_KEY=your_secret_key
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your_email
SMTP_PASSWORD=your_app_password
VIETQR_BANK_ID=970423
VIETQR_ACCOUNT_NO=99992162001
VIETQR_BANK_NAME=TPBank
VIETQR_ACCOUNT_NAME=Khách sạn PTIT
DEPOSIT_PERCENT=0.3
```

#### Nginx config (tùy chọn)
```nginx
server {
    listen 80;
    server_name your-domain.com;
    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## KẾT LUẬN

Hệ thống quản lý khách sạn PTIT là một giải pháp toàn diện, hiện đại và dễ sử dụng cho các khách sạn muốn số hóa quy trình quản lý. Với các tính năng phong phú từ đặt phòng online, thanh toán QR, chat real-time đến quản lý nhân viên và báo cáo thống kê, hệ thống giúp nâng cao hiệu quả kinh doanh và trải nghiệm khách hàng.

Hệ thống được xây dựng trên nền tảng công nghệ vững chắc với Python Flask 3.0.0, MySQL và các thư viện hiện đại, đảm bảo tính ổn định, bảo mật và khả năng mở rộng. Giao diện thân thiện, dễ sử dụng cùng với tài liệu hướng dẫn chi tiết giúp nhân viên có thể làm quen và sử dụng hệ thống một cách nhanh chóng.

Chúng tôi cam kết sẽ tiếp tục phát triển và cải thiện hệ thống dựa trên phản hồi từ người dùng, đồng thời nghiên cứu và tích hợp các công nghệ mới để đáp ứng nhu cầu ngày càng cao của thị trường khách sạn.

Cảm ơn bạn đã quan tâm đến hệ thống quản lý khách sạn PTIT!

---

*Tài liệu này được cập nhật dựa trên mã nguồn thực tế của hệ thống. Cập nhật lần cuối: Tháng 10/2025*