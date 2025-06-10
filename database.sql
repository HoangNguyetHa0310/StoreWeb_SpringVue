-- ================================================
-- E-COMMERCE DATABASE SCHEMA FOR POSTGRESQL
-- ================================================

-- Tạo database (chạy riêng nếu cần)
-- CREATE DATABASE ecommerce_store;

-- Bảng người dùng/khách hàng
CREATE TABLE users
(
    id             SERIAL PRIMARY KEY,
    email          VARCHAR(255) UNIQUE NOT NULL,
    password_hash  VARCHAR(255)        NOT NULL,
    first_name     VARCHAR(100)        NOT NULL,
    last_name      VARCHAR(100)        NOT NULL,
    phone          VARCHAR(20),
    date_of_birth  DATE,
    gender         VARCHAR(10) CHECK (gender IN ('male', 'female', 'other')),
    is_active      BOOLEAN   DEFAULT true,
    email_verified BOOLEAN   DEFAULT false,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng vai trò người dùng
CREATE TABLE user_roles
(
    id          SERIAL PRIMARY KEY,
    role_name   VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng phân quyền người dùng
CREATE TABLE user_role_assignments
(
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER REFERENCES users (id) ON DELETE CASCADE,
    role_id     INTEGER REFERENCES user_roles (id) ON DELETE CASCADE,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, role_id)
);

-- Bảng địa chỉ
CREATE TABLE addresses
(
    id             SERIAL PRIMARY KEY,
    user_id        INTEGER REFERENCES users (id) ON DELETE CASCADE,
    address_type   VARCHAR(20) DEFAULT 'shipping' CHECK (address_type IN ('billing', 'shipping')),
    street_address VARCHAR(255) NOT NULL,
    city           VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code    VARCHAR(20),
    country        VARCHAR(100) NOT NULL,
    is_default     BOOLEAN     DEFAULT false,
    created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng danh mục sản phẩm
CREATE TABLE categories
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100)        NOT NULL,
    slug        VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_id   INTEGER             REFERENCES categories (id) ON DELETE SET NULL,
    image_url   VARCHAR(500),
    is_active   BOOLEAN   DEFAULT true,
    sort_order  INTEGER   DEFAULT 0,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thương hiệu
CREATE TABLE brands
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100)        NOT NULL,
    slug        VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    logo_url    VARCHAR(500),
    website_url VARCHAR(500),
    is_active   BOOLEAN   DEFAULT true,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng sản phẩm
CREATE TABLE products
(
    id                SERIAL PRIMARY KEY,
    name              VARCHAR(255)        NOT NULL,
    slug              VARCHAR(255) UNIQUE NOT NULL,
    description       TEXT,
    short_description TEXT,
    sku               VARCHAR(100) UNIQUE NOT NULL,
    brand_id          INTEGER             REFERENCES brands (id) ON DELETE SET NULL,
    category_id       INTEGER             REFERENCES categories (id) ON DELETE SET NULL,
    price             DECIMAL(10, 2)      NOT NULL,
    sale_price        DECIMAL(10, 2),
    cost_price        DECIMAL(10, 2),
    weight            DECIMAL(8, 2),
    dimensions        VARCHAR(100),
    status            VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'discontinued')),
    is_featured       BOOLEAN     DEFAULT false,
    is_digital        BOOLEAN     DEFAULT false,
    meta_title        VARCHAR(255),
    meta_description  TEXT,
    created_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng hình ảnh sản phẩm
CREATE TABLE product_images
(
    id         SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products (id) ON DELETE CASCADE,
    image_url  VARCHAR(500) NOT NULL,
    alt_text   VARCHAR(255),
    is_primary BOOLEAN   DEFAULT false,
    sort_order INTEGER   DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thuộc tính sản phẩm (size, color, etc.)
CREATE TABLE product_attributes
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(100)        NOT NULL,
    slug         VARCHAR(100) UNIQUE NOT NULL,
    type         VARCHAR(50) DEFAULT 'text' CHECK (type IN ('text', 'number', 'select', 'multiselect', 'boolean')),
    is_required  BOOLEAN     DEFAULT false,
    is_variation BOOLEAN     DEFAULT false,
    created_at   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng giá trị thuộc tính
CREATE TABLE product_attribute_values
(
    id           SERIAL PRIMARY KEY,
    attribute_id INTEGER REFERENCES product_attributes (id) ON DELETE CASCADE,
    value        VARCHAR(255) NOT NULL,
    sort_order   INTEGER   DEFAULT 0,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thuộc tính sản phẩm cụ thể
CREATE TABLE product_attribute_assignments
(
    id                 SERIAL PRIMARY KEY,
    product_id         INTEGER REFERENCES products (id) ON DELETE CASCADE,
    attribute_id       INTEGER REFERENCES product_attributes (id) ON DELETE CASCADE,
    attribute_value_id INTEGER REFERENCES product_attribute_values (id) ON DELETE CASCADE,
    custom_value       TEXT,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (product_id, attribute_id, attribute_value_id)
);

-- Bảng biến thể sản phẩm
CREATE TABLE product_variations
(
    id             SERIAL PRIMARY KEY,
    product_id     INTEGER REFERENCES products (id) ON DELETE CASCADE,
    sku            VARCHAR(100) UNIQUE NOT NULL,
    price          DECIMAL(10, 2),
    sale_price     DECIMAL(10, 2),
    stock_quantity INTEGER   DEFAULT 0,
    image_url      VARCHAR(500),
    is_active      BOOLEAN   DEFAULT true,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thuộc tính biến thể
CREATE TABLE variation_attributes
(
    id                 SERIAL PRIMARY KEY,
    variation_id       INTEGER REFERENCES product_variations (id) ON DELETE CASCADE,
    attribute_id       INTEGER REFERENCES product_attributes (id) ON DELETE CASCADE,
    attribute_value_id INTEGER REFERENCES product_attribute_values (id) ON DELETE CASCADE,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (variation_id, attribute_id)
);

-- Bảng kho hàng
CREATE TABLE inventory
(
    id                  SERIAL PRIMARY KEY,
    product_id          INTEGER REFERENCES products (id) ON DELETE CASCADE,
    variation_id        INTEGER REFERENCES product_variations (id) ON DELETE CASCADE,
    stock_quantity      INTEGER   DEFAULT 0,
    reserved_quantity   INTEGER   DEFAULT 0,
    low_stock_threshold INTEGER   DEFAULT 10,
    warehouse_location  VARCHAR(100),
    last_updated        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (product_id, variation_id)
);

-- Bảng giỏ hàng
CREATE TABLE shopping_carts
(
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER REFERENCES users (id) ON DELETE CASCADE,
    session_id VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id)
);

-- Bảng items trong giỏ hàng
CREATE TABLE cart_items
(
    id           SERIAL PRIMARY KEY,
    cart_id      INTEGER REFERENCES shopping_carts (id) ON DELETE CASCADE,
    product_id   INTEGER REFERENCES products (id) ON DELETE CASCADE,
    variation_id INTEGER        REFERENCES product_variations (id) ON DELETE SET NULL,
    quantity     INTEGER        NOT NULL CHECK (quantity > 0),
    price        DECIMAL(10, 2) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng mã giảm giá
CREATE TABLE coupons
(
    id               SERIAL PRIMARY KEY,
    code             VARCHAR(50) UNIQUE NOT NULL,
    name             VARCHAR(100)       NOT NULL,
    description      TEXT,
    discount_type    VARCHAR(20)        NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
    discount_value   DECIMAL(10, 2)     NOT NULL,
    minimum_amount   DECIMAL(10, 2) DEFAULT 0,
    maximum_discount DECIMAL(10, 2),
    usage_limit      INTEGER,
    used_count       INTEGER        DEFAULT 0,
    is_active        BOOLEAN        DEFAULT true,
    valid_from       TIMESTAMP,
    valid_until      TIMESTAMP,
    created_at       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

-- Bảng phương thức thanh toán
CREATE TABLE payment_methods
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    type       VARCHAR(50)  NOT NULL,
    is_active  BOOLEAN   DEFAULT true,
    settings   JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng phương thức vận chuyển
CREATE TABLE shipping_methods
(
    id                      SERIAL PRIMARY KEY,
    name                    VARCHAR(100)   NOT NULL,
    description             TEXT,
    cost                    DECIMAL(10, 2) NOT NULL,
    free_shipping_threshold DECIMAL(10, 2),
    estimated_delivery_days INTEGER,
    is_active               BOOLEAN   DEFAULT true,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng đơn hàng
CREATE TABLE orders
(
    id                 SERIAL PRIMARY KEY,
    order_number       VARCHAR(50) UNIQUE NOT NULL,
    user_id            INTEGER            REFERENCES users (id) ON DELETE SET NULL,
    status             VARCHAR(20)    DEFAULT 'pending' CHECK (status IN
                                                               ('pending', 'processing', 'shipped', 'delivered',
                                                                'cancelled', 'refunded')),
    subtotal           DECIMAL(10, 2)     NOT NULL,
    tax_amount         DECIMAL(10, 2) DEFAULT 0,
    shipping_cost      DECIMAL(10, 2) DEFAULT 0,
    discount_amount    DECIMAL(10, 2) DEFAULT 0,
    total_amount       DECIMAL(10, 2)     NOT NULL,
    currency           VARCHAR(3)     DEFAULT 'VND',
    coupon_id          INTEGER            REFERENCES coupons (id) ON DELETE SET NULL,
    payment_method_id  INTEGER            REFERENCES payment_methods (id) ON DELETE SET NULL,
    shipping_method_id INTEGER            REFERENCES shipping_methods (id) ON DELETE SET NULL,
    billing_address    JSONB,
    shipping_address   JSONB,
    notes              TEXT,
    created_at         TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at         TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_items
(
    id               SERIAL PRIMARY KEY,
    order_id         INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    product_id       INTEGER        REFERENCES products (id) ON DELETE SET NULL,
    variation_id     INTEGER        REFERENCES product_variations (id) ON DELETE SET NULL,
    product_name     VARCHAR(255)   NOT NULL,
    product_sku      VARCHAR(100)   NOT NULL,
    quantity         INTEGER        NOT NULL CHECK (quantity > 0),
    unit_price       DECIMAL(10, 2) NOT NULL,
    total_price      DECIMAL(10, 2) NOT NULL,
    product_snapshot JSONB,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thanh toán
CREATE TABLE payments
(
    id                SERIAL PRIMARY KEY,
    order_id          INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    payment_method_id INTEGER        REFERENCES payment_methods (id) ON DELETE SET NULL,
    amount            DECIMAL(10, 2) NOT NULL,
    status            VARCHAR(20) DEFAULT 'pending' CHECK (status IN
                                                           ('pending', 'processing', 'completed', 'failed', 'cancelled',
                                                            'refunded')),
    transaction_id    VARCHAR(255),
    gateway_response  JSONB,
    created_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng vận chuyển
CREATE TABLE shipments
(
    id              SERIAL PRIMARY KEY,
    order_id        INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    tracking_number VARCHAR(255),
    carrier         VARCHAR(100),
    status          VARCHAR(20) DEFAULT 'preparing' CHECK (status IN ('preparing', 'shipped', 'in_transit', 'delivered',
                                                                      'returned')),
    shipped_at      TIMESTAMP,
    delivered_at    TIMESTAMP,
    notes           TEXT,
    created_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng đánh giá sản phẩm
CREATE TABLE product_reviews
(
    id                   SERIAL PRIMARY KEY,
    product_id           INTEGER REFERENCES products (id) ON DELETE CASCADE,
    user_id              INTEGER REFERENCES users (id) ON DELETE CASCADE,
    order_id             INTEGER REFERENCES orders (id) ON DELETE SET NULL,
    rating               INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title                VARCHAR(255),
    review_text          TEXT,
    is_verified_purchase BOOLEAN   DEFAULT false,
    is_approved          BOOLEAN   DEFAULT false,
    helpful_count        INTEGER   DEFAULT 0,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng danh sách yêu thích
CREATE TABLE wishlists
(
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER REFERENCES users (id) ON DELETE CASCADE,
    name       VARCHAR(100) DEFAULT 'My Wishlist',
    is_public  BOOLEAN      DEFAULT false,
    created_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Bảng sản phẩm trong danh sách yêu thích
CREATE TABLE wishlist_items
(
    id           SERIAL PRIMARY KEY,
    wishlist_id  INTEGER REFERENCES wishlists (id) ON DELETE CASCADE,
    product_id   INTEGER REFERENCES products (id) ON DELETE CASCADE,
    variation_id INTEGER REFERENCES product_variations (id) ON DELETE CASCADE,
    added_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (wishlist_id, product_id, variation_id)
);

-- Bảng thông báo
CREATE TABLE notifications
(
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER REFERENCES users (id) ON DELETE CASCADE,
    type       VARCHAR(50)  NOT NULL,
    title      VARCHAR(255) NOT NULL,
    message    TEXT         NOT NULL,
    is_read    BOOLEAN   DEFAULT false,
    related_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng lịch sử giá sản phẩm
CREATE TABLE price_history
(
    id            SERIAL PRIMARY KEY,
    product_id    INTEGER REFERENCES products (id) ON DELETE CASCADE,
    variation_id  INTEGER REFERENCES product_variations (id) ON DELETE CASCADE,
    old_price     DECIMAL(10, 2) NOT NULL,
    new_price     DECIMAL(10, 2) NOT NULL,
    change_reason VARCHAR(255),
    changed_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng session
CREATE TABLE sessions
(
    id         SERIAL PRIMARY KEY,
    session_id VARCHAR(255) UNIQUE NOT NULL,
    user_id    INTEGER REFERENCES users (id) ON DELETE CASCADE,
    ip_address INET,
    user_agent TEXT,
    data       JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP           NOT NULL
);

-- ================================================
-- INDEXES FOR PERFORMANCE
-- ================================================

-- Indexes cho users
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_active ON users (is_active);

-- Indexes cho products
CREATE INDEX idx_products_slug ON products (slug);
CREATE INDEX idx_products_category ON products (category_id);
CREATE INDEX idx_products_brand ON products (brand_id);
CREATE INDEX idx_products_status ON products (status);
CREATE INDEX idx_products_featured ON products (is_featured);
CREATE INDEX idx_products_price ON products (price);

-- Indexes cho categories
CREATE INDEX idx_categories_parent ON categories (parent_id);
CREATE INDEX idx_categories_slug ON categories (slug);
CREATE INDEX idx_categories_active ON categories (is_active);

-- Indexes cho orders
CREATE INDEX idx_orders_user ON orders (user_id);
CREATE INDEX idx_orders_status ON orders (status);
CREATE INDEX idx_orders_created ON orders (created_at);
CREATE INDEX idx_orders_number ON orders (order_number);

-- Indexes cho inventory
CREATE INDEX idx_inventory_product ON inventory (product_id);
CREATE INDEX idx_inventory_variation ON inventory (variation_id);

-- Indexes cho reviews
CREATE INDEX idx_reviews_product ON product_reviews (product_id);
CREATE INDEX idx_reviews_user ON product_reviews (user_id);
CREATE INDEX idx_reviews_approved ON product_reviews (is_approved);

-- ================================================
-- TRIGGERS FOR AUTO-UPDATE TIMESTAMPS
-- ================================================

-- Function để tự động cập nhật updated_at
CREATE
OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at
= CURRENT_TIMESTAMP;
RETURN NEW;
END;
$$
language 'plpgsql';

-- Áp dụng trigger cho các bảng cần thiết
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE
    ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at
    BEFORE UPDATE
    ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at
    BEFORE UPDATE
    ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at
    BEFORE UPDATE
    ON categories
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_brands_updated_at
    BEFORE UPDATE
    ON brands
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
