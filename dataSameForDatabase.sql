
-- ================================================
-- COMPREHENSIVE SAMPLE DATA FOR DATABASE STORE WEBSITE
-- ================================================

-- Thêm dữ liệu mẫu cho user roles
INSERT INTO user_roles (role_name, description)
VALUES ('admin', 'Administrator with full access'),
       ('customer', 'Regular customer'),
       ('vendor', 'Product vendor'),
       ('moderator', 'Content moderator');

-- Thêm dữ liệu mẫu cho users
INSERT INTO users (email, password_hash, first_name, last_name, phone, date_of_birth, gender, is_active, email_verified)
VALUES ('admin@store.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Admin', 'User',
        '0123456789', '1990-01-01', 'other', true, true),
       ('john.doe@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'John', 'Doe',
        '0987654321', '1985-05-15', 'male', true, true),
       ('jane.smith@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Jane', 'Smith',
        '0912345678', '1992-08-22', 'female', true, true),
       ('vendor@store.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Vendor', 'User',
        '0898765432', '1988-12-10', 'male', true, true),
       ('customer@email.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Customer', 'Test',
        '0876543210', '1995-03-18', 'female', true, false);

-- Phân quyền người dùng
INSERT INTO user_role_assignments (user_id, role_id)
VALUES (1, 1), -- Admin role for admin user
       (2, 2), -- Customer role for John
       (3, 2), -- Customer role for Jane
       (4, 3), -- Vendor role for vendor
       (5, 2);
-- Customer role for test customer

-- Thêm địa chỉ cho users
INSERT INTO addresses (user_id, address_type, street_address, city, state_province, postal_code, country, is_default)
VALUES (2, 'shipping', '123 Nguyen Van Linh', 'Ho Chi Minh City', 'Ho Chi Minh', '700000', 'Vietnam', true),
       (2, 'billing', '456 Le Loi', 'Ho Chi Minh City', 'Ho Chi Minh', '700000', 'Vietnam', false),
       (3, 'shipping', '789 Tran Hung Dao', 'Hanoi', 'Hanoi', '100000', 'Vietnam', true),
       (4, 'shipping', '321 Hai Ba Trung', 'Da Nang', 'Da Nang', '550000', 'Vietnam', true),
       (5, 'shipping', '654 Bach Dang', 'Can Tho', 'Can Tho', '900000', 'Vietnam', true);

-- Thêm dữ liệu mẫu cho categories
INSERT INTO categories (name, slug, description, parent_id, image_url, is_active, sort_order)
VALUES ('Electronics', 'electronics', 'Electronic devices and accessories', NULL, '/images/categories/electronics.jpg',
        true, 1),
       ('Smartphones', 'smartphones', 'Mobile phones and accessories', 1, '/images/categories/smartphones.jpg', true,
        1),
       ('Laptops', 'laptops', 'Laptops and computers', 1, '/images/categories/laptops.jpg', true, 2),
       ('Clothing', 'clothing', 'Fashion and apparel', NULL, '/images/categories/clothing.jpg', true, 2),
       ('Men Fashion', 'men-fashion', 'Clothing for men', 4, '/images/categories/men-fashion.jpg', true, 1),
       ('Women Fashion', 'women-fashion', 'Clothing for women', 4, '/images/categories/women-fashion.jpg', true, 2),
       ('Books', 'books', 'Books and literature', NULL, '/images/categories/books.jpg', true, 3),
       ('Home & Garden', 'home-garden', 'Home and garden items', NULL, '/images/categories/home-garden.jpg', true, 4);

-- Thêm dữ liệu mẫu cho brands
INSERT INTO brands (name, slug, description, logo_url, website_url, is_active)
VALUES ('Samsung', 'samsung', 'Samsung Electronics - Global technology company', '/images/brands/samsung.jpg',
        'https://samsung.com', true),
       ('Apple', 'apple', 'Apple Inc. - Technology and innovation', '/images/brands/apple.jpg', 'https://apple.com',
        true),
       ('Nike', 'nike', 'Nike Sportswear - Just Do It', '/images/brands/nike.jpg', 'https://nike.com', true),
       ('Adidas', 'adidas', 'Adidas Sports - Impossible is Nothing', '/images/brands/adidas.jpg', 'https://adidas.com',
        true),
       ('Dell', 'dell', 'Dell Technologies', '/images/brands/dell.jpg', 'https://dell.com', true),
       ('HP', 'hp', 'HP Inc. - Technology solutions', '/images/brands/hp.jpg', 'https://hp.com', true);

-- Thêm dữ liệu mẫu cho product attributes
INSERT INTO product_attributes (name, slug, type, is_required, is_variation)
VALUES ('Color', 'color', 'select', false, true),
       ('Size', 'size', 'select', true, true),
       ('Memory', 'memory', 'select', false, true),
       ('Storage', 'storage', 'select', false, true),
       ('Screen Size', 'screen-size', 'text', false, false),
       ('Weight', 'weight', 'number', false, false),
       ('Material', 'material', 'text', false, false),
       ('Brand Model', 'brand-model', 'text', false, false);

-- Thêm giá trị cho attributes
INSERT INTO product_attribute_values (attribute_id, value, sort_order)
VALUES
-- Colors
(1, 'Black', 1),
(1, 'White', 2),
(1, 'Red', 3),
(1, 'Blue', 4),
(1, 'Green', 5),
-- Sizes
(2, 'XS', 1),
(2, 'S', 2),
(2, 'M', 3),
(2, 'L', 4),
(2, 'XL', 5),
(2, 'XXL', 6),
-- Memory
(3, '4GB', 1),
(3, '8GB', 2),
(3, '16GB', 3),
(3, '32GB', 4),
-- Storage
(4, '64GB', 1),
(4, '128GB', 2),
(4, '256GB', 3),
(4, '512GB', 4),
(4, '1TB', 5);

-- Thêm dữ liệu mẫu cho products
INSERT INTO products (name, slug, description, short_description, sku, brand_id, category_id, price, sale_price,
                      cost_price, weight, status, is_featured, meta_title, meta_description)
VALUES ('Samsung Galaxy S24', 'samsung-galaxy-s24',
        'Latest Samsung flagship smartphone with advanced AI features and stunning camera quality.',
        'Samsung Galaxy S24 - AI-powered smartphone', 'SGS24-001', 1, 2, 25000000, 23000000, 20000000, 0.17, 'active',
        true, 'Samsung Galaxy S24 - Best Smartphone 2024', 'Buy Samsung Galaxy S24 with best price and warranty'),
       ('iPhone 15 Pro', 'iphone-15-pro',
        'Apple iPhone 15 Pro with titanium design and A17 Pro chip for ultimate performance.',
        'iPhone 15 Pro - Pro performance', 'IP15P-001', 2, 2, 30000000, NULL, 25000000, 0.18, 'active', true,
        'iPhone 15 Pro - Apple Flagship', 'Latest iPhone 15 Pro with advanced features'),
       ('Dell XPS 13', 'dell-xps-13',
        'Ultra-portable laptop with stunning InfinityEdge display and premium build quality.',
        'Dell XPS 13 - Premium ultrabook', 'DXPS13-001', 5, 3, 45000000, 42000000, 38000000, 1.2, 'active', true,
        'Dell XPS 13 - Premium Laptop', 'Best ultrabook for professionals'),
       ('Nike Air Max 270', 'nike-air-max-270',
        'Comfortable running shoes with Air Max technology for maximum cushioning.', 'Nike Air Max 270 - Running shoes',
        'NAM270-001', 3, 5, 3500000, 3200000, 2800000, 0.8, 'active', false, 'Nike Air Max 270 - Running Shoes',
        'Comfortable Nike running shoes'),
       ('Adidas Ultraboost 22', 'adidas-ultraboost-22',
        'Premium running shoes with Boost technology for energy return.', 'Adidas Ultraboost 22 - Energy return',
        'AUB22-001', 4, 5, 4200000, NULL, 3500000, 0.9, 'active', true, 'Adidas Ultraboost 22 - Premium Running',
        'Best Adidas running shoes'),
       ('Samsung 4K Smart TV 55"', 'samsung-4k-tv-55', '55-inch 4K UHD Smart TV with Crystal Display and Tizen OS.',
        'Samsung 55" 4K Smart TV', 'S4KTV55-001', 1, 1, 15000000, 13500000, 12000000, 18.5, 'active', true,
        'Samsung 55" 4K Smart TV', '4K Smart TV with great picture quality'),
       ('HP Pavilion 15', 'hp-pavilion-15', 'Affordable laptop for everyday computing with reliable performance.',
        'HP Pavilion 15 - Everyday laptop', 'HPP15-001', 6, 3, 18000000, NULL, 15000000, 1.75, 'active', false,
        'HP Pavilion 15 - Affordable Laptop', 'Budget-friendly laptop for students');

-- Thêm hình ảnh cho products
INSERT INTO product_images (product_id, image_url, alt_text, is_primary, sort_order)
VALUES
-- Samsung Galaxy S24
(1, '/images/products/samsung-s24-1.jpg', 'Samsung Galaxy S24 front view', true, 1),
(1, '/images/products/samsung-s24-2.jpg', 'Samsung Galaxy S24 back view', false, 2),
(1, '/images/products/samsung-s24-3.jpg', 'Samsung Galaxy S24 side view', false, 3),
-- iPhone 15 Pro
(2, '/images/products/iphone15pro-1.jpg', 'iPhone 15 Pro titanium design', true, 1),
(2, '/images/products/iphone15pro-2.jpg', 'iPhone 15 Pro camera system', false, 2),
-- Dell XPS 13
(3, '/images/products/dell-xps13-1.jpg', 'Dell XPS 13 laptop open', true, 1),
(3, '/images/products/dell-xps13-2.jpg', 'Dell XPS 13 closed view', false, 2),
-- Nike Air Max 270
(4, '/images/products/nike-airmax270-1.jpg', 'Nike Air Max 270 side view', true, 1),
(4, '/images/products/nike-airmax270-2.jpg', 'Nike Air Max 270 sole', false, 2),
-- Adidas Ultraboost 22
(5, '/images/products/adidas-ultraboost22-1.jpg', 'Adidas Ultraboost 22', true, 1),
-- Samsung TV
(6, '/images/products/samsung-tv55-1.jpg', 'Samsung 55 inch 4K TV', true, 1),
-- HP Pavilion
(7, '/images/products/hp-pavilion15-1.jpg', 'HP Pavilion 15 laptop', true, 1);

-- Thêm product variations
INSERT INTO product_variations (product_id, sku, price, sale_price, stock_quantity, is_active)
VALUES
-- Samsung Galaxy S24 variations
(1, 'SGS24-BLACK-256', 25000000, 23000000, 50, true),
(1, 'SGS24-WHITE-256', 25000000, 23000000, 30, true),
(1, 'SGS24-BLACK-512', 28000000, 26000000, 20, true),
-- iPhone 15 Pro variations
(2, 'IP15P-BLACK-256', 30000000, NULL, 25, true),
(2, 'IP15P-WHITE-256', 30000000, NULL, 15, true),
(2, 'IP15P-BLACK-512', 35000000, NULL, 10, true),
-- Nike Air Max variations
(4, 'NAM270-BLACK-42', 3500000, 3200000, 20, true),
(4, 'NAM270-BLACK-43', 3500000, 3200000, 25, true),
(4, 'NAM270-WHITE-42', 3500000, 3200000, 15, true),
(4, 'NAM270-WHITE-43', 3500000, 3200000, 18, true);

-- Thêm variation attributes
INSERT INTO variation_attributes (variation_id, attribute_id, attribute_value_id)
VALUES
-- Samsung Galaxy S24 Black 256GB
(1, 1, 1),
(1, 4, 3), -- Black, 256GB
-- Samsung Galaxy S24 White 256GB
(2, 1, 2),
(2, 4, 3), -- White, 256GB
-- Samsung Galaxy S24 Black 512GB
(3, 1, 1),
(3, 4, 4), -- Black, 512GB
-- iPhone 15 Pro variations
(4, 1, 1),
(4, 4, 3), -- Black, 256GB
(5, 1, 2),
(5, 4, 3), -- White, 256GB
(6, 1, 1),
(6, 4, 4), -- Black, 512GB
-- Nike variations (using size attribute - assuming we have size values)
(7, 1, 1), -- Black, size will be added separately
(8, 1, 1), -- Black
(9, 1, 2), -- White
(10, 1, 2);
-- White

-- Thêm inventory data
INSERT INTO inventory (product_id, variation_id, stock_quantity, reserved_quantity, low_stock_threshold,
                       warehouse_location)
VALUES (1, 1, 50, 5, 10, 'Warehouse A'),
       (1, 2, 30, 2, 10, 'Warehouse A'),
       (1, 3, 20, 0, 5, 'Warehouse A'),
       (2, 4, 25, 3, 5, 'Warehouse B'),
       (2, 5, 15, 1, 5, 'Warehouse B'),
       (2, 6, 10, 0, 3, 'Warehouse B'),
       (3, NULL, 40, 5, 10, 'Warehouse A'),
       (4, 7, 20, 2, 5, 'Warehouse C'),
       (4, 8, 25, 0, 5, 'Warehouse C'),
       (4, 9, 15, 1, 5, 'Warehouse C'),
       (4, 10, 18, 0, 5, 'Warehouse C'),
       (5, NULL, 35, 3, 8, 'Warehouse C'),
       (6, NULL, 12, 1, 3, 'Warehouse D'),
       (7, NULL, 45, 5, 10, 'Warehouse A');

-- Thêm dữ liệu mẫu cho payment methods
INSERT INTO payment_methods (name, type, is_active, settings)
VALUES ('Credit Card', 'card', true, '{
  "supported_cards": [
    "visa",
    "mastercard",
    "amex"
  ]
}'),
       ('PayPal', 'paypal', true, '{
         "environment": "sandbox"
       }'),
       ('Bank Transfer', 'bank_transfer', true, '{
         "bank_info": "Account details will be provided"
       }'),
       ('Cash on Delivery', 'cod', true, '{
         "max_amount": 10000000
       }'),
       ('MoMo', 'e_wallet', true, '{
         "partner_code": "MOMO_PARTNER"
       }'),
       ('ZaloPay', 'e_wallet', true, '{
         "partner_code": "ZALO_PARTNER"
       }');

-- Thêm dữ liệu mẫu cho shipping methods
INSERT INTO shipping_methods (name, description, cost, free_shipping_threshold, estimated_delivery_days, is_active)
VALUES ('Standard Shipping', 'Standard delivery within 5-7 days', 30000, 500000, 6, true),
       ('Express Shipping', 'Fast delivery within 1-2 days', 50000, 1000000, 2, true),
       ('Free Shipping', 'Free shipping for orders over 500k', 0, 500000, 7, true),
       ('Same Day Delivery', 'Same day delivery in major cities', 100000, NULL, 1, true),
       ('Economy Shipping', 'Cheapest option, 7-10 days', 20000, NULL, 9, true);

-- Thêm shopping carts
INSERT INTO shopping_carts (user_id, session_id)
VALUES (2, 'sess_john_doe_123'),
       (3, 'sess_jane_smith_456'),
       (5, 'sess_customer_789');

-- Thêm cart items
INSERT INTO cart_items (cart_id, product_id, variation_id, quantity, price)
VALUES (1, 1, 1, 1, 23000000),    -- John's cart: Samsung Galaxy S24
       (1, 4, 7, 1, 3200000),     -- John's cart: Nike shoes
       (2, 2, 4, 1, 30000000),    -- Jane's cart: iPhone 15 Pro
       (2, 3, NULL, 1, 42000000), -- Jane's cart: Dell laptop
       (3, 6, NULL, 1, 13500000);
-- Customer cart: Samsung TV

-- Thêm coupons
INSERT INTO coupons (code, name, description, discount_type, discount_value, minimum_amount, maximum_discount,
                     usage_limit, used_count, is_active, valid_from, valid_until)
VALUES ('WELCOME10', 'Welcome Discount', '10% off for new customers', 'percentage', 10.00, 500000, 1000000, 100, 15,
        true, '2024-01-01', '2024-12-31'),
       ('SAVE50K', 'Save 50K', 'Fixed 50K discount', 'fixed', 50000, 1000000, NULL, 200, 45, true, '2024-01-01',
        '2024-12-31'),
       ('FLASH20', 'Flash Sale', '20% off flash sale', 'percentage', 20.00, 300000, 500000, 50, 25, true, '2024-06-01',
        '2024-06-30'),
       ('FREESHIP', 'Free Shipping', 'Free shipping coupon', 'fixed', 30000, 200000, 30000, 500, 120, true,
        '2024-01-01', '2024-12-31');

-- Thêm orders
INSERT INTO orders (order_number, user_id, status, subtotal, tax_amount, shipping_cost, discount_amount, total_amount,
                    currency, coupon_id, payment_method_id, shipping_method_id, billing_address, shipping_address,
                    notes)
VALUES ('ORD-2024-001', 2, 'delivered', 26200000, 2620000, 30000, 2620000, 26230000, 'VND', 1, 1, 1,
        '{
          "street": "456 Le Loi",
          "city": "Ho Chi Minh City",
          "country": "Vietnam"
        }',
        '{
          "street": "123 Nguyen Van Linh",
          "city": "Ho Chi Minh City",
          "country": "Vietnam"
        }',
        'Please deliver in the morning'),
       ('ORD-2024-002', 3, 'processing', 72000000, 7200000, 0, 0, 79200000, 'VND', NULL, 2, 3,
        '{
          "street": "789 Tran Hung Dao",
          "city": "Hanoi",
          "country": "Vietnam"
        }',
        '{
          "street": "789 Tran Hung Dao",
          "city": "Hanoi",
          "country": "Vietnam"
        }',
        NULL),
       ('ORD-2024-003', 5, 'shipped', 13500000, 1350000, 30000, 50000, 14830000, 'VND', 2, 4, 1,
        '{
          "street": "654 Bach Dang",
          "city": "Can Tho",
          "country": "Vietnam"
        }',
        '{
          "street": "654 Bach Dang",
          "city": "Can Tho",
          "country": "Vietnam"
        }',
        'Call before delivery');

-- Thêm order items
INSERT INTO order_items (order_id, product_id, variation_id, product_name, product_sku, quantity, unit_price,
                         total_price, product_snapshot)
VALUES (1, 1, 1, 'Samsung Galaxy S24', 'SGS24-BLACK-256', 1, 23000000, 23000000, '{
  "color": "Black",
  "storage": "256GB"
}'),
       (1, 4, 7, 'Nike Air Max 270', 'NAM270-BLACK-42', 1, 3200000, 3200000, '{
         "color": "Black",
         "size": "42"
       }'),
       (2, 2, 4, 'iPhone 15 Pro', 'IP15P-BLACK-256', 1, 30000000, 30000000, '{
         "color": "Black",
         "storage": "256GB"
       }'),
       (2, 3, NULL, 'Dell XPS 13', 'DXPS13-001', 1, 42000000, 42000000, '{
         "model": "XPS 13",
         "color": "Silver"
       }'),
       (3, 6, NULL, 'Samsung 4K Smart TV 55"', 'S4KTV55-001', 1, 13500000, 13500000, '{
         "size": "55 inch",
         "resolution": "4K"
       }');

-- Thêm payments
INSERT INTO payments (order_id, payment_method_id, amount, status, transaction_id, gateway_response)
VALUES (1, 1, 26230000, 'completed', 'TXN_001_2024', '{
  "status": "success",
  "gateway": "stripe"
}'),
       (2, 2, 79200000, 'processing', 'PP_002_2024', '{
         "status": "pending",
         "gateway": "paypal"
       }'),
       (3, 4, 14830000, 'completed', 'COD_003_2024', '{
         "status": "cod_confirmed"
       }');

-- Thêm shipments
INSERT INTO shipments (order_id, tracking_number, carrier, status, shipped_at, delivered_at, notes)
VALUES (1, 'VN123456789', 'Giao Hang Nhanh', 'delivered', '2024-05-15 10:00:00', '2024-05-17 14:30:00',
        'Delivered successfully'),
       (2, 'VN987654321', 'Viettel Post', 'in_transit', '2024-06-08 09:00:00', NULL, 'Package in transit'),
       (3, 'VN456789123', 'Vietnam Post', 'shipped', '2024-06-09 08:00:00', NULL, 'Shipped from warehouse');

-- Thêm product reviews
INSERT INTO product_reviews (product_id, user_id, order_id, rating, title, review_text, is_verified_purchase,
                             is_approved, helpful_count)
VALUES (1, 2, 1, 5, 'Excellent phone!', 'Great camera quality and performance. Highly recommended!', true, true, 12),
       (4, 2, 1, 4, 'Comfortable shoes', 'Very comfortable for running, good cushioning.', true, true, 8),
       (2, 3, 2, 5, 'Amazing iPhone', 'Best iPhone ever, camera is incredible and battery lasts all day.', true, true,
        15),
       (6, 5, 3, 4, 'Good TV for the price', 'Picture quality is good, smart features work well.', true, true, 5),
       (1, 3, NULL, 5, 'Love this phone', 'Switched from iPhone and very happy with Samsung.', false, true, 3);

-- Thêm wishlists
INSERT INTO wishlists (user_id, name, is_public)
VALUES (2, 'My Wishlist', false),
       (3, 'Future Purchases', false),
       (5, 'Dream Tech', true);

-- Thêm wishlist items
INSERT INTO wishlist_items (wishlist_id, product_id, variation_id)
VALUES (1, 2, 4),    -- John wants iPhone 15 Pro
       (1, 7, NULL), -- John wants HP laptop
       (2, 5, NULL), -- Jane wants Adidas shoes
       (2, 6, NULL), -- Jane wants Samsung TV
       (3, 1, 1),    -- Customer wants Samsung phone
       (3, 3, NULL);
-- Customer wants Dell laptop

-- Thêm notifications
INSERT INTO notifications (user_id, type, title, message, is_read, related_id)
VALUES (2, 'order_status', 'Order Delivered', 'Your order ORD-2024-001 has been delivered successfully.', true, 1),
       (2, 'promotion', 'Special Offer', 'Get 20% off on all electronics this weekend!', false, NULL),
       (3, 'order_status', 'Order Processing', 'Your order ORD-2024-002 is being processed.', false, 2),
       (3, 'wishlist', 'Price Drop', 'Item in your wishlist is now on sale!', false, 5),
       (5, 'order_status', 'Order Shipped', 'Your order ORD-2024-003 has been shipped.', false, 3);

-- Thêm price history
INSERT INTO price_history (product_id, variation_id, old_price, new_price, change_reason)
VALUES (1, NULL, 26000000, 25000000, 'Seasonal discount'),
       (2, NULL, 32000000, 30000000, 'Competitor pricing'),
       (3, NULL, 47000000, 45000000, 'Bulk purchase savings'),
       (4, NULL, 3800000, 3500000, 'Clearance sale'),
       (6, NULL, 16000000, 15000000, 'New model release');

-- Thêm sessions (sample data)
INSERT INTO sessions (session_id, user_id, ip_address, user_agent, data, expires_at)
VALUES ('sess_john_doe_123', 2, '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '{
  "cart_id": 1,
  "last_activity": "2024-06-10T10:00:00Z"
}', '2024-06-17 10:00:00'),
       ('sess_jane_smith_456', 3, '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)', '{
         "cart_id": 2,
         "last_activity": "2024-06-10T11:00:00Z"
       }', '2024-06-17 11:00:00'),
       ('sess_customer_789', 5, '192.168.1.102', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)', '{
         "cart_id": 3,
         "last_activity": "2024-06-10T12:00:00Z"
       }', '2024-06-17 12:00:00'),
       ('sess_anonymous_111', NULL, '192.168.1.103', 'Mozilla/5.0 (Android 13; Mobile)', '{
         "browsing_history": [
           "electronics",
           "smartphones"
         ]
       }', '2024-06-17 15:00:00');