param([Parameter(Mandatory)][ValidatePattern('^v\d+\.\d+\.\d+\.\d+$')][string]$Tag)
$ErrorActionPreference = 'Stop'
$base = "https://github.com/weileliNS/Accountant/releases/download/$Tag"
$manifest = Invoke-RestMethod "$base/Accountant.json"
if ($manifest.InternalName -ne 'AccountantCN' -or "v$($manifest.AssemblyVersion)" -ne $Tag -or $manifest.DalamudApiLevel -ne 15) {
    throw 'Unexpected plugin identity, version, or API level'
}
foreach ($key in @('DownloadLinkInstall','DownloadLinkUpdate','DownloadLinkTesting')) {
    $manifest | Add-Member -NotePropertyName $key -NotePropertyValue "$base/latest.zip" -Force
}
$manifest | Add-Member -NotePropertyName LastUpdate -NotePropertyValue ([DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) -Force
$manifest | Add-Member -NotePropertyName IconUrl -NotePropertyValue 'https://raw.githubusercontent.com/weileliNS/Accountant/main/images/icon.png' -Force
$indexPath = Join-Path $PSScriptRoot 'repo.json'
$plugins = @(Get-Content -LiteralPath $indexPath -Raw | ConvertFrom-Json)
$plugins = @($plugins | Where-Object { $_.InternalName -ne $manifest.InternalName }) + @($manifest)
$json = ConvertTo-Json -InputObject $plugins -Depth 20
[IO.File]::WriteAllText($indexPath, $json, [Text.UTF8Encoding]::new($false))
