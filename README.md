# Etyra

离线优先的英语词根词缀学习应用，使用 Flutter + Dart，首版面向 iOS。

## 项目状态

工程骨架已建立，功能开发尚未开始。产品目标、功能/设计规划、架构和协作约定见：

- [产品目标](docs/PRODUCT_GOAL.md)
- [功能规划](docs/FEATURE_PLAN.md)
- [架构与目录](docs/ARCHITECTURE.md)
- [ET-01 实施蓝图](docs/IMPLEMENTATION_PLAN.md)
- [v0.1 前后端契约](docs/CONTRACTS_V0_1.md)

## 工具链基线

- Flutter 3.47.1 stable / Dart 3.13.1
- Xcode 16.2
- 最低 iOS 17.0
- 真机目标：iPhone 12 Pro（iOS 17.6）

Riverpod/Drift 依赖已解析，版本锁定在 `pubspec.lock`。当前 Bundle ID 是模板占位 `com.example.etyra`，真机签名前需要替换。
