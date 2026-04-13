-- --------------------------------------------------
-- 1) DEMO CUSTOMERS
-- --------------------------------------------------
INSERT INTO `customers`
(`name`, `email`, `email_verified_at`, `password`, `phone`, `date_of_birth`, `gender`, `is_active`, `remember_token`, `created_at`, `updated_at`, `deleted_at`)
VALUES
('Ava Thompson', 'ava.thompson@example.com', NOW(), '$2y$12$U1IriYKz.iZ2JuBFyyG0f.TON2n5YgI9TgFHi384uPpcRVSmDMCU.', '416-555-1001', '1992-04-12', 'female', 1, NULL, NOW(), NOW(), NULL),
('Noah Patel', 'noah.patel@example.com', NOW(), '$2y$12$U1IriYKz.iZ2JuBFyyG0f.TON2n5YgI9TgFHi384uPpcRVSmDMCU.', '647-555-1002', '1989-09-03', 'male', 1, NULL, NOW(), NOW(), NULL),
('Emma Rodriguez', 'emma.rodriguez@example.com', NOW(), '$2y$12$U1IriYKz.iZ2JuBFyyG0f.TON2n5YgI9TgFHi384uPpcRVSmDMCU.', '437-555-1003', '1995-01-28', 'female', 1, NULL, NOW(), NOW(), NULL),
('Liam Chen', 'liam.chen@example.com', NOW(), '$2y$12$U1IriYKz.iZ2JuBFyyG0f.TON2n5YgI9TgFHi384uPpcRVSmDMCU.', '905-555-1004', '1991-07-19', 'male', 1, NULL, NOW(), NOW(), NULL),
('Sophia Martin', 'sophia.martin@example.com', NOW(), '$2y$12$U1IriYKz.iZ2JuBFyyG0f.TON2n5YgI9TgFHi384uPpcRVSmDMCU.', '289-555-1005', '1993-11-08', 'female', 1, NULL, NOW(), NOW(), NULL);

-- --------------------------------------------------
-- 2) DEMO PRODUCTS
-- Assumes category_id and brand_id from your existing dump:
-- categories: 1 Electronics, 2 Fashion, 3 Home, 4 Sports, 5 Books, 6 Beauty
-- brands: 1 Apple, 2 Samsung, 3 Sony, 4 Nike, 5 Adidas, 6 Dell, 7 HP, 10 LG, 12 Microsoft, 15 ASUS
-- --------------------------------------------------
INSERT INTO `products`
(`category_id`, `brand_id`, `name`, `slug`, `sku`, `short_description`, `description`, `price`, `compare_price`, `cost_price`, `stock_quantity`, `low_stock_threshold`, `manage_stock`, `stock_status`, `is_active`, `is_featured`, `has_variants`, `weight`, `meta_title`, `meta_description`, `views_count`, `created_at`, `updated_at`, `deleted_at`)
VALUES
(1, 1, 'Apple iPhone 15 Pro', 'apple-iphone-15-pro', 'SKU-IP15PRO', 'Flagship Apple smartphone with pro camera system.', '<p>Premium smartphone with A17 Pro chip, titanium design, and advanced camera capabilities.</p>', 1499.00, 1599.00, 1120.00, 25, 5, 1, 'in_stock', 1, 1, 0, 0.22, 'Apple iPhone 15 Pro', 'Buy Apple iPhone 15 Pro online.', 120, NOW(), NOW(), NULL),

(1, 2, 'Samsung Galaxy S24 Ultra', 'samsung-galaxy-s24-ultra', 'SKU-S24ULTRA', 'High-end Android phone with stylus support.', '<p>Large AMOLED display, advanced zoom camera, and all-day battery life.</p>', 1699.00, 1799.00, 1250.00, 18, 5, 1, 'in_stock', 1, 1, 0, 0.23, 'Samsung Galaxy S24 Ultra', 'Shop Samsung Galaxy S24 Ultra.', 95, NOW(), NOW(), NULL),

(1, 6, 'Dell XPS 13 Laptop', 'dell-xps-13-laptop', 'SKU-XPS13', 'Compact premium ultrabook for work and study.', '<p>13-inch laptop with Intel processor, fast SSD, and lightweight aluminum design.</p>', 1799.00, 1949.00, 1360.00, 12, 3, 1, 'in_stock', 1, 1, 0, 1.24, 'Dell XPS 13 Laptop', 'Dell XPS 13 ultrabook.', 80, NOW(), NOW(), NULL),

(1, 7, 'HP Envy 16 Laptop', 'hp-envy-16-laptop', 'SKU-HPENVY16', 'Large-screen productivity laptop.', '<p>Powerful laptop with vivid display, excellent keyboard, and strong multitasking performance.</p>', 1599.00, 1749.00, 1210.00, 10, 3, 1, 'in_stock', 1, 0, 0, 1.90, 'HP Envy 16 Laptop', 'HP Envy 16 for work and creativity.', 52, NOW(), NOW(), NULL),

(1, 3, 'Sony WH-1000XM5 Headphones', 'sony-wh-1000xm5-headphones', 'SKU-SONYXM5', 'Premium wireless noise-cancelling headphones.', '<p>Industry-leading noise cancellation, long battery life, and clear call quality.</p>', 499.00, 549.00, 360.00, 40, 8, 1, 'in_stock', 1, 1, 0, 0.25, 'Sony WH-1000XM5 Headphones', 'Sony premium headphones.', 140, NOW(), NOW(), NULL),

(1, 10, 'LG 27 Inch 4K Monitor', 'lg-27-inch-4k-monitor', 'SKU-LG274K', 'Sharp 4K monitor for office and creative work.', '<p>27-inch IPS panel with UHD resolution and vibrant color reproduction.</p>', 429.00, 479.00, 300.00, 22, 5, 1, 'in_stock', 1, 0, 0, 4.80, 'LG 27 Inch 4K Monitor', 'LG 4K monitor.', 33, NOW(), NOW(), NULL),

(1, 15, 'ASUS ROG Strix G16', 'asus-rog-strix-g16', 'SKU-ROGG16', 'Gaming laptop with high refresh rate display.', '<p>Built for gaming with dedicated graphics, fast cooling, and RGB keyboard.</p>', 2199.00, 2399.00, 1710.00, 8, 2, 1, 'in_stock', 1, 1, 0, 2.50, 'ASUS ROG Strix G16', 'ASUS gaming laptop.', 61, NOW(), NOW(), NULL),

(2, 4, 'Nike Air Zoom Pegasus 40', 'nike-air-zoom-pegasus-40', 'SKU-NIKEPEG40', 'Comfortable everyday running shoes.', '<p>Responsive cushioning and breathable upper for daily training.</p>', 179.00, 210.00, 110.00, 55, 10, 1, 'in_stock', 1, 1, 0, 0.70, 'Nike Air Zoom Pegasus 40', 'Nike running shoes.', 88, NOW(), NOW(), NULL),

(2, 5, 'Adidas Essentials Hoodie', 'adidas-essentials-hoodie', 'SKU-ADIHOODIE', 'Soft fleece hoodie for casual wear.', '<p>Warm, comfortable, and versatile hoodie for everyday use.</p>', 89.00, 109.00, 45.00, 65, 12, 1, 'in_stock', 1, 0, 1, 0.55, 'Adidas Essentials Hoodie', 'Adidas fleece hoodie.', 41, NOW(), NOW(), NULL),

(3, 10, 'LG CordZero Vacuum', 'lg-cordzero-vacuum', 'SKU-LGCORDZERO', 'Cordless vacuum cleaner for home use.', '<p>Strong suction, lightweight body, and easy charging dock.</p>', 699.00, 799.00, 510.00, 14, 4, 1, 'in_stock', 1, 0, 0, 2.90, 'LG CordZero Vacuum', 'LG cordless vacuum.', 27, NOW(), NOW(), NULL),

(3, 19, 'Bosch Electric Kettle', 'bosch-electric-kettle', 'SKU-BOSCHKETTLE', 'Fast-boiling electric kettle for kitchen use.', '<p>Stainless steel kettle with auto shut-off and modern compact design.</p>', 79.00, 99.00, 42.00, 48, 10, 1, 'in_stock', 1, 0, 0, 1.10, 'Bosch Electric Kettle', 'Bosch kitchen kettle.', 18, NOW(), NOW(), NULL),

(4, 4, 'Nike Training Duffel Bag', 'nike-training-duffel-bag', 'SKU-NIKEDUFFEL', 'Spacious gym bag with durable straps.', '<p>Ideal for gym, travel, and daily sports use.</p>', 69.00, 85.00, 34.00, 70, 10, 1, 'in_stock', 1, 0, 0, 0.80, 'Nike Training Duffel Bag', 'Nike duffel bag.', 24, NOW(), NOW(), NULL),

(4, 5, 'Adidas Yoga Mat Pro', 'adidas-yoga-mat-pro', 'SKU-ADIYOGAMAT', 'Cushioned non-slip yoga mat.', '<p>Thick training mat suitable for yoga, pilates, and home workouts.</p>', 59.00, 79.00, 28.00, 75, 12, 1, 'in_stock', 1, 0, 0, 1.30, 'Adidas Yoga Mat Pro', 'Adidas yoga mat.', 22, NOW(), NOW(), NULL),

(5, 12, 'Microsoft Office Home 2024', 'microsoft-office-home-2024', 'SKU-OFFICE2024', 'Productivity software for home users.', '<p>Classic Office apps for home productivity and personal projects.</p>', 189.00, 219.00, 120.00, 100, 15, 1, 'in_stock', 1, 0, 0, 0.00, 'Microsoft Office Home 2024', 'Microsoft Office software.', 39, NOW(), NOW(), NULL),

(6, 18, 'Philips Sonic Electric Toothbrush', 'philips-sonic-electric-toothbrush', 'SKU-PHILIPSSONIC', 'Electric toothbrush with multiple cleaning modes.', '<p>Helps improve oral care with gentle sonic cleaning and long battery life.</p>', 129.00, 159.00, 70.00, 35, 8, 1, 'in_stock', 1, 0, 0, 0.35, 'Philips Sonic Electric Toothbrush', 'Philips sonic toothbrush.', 29, NOW(), NOW(), NULL);

-- --------------------------------------------------
-- 3) DEMO ORDERS
-- Uses the newly inserted customers by email lookup
-- --------------------------------------------------
INSERT INTO `orders`
(`order_number`, `customer_id`, `coupon_id`, `subtotal`, `discount_amount`, `shipping_cost`, `tax_amount`, `total`,
 `shipping_full_name`, `shipping_phone`, `shipping_address_line_1`, `shipping_address_line_2`, `shipping_city`, `shipping_state`,
 `shipping_postal_code`, `shipping_country`, `payment_method`, `payment_status`, `transaction_id`, `status`,
 `tracking_number`, `customer_notes`, `admin_notes`, `created_at`, `updated_at`, `deleted_at`)
VALUES
('ORD-DEMO-1001',
 (SELECT id FROM customers WHERE email='ava.thompson@example.com' LIMIT 1),
 NULL, 1998.00, 0.00, 25.00, 259.74, 2282.74,
 'Ava Thompson', '416-555-1001', '25 King Street West', NULL, 'Toronto', 'Ontario', 'M5H 1A1', 'CA',
 'stripe', 'paid', 'TXN-DEMO-1001', 'processing', NULL, 'Please deliver after 5 PM.', NULL, NOW(), NOW(), NULL),

('ORD-DEMO-1002',
 (SELECT id FROM customers WHERE email='noah.patel@example.com' LIMIT 1),
 NULL, 678.00, 20.00, 15.00, 85.54, 758.54,
 'Noah Patel', '647-555-1002', '88 Eglinton Avenue', 'Unit 12', 'Mississauga', 'Ontario', 'L5B 2C9', 'CA',
 'cash_on_delivery', 'pending', NULL, 'pending', NULL, NULL, NULL, NOW(), NOW(), NULL),

('ORD-DEMO-1003',
 (SELECT id FROM customers WHERE email='emma.rodriguez@example.com' LIMIT 1),
 NULL, 2288.00, 0.00, 30.00, 301.34, 2619.34,
 'Emma Rodriguez', '437-555-1003', '102 Front Street East', NULL, 'Toronto', 'Ontario', 'M5A 1E1', 'CA',
 'stripe', 'paid', 'TXN-DEMO-1003', 'shipped', 'TRK-DEMO-3003', 'Call on arrival.', NULL, NOW(), NOW(), NULL),

('ORD-DEMO-1004',
 (SELECT id FROM customers WHERE email='liam.chen@example.com' LIMIT 1),
 NULL, 437.00, 0.00, 12.00, 58.37, 507.37,
 'Liam Chen', '905-555-1004', '14 Bayview Drive', NULL, 'Markham', 'Ontario', 'L3R 5B4', 'CA',
 'stripe', 'paid', 'TXN-DEMO-1004', 'delivered', 'TRK-DEMO-4004', NULL, 'Left at front desk.', NOW(), NOW(), NULL),

('ORD-DEMO-1005',
 (SELECT id FROM customers WHERE email='sophia.martin@example.com' LIMIT 1),
 NULL, 957.00, 25.00, 20.00, 123.76, 1075.76,
 'Sophia Martin', '289-555-1005', '300 Main Street', 'Apt 9', 'Oshawa', 'Ontario', 'L1H 4R6', 'CA',
 'cash_on_delivery', 'paid', 'TXN-DEMO-1005', 'processing', NULL, 'Gift wrap if possible.', NULL, NOW(), NOW(), NULL);

-- --------------------------------------------------
-- 4) DEMO ORDER ITEMS
-- Linked to the demo orders and products
-- --------------------------------------------------
INSERT INTO `order_items`
(`order_id`, `product_id`, `product_variant_id`, `product_name`, `product_sku`, `variant_name`, `price`, `quantity`, `subtotal`, `created_at`, `updated_at`)
VALUES
-- Order 1001
((SELECT id FROM orders WHERE order_number='ORD-DEMO-1001' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-IP15PRO' LIMIT 1),
 NULL, 'Apple iPhone 15 Pro', 'SKU-IP15PRO', NULL, 1499.00, 1, 1499.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1001' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-SONYXM5' LIMIT 1),
 NULL, 'Sony WH-1000XM5 Headphones', 'SKU-SONYXM5', NULL, 499.00, 1, 499.00, NOW(), NOW()),

-- Order 1002
((SELECT id FROM orders WHERE order_number='ORD-DEMO-1002' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-NIKEPEG40' LIMIT 1),
 NULL, 'Nike Air Zoom Pegasus 40', 'SKU-NIKEPEG40', 'Black - 10', 179.00, 2, 358.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1002' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-NIKEDUFFEL' LIMIT 1),
 NULL, 'Nike Training Duffel Bag', 'SKU-NIKEDUFFEL', NULL, 69.00, 2, 138.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1002' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-ADIYOGAMAT' LIMIT 1),
 NULL, 'Adidas Yoga Mat Pro', 'SKU-ADIYOGAMAT', NULL, 59.00, 3, 177.00, NOW(), NOW()),

-- Order 1003
((SELECT id FROM orders WHERE order_number='ORD-DEMO-1003' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-ROGG16' LIMIT 1),
 NULL, 'ASUS ROG Strix G16', 'SKU-ROGG16', NULL, 2199.00, 1, 2199.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1003' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-BOSCHKETTLE' LIMIT 1),
 NULL, 'Bosch Electric Kettle', 'SKU-BOSCHKETTLE', NULL, 79.00, 1, 79.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1003' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-ADIHOODIE' LIMIT 1),
 NULL, 'Adidas Essentials Hoodie', 'SKU-ADIHOODIE', 'Grey - L', 89.00, 1, 89.00, NOW(), NOW()),

-- Order 1004
((SELECT id FROM orders WHERE order_number='ORD-DEMO-1004' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-OFFICE2024' LIMIT 1),
 NULL, 'Microsoft Office Home 2024', 'SKU-OFFICE2024', NULL, 189.00, 1, 189.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1004' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-PHILIPSSONIC' LIMIT 1),
 NULL, 'Philips Sonic Electric Toothbrush', 'SKU-PHILIPSSONIC', NULL, 129.00, 1, 129.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1004' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-ADIYOGAMAT' LIMIT 1),
 NULL, 'Adidas Yoga Mat Pro', 'SKU-ADIYOGAMAT', NULL, 59.00, 2, 118.00, NOW(), NOW()),

-- Order 1005
((SELECT id FROM orders WHERE order_number='ORD-DEMO-1005' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-LGCORDZERO' LIMIT 1),
 NULL, 'LG CordZero Vacuum', 'SKU-LGCORDZERO', NULL, 699.00, 1, 699.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1005' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-LG274K' LIMIT 1),
 NULL, 'LG 27 Inch 4K Monitor', 'SKU-LG274K', NULL, 429.00, 1, 429.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1005' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-BOSCHKETTLE' LIMIT 1),
 NULL, 'Bosch Electric Kettle', 'SKU-BOSCHKETTLE', NULL, 79.00, 1, 79.00, NOW(), NOW()),

((SELECT id FROM orders WHERE order_number='ORD-DEMO-1005' LIMIT 1),
 (SELECT id FROM products WHERE sku='SKU-NIKEDUFFEL' LIMIT 1),
 NULL, 'Nike Training Duffel Bag', 'SKU-NIKEDUFFEL', NULL, 69.00, 1, 69.00, NOW(), NOW());