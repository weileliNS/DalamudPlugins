# 个人国服 Dalamud 插件仓库

仓库地址：

```text
https://raw.githubusercontent.com/weileliNS/DalamudPlugins/main/repo.json
```

当前维护 [Accountant CN](https://github.com/weileliNS/Accountant)。索引只在 release 资产确实发布后更新，不发布占位或失效下载链接。

## 更新

先在源码仓发布版本，再在本仓 Actions 手动运行 `Update plugin index`，输入标签，例如 `v1.8.3.4`。也可本地运行：

```powershell
./Update-Index.ps1 -Tag v1.8.3.4
```

脚本下载已发布清单，检查 InternalName、版本及 API，再生成 `repo.json`。版本和 ZIP 均固定到相应标签，旧版本可以回退。

## 从官方源迁移

Accountant CN 保留 `Accountant` 内部名称。请先备份 Accountant 配置与数据，卸载官方源版本，再通过本自定义源安装；不能靠增加仓库 URL 强行覆盖官方源已安装的插件。

本仓仅包含分发索引与工作流；插件代码和许可在源码仓。不会存放个人游戏配置、角色记录或日志。
