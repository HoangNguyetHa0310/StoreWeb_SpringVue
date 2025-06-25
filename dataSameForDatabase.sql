-- ================================================
-- SAMPLE DATA INSERT QUERIES - E-COMMERCE DATABASE
-- ================================================

-- 1. Bảng USERS - 5 users mẫu
INSERT INTO users (email, password_hash, first_name, last_name, phone, is_active)
VALUES ('john.doe@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John', 'Doe',
        '0901234567', true),
       ('jane.smith@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane', 'Smith',
        '0902345678', true),
       ('mike.johnson@yahoo.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Mike', 'Johnson',
        '0903456789', true),
       ('sarah.wilson@hotmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Sarah', 'Wilson',
        '0904567890', true),
       ('david.brown@gmail.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'David', 'Brown',
        '0905678901', false);

-- 2. Bảng ADDRESSES - 5 địa chỉ mẫu
INSERT INTO addresses (user_id, address_type, street_address, city, state_province, postal_code, country, is_default)
VALUES (1, 'shipping', '123 Nguyễn Huệ', 'Hồ Chí Minh', 'Hồ Chí Minh', '700000', 'Vietnam', true),
       (1, 'billing', '456 Lê Lợi', 'Hồ Chí Minh', 'Hồ Chí Minh', '700000', 'Vietnam', false),
       (2, 'shipping', '789 Trần Hưng Đạo', 'Hà Nội', 'Hà Nội', '100000', 'Vietnam', true),
       (3, 'shipping', '321 Hoàng Diệu', 'Đà Nẵng', 'Đà Nẵng', '550000', 'Vietnam', true),
       (4, 'shipping', '654 Võ Văn Tần', 'Cần Thơ', 'Cần Thơ', '900000', 'Vietnam', true);

-- 3. Bảng CATEGORIES - 5 danh mục mẫu
INSERT INTO categories (name, slug, description, parent_id, is_active)
VALUES ('Điện tử', 'dien-tu', 'Các sản phẩm điện tử tiêu dùng', NULL, true),
       ('Điện thoại & Phụ kiện', 'dien-thoai-phu-kien', 'Điện thoại thông minh và phụ kiện', 1, true),
       ('Laptop & Máy tính', 'laptop-may-tinh', 'Laptop, PC và linh kiện máy tính', 1, true),
       ('Thời trang', 'thoi-trang', 'Quần áo, giày dép, phụ kiện thời trang', NULL, true),
       ('Nhà cửa & Đời sống', 'nha-cua-doi-song', 'Đồ gia dụng, nội thất, trang trí', NULL, true);

-- 4. Bảng PRODUCTS - 5 sản phẩm mẫu
INSERT INTO products (name, slug, description, sku, category_id, price, sale_price, stock_quantity, image_url, status,
                      is_featured)
VALUES ('iPhone 15 Pro Max 256GB', 'iphone-15-pro-max-256gb',
        'Điện thoại iPhone 15 Pro Max với chip A17 Pro, camera tiên tiến', 'IPH15PM256', 2, 29990000, 28500000, 50,
        'https://example.com/iphone15.jpg', 'active', true),
       ('MacBook Air M2 13 inch', 'macbook-air-m2-13-inch', 'Laptop MacBook Air với chip M2, màn hình 13.6 inch Retina',
        'MBA13M2', 3, 27990000, NULL, 30, 'https://example.com/macbook-air.jpg', 'active', true),
       ('Samsung Galaxy S24 Ultra', 'samsung-galaxy-s24-ultra', 'Điện thoại Samsung flagship với S Pen, camera 200MP',
        'SGS24U', 2, 26990000, 25500000, 25, 'https://example.com/galaxy-s24.jpg', 'active', false),
       ('Áo Polo Nam Premium', 'ao-polo-nam-premium', 'Áo polo nam chất liệu cotton cao cấp, form slim fit', 'POLO001',
        4, 350000, 280000, 100, 'https://example.com/polo-shirt.jpg', 'active', false),
       ('Ghế Gaming DXRacer', 'ghe-gaming-dxracer', 'Ghế gaming ergonomic với đệm memory foam, điều chỉnh độ cao',
        'CHAIR001', 5, 4990000, NULL, 15, 'https://example.com/gaming-chair.jpg', 'active', true);

-- 5. Bảng SHOPPING_CARTS - 5 giỏ hàng mẫu
INSERT INTO shopping_carts (user_id, session_id)
VALUES (1, NULL),
       (2, NULL),
       (3, NULL),
       (4, 'sess_abc123xyz'),
       (NULL, 'sess_def456uvw');

-- 6. Bảng CART_ITEMS - 5 items trong giỏ hàng
INSERT INTO cart_items (cart_id, product_id, quantity, price)
VALUES (1, 1, 1, 28500000),
       (1, 4, 2, 280000),
       (2, 2, 1, 27990000),
       (3, 3, 1, 25500000),
       (4, 5, 1, 4990000);

-- 7. Bảng COUPONS - 5 mã giảm giá mẫu
INSERT INTO coupons (code, name, discount_type, discount_value, minimum_amount, usage_limit, used_count, is_active,
                     valid_from, valid_until)
VALUES ('WELCOME10', 'Mã giảm giá chào mừng', 'percentage', 10.00, 500000, 100, 15, true, '2024-01-01 00:00:00',
        '2024-12-31 23:59:59'),
       ('FREESHIP', 'Miễn phí vận chuyển', 'fixed', 50000, 1000000, 200, 45, true, '2024-01-01 00:00:00',
        '2024-12-31 23:59:59'),
       ('BLACKFRIDAY', 'Black Friday Sale', 'percentage', 25.00, 2000000, 50, 30, true, '2024-11-20 00:00:00',
        '2024-11-30 23:59:59'),
       ('NEWUSER50', 'Người dùng mới giảm 50k', 'fixed', 50000, 300000, NULL, 8, true, '2024-01-01 00:00:00',
        '2024-12-31 23:59:59'),
       ('VIP20', 'Khách hàng VIP giảm 20%', 'percentage', 20.00, 5000000, 20, 5, true, '2024-01-01 00:00:00',
        '2024-12-31 23:59:59');

-- 8. Bảng ORDERS - 5 đơn hàng mẫu
INSERT INTO orders (order_number, user_id, status, subtotal, tax_amount, shipping_cost, discount_amount, total_amount,
                    coupon_id, shipping_address, billing_address, notes)
VALUES ('ORD001', 1, 'delivered', 29070000, 0, 50000, 2907000, 26213000, 1,
        '{"street":"123 Nguyễn Huệ","city":"Hồ Chí Minh","country":"Vietnam"}',
        '{"street":"456 Lê Lợi","city":"Hồ Chí Minh","country":"Vietnam"}', 'Giao hàng giờ hành chính'),
       ('ORD002', 2, 'processing', 27990000, 0, 0, 50000, 27940000, 2,
        '{"street":"789 Trần Hưng Đạo","city":"Hà Nội","country":"Vietnam"}',
        '{"street":"789 Trần Hưng Đạo","city":"Hà Nội","country":"Vietnam"}', NULL),
       ('ORD003', 3, 'shipped', 25500000, 0, 50000, 0, 25550000, NULL,
        '{"street":"321 Hoàng Diệu","city":"Đà Nẵng","country":"Vietnam"}',
        '{"street":"321 Hoàng Diệu","city":"Đà Nẵng","country":"Vietnam"}', 'Gọi trước khi giao'),
       ('ORD004', 4, 'pending', 4990000, 0, 50000, 0, 5040000, NULL,
        '{"street":"654 Võ Văn Tần","city":"Cần Thơ","country":"Vietnam"}',
        '{"street":"654 Võ Văn Tần","city":"Cần Thơ","country":"Vietnam"}', NULL),
       ('ORD005', 1, 'cancelled', 350000, 0, 30000, 35000, 345000, 1,
        '{"street":"123 Nguyễn Huệ","city":"Hồ Chí Minh","country":"Vietnam"}',
        '{"street":"123 Nguyễn Huệ","city":"Hồ Chí Minh","country":"Vietnam"}', 'Khách hủy do thay đổi ý kiến');

-- 9. Bảng ORDER_ITEMS - 5 chi tiết đơn hàng
INSERT INTO order_items (order_id, product_id, product_name, product_sku, quantity, unit_price, total_price)
VALUES (1, 1, 'iPhone 15 Pro Max 256GB', 'IPH15PM256', 1, 28500000, 28500000),
       (1, 4, 'Áo Polo Nam Premium', 'POLO001', 2, 280000, 560000),
       (2, 2, 'MacBook Air M2 13 inch', 'MBA13M2', 1, 27990000, 27990000),
       (3, 3, 'Samsung Galaxy S24 Ultra', 'SGS24U', 1, 25500000, 25500000),
       (4, 5, 'Ghế Gaming DXRacer', 'CHAIR001', 1, 4990000, 4990000);

-- 10. Bảng PAYMENTS - 5 thanh toán mẫu
INSERT INTO payments (order_id, amount, payment_method, status, transaction_id)
VALUES (1, 26213000, 'credit_card', 'completed', 'TXN_CC_001'),
       (2, 27940000, 'bank_transfer', 'completed', 'TXN_BT_002'),
       (3, 25550000, 'paypal', 'completed', 'TXN_PP_003'),
       (4, 5040000, 'cash_on_delivery', 'pending', NULL),
       (5, 345000, 'credit_card', 'refunded', 'TXN_CC_005');

-- 11. Bảng PRODUCT_REVIEWS - 5 đánh giá sản phẩm
INSERT INTO product_reviews (product_id, user_id, order_id, rating, title, review_text, is_approved)
VALUES (1, 1, 1, 5, 'iPhone tuyệt vời!',
        'Sản phẩm chất lượng cao, camera rất đẹp, hiệu năng mượt mà. Rất hài lòng với mua hàng.', true),
       (2, 2, 2, 4, 'MacBook Air ổn', 'Máy nhẹ, pin tốt, phù hợp cho công việc văn phòng. Chỉ tiếc là RAM hơi ít.',
        true),
       (3, 3, 3, 5, 'Galaxy S24 Ultra xuất sắc',
        'S Pen rất tiện dụng, camera zoom cực kỳ ấn tượng. Đáng đồng tiền bát gạo.', true),
       (4, 1, 1, 3, 'Áo polo bình thường',
        'Chất liệu ổn nhưng màu sắc không được như hình. Size hơi nhỏ so với bảng size.', false),
       (5, 4, 4, 4, 'Ghế gaming thoải mái',
        'Ngồi làm việc cả ngày không bị mỏi lưng. Lắp ráp hơi phức tạp nhưng chất lượng tốt.', true);

-- ================================================
-- VERIFY DATA WITH SELECT QUERIES
-- ================================================

-- Kiểm tra dữ liệu đã insert
SELECT 'Users' as table_name, COUNT(*) as record_count
FROM users
UNION ALL
SELECT 'Addresses', COUNT(*)
FROM addresses
UNION ALL
SELECT 'Categories', COUNT(*)
FROM categories
UNION ALL
SELECT 'Products', COUNT(*)
FROM products
UNION ALL
SELECT 'Shopping Carts', COUNT(*)
FROM shopping_carts
UNION ALL
SELECT 'Cart Items', COUNT(*)
FROM cart_items
UNION ALL
SELECT 'Coupons', COUNT(*)
FROM coupons
UNION ALL
SELECT 'Orders', COUNT(*)
FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*)
FROM order_items
UNION ALL
SELECT 'Payments', COUNT(*)
FROM payments
UNION ALL
SELECT 'Product Reviews', COUNT(*)
FROM product_reviews;