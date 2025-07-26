# Unit Test

本專案的資料夾結構使用 Clean Architecture 建構, 不強求 TDD, 但在 Jacoco 內設定 domain service, adapter 和 DB 的方法都需要經過測試:

* domain/service/**
* infrastructure/adapter/**
* infrastructure/persistence/repo/**

domain service 的方法要囊括 Spec 內的 Scenario
而 controller 在 domain service test 完整的情況下，可以只測試 Happy Path + 1~2 個錯誤情境

common package 內的 untils 工具全部都需要測試, 但是不包含在 coverage 內。