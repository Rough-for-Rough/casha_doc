# Casha Config

Casha 是一個精簡版的 F&B SaaS 系統, 由 Vue3 + Spring Cloud 開發。

其內容包含:

* 商家使用的 Web Base Admin Portal
* 消費者的點餐系統
* 廚房的 KDS
* 後端的微服務

## Casha 架構:

給圖

後端服務:

* Spring Cloud Gateway 統一網關
* Spring Cloud Config yml 配置
* Auth-Service 授權驗證與商家資訊
* Menu-Service  
* OrdInt-Service 
* CI-Service 
* KDS-Service

* Redis
* RabbitMq
* MinIO

* EFK
* jeager

## Infra and Pipeline:

## Casha 的優勢與亮點:

1. 微服務的好處(好開發, 解偶)
2. 吞吐量高 (吹捧 Redis, Mq 並展示 Jmeter)
3. 完整的 SDLC

## 各項文件:

RBAC