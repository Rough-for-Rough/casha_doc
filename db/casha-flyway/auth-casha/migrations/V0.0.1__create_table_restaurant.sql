-- 餐廳基本資料表
CREATE TABLE `restaurant` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `name` varchar(100) NOT NULL COMMENT '餐廳名稱',
  `code` varchar(20) NOT NULL COMMENT '餐廳代碼(用於識別)',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '狀態(1:啟用,0:停用)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_restaurant_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='餐廳基本資料表';