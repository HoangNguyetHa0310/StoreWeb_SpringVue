-- ================================================
-- SIMPLIFIED E-COMMERCE DATABASE SCHEMA FOR POSTGRESQL
-- ================================================

-- Bảng người dùng/khách hàng
CREATE TABLE users
(
    id            SERIAL PRIMARY KEY,
    email         VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255)        NOT NULL,
    first_name    VARCHAR(100)        NOT NULL,
    last_name     VARCHAR(100)        NOT NULL,
    phone         VARCHAR(20),
    is_active     BOOLEAN   DEFAULT true,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
    created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng danh mục sản phẩm
CREATE TABLE categories
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100)        NOT NULL,
    slug        VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    parent_id   INTEGER             REFERENCES categories (id) ON DELETE SET NULL,
    is_active   BOOLEAN   DEFAULT true,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng sản phẩm
CREATE TABLE products
(
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(255)        NOT NULL,
    slug           VARCHAR(255) UNIQUE NOT NULL,
    description    TEXT,
    sku            VARCHAR(100) UNIQUE NOT NULL,
    category_id    INTEGER             REFERENCES categories (id) ON DELETE SET NULL,
    price          DECIMAL(10, 2)      NOT NULL,
    sale_price     DECIMAL(10, 2),
    stock_quantity INTEGER     DEFAULT 0,
    image_url      VARCHAR(500),
    status         VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    is_featured    BOOLEAN     DEFAULT false,
    created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
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
    id         SERIAL PRIMARY KEY,
    cart_id    INTEGER REFERENCES shopping_carts (id) ON DELETE CASCADE,
    product_id INTEGER REFERENCES products (id) ON DELETE CASCADE,
    quantity   INTEGER        NOT NULL CHECK (quantity > 0),
    price      DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng mã giảm giá
CREATE TABLE coupons
(
    id             SERIAL PRIMARY KEY,
    code           VARCHAR(50) UNIQUE NOT NULL,
    name           VARCHAR(100)       NOT NULL,
    discount_type  VARCHAR(20)        NOT NULL CHECK (discount_type IN ('percentage', 'fixed')),
    discount_value DECIMAL(10, 2)     NOT NULL,
    minimum_amount DECIMAL(10, 2) DEFAULT 0,
    usage_limit    INTEGER,
    used_count     INTEGER        DEFAULT 0,
    is_active      BOOLEAN        DEFAULT true,
    valid_from     TIMESTAMP,
    valid_until    TIMESTAMP,
    created_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

-- Bảng đơn hàng
CREATE TABLE orders
(
    id               SERIAL PRIMARY KEY,
    order_number     VARCHAR(50) UNIQUE NOT NULL,
    user_id          INTEGER            REFERENCES users (id) ON DELETE SET NULL,
    status           VARCHAR(20)    DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
    subtotal         DECIMAL(10, 2)     NOT NULL,
    tax_amount       DECIMAL(10, 2) DEFAULT 0,
    shipping_cost    DECIMAL(10, 2) DEFAULT 0,
    discount_amount  DECIMAL(10, 2) DEFAULT 0,
    total_amount     DECIMAL(10, 2)     NOT NULL,
    coupon_id        INTEGER            REFERENCES coupons (id) ON DELETE SET NULL,
    shipping_address JSONB,
    billing_address  JSONB,
    notes            TEXT,
    created_at       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

-- Bảng chi tiết đơn hàng
CREATE TABLE order_items
(
    id           SERIAL PRIMARY KEY,
    order_id     INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    product_id   INTEGER        REFERENCES products (id) ON DELETE SET NULL,
    product_name VARCHAR(255)   NOT NULL,
    product_sku  VARCHAR(100)   NOT NULL,
    quantity     INTEGER        NOT NULL CHECK (quantity > 0),
    unit_price   DECIMAL(10, 2) NOT NULL,
    total_price  DECIMAL(10, 2) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng thanh toán
CREATE TABLE payments
(
    id             SERIAL PRIMARY KEY,
    order_id       INTEGER REFERENCES orders (id) ON DELETE CASCADE,
    amount         DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50)    NOT NULL, -- 'credit_card', 'paypal', 'bank_transfer', etc.
    status         VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'completed', 'failed', 'refunded')),
    transaction_id VARCHAR(255),
    created_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
);

-- Bảng đánh giá sản phẩm
CREATE TABLE product_reviews
(
    id          SERIAL PRIMARY KEY,
    product_id  INTEGER REFERENCES products (id) ON DELETE CASCADE,
    user_id     INTEGER REFERENCES users (id) ON DELETE CASCADE,
    order_id    INTEGER REFERENCES orders (id) ON DELETE SET NULL,
    rating      INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    title       VARCHAR(255),
    review_text TEXT,
    is_approved BOOLEAN   DEFAULT false,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ================================================
-- INDEXES FOR PERFORMANCE
-- ================================================

-- Users indexes
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_active ON users (is_active);

-- Products indexes
CREATE INDEX idx_products_slug ON products (slug);
CREATE INDEX idx_products_category ON products (category_id);
CREATE INDEX idx_products_status ON products (status);
CREATE INDEX idx_products_featured ON products (is_featured);
CREATE INDEX idx_products_stock ON products (stock_quantity);

-- Categories indexes
CREATE INDEX idx_categories_slug ON categories (slug);
CREATE INDEX idx_categories_parent ON categories (parent_id);
CREATE INDEX idx_categories_active ON categories (is_active);

-- Orders indexes
CREATE INDEX idx_orders_user ON orders (user_id);
CREATE INDEX idx_orders_status ON orders (status);
CREATE INDEX idx_orders_created ON orders (created_at);
CREATE INDEX idx_orders_number ON orders (order_number);

-- Reviews indexes
CREATE INDEX idx_reviews_product ON product_reviews (product_id);
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

CREATE TRIGGER update_shopping_carts_updated_at
    BEFORE UPDATE
    ON shopping_carts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_payments_updated_at
    BEFORE UPDATE
    ON payments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();