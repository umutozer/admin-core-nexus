-- Kategoriler
INSERT INTO categories (name, slug, description) VALUES
('Elektronik', 'elektronik', 'Tüm elektronik ürünler'),
('Bilgisayar', 'bilgisayar', 'Laptop, masaüstü ve aksesuarlar'),
('Telefon', 'telefon', 'Akıllı telefon ve aksesuarlar'),
('Ev Aletleri', 'ev-aletleri', 'Küçük ve büyük ev aletleri'),
('Kitap', 'kitap', 'Tüm kitap kategorileri');

-- Kullanıcılar (password: Admin123!)
INSERT INTO users (full_name, email, password_hash, role, status, last_login_at) VALUES
('Admin User', 'admin@admin-core-nexus.com', '$2b$10$rQjRH8fLX0x7yJd7V.HJquxZ3eikjKLVVQ2dK3L.hVZMqJq7XnSOWq', 'admin', 'active', CURRENT_TIMESTAMP),
('Ayşe Yılmaz', 'ayse.yilmaz@admin-core-nexus.com', '$2b$10$rQjRH8fLX0x7yJd7V.HJquxZ3eikjKLVVQ2dK3L.hVZMqJq7XnSOWq', 'manager', 'active', CURRENT_TIMESTAMP - INTERVAL '2 days'),
('Mehmet Demir', 'mehmet.demir@admin-core-nexus.com', '$2b$10$rQjRH8fLX0x7yJd7V.HJquxZ3eikjKLVVQ2dK3L.hVZMqJq7XnSOWq', 'editor', 'active', CURRENT_TIMESTAMP - INTERVAL '5 days'),
('Zeynep Kaya', 'zeynep.kaya@admin-core-nexus.com', '$2b$10$rQjRH8fLX0x7yJd7V.HJquxZ3eikjKLVVQ2dK3L.hVZMqJq7XnSOWq', 'viewer', 'active', CURRENT_TIMESTAMP - INTERVAL '10 days'),
('Ahmet Şahin', 'ahmet.sahin@admin-core-nexus.com', '$2b$10$rQjRH8fLX0x7yJd7V.HJquxZ3eikjKLVVQ2dK3L.hVZMqJq7XnSOWq', 'editor', 'inactive', NULL);

-- Ürünler
INSERT INTO products (name, slug, description, category_id, price, stock_quantity, sku, image_url, is_active) VALUES
('iPhone 15 Pro', 'iphone-15-pro', 'Apple iPhone 15 Pro 256GB', 3, 49999.00, 25, 'IP15P256', 'https://example.com/iphone15pro.jpg', true),
('MacBook Air M2', 'macbook-air-m2', 'Apple MacBook Air M2 13.6 inch', 2, 24999.00, 15, 'MBA2-13', 'https://example.com/macbook-air.jpg', true),
('Samsung Galaxy S24', 'samsung-galaxy-s24', 'Samsung Galaxy S24 256GB', 3, 39999.00, 30, 'SGS24-256', 'https://example.com/galaxy-s24.jpg', true),
('Dyson V15 Vacuum', 'dyson-v15-vacuum', 'Dyson V15 Detect Vacuum Cleaner', 4, 12999.00, 8, 'DV15-VAC', 'https://example.com/dyson-v15.jpg', true),
('JavaScript: The Good Parts', 'javascript-good-parts', 'JavaScript programlama kitabı', 5, 299.99, 50, 'JS-GOOD-PT', 'https://example.com/js-book.jpg', true),
('Dell XPS 15', 'dell-xps-15', 'Dell XPS 15 9520 Laptop', 2, 18999.00, 12, 'DELL-XPS15', 'https://example.com/dell-xps15.jpg', true),
('Xiaomi Redmi Note 12', 'xiaomi-redmi-note-12', 'Xiaomi Redmi Note 12 128GB', 3, 6999.00, 45, 'RMN12-128', 'https://example.com/redmi-note12.jpg', true),
('Bosch Washing Machine', 'bosch-washing-machine', 'Bosch 9kg Çamaşır Makinesi', 4, 8999.00, 6, 'BOSCH-9KG', 'https://example.com/bosch-wm.jpg', false);

-- Satışlar (son 30 gün)
INSERT INTO sales (product_id, quantity, unit_price, total_amount, sale_date) VALUES
(1, 3, 49999.00, 149997.00, CURRENT_TIMESTAMP - INTERVAL '25 days'),
(2, 2, 24999.00, 49998.00, CURRENT_TIMESTAMP - INTERVAL '22 days'),
(3, 5, 39999.00, 199995.00, CURRENT_TIMESTAMP - INTERVAL '20 days'),
(1, 4, 49999.00, 199996.00, CURRENT_TIMESTAMP - INTERVAL '18 days'),
(5, 10, 299.99, 2999.90, CURRENT_TIMESTAMP - INTERVAL '15 days'),
(4, 1, 12999.00, 12999.00, CURRENT_TIMESTAMP - INTERVAL '12 days'),
(6, 2, 18999.00, 37998.00, CURRENT_TIMESTAMP - INTERVAL '10 days'),
(7, 8, 6999.00, 55992.00, CURRENT_TIMESTAMP - INTERVAL '8 days'),
(3, 3, 39999.00, 119997.00, CURRENT_TIMESTAMP - INTERVAL '5 days'),
(2, 1, 24999.00, 24999.00, CURRENT_TIMESTAMP - INTERVAL '3 days'),
(1, 2, 49999.00, 99998.00, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(7, 5, 6999.00, 34995.00, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Kullanıcı aktiviteleri
INSERT INTO user_activities (user_id, action, entity_type, entity_id, metadata, ip_address, user_agent) VALUES
(1, 'user_login', 'user', 1, '{"browser": "Chrome"}', '192.168.1.1', 'Mozilla/5.0...'),
(1, 'product_create', 'product', 1, '{"name": "iPhone 15 Pro"}', '192.168.1.1', 'Mozilla/5.0...'),
(2, 'user_update', 'user', 3, '{"field": "role", "old": "viewer", "new": "editor"}', '192.168.1.5', 'Mozilla/5.0...'),
(3, 'product_update', 'product', 2, '{"field": "stock", "old": 10, "new": 15}', '192.168.1.8', 'Mozilla/5.0...'),
(4, 'user_login', 'user', 4, '{}', '192.168.1.12', 'Mozilla/5.0...'),
(1, 'category_create', 'category', 5, '{"name": "Kitap"}', '192.168.1.1', 'Mozilla/5.0...'),
(2, 'sale_create', 'sale', 3, '{"product_id": 3, "quantity": 5}', '192.168.1.5', 'Mozilla/5.0...'),
(3, 'product_delete', 'product', 8, '{"name": "Bosch Washing Machine"}', '192.168.1.8', 'Mozilla/5.0...');