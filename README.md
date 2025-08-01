# 🛍️ StoreWeb – Website Thương Mại Điện Tử Fullstack (Vue 3 + Spring Boot)

> Dự án xây dựng hệ thống thương mại điện tử hiện đại, sử dụng **Vue 3 (Composition API + TypeScript)** cho frontend và **Spring Boot (Java 21 + PostgreSQL)** cho backend. Bao gồm: xác thực người dùng, giỏ hàng, đặt hàng, dashboard quản trị và triển khai thực tế.

---

## 📘 Giới thiệu dự án

**StoreWeb** là một hệ thống web bán hàng hoàn chỉnh được thiết kế theo kiến trúc fullstack, giúp thực hành toàn bộ quy trình xây dựng ứng dụng hiện đại:

- Xác thực người dùng bằng JWT
- Quản lý sản phẩm (CRUD)
- Giỏ hàng & đặt hàng
- Dashboard quản trị + biểu đồ
- Giao diện thân thiện, responsive
- CI/CD + Docker + Triển khai thực tế

---

## 🚀 Công nghệ sử dụng

### 🔧 Backend
- Java 21 + Spring Boot
- Spring Security (JWT)
- Spring Data JPA
- PostgreSQL
- Docker
- Cấu hình: `application.yml`
- **DI**: Sử dụng `@Autowired` (tránh lỗi constructor khi số lượng service lớn)
- **Chuẩn DB**: đặt tên cột theo dạng `under_score`

### 🎨 Frontend
- Vue 3 + Composition API
- TypeScript
- Vue Router
- Pinia (quản lý trạng thái)
- Axios (dùng `async/await`)
- Element Plus (UI Framework hiện đại)
- Chart.js (biểu đồ dữ liệu)

---

## 📅 Lộ trình phát triển (4 tuần)

**Tổng thời gian:** 20 ngày làm việc (trừ T7 & CN)  
**Mỗi ngày:** ~2–3 giờ

### 🗓️ Tuần 1 – Khởi tạo dự án & chức năng nền tảng

| Ngày   | Backend                                  | Frontend                            | Ghi chú                          |
|--------|------------------------------------------|-------------------------------------|----------------------------------|
| Thứ 2  | Tạo project Spring Boot, cấu trúc lại     | Khởi tạo Vue 3 + TS, Router         | Thiết lập môi trường & Git       |
| Thứ 3  | Kết nối PostgreSQL, tạo bảng User/Product| Trang chủ                            | Test API sơ bộ                   |
| Thứ 4  | CRUD Product (DTO, service)              | Hiển thị danh sách sản phẩm         | Gọi API bằng Axios               |
| Thứ 5  | CRUD User, mã hóa mật khẩu               | Form đăng ký/đăng nhập              | Xử lý validate + gọi API         |
| Thứ 6  | Hoàn thiện API User/Product              | Tích hợp login, quản lý token       | LocalStorage, RouteGuard         |

### 🗓️ Tuần 2 – Bảo mật & đặt hàng

| Ngày   | Backend                                  | Frontend                            | Ghi chú                          |
|--------|------------------------------------------|-------------------------------------|----------------------------------|
| Thứ 2  | JWT + Spring Security                    | Lưu token, bảo vệ route             | Middleware & Auth logic          |
| Thứ 3  | Entity Order, OrderItem + API            | Giao diện giỏ hàng                  | Quản lý cart bằng Pinia          |
| Thứ 4  | API đặt hàng                             | Giao diện thanh toán                | Xác nhận, toast                  |
| Thứ 5  | API lịch sử đơn hàng                     | Danh sách + chi tiết đơn hàng       | Table, Dialog                    |
| Thứ 6  | Phân quyền USER/ADMIN                    | Bảo vệ route theo vai trò           | UI loading/error state           |

### 🗓️ Tuần 3 – Giao diện nâng cao & dashboard

| Ngày   | Backend                                  | Frontend                            | Ghi chú                          |
|--------|------------------------------------------|-------------------------------------|----------------------------------|
| Thứ 2  | API quản lý sản phẩm                     | Refactor layout dùng Element Plus   | Component hóa UI                 |
| Thứ 3  | API quản lý đơn toàn hệ thống            | Trang admin dashboard               | Table + Pagination               |
| Thứ 4  | API thống kê doanh thu                   | Biểu đồ Chart.js                    | Xử lý format dữ liệu             |
| Thứ 5  | Tối ưu truy vấn & cache                  | Responsive + animation              | Kiểm thử hiệu suất               |
| Thứ 6  | Rà soát hệ thống                         | Trang lỗi 404/500, UI hoàn chỉnh    | Fix bug + polish UI              |

### 🗓️ Tuần 4 – Triển khai & CI/CD

| Ngày   | Backend                                  | Frontend                            | Ghi chú                          |
|--------|------------------------------------------|-------------------------------------|----------------------------------|
| Thứ 2  | Viết tài liệu API / cấu hình OpenAPI (nếu cần) | Viết hướng dẫn sử dụng UI          | README, tài liệu người dùng      |
| Thứ 3  | Docker hóa backend                       | Build frontend tĩnh                 | Kiểm thử Docker                  |
| Thứ 4  | Deploy lên Railway / Render / VPS        | Test hoạt động online               | CORS, cấu hình SSL (nếu có)      |
| Thứ 5  | CI/CD cho backend (GitHub Actions)       | CI frontend + badge                 | Test tự động, clean build        |
| Thứ 6  | Viết Unit Test                           | UI Test (tuỳ chọn)                  | Chuẩn bị video demo              |

---

## 🔑 Các tính năng chính

- ✅ Quản lý người dùng, sản phẩm (CRUD đầy đủ)
- 🔐 Đăng ký, đăng nhập, JWT, phân quyền USER/ADMIN
- 🛒 Thêm giỏ hàng, đặt hàng, lịch sử đơn
- 📊 Dashboard admin + thống kê bằng biểu đồ
- 📱 UI responsive, chia component hợp lý
- 🐳 Docker, CI/CD, triển khai thực tế

---

[//]: # ()
[//]: # (## 📂 Cấu trúc dự án &#40;sơ lược&#41;)

[//]: # ()
[//]: # (### Backend &#40;Spring Boot&#41;)

[//]: # (store-backend/)

[//]: # (└── src/)

[//]: # (└── main/)

[//]: # (├── java/)

[//]: # (│   └── com/example/store/)

[//]: # (│       ├── controller/     # Các REST API controller)

[//]: # (│       ├── service/        # Xử lý logic nghiệp vụ)

[//]: # (│       ├── repository/     # Giao tiếp với database &#40;JPA&#41;)

[//]: # (│       ├── model/          # Entity & DTO)

[//]: # (│       └── config/         # Cấu hình bảo mật, CORS, JWT)

[//]: # (└── resources/)

[//]: # (├── application.yml     # Cấu hình hệ thống &#40;DB, JWT, CORS, ...&#41;)

[//]: # (└── static/             # &#40;Tùy chọn&#41; File tĩnh nếu cần)

[//]: # ()
[//]: # ()
[//]: # (### Frontend &#40;Vue 3 + TS&#41;)

[//]: # (store-frontend/)

[//]: # (└── src/)

[//]: # (├── views/                        # Các trang chính &#40;Home, Login, Admin, etc.&#41;)

[//]: # (├── components/                   # Component dùng lại được)

[//]: # (│   ├── product/                  # Thành phần liên quan đến sản phẩm)

[//]: # (│   ├── user/                     # Thành phần người dùng &#40;form, profile, etc.&#41;)

[//]: # (│   └── admin/                    # Dashboard, thống kê, quản trị)

[//]: # (├── store/                        # State management &#40;Pinia&#41;)

[//]: # (├── router/                       # Định tuyến ứng dụng)

[//]: # (├── utils/                        # Hàm tiện ích &#40;auth, validate, etc.&#41;)

[//]: # (└── services/                     # Gọi API &#40;axios&#41;)
![img.png](img.png)
---

## 👨‍💻 Tác giả

**👤 Tên:** Hoàng Trần  

---

## 📌 Gợi ý cải thiện (nếu làm nhóm / mở rộng)
- Viết Unit Test cho cả BE và FE
- Tách role ADMIN/User kỹ hơn
- Thêm refresh token
- Quản lý trạng thái async tốt hơn với loading global
- Hỗ trợ đa ngôn ngữ (i18n)

---