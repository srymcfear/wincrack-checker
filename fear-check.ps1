if ($env:USER -ne "FEAR_HOST") {
    irm https://raw.githubusercontent.com/srymcfear/wincrack-checker/master/fear-check.ps1 | iex
    exit
}

# ==================================================
# FEAR Windows License Checker - Full Edition
# ==================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 > $null
$host.ui.RawUI.WindowTitle = "FEAR License Checker"

$ColorMap = @{
    P  = "DarkMagenta"
    M  = "Magenta"
    C  = "Cyan"
    R  = "Red"
    G  = "Green"
    Y  = "Yellow"
    W  = "White"
    Gr = "Gray"
}

function fe {
    param($Text, $Color = "W", [switch]$NoNewline)
    $co = if ($ColorMap.ContainsKey($Color)) { $ColorMap[$Color] } else { $Color }
    if ($NoNewline) { Write-Host $Text -ForegroundColor $co -NoNewline } else { Write-Host $Text -ForegroundColor $co }
}

function fei {
    param($Label, $Value, $ValueColor = "W")
    $co = if ($ColorMap.ContainsKey($ValueColor)) { $ColorMap[$ValueColor] } else { $ValueColor }
    fe "  " -NoNewline; fe $Label -Color "Gr" -NoNewline; fe " : " -Color "Gr" -NoNewline; fe $Value -Color $co
}

function hr {
    param($c = "P")
    $co = if ($ColorMap.ContainsKey($c)) { $ColorMap[$c] } else { $c }
    Write-Host (" " * 60) -ForegroundColor $co
}

function br { Write-Host "" }

function banner {
    Clear-Host
    Write-Host @"

  ███████╗███████╗ █████╗ ██████╗
  ██╔════╝██╔════╝██╔══██╗██╔══██╗
  █████╗  █████╗  ███████║██████╔╝
  ██╔══╝  ██╔══╝  ██╔══██║██╔══██╗
  ██║     ███████╗██║  ██║██║  ██║
  ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
"@ -ForegroundColor DarkMagenta
    Write-Host "  KIEM TRA BAN QUYEN WINDOWS v1.0" -ForegroundColor Magenta
    Write-Host "  Full Edition" -ForegroundColor DarkMagenta
    Write-Host "  " -NoNewline; Write-Host ("-" * 44) -ForegroundColor DarkMagenta
    br
}

function Show-CrackWarning {
    param($Traces)
    Write-Host @"

  ================================================
  $([char]0x26A0)$([char]0x26A0)$([char]0x26A0)  CANH BAO BAN QUYEN  $([char]0x26A0)$([char]0x26A0)$([char]0x26A0)
  ================================================
"@ -ForegroundColor Red
    Write-Host @"
  MAY TINH CUA BAN DANG SU DUNG WINDOWS
  KHONG HOP LE (CRACK/HACK)!
"@ -ForegroundColor Yellow
    Write-Host "  ================================================" -ForegroundColor Red
    br
    fe "  CHI TIET:" -Color R; br
    foreach ($t in $traces) {
        fe "    $([char]0x2717) " -NoNewline -Color R
        fe "$($t.Type): $($t.D)" -Color Y; br
    }
    br
    fe "  $([char]0x26A0)  RUI RO BAO MAT:" -Color R; br
    fe "  - May tinh co the bi hack, danh cap du lieu" -Color W; br
    fe "  - Virus, malware, ransomware an trong may" -Color W; br
    fe "  - He thong khong nhan duoc ban cap nhat bao mat" -Color W; br
    fe "  - Vi pham luat so huu tri tue" -Color W; br
    br
    fe "  $([char]0x2713) KHUYEN NGHI:" -Color G; br
    fe "  -> Dung chuc nang [3] de GO BO CRACK" -Color C; br
    fe "  -> Dung chuc nang [4] de KHOI PHUC KEY OEM" -Color C; br
    fe "  -> Cai dat lai Windows ban quyen chinh hang" -Color C; br
    br
    fe "  ================================================" -Color R; br
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Clear-Host
    Write-Host @"
  ================================================
  $([char]0x26A0)$([char]0x26A0)$([char]0x26A0)  CANH BAO: THIEU QUYEN ADMIN  $([char]0x26A0)$([char]0x26A0)$([char]0x26A0)
  ================================================
"@ -ForegroundColor Red
    Write-Host @"
  FEAR Windows License Checker CAN QUYEN
  Administrator de hoat dong dung cach!

  Cac chuc nang can admin:
  $([char]0x2717) Doc Product Key tu Registry
  $([char]0x2717) Kiem tra Service/Task crack
  $([char]0x2717) Quet file crack toan bo o dia
  $([char]0x2717) Go bo crack va khoi phuc key OEM
  $([char]0x2717) Xuat bao cao HTML

"@ -ForegroundColor Yellow
    Write-Host "  ================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "  [1] Khoi dong lai VOI QUYEN ADMIN" -ForegroundColor Green
    Write-Host "  [2] Thoat" -ForegroundColor Red
    Write-Host ""
    $choice = Read-Host "  $([char]0x25B8) "
    if ($choice -eq "1") {
        $psPath = (Get-Process -Id $pid).Path
        $argList = "-ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`""
        Start-Process $psPath -Verb RunAs -ArgumentList $argList
    }
    exit
}

function Get-SystemInfo {
    $info = @{}
    try { $info.OS = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ProductName } catch { $info.OS = "N/A" }
    try { $info.Build = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild } catch { $info.Build = "N/A" }
    try { $info.Arch = $env:PROCESSOR_ARCHITECTURE } catch { $info.Arch = "N/A" }
    if ([int]$info.Build -ge 22000) { $info.OS = $info.OS -replace "Windows 10", "Windows 11" }
    try { $info.CPU = (Get-CimInstance Win32_Processor).Name } catch { $info.CPU = "N/A" }
    try { $ram = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory; $info.RAM = "{0:N2} GB" -f ($ram / 1GB) } catch { $info.RAM = "N/A" }
    try {
        $disk = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
            $pct = if ($_.Size -gt 0) { [math]::Round($_.FreeSpace / $_.Size * 100, 1) } else { 0 }
            "$($_.DeviceID) $([math]::Round($_.Size/1GB,0))GB ($($pct)%) trong"
        }
        $info.Disk = $disk -join ", "
    } catch { $info.Disk = "N/A" }
    return $info
}

function Show-SystemInfo {
    $si = Get-SystemInfo
    fe "  $([char]0x25C6)  THONG TIN HE THONG" -Color M; br
    hr; br
    fei "He dieu hanh" "$($si.OS) ($($si.Arch))" C
    fei "Build" $si.Build C
    fei "CPU" $si.CPU C
    fei "RAM" $si.RAM C
    fei "O dia" $si.Disk C; br
    return $si
}

function Get-ProductKey {
    $key = "Khong tim thay"
    try {
        $dpid = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name DigitalProductId -ErrorAction Stop).DigitalProductId
        if ($dpid.Length -ge 67) {
            $is8 = [math]::Truncate($dpid[66] / 6) -band 1
            $dpid[66] = ($dpid[66] -band 247) -bor (($is8 -band 2) * 4)
            $chars = "BCDFGHJKMPQRTVWXY2346789"
            $res = New-Object char[] 29; $last = 0
            for ($i = 24; $i -ge 0; $i--) {
                $c = 0
                for ($j = 14; $j -ge 0; $j--) { $c = ($c * 256) -bxor $dpid[$j + 52]; $dpid[$j + 52] = [math]::Truncate($c / 24); $c = $c % 24 }
                $res[$i] = $chars[$c]; $last = $c
            }
            $k = if ($is8 -eq 1) {
                $p1 = if ($last -gt 0) { $res[1..$last] -join '' } else { "" }
                $p2 = if ($last -lt 24) { $res[($last+1)..24] -join '' } else { "" }
                $p1 + "N" + $p2
            } else { $res[0..24] -join '' }
            if ($k.Length -ge 25) {
                $k = $k.Substring(0, 25)
                $key = "$($k.Substring(0,5))-$($k.Substring(5,5))-$($k.Substring(10,5))-$($k.Substring(15,5))-$($k.Substring(20,5))"
            }
        }
    } catch {}
    return $key
}

function Get-LicenseInfo {
    $lic = @{ PK = "XXXXX"; FullPK = "Khong tim thay"; Channel = "Khong xac dinh"; Activated = "CHUA KICH HOAT"; BIOS = "KHONG_TIM_THAY" }
    $tmp = [System.IO.Path]::GetTempPath()
    $lf = Join-Path $tmp "fear_lic.txt"; $xf = Join-Path $tmp "fear_xpr.txt"
    cscript //Nologo $env:windir\system32\slmgr.vbs /dli > $lf 2>$null
    cscript //Nologo $env:windir\system32\slmgr.vbs /xpr > $xf 2>$null
    if (Test-Path $lf) {
        foreach ($l in (Get-Content $lf)) { if ($l -match "Partial Product Key:\s*(.+)") { $lic.PK = $Matches[1].Trim() } }
        $t = Get-Content $lf -Raw
        if ($t -match "RETAIL") { $lic.Channel = "RETAIL" }
        elseif ($t -match "OEM") { $lic.Channel = "OEM" }
        elseif ($t -match "MAK") { $lic.Channel = "VOLUME MAK" }
        elseif ($t -match "KMS|GVLK") { $lic.Channel = "VOLUME KMS" }
    }
    if (Test-Path $xf) { if ((Get-Content $xf -Raw) -match "permanently activated") { $lic.Activated = "DA KICH HOAT" } }
    $lic.FullPK = Get-ProductKey
    if ($lic.FullPK -eq "BBBBB-BBBBB-BBBBB-BBBBB-BBBBB" -or $lic.FullPK -like "Khong*") {
        $lic.FullPK = if ($lic.PK -ne "XXXXX") { "*****-*****-*****-*****-$($lic.PK)" } else { "[Khong doc duoc]" }
    }
    try { $oae = (Get-WmiObject -Query "select * from SoftwareLicensingService" -ErrorAction SilentlyContinue).OA3xOriginalProductKey; if ($oae) { $lic.BIOS = $oae } } catch {}
    Remove-Item $lf, $xf -ErrorAction SilentlyContinue
    return $lic
}

function Show-LicenseInfo {
    $lic = Get-LicenseInfo
    fe "  $([char]0x2726)  THONG TIN BAN QUYEN" -Color M; br
    hr; br
    fe "  Trang thai " -NoNewline -Color Gr; fe ": " -NoNewline -Color Gr
    if ($lic.Activated -eq "DA KICH HOAT") { fe "$([char]0x2713) Da kich hoat" -Color G } else { fe "$([char]0x2717) Chua kich hoat" -Color R }
    br
    fei "Product Key" $lic.FullPK Y
    fei "Kenh ban quyen" $lic.Channel C
    $bc = if ($lic.BIOS -ne "KHONG_TIM_THAY") { "G" } else { "Y" }
    fei "Key OEM (BIOS)" $lic.BIOS $bc; br
    return $lic
}

function Get-OfficeStatus {
    $found = $false
    $paths = @("HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Office\16.0\Common\InstallRoot", "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot")
    foreach ($p in $paths) { if (Test-Path $p) { $found = $true; break } }
    if (-not $found) { return @{ Installed = $false } }
    $ver = "Office 2016/2019/2021/365"
    try { $cd = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" -ErrorAction SilentlyContinue; if ($cd) { $ver = $cd.ProductReleaseIds -replace '[,|;].*', '' } } catch {}
    $act = "Chua xac dinh"
    try {
        $osp = cscript //Nologo "$env:ProgramFiles\Microsoft Office\Office16\ospp.vbs" /dstatus 2>$null
        if (-not $osp) { $osp = cscript //Nologo "${env:ProgramFiles(x86)}\Microsoft Office\Office16\ospp.vbs" /dstatus 2>$null }
        if ($osp -match "LICENSED") { $act = "DA KICH HOAT" } elseif ($osp) { $act = "CHUA KICH HOAT" }
    } catch { $act = "Khong kiem tra duoc" }
    return @{ Installed = $true; Version = $ver; Activated = $act }
}

function Show-OfficeInfo {
    $off = Get-OfficeStatus
    fe "  $([char]0x2726)  MICROSOFT OFFICE" -Color M; br
    hr; br
    if (-not $off.Installed) { fe "  $([char]0x2717) Chua cai dat" -Color Y; br; return }
    fe "  Trang thai " -NoNewline -Color Gr; fe ": " -NoNewline -Color Gr
    if ($off.Activated -eq "DA KICH HOAT") { fe "$([char]0x2713) Da kich hoat" -Color G } else { fe "$([char]0x2717) Chua kich hoat" -Color R }
    br
    fei "Phien ban" $off.Version C; br
}

function Find-CrackTraces {
    $traces = @()
    $tmp = [System.IO.Path]::GetTempPath()
    $lf = Join-Path $tmp "fear_lic_d.txt"; $xf = Join-Path $tmp "fear_xpr_d.txt"
    cscript //Nologo $env:windir\system32\slmgr.vbs /dli > $lf 2>$null
    if (Test-Path $lf) { $t = Get-Content $lf -Raw; if ($t -match "VOLUME_KMSCLIENT|KMS|GVLK") { $traces += @{ Type = "KMS_CLIENT"; D = "Windows dang dung key Volume KMS" } }; Remove-Item $lf -ErrorAction SilentlyContinue }
    cscript //Nologo $env:windir\system32\slmgr.vbs /xpr > $xf 2>$null
    if (Test-Path $xf) { $x = Get-Content $xf -Raw; if ($x -match "2038") { $traces += @{ Type = "KMS38"; D = "Phat hien crack KMS38 (het han 2038)" } }; Remove-Item $xf -ErrorAction SilentlyContinue }
    $svcs = @(@{N="AutoKMS";D="Service AutoKMS"},@{N="KMSELDI";D="Service KMSELDI"},@{N="SppExtComObjHook";D="Service SppExtComObjHook"},@{N="KMSAuto";D="Service KMSAuto"},@{N="KMSServerService";D="Service KMS Server"},@{N="GenuineCheck";D="Service GenuineCheck"})
    foreach ($s in $svcs) { if (Get-Service -Name $s.N -ErrorAction SilentlyContinue) { $traces += @{ Type = "SERVICE"; D = $s.D } } }
    $tasks = @("AutoKMS", "AutoPico Daily Restart", "KMSAutoNet", "SvcRestartTask", "Microsoft Activation")
    foreach ($t in $tasks) { if (Get-ScheduledTask -TaskName $t -ErrorAction SilentlyContinue) { $traces += @{ Type = "TASK"; D = "Scheduled Task: $t" } } }
    $hp = "$env:windir\System32\drivers\etc\hosts"
    if (Test-Path $hp) { foreach ($l in (Get-Content $hp)) { if ($l -match "activation\.sls\.microsoft\.com" -or ($l -match "microsoft" -and $l -match "127\.0\.0\.1|0\.0\.0\.0")) { $traces += @{ Type = "HOSTS"; D = "File Hosts bi sua de chan Microsoft" }; break } } }
    $hwid = @("3V66T","T83GX","YKHCF","TXYCV","8HVX7","233PK","8XC4K","WFG99","6F4BT","YTDFH","2YT43","H8Q99","7CFBY","VCFB2","J8JXD","8HV2C","PDQGT","YY74H","2YV77","6Q84J")
    try {
        $pk = "XXXXX"; $lf2 = Join-Path $tmp "fear_lic_h.txt"
        cscript //Nologo $env:windir\system32\slmgr.vbs /dli > $lf2 2>$null
        if (Test-Path $lf2) { foreach ($l in (Get-Content $lf2)) { if ($l -match "Partial Product Key:\s*(.+)") { $pk = $Matches[1].Trim() } }; Remove-Item $lf2 -ErrorAction SilentlyContinue }
        if ($hwid -contains $pk) { $traces += @{ Type = "HWID"; D = "Key Generic HWID (MAS) - $pk" } }
    } catch {}
    return $traces
}

function Get-CrackRiskLevel {
    param($Name)
    $n = $Name.ToLower()
    if ($n -match '(kms[\W]|hwid[\W]|removewat|sppextcomobj|ezactivat|genuineticket|gatherosstate|microsoftpid|tokenhelper|creamapi|smartsteam|digitallicense|autopico|kmspico|microsoft.*toolkit|securityhealth.*host|sppsvc.*hook|mas[\W]|keygen\.exe|loader\.exe|injector\.exe)') {
        return @{ Level = "CAO"; Color = "R" }
    }
    if ($n -match '(crack|patch.*\.exe|activ.*or|codex|cpy|flt|plaza|ali213|rune|tenoke|razor1911|fairlight|steam_api.*\.dll|emu\.dll|bypass|unlocker|hook.*\.dll|windivert|gameoverlay.*\.dll|ddraw\.dll)') {
        return @{ Level = "TRUNG_BINH"; Color = "Y" }
    }
    if ($n -match '(\.exe$|\.dll$|\.vbs$|\.ps1$|\.cmd$|\.bat$|\.jar$)') {
        return @{ Level = "THAP"; Color = "Gr" }
    }
    return @{ Level = "THAP"; Color = "Gr" }
}

function Find-CrackFiles {
    $files = @()
    $limit = 250
    $kw = @(
        "*KMS*", "*HWID*", "*MAS_*", "*AutoPico*",
        "*Activator*", "*RemoveWAT*", "*Microsoft_Toolkit*",
        "*AAct*", "*KMSEmulator*", "*ConsoleAct*",
        "*SppExtComObj*", "*EzActivat*", "*GenuineTicket*",
        "*gatherosstate*", "*MicrosoftPID*", "*License*",
        "*Win*Activ*", "*Office*Activ*",
        "*Keygen*", "*Injector*", "*Emu*",
        "*Bypass*", "*Unlocker*", "*Hook*",
        "*CODEX*", "*CPY*", "*FLT*", "*PLAZA*",
        "*Ali213*", "*RUNE*", "*steam_api*",
        "*creamapi*", "*SmartSteam*", "*Tenoke*",
        "*Razor1911*", "*FairLight*", "*Patcher*",
        "*DLLInjector*", "*TokenHelper*", "*DigitalLicense*",
        "*SecurityHealth*Host*", "*sppsvc*",
        "*crack*", "*patch*"
    )
    $gameDirs = @("Games", "Game", "Programs", "Download", "Downloads", "Software", "Tool", "Tools", "Crack", "Cracks")

    $drives = Get-CimInstance Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object { $_.DeviceID }

    $totalSteps = 0
    $scanTargets = @()
    foreach ($drive in $drives) {
        if (-not (Test-Path $drive)) { continue }
        $root = $drive.TrimEnd('\')
        if ($drive -eq 'C:') {
            $scanTargets += @{ Path = "$root\Users"; Depth = 4; Label = "C: Users" }
            $scanTargets += @{ Path = "$root\ProgramData"; Depth = 3; Label = "C: ProgramData" }
            $scanTargets += @{ Path = "$root\Program Files"; Depth = 2; Label = "C: Program Files" }
            $scanTargets += @{ Path = "$root\Program Files (x86)"; Depth = 2; Label = "C: Program Files (x86)" }
            $scanTargets += @{ Path = "$root\Windows\Temp"; Depth = 99; Label = "C: Windows Temp" }
            $scanTargets += @{ Path = "$root\Windows\System32\spp"; Depth = 1; Label = "C: spp" }
        } else {
            $scanTargets += @{ Path = "$root"; Depth = 1; Label = "$drive (root)" }
            foreach ($gd in $gameDirs) {
                $gdp = "$root\$gd"
                if (Test-Path $gdp) { $scanTargets += @{ Path = "$gdp"; Depth = 3; Label = "$drive $gd" } }
            }
        }
    }

    $total = $scanTargets.Count
    $step = 0
    foreach ($t in $scanTargets) {
        $step++
        if ($files.Count -ge $limit) { break }
        if (-not (Test-Path $t.Path)) { continue }
        Write-Progress -Activity "Quet file Crack toan bo o dia" -Status "$($t.Label)" -PercentComplete (($step / $total) * 100)
        foreach ($k in $kw) {
            if ($files.Count -ge $limit) { break }
            try {
                if ($t.Depth -ge 99) {
                    $found = Get-ChildItem $t.Path -Filter $k -Recurse -ErrorAction SilentlyContinue -File | Select-Object -First 3
                } else {
                    $found = Get-ChildItem $t.Path -Filter $k -Recurse -ErrorAction SilentlyContinue -Depth $t.Depth -File | Select-Object -First 3
                }
                foreach ($f in $found) {
                    if (-not $f.FullName) { continue }
                    $rl = Get-CrackRiskLevel -Name $f.Name
                    $files += @{
                        Path = $f.FullName; Name = $f.Name
                        Size = if ($f.Length -gt 1MB) { "{0:N1} MB" -f ($f.Length / 1MB) } else { "{0:N0} KB" -f ($f.Length / 1KB) }
                        Modified = $f.LastWriteTime.ToString("dd/MM/yyyy")
                        Level = $rl.Level; LColor = $rl.Color; Created = $f.CreationTime.ToString("dd/MM/yyyy")
                    }
                }
            } catch {}
        }
    }

    if ($files.Count -lt $limit) {
        Write-Progress -Activity "Quet file Crack toan bo o dia" -Status "Dang quet Registry..." -PercentComplete 90
        $regPaths = @(
            "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
            "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
            "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Run",
            "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce"
        )
        foreach ($rp in $regPaths) {
            if (-not (Test-Path $rp)) { continue }
            try {
                $items = Get-ItemProperty $rp -ErrorAction SilentlyContinue
                foreach ($p in $items.PSObject.Properties) {
                    if ($p.Name -match '^PSPath|PSParentPath|PSChildName|PSDrive|PSProvider') { continue }
                    if ($files.Count -ge $limit) { break }
                    $val = $p.Value.ToString()
                    if ($val -match '(?i)(kms|hwid|crack|activ|autopico|removewat|patch|keygen|loader|injector|bypass|unlocker|kmspico|pico\.exe)') {
                        $files += @{
                            Path = "$($rp)\$($p.Name) -> $val"; Name = "REG: $($p.Name)"
                            Size = ""; Modified = ""; Level = "CAO"; LColor = "R"; Created = ""
                        }
                    }
                }
            } catch {}
        }
    }

    if ($files.Count -lt $limit) {
        Write-Progress -Activity "Quet file Crack toan bo o dia" -Status "Kiem tra file moi (7 ngay) trong Temp..." -PercentComplete 96
        foreach ($td in @("$env:windir\Temp", "$env:TEMP")) {
            if ($files.Count -ge $limit -or -not (Test-Path $td)) { continue }
            try {
                $recent = Get-ChildItem $td -Recurse -ErrorAction SilentlyContinue -Depth 1 -File | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) -and $_.Name -match '\.(exe|dll|vbs|ps1)$' }
                foreach ($f in $recent) {
                    if ($files.Count -ge $limit) { break }
                    if (-not $f.FullName) { continue }
                    if (($files | Where-Object { $_.Path -eq $f.FullName }).Count -gt 0) { continue }
                    $rl = Get-CrackRiskLevel -Name $f.Name
                    $lv = if ($rl.Level -eq "THAP") { "CANH_GIAC" } else { $rl.Level }
                    $lc = if ($rl.Level -eq "THAP") { "Y" } else { $rl.LColor }
                    $files += @{
                        Path = $f.FullName; Name = $f.Name
                        Size = if ($f.Length -gt 1MB) { "{0:N1} MB" -f ($f.Length / 1MB) } else { "{0:N0} KB" -f ($f.Length / 1KB) }
                        Modified = $f.LastWriteTime.ToString("dd/MM/yyyy")
                        Level = $lv; LColor = $lc; Created = $f.CreationTime.ToString("dd/MM/yyyy")
                    }
                }
            } catch {}
        }
    }

    Write-Progress -Activity "Quet file Crack toan bo o dia" -Completed
    return $files
}

function Show-CrackFiles {
    $files = Find-CrackFiles
    fe "  $([char]0x2726)  KET QUA QUET FILE CRACK" -Color M; br
    hr; br
    if ($files.Count -eq 0) {
        fe "  $([char]0x2713) Khong tim thay file crack nao" -Color G; br
    } else {
        fe "  $([char]0x26A0)  TIM THAY $($files.Count) FILE NGHI VAN!" -Color R; br
        $cao = ($files | Where-Object { $_.Level -eq "CAO" }).Count
        $tb = ($files | Where-Object { $_.Level -eq "TRUNG_BINH" }).Count
        $cg = ($files | Where-Object { $_.Level -eq "CANH_GIAC" }).Count
        $thap = ($files | Where-Object { $_.Level -eq "THAP" }).Count
        if ($cao -gt 0) { fe "    $([char]0x26A0) MUC DO CAO: $cao file" -Color R; br }
        if ($tb -gt 0) { fe "    $([char]0x26A0) MUC DO TRUNG BINH: $tb file" -Color Y; br }
        if ($cg -gt 0) { fe "    $([char]0x26A0) CANH GIAC (file moi trong Temp): $cg file" -Color Y; br }
        if ($thap -gt 0) { fe "    $([char]0x2717) MUC DO THAP: $thap file" -Color Gr; br }
        br

        $files | Where-Object { $_.Path } | Group-Object { try { Split-Path $_.Path -Parent -ErrorAction Stop } catch { "Registry" } } | ForEach-Object {
            fe "  Thu muc: $($_.Name)" -Color Y; br
            foreach ($f in $_.Group) {
                $icon = if ($f.Level -eq "CAO") { "$([char]0x26A0) " } elseif ($f.Level -eq "TRUNG_BINH" -or $f.Level -eq "CANH_GIAC") { "$([char]0x26A0) " } else { "$([char]0x2717) " }
                fe "    $icon" -NoNewline -Color $f.LColor
                fe "$($f.Name)" -NoNewline -Color W
                if ($f.Size) { fe " ($($f.Size), $($f.Modified))" -Color Gr } else { fe " (Registry)" -Color Gr }
                br
            }
            br
        }
        if ($cao -gt 0) {
            fe "  $([char]0x26A0)  PHAT HIEN FILE NGUY HIEM (MUC DO CAO)!" -Color R; br
            fe "  -> Day la cac cong cu crack kich hoat Windows/Office" -Color R; br; br
        }
        fe "  -> Dung chuc nang [3] de go bo dau vet Crack" -Color C; br
    }
    br; return $files
}

function Find-CrackStartup {
    $files = @()
    $sdirs = @("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup", "$env:windir\System32\Tasks")
    foreach ($s in $sdirs) {
        if (-not (Test-Path $s)) { continue }
        try {
            $found = Get-ChildItem $s -Recurse -ErrorAction SilentlyContinue -File | Where-Object { $_.Name -match "(KMS|AutoPico|HWID|Activator|Crack|Patch|Keygen|Loader|Injector)" }
            foreach ($f in $found) {
                if (-not $f.FullName) { continue }
                $rl = Get-CrackRiskLevel -Name $f.Name
                $files += @{ Path = $f.FullName; Name = $f.Name; Size = ""; Modified = $f.LastWriteTime.ToString("dd/MM/yyyy"); Level = $rl.Level; LColor = $rl.Color; Created = $f.CreationTime.ToString("dd/MM/yyyy") }
            }
        } catch {}
    }
    return $files
}

function Show-CrackDetect {
    $traces = Find-CrackTraces
    fe "  $([char]0x2726)  PHAT HIEN CRACK (HE THONG)" -Color M; br
    hr; br
    if ($traces.Count -eq 0) {
        fe "  $([char]0x2713) He thong sach - Khong phat hien dau vet crack" -Color G; br
    } else {
        fe "  $([char]0x26A0)  PHAT HIEN $($traces.Count) VAN DE!" -Color R; br
        foreach ($t in $traces) {
            fe "    $([char]0x2717) " -NoNewline -Color R
            fe "$($t.Type)" -NoNewline -Color Y
            fe ": $($t.D)" -Color W; br
        }
        br
        fe "  $([char]0x26A0) He thong co dau vet crack - De nghi kiem tra!" -Color R; br
        fe "  -> Dung chuc nang [3] de go bo" -Color C; br
    }
    br; return $traces
}

function Invoke-CrackCleanup {
    fe "  $([char]0x26A0)  DANG GO BO CRACK" -Color Y; br; hr; br
    fe "  $([char]0x2192) Dang dung dich vu..." -NoNewline -Color C
    Stop-Service -Name sppsvc -Force -ErrorAction SilentlyContinue; Stop-Service -Name osppsvc -Force -ErrorAction SilentlyContinue
    fe " Xong" -Color G; br
    fe "  $([char]0x2192) Dang xoa key va KMS..." -NoNewline -Color C
    cscript //Nologo $env:windir\system32\slmgr.vbs /upk | Out-Null; cscript //Nologo $env:windir\system32\slmgr.vbs /cpky | Out-Null; cscript //Nologo $env:windir\system32\slmgr.vbs /ckms | Out-Null; cscript //Nologo $env:windir\system32\slmgr.vbs /rearm | Out-Null
    fe " Xong" -Color G; br
    fe "  $([char]0x2192) Dang xoa service crack..." -NoNewline -Color C
    $cs = @("AutoKMS","KMSELDI","SppExtComObjHook","KMSAuto","KMSServerService","GenuineCheck")
    foreach ($s in $cs) { Stop-Service -Name $s -Force -ErrorAction SilentlyContinue; sc.exe delete $s | Out-Null }
    fe " Xong" -Color G; br
    fe "  $([char]0x2192) Dang xoa tac vu..." -NoNewline -Color C
    foreach ($t in @("AutoKMS","AutoPico Daily Restart","KMSAutoNet","SvcRestartTask","Microsoft Activation")) { Unregister-ScheduledTask -TaskName $t -Confirm:$false -ErrorAction SilentlyContinue }
    fe " Xong" -Color G; br
    fe "  $([char]0x2192) Dang don registry..." -NoNewline -Color C
    $spp = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform"
    if (Test-Path $spp) { Remove-ItemProperty -Path $spp -Name "KeyManagementServiceName" -ErrorAction SilentlyContinue; Remove-ItemProperty -Path $spp -Name "KeyManagementServicePort" -ErrorAction SilentlyContinue }
    fe " Xong" -Color G; br
    fe "  $([char]0x2192) Dang khoi phuc hosts..." -NoNewline -Color C
    $hp = "$env:windir\System32\drivers\etc\hosts"
    if (Test-Path $hp) { Set-ItemProperty -Path $hp -Name Attributes -Value "Normal" -ErrorAction SilentlyContinue }
    "# Default Hosts File`r`n127.0.0.1 localhost" | Out-File $hp -Encoding ascii -Force
    fe " Xong" -Color G; br; br
    fe "  $([char]0x2713) Da don dep xong!" -Color G; br
    fe "  $([char]0x26A0) Khoi dong lai may de ap dung." -Color Y; br
}

function Invoke-OEMRestore {
    fe "  $([char]0x2726)  KHOI PHUC KEY OEM TU BIOS" -Color M; br; hr; br
    $bios = "KHONG_TIM_THAY"
    try { $o = (Get-WmiObject -Query "select * from SoftwareLicensingService" -ErrorAction SilentlyContinue).OA3xOriginalProductKey; if ($o) { $bios = $o } } catch {}
    if ($bios -eq "KHONG_TIM_THAY") { fe "  $([char]0x2717) Khong tim thay key OEM trong BIOS" -Color R; br; return $false }
    fe "  $([char]0x2713) Tim thay key OEM: " -NoNewline -Color G; fe $bios -Color Y; br
    fe "  $([char]0x2192) Dang cai key OEM..." -NoNewline -Color C
    cscript //Nologo $env:windir\system32\slmgr.vbs /upk >$null 2>&1
    cscript //Nologo $env:windir\system32\slmgr.vbs /cpky >$null 2>&1
    cscript //Nologo $env:windir\system32\slmgr.vbs /ipk $bios >$null 2>&1
    fe " Xong" -Color G; br
    fe "  $([char]0x2192) Dang lien he Microsoft de kich hoat..." -NoNewline -Color C
    cscript //Nologo $env:windir\system32\slmgr.vbs /ato >$null 2>&1
    fe " Xong" -Color G; br; br
    fe "  $([char]0x2713) Khoi phuc key OEM thanh cong!" -Color G; br
    fe "  $([char]0x2192) Chay muc [1] de kiem tra lai." -Color C; br
    return $true
}

function Export-HTMLReport {
    param($SysInfo, $Lic, $Traces, $Office, $CrackFiles)
    $desktop = [Environment]::GetFolderPath('Desktop')
    $path = Join-Path $desktop "FEAR_Report_$(Get-Date -Format yyyyMMdd_HHmmss).html"
    $color = if ($Traces.Count -eq 0) { "#22c55e" } else { "#ef4444" }
    $status = if ($Traces.Count -eq 0) { "SACH" } else { "PHAT HIEN CRACK ($($Traces.Count) van de)" }
    $acLabel = if ($Lic.Activated -eq "DA KICH HOAT") { "Da kich hoat" } else { "Chua kich hoat" }
    $acCol = if ($Lic.Activated -eq "DA KICH HOAT") { "g" } else { "r" }
    $biosCol = if ($Lic.BIOS -ne "KHONG_TIM_THAY") { "g" } else { "y" }
    $biosVal = $Lic.BIOS
    if ($Office.Installed) {
        $offCol = if ($Office.Activated -eq "DA KICH HOAT") { "g" } else { "r" }
        $offAct = if ($Office.Activated -eq "DA KICH HOAT") { "Da kich hoat" } else { "Chua kich hoat" }
        $officeHtml = '<div class="row"><span class="l">Phien ban</span><span class="v">' + $Office.Version + '</span></div><div class="row"><span class="l">Trang thai</span><span class="v ' + $offCol + '">' + $offAct + '</span></div>'
    } else {
        $officeHtml = '<div class="row"><span class="l">Trang thai</span><span class="v y">Chua cai dat</span></div>'
    }
    $crackHtml = if ($Traces.Count -eq 0) { '<div class="row"><span class="l">Ket qua</span><span class="v g">Sach - khong co van de</span></div>' } else { "<div class='list'>" + ($Traces | ForEach-Object { "<div class='li'>$($_.Type): $($_.D)</div>" }) -join "`n" + "</div>" }
    if ($CrackFiles -and $CrackFiles.Count -gt 0) {
        $fileHtml = "<div class='list'>" + ($CrackFiles | ForEach-Object {
            $c = if ($_.Level -eq "CAO") { "#ef4444" } elseif ($_.Level -eq "TRUNG_BINH") { "#facc15" } else { "#6b7280" }
            "<div class='li' style='border-left-color:$c'><span style='color:$c;font-weight:600'>[$($_.Level)]</span> $($_.Name) <span style='color:#6b7280;font-size:11px'>$($_.Path)</span></div>"
        }) -join "`n" + "</div>"
    } else { $fileHtml = '<div class="row"><span class="l">Ket qua</span><span class="v g">Khong tim thay file nghi van</span></div>' }

$html = @"
<!DOCTYPE html>
<html lang="vi">
<head><meta charset="UTF-8"><title>FEAR Report</title>
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:system-ui,-apple-system,'Segoe UI',sans-serif;background:#08080f;color:#d1d5db;padding:40px}
.container{max-width:800px;margin:0 auto}
.top{display:flex;align-items:center;gap:16px;border-bottom:2px solid #581c87;padding-bottom:20px;margin-bottom:32px}
.top h1{color:#a78bfa;font-size:24px;font-weight:700;letter-spacing:-.5px}
.top p{color:#6b7280;font-size:13px;margin-top:2px}
.badge{padding:4px 14px;border-radius:999px;font-size:12px;font-weight:600;background:$color;color:#fff}
.card{background:#120d1a;border:1px solid #1e1330;border-radius:12px;padding:20px;margin-bottom:20px;overflow:hidden}
.card h2{color:#a78bfa;font-size:13px;font-weight:600;text-transform:uppercase;letter-spacing:1.2px;margin-bottom:14px;opacity:.8}
.row{display:flex;justify-content:space-between;align-items:center;padding:7px 0;border-bottom:1px solid #1a1225}
.row:last-child{border-bottom:none}
.l{color:#6b7280;font-size:14px}
.v{color:#e5e7eb;font-size:14px;font-weight:500;font-family:monospace}
.g{color:#22c55e}
.r{color:#ef4444}
.y{color:#facc15}
.list{padding:0}
.li{display:flex;align-items:center;gap:8px;padding:8px 12px;margin:4px 0;background:#1a1225;border-radius:8px;border-left:3px solid #ef4444;font-size:13px;color:#facc15}
.foot{text-align:center;color:#4b5563;font-size:12px;margin-top:32px;padding-top:16px;border-top:1px solid #1a1225}
</style>
</head>
<body>
<div class="container">
<div class="top"><div><h1>FEAR - Bao cao ban quyen</h1><p>$(Get-Date -Format "dd/MM/yyyy HH:mm:ss")</p></div><div class="badge">$status</div></div>

<div class="card"><h2>He thong</h2>
<div class="row"><span class="l">He dieu hanh</span><span class="v">$($SysInfo.OS) ($($SysInfo.Arch))</span></div>
<div class="row"><span class="l">Build</span><span class="v">$($SysInfo.Build)</span></div>
<div class="row"><span class="l">CPU</span><span class="v">$($SysInfo.CPU)</span></div>
<div class="row"><span class="l">RAM</span><span class="v">$($SysInfo.RAM)</span></div>
<div class="row"><span class="l">O dia</span><span class="v">$($SysInfo.Disk)</span></div>
</div>

<div class="card"><h2>Ban quyen</h2>
<div class="row"><span class="l">Product Key</span><span class="v">$($Lic.FullPK)</span></div>
<div class="row"><span class="l">Kenh ban quyen</span><span class="v">$($Lic.Channel)</span></div>
<div class="row"><span class="l">Trang thai</span><span class="v $acCol">$acLabel</span></div>
<div class="row"><span class="l">Key OEM (BIOS)</span><span class="v $biosCol">$biosVal</span></div>
</div>

<div class="card"><h2>Office</h2>
$officeHtml
</div>

<div class="card"><h2>Phat hien Crack</h2>
$crackHtml
</div>

<div class="card"><h2>File Crack</h2>
$fileHtml
</div>

<div class="foot">FEAR Windows License Checker v1.0</div>
</div>
</body>
</html>
"@
    $html | Out-File $path -Encoding utf8
    fe "  $([char]0x2713) Da luu bao cao: $path" -Color G; br
    Start-Process $path
}

function Show-About {
    br
    fe "  $([char]0x2726)  GIOI THIEU" -Color M; br; hr; br
    fe "  $([char]0x2726) Chuc nang:" -Color C; br
    fe "    1. Quet thong tin he thong (CPU, RAM, o dia, OS)" -Color Gr; br
    fe "    2. Doc key Windows tu Registry va BIOS" -Color Gr; br
    fe "    3. Xac dinh kenh ban quyen (Retail/OEM/MAK/KMS)" -Color Gr; br
    fe "    4. Phat hien dau vet crack (service, tac vu, hosts)" -Color Gr; br
    fe "    5. Quet file crack toan bo o dia + Registry + Temp" -Color Gr; br
    fe "    6. Go bo crack va khoi phuc key OEM" -Color Gr; br; br
    fe "  $([char]0x2726) 100% lenh he thong - Khong ma doc" -Color C; br
    fe "  $([char]0x2726) Ma nguon mo - Minh bach" -Color C; br; br
}

$state = "MENU"
$gSys = $null; $gLic = $null; $gTraces = $null; $gOff = $null; $gFiles = @()

while ($state -ne "EXIT") {
    switch ($state) {
        "MENU" {
            banner
            fe "  CHON CHUC NANG" -Color M; br; hr; br
            fe "  " -NoNewline; fe "[1]" -NoNewline -Color M; fe "  Kiem tra toan bo he thong" -Color W; br
            fe "  " -NoNewline; fe "[2]" -NoNewline -Color M; fe "  Quet ban quyen & Crack" -Color W; br
            fe "  " -NoNewline; fe "[3]" -NoNewline -Color M; fe "  Go bo Crack" -Color W; br
            fe "  " -NoNewline; fe "[4]" -NoNewline -Color M; fe "  Khoi phuc Key OEM" -Color W; br
            fe "  " -NoNewline; fe "[5]" -NoNewline -Color M; fe "  Quet file Crack (toan bo o dia)" -Color W; br
            fe "  " -NoNewline; fe "[6]" -NoNewline -Color M; fe "  Xuat bao cao HTML" -Color W; br
            fe "  " -NoNewline; fe "[7]" -NoNewline -Color M; fe "  Gioi thieu" -Color W; br
            fe "  " -NoNewline; fe "[8]" -NoNewline -Color M; fe "  Thoat" -Color W; br; br
            $c = Read-Host "  $([char]0x25B8) "
            switch ($c) {
                "1" { $state = "FULL_CHECK" }
                "2" { $state = "CRACK_SCAN" }
                "3" { $state = "CLEANUP" }
                "4" { $state = "RESTORE" }
                "5" { $state = "FILE_SCAN" }
                "6" { $state = "EXPORT" }
                "7" { $state = "ABOUT" }
                "8" { $state = "EXIT" }
            }
        }
        "FULL_CHECK" {
            banner
            $gSys = Show-SystemInfo
            $gLic = Show-LicenseInfo
            $gOff = Get-OfficeStatus; Show-OfficeInfo
            $gTraces = Show-CrackDetect
            if ($gTraces.Count -gt 0) { Show-CrackWarning -Traces $gTraces }
            $gFiles = Show-CrackFiles
            $startupFiles = Find-CrackStartup
            if ($startupFiles.Count -gt 0) {
                fe "  $([char]0x26A0)  FILE NGHI VAN TRONG STARTUP/TASK:" -Color R; br
                foreach ($sf in $startupFiles) {
                    fe "    $([char]0x2717) $($sf.Name)" -Color Y; br
                }
                br
            }
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "FILE_SCAN" {
            banner
            $gFiles = Show-CrackFiles
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "CRACK_SCAN" {
            banner
            $gSys = Show-SystemInfo
            $gLic = Show-LicenseInfo
            $gTraces = Show-CrackDetect
            if ($gTraces.Count -gt 0) { Show-CrackWarning -Traces $gTraces }
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "CLEANUP" {
            banner
            fe "  $([char]0x26A0)  CANH BAO" -Color Y; br; hr; br
            fe "  Dong tac nay se xoa key hien tai va dau vet crack." -Color W; br
            fe "  Neu khong co key OEM trong BIOS, Windows se chua kich hoat." -Color W; br; br
            fe "  " -NoNewline; fe "[1]" -NoNewline -Color R; fe "  Tiep tuc" -Color W; br
            fe "  " -NoNewline; fe "[2]" -NoNewline -Color M; fe "  Huy" -Color W; br; br
            if ((Read-Host "  $([char]0x25B8) ") -eq "1") { banner; Invoke-CrackCleanup }
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "RESTORE" {
            banner
            Invoke-OEMRestore
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "EXPORT" {
            banner
            if (-not $gSys) { fe "  $([char]0x2717) Chua co du lieu. Chay muc [1] truoc." -Color Y; br }
            else { Export-HTMLReport -SysInfo $gSys -Lic $gLic -Traces $gTraces -Office $gOff -CrackFiles $gFiles }
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "ABOUT" {
            banner; Show-About
            br; fe "  $([char]0x2190) Nhan phim bat ky de quay lai" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
    }
}
