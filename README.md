# StoreWeb - Spring Boot + Vue 3 + MySQL + Docker

Bản README này hướng dẫn bạn cách khởi chạy project **StoreWeb** — một ứng dụng mẫu (Spring Boot backend, Vue 3 frontend, MySQL DB) đã được cấu hình sẵn để chạy bằng Docker Compose.

## Nội dung trong repository
- `backend/` - Spring Boot application (Java, Maven)
- `frontend/` - Vue 3 + Vite app
- `docker-compose.yml` - Dùng để build & chạy 3 service: db (MySQL), backend, frontend

---

## Yêu cầu
- Docker & Docker Compose
- Java 22 và Maven (nếu bạn muốn chạy backend local)
- Node.js (nếu bạn muốn chạy frontend local)

---

## Cách chạy nhanh bằng Docker (recommended)
1. Clone repository (trên máy mới):
```bash
git clone https://github.com/HoangNguyetHa0310/StoreWeb_SpringVue.git
cd StoreWeb_SpringVue
```

2. Build & start các service:
```bash
docker compose up --build -d
```

3. Mở trên browser:
- Frontend: http://localhost:8081
- Backend (API): http://localhost:8080/api/products

4. Stop các service:
```bash
docker compose down
```

---

## Phát triển cục bộ (không dùng Docker)

### Backend (Spring Boot)
1. Đi vào folder backend:
```bash
cd backend
```
2. Chạy bằng maven (Java 22):
```bash
mvn -U spring-boot:run
```
Hoặc build jar:
```bash
mvn -B -DskipTests package
java -jar target/backend-0.0.1-SNAPSHOT.jar
```
3. Mặc định backend dùng port 8080 và kết nối MySQL theo biến môi trường DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASSWORD.

Lưu ý: backend bây giờ yêu cầu Java 22 (JDK 22). Nếu bạn chạy cục bộ, hãy cài Java 22 hoặc dùng SDKMAN/jenv để chuyển.

### Frontend (Vite + Vue)
1. Đi vào folder frontend:
```bash
cd frontend
npm ci
npm run dev
```
Dev server mặc định đặt proxy `/api` đến `http://localhost:8080`, vì vậy bạn có thể chạy backend ở `localhost:8080` và phát triển frontend đồng thời.

---

## Biến môi trường và các lưu ý
- Trong `docker-compose.yml`, hiện tại đã map các cổng sang host:
	- DB: `3307:3306` (host:container)
	- Backend: `8080:8080`
	- Frontend: `8081:80`
- Nếu muốn dùng `3306`/`80` trên host, bạn cần đảm bảo host không đang chạy dịch vụ khác tại port đó.
- Endpoint product: `/api/products` – hỗ trợ GET/POST/PUT/DELETE.

---

## Các lệnh Git cơ bản để khởi tạo repo trên máy mới
Sau khi clone repo, bạn có thể bật repo thành GitHub (nếu cần):
```bash
# Nếu bạn tạo repo mới, thực hiện (nếu chưa có):
# (Ví dụ user-provided steps)
echo "# StoreWeb_SpringVue" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M master
git remote add origin https://github.com/HoangNguyetHa0310/StoreWeb_SpringVue.git
git push -u origin master
```
> Lưu ý: Lệnh `git push` có thể yêu cầu xác thực. Bạn có thể cấu hình SSH key hoặc GitHub token trong Git config.

---

## Cách sửa lỗi thông dụng
- Lỗi port conflict: đổi mapping port trong `docker-compose.yml` hoặc tắt dịch vụ chiếm port đó.
- Lỗi DB kết nối: kiểm tra username/password và DB_NAME.