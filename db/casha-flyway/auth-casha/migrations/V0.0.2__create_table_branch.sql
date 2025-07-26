-- 分店表（branch）
CREATE TABLE `branch` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `restaurant_id` bigint NOT NULL COMMENT '所屬餐廳ID, restaurant.id',
  `name` varchar(100) NOT NULL COMMENT '分店名稱',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `phone` varchar(20) DEFAULT NULL COMMENT '電話',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '狀態(1:啟用,0:停用)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_branch_restaurant` (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餐廳分店表';