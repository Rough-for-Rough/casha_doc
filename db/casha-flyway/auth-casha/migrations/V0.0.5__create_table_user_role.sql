-- 使用者角色關聯（user_role）
CREATE TABLE `user_role` (
  `id` bigint NOT NULL COMMENT 'Snowflake ID',
  `user_id` bigint NOT NULL COMMENT '使用者ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_role_user` (`user_id`) COMMENT '一個使用者只能有一個角色',
  KEY `idx_user_role_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者角色關聯表';