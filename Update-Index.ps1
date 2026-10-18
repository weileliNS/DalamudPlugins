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
$json = ConvertTo-Json -InputObject @($manifest) -Depth 20
[IO.File]::WriteAllText((Join-Path $PSScriptRoot 'repo.json'), $json, [Text.UTF8Encoding]::new($false))
