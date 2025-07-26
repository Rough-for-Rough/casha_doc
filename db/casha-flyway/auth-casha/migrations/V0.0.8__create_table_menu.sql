CREATE TABLE `function_menu` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `name` varchar(50) NOT NULL COMMENT '功能名稱 (例: 訂單管理)',
  `path` varchar(100) DEFAULT NULL COMMENT '前端路由 (例: /orders)',
  `component` varchar(100) DEFAULT NULL COMMENT '前端組件名稱 (Vue Component)',
  `type` enum('MENU','BUTTON') NOT NULL COMMENT '類型 (MENU=菜單, BUTTON=按鈕)',
  `permission_code` varchar(50) DEFAULT NULL COMMENT '對應權限代碼 (permission.code)',
  `parent_id` bigint DEFAULT NULL COMMENT '父級 ID (支持樹狀)',
  `sort_order` int DEFAULT 0 COMMENT '排序',
  `icon` varchar(50) DEFAULT NULL COMMENT '圖示',
  `is_active` tinyint NOT NULL DEFAULT '1' COMMENT '是否啟用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  KEY `idx_menu_parent` (`parent_id`),
  KEY `idx_menu_permission_code` (`permission_code`),
  CONSTRAINT `fk_menu_permission` FOREIGN KEY (`permission_code`) REFERENCES `permission`(`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='功能菜單表';
