-- 權限定義（permission）
CREATE TABLE `permission` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `code` varchar(50) NOT NULL COMMENT '權限代碼(系統定義)',
  `name` varchar(50) NOT NULL COMMENT '權限名稱',
  `description` varchar(200) DEFAULT NULL COMMENT '權限描述',
  `category` varchar(30) NOT NULL COMMENT '權限分類(如:ORDER,REPORT等)',
  `scope` enum('ADMIN_PORTAL','POS') NOT NULL DEFAULT 'ADMIN_PORTAL' COMMENT '適用範圍',
  `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '是否啟用(1:是,0:否)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_permission_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系統權限定義表';