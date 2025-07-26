-- 角色表（role）
CREATE TABLE `role` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `branch_id` bigint NOT NULL COMMENT '所屬分店ID (每個分店可自訂角色)',
  `name` varchar(50) NOT NULL COMMENT '角色名稱',
  `description` varchar(200) DEFAULT NULL COMMENT '角色描述',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_branch_name` (`branch_id`,`name`) COMMENT '同分店角色名稱不可重複',
  KEY `idx_role_branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='分店角色表';