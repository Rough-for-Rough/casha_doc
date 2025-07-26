# Database 要點



## Primary Key

使用 Snowflake ID 來確保全局唯一且趨勢遞增，避免自增 ID 對分庫分表的限制；同時引入 shard_code 作為路由維度，應用層計算分片(ShardingSphere)，避免數據庫層 FK 造成瓶頸

部分資料量較少的表格如 RBAC 相關則不使用分片

| 1 bit |    41 bits    |   10 bits   |  12 bits   |
| ------ | -------| -------| ------- |
| 符號位 |  時間戳(ms)   | 機器ID      | 序列號      |

> 起始時間 2025-07-22 00:00:00 UTC = 1753056000000
> snowflake.atacenter-id=1 # 資料中心 ID (1~2) 
> datacenter-id: 1   # 資料中心 ID (1~2 預設台北高雄各一台)
> machine-id: 3      # 機器 ID (1~2 預設每個 DC 各一台 VM)

## Foreign Key

在 MySQL 裡不強制設定 FK，而是應用層驗證，因為專案走微服務架構，避免 FK 造成分庫困難，避免寫入性能瓶頸。

## JPA & Native Query

簡單 CRUD 場景用 JPA，在大量聚合和批量計算場景，用 Native SQL

