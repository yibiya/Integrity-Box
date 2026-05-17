# Integrity-Box (汉化版)

停止发布 Play Integrity 截图。每次不必要的检查都会加速 Keybox 的消耗。没有人关心你的 "STRONG INTEGRITY" 截图。

## 要求

在使用 Integrity Box 之前，请确保已安装以下模块：

1. [**Official Tricky Store**](https://github.com/5ec1cff/TrickyStore/releases) 或 [**TEE Simulator**](https://github.com/JingMatrix/TEESimulator/releases)（二选一）
2. [**Zygisk Next**](https://github.com/Dr-TSNG/ZygiskNext/releases) 或 [**ReZygisk**](https://github.com/PerformanC/ReZygisk/releases)（二选一）

## 常见问题

- **什么是 IntegrityBox？**
  一个完整的 Play Integrity 兼容性和系统信号管理工具包。
- **谁应该使用 IntegrityBox？**
  关心 Play Integrity 可靠性的 Root 用户和自定义 ROM 用户。
- **它是否支持 DEVICE 和 STRONG 完整性？**
  支持，请确保已安装 Tricky Store 或 TEE Simulator 模块。

## 模块功能

- **核心实用程序：** 内置助手、推荐模块下载、检测标记应用、修复“设备未认证”问题。
- **欺骗与完整性增强：** 欺骗安卓和启动安全补丁级别、欺骗 ROM 发行密钥和构建标签、欺骗 LineageOS 属性检测、修复异常启动哈希。
- **系统与环境屏蔽：** 欺骗 SELinux 状态、加密状态、自定义恢复检测，隐藏 PIF Hook 检测。
- **Keybox 与 TEE 管理：** 更新并维护有效的 `keybox.xml`，支持多个 Keybox 注入，自动更新 `target.txt`。

## 常见失败原因

- SELinux 设置为 `permissive`。
- Play Store 版本过高（高于 40.xx）。
- 存在冲突的 Magisk / KernelSU / LSPosed 模块。
- Keybox 被吊销或无效。
- 指纹被封禁。
- 已启用 ROM 内置的 GMS 欺骗。
- 根权限未正确隐藏。

## 鸣谢

本项目使用了以下开源项目的代码：
- [ezme-nodebug](https://github.com/ez-me/ezme-nodebug)
- [PlayIntegrityFork](https://github.com/osm0sis/PlayIntegrityFork)
- [Shamiko](https://github.com/LSPosed/LSPosed.github.io/tree/shamiko-414)
