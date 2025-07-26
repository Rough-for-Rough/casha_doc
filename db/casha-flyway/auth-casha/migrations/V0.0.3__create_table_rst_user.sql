-- 分店使用者（rst_user）
CREATE TABLE `rst_user` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `restaurant_id` bigint NOT NULL COMMENT '所屬餐廳ID (冗餘欄位)',
  `branch_id` bigint NOT NULL COMMENT '所屬分店ID',
  `username` varchar(50) NOT NULL COMMENT '登入帳號(通常是email)',
  `password_hash` varchar(255) NOT NULL COMMENT '密碼雜湊值',
  `name` varchar(50) NOT NULL COMMENT '使用者真實姓名',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '狀態(1:啟用,0:停用)',
  `last_login_at` datetime DEFAULT NULL COMMENT '最後登入時間',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_rst_user_username` (`username`),
  KEY `idx_rst_user_branch` (`branch_id`),
  KEY `idx_rst_user_restaurant` (`restaurant_id`),
  KEY `idx_rst_user_restaurant_branch` (`restaurant_id`, `branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分店使用者帳號表';