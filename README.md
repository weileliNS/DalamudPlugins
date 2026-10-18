# 个人国服 Dalamud 插件仓库

仓库地址：

```text
https://raw.githubusercontent.com/weileliNS/DalamudPlugins/main/repo.json
```

当前维护 [Accountant CN](https://github.com/weileliNS/Accountant)。索引只在 release 资产确实发布后更新，不发布占位或失效下载链接。

## 更新

先在源码仓发布版本，再在本仓 Actions 手动运行 `Update plugin index`，输入标签，例如 `v1.8.3.6`。也可本地运行：

```powershell
./Update-Index.ps1 -Tag v1.8.3.6
```

脚本下载已发布清单，检查 InternalName、版本及 API，再生成 `repo.json`。版本和 ZIP 均固定到相应标签，旧版本可以回退。

## 从官方源迁移

Accountant CN 从 1.8.3.6 起使用独立内部名称 `AccountantCN`。旧自定义版本使用 `Accountant`，会被国服框架按官方清单过滤；卸载和重启均不能解除这种同名过滤。

保留旧配置，停用或卸载官方 Accountant，刷新后安装 Accountant CN 1.8.3.6 或更新版本。首次启动会把旧配置及计时数据复制到独立 CN 目录并迁移 JSON 类型引用，保留原始文件，不覆盖已有 CN 数据。两个版本不要同时启用。

发布附件仍沿用 `Accountant.json` 文件名，文件中的 `InternalName` 及 ZIP 内的 DLL/清单均为 `AccountantCN`。

本仓仅包含分发索引与工作流；插件代码和许可在源码仓。不会存放个人游戏配置、角色记录或日志。
