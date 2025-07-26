# Role-Based Access Control

Casha 透過 Spring Security 以及 JWT 實現 RBAC 認證機制。

## Role and Permission

餐廳 (Resturant) 以分店 (Branch) 作為單位，旗下可以開通多位用戶 (User)，每位用戶**目前暫定綁訂一個自定義角色(先保留一對多)**，如 Admin(default)、Viewer、Cashier 等；每個角色可以調整在平台上的使用權限。

### 創建與配置流程

1. Flyway 控制初始用戶與權限
   1. SaaS Admin Account
   2. SaaS Permission
   3. Resturant Permission
   4. Branch Permission
2. 餐廳申請帳號
3. 平台審核申請, 創建分店與餐廳級, 分店級管理員用戶
4. 分店級管理員建立角色, 配置 Permissions
5. 分店級管理員建立分店用戶, 綁並角色

### Function & Permissions

功能清單與權限相互關聯, 分別以 [function_menu] [permission] 兩個表控制。

功能由管理員於後台建立 & 測試, 再控制於 flway 內。

## ER Model

```mermaid
erDiagram
    %% 實體定義
    restaurant {
        bigint id PK "Snowflake ID"
        varchar(100) name "餐廳名稱"
        varchar(20) code UK "餐廳代碼"
        tinyint status "狀態(1:啟用,0:停用)"
        datetime created_at "建立時間"
        datetime updated_at "更新時間"
    }

    branch {
        bigint id PK "Snowflake ID"
        bigint restaurant_id FK "restaurant.id"
        varchar(100) name "分店名稱"
        varchar(255) address "地址"
        varchar(20) phone "電話"
        tinyint status "狀態"
        datetime created_at "建立時間"
        datetime updated_at "更新時間"
    }

    rst_user {
        bigint id PK "Snowflake ID"
        bigint restaurant_id FK "restaurant.id (冗餘)"
        bigint branch_id FK "branch.id"
        varchar(50) username UK "登入帳號"
        varchar(255) password_hash "密碼雜湊值"
        varchar(50) name "真實姓名"
        tinyint status "狀態"
        datetime last_login_at "最後登入時間"
        datetime created_at "建立時間"
        datetime updated_at "更新時間"
    }

    role {
        bigint id PK "Snowflake ID"
        bigint branch_id FK "branch.id"
        varchar(50) name "角色名稱"
        varchar(200) description "描述"
        varchar(100) default_path "預設首頁路徑"
        datetime created_at "建立時間"
        datetime updated_at "更新時間"
    }

    user_role {
        bigint id PK "Snowflake ID"
        bigint user_id FK "rst_user.id"
        bigint role_id FK "role.id"
        datetime created_at "建立時間"
    }

    permission {
        bigint id PK "Snowflake ID"
        varchar(50) code UK "權限代碼"
        varchar(50) name "權限名稱"
        varchar(200) description "描述"
        varchar(30) category "分類"
        enum scope "ADMIN_PORTAL|POS"
        varchar(20) data_scope "資料範圍(ALL,RESTAURANT,BRANCH)"
        tinyint is_active "是否啟用"
        datetime created_at "建立時間"
        datetime updated_at "更新時間"
    }

    role_permission {
        bigint id PK "Snowflake ID"
        bigint role_id FK "role.id"
        bigint permission_id FK "permission.id"
        datetime created_at "建立時間"
    }

    function_menu {
        bigint id PK "Snowflake ID"
        varchar(50) name "功能名稱"
        varchar(100) path "前端路由"
        varchar(100) component "前端組件"
        enum type "MENU|BUTTON"
        varchar(50) permission_code FK "permission.code"
        bigint parent_id "父級ID"
        int sort_order "排序"
        varchar(50) icon "圖示"
        tinyint is_active "是否啟用"
        datetime created_at "建立時間"
        datetime updated_at "更新時間"
    }

    %% 關係定義
    restaurant ||--o{ branch : "1:N\n(餐廳→分店)"
    branch ||--o{ rst_user : "1:N\n(分店→使用者)"
    rst_user ||--|| user_role : "1:1\n(使用者→角色關聯)"
    role ||--o{ user_role : "1:N\n(角色→使用者關聯)"
    role ||--o{ role_permission : "1:N\n(角色→權限關聯)"
    permission ||--o{ role_permission : "1:N\n(權限→角色關聯)"
    permission ||--o{ function_menu : "1:N\n(權限→功能菜單)"
    function_menu ||--o{ function_menu : "1:N\n(父菜單→子菜單)"
```

## JWT Validation

```mermaid
sequenceDiagram
    participant Client
    participant Gateway
    participant AuthService
    participant Redis

    %% ===================== 1. 登入流程 =====================
    Note over Client: 用戶登入
    Client->>Gateway: POST /auth/login (帳號密碼)
    Gateway->>AuthService: 轉發登入請求
    AuthService->>AuthService: 驗證帳號密碼
    AuthService->>Redis: 生成 JWT(jti=xyz123, roles=USER)<br>SET "jti:xyz123" "valid" EX 3600
    AuthService-->>Gateway: 返回 JWT
    Gateway-->>Client: 返回 JWT (存於客戶端)

    %% ===================== 2. 請求用戶資料 =====================
    Note over Client: 請求用戶資料
    Client->>Gateway: GET /auth/profile<br>Header: Authorization: Bearer <JWT>
    Gateway->>Gateway: 1. 解析 JWT (jti=xyz123, roles=USER)
    Gateway->>Redis: 檢查 "jti:xyz123" 是否存在
    Redis-->>Gateway: "valid" (存在且未過期)
    Gateway->>Gateway: 2. 生成 HMAC 簽名<br>(X-User-ID=123, X-User-Roles=USER)
    Gateway->>AuthService: 轉發請求<br>Headers: X-User-ID=123, X-User-Roles=USER, X-Signature=abc123
    AuthService->>AuthService: 3. 驗證 HMAC 簽名
    AuthService->>AuthService: 4. 構建 SecurityContext<br>(Authentication(principal=123, roles=[ROLE_USER]))
    AuthService->>AuthService: 5. 執行 @PreAuthorize("hasRole('USER')") 檢查
    AuthService->>AuthService: 6. 查詢用戶資料
    AuthService-->>Gateway: 返回用戶資料
    Gateway-->>Client: 返回資料

    %% ===================== 3. 登出或 Token 失效 =====================
    Note over Client: 用戶登出
    Client->>Gateway: POST /auth/logout<br>Header: Bearer <JWT>
    Gateway->>Redis: DEL "jti:xyz123" (使 JWT 失效)
    Redis-->>Gateway: OK
    Gateway-->>Client: 204 No Content
```
