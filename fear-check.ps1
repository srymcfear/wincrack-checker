if ($env:USER -ne "FEAR_HOST" -and -not $env:FEAR_DOWNLOADED) {
    $env:FEAR_DOWNLOADED = "1"
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

Clear-Host
Write-Host @"
  ================================================
  FEAR Windows License Checker - LANGUAGE
  ================================================
  [1] Tieng Viet
  [2] English
  ================================================
"@ -ForegroundColor Magenta
$langChoice = Read-Host "  $([char]0x25B8) "
$EN = if ($langChoice -eq "2") { $true } else { $false }

$MsgVI = @{
    SACH = "Sach"; KHONG_PHAT_HIEN = "Khong phat hien"
    DA_KICH_HOAT = "Da kich hoat"; CHUA_KICH_HOAT = "Chua kich hoat"
    HE_THONG = "He thong"; BAN_QUYEN = "Ban quyen"; FILE_CRACK = "File Crack"
    KET_QUA = "Ket qua"; CHI_TIET = "Chi tiet"; CHUC_NANG = "Chuc nang"
    THONG_TIN = "Thong tin"; TRANG_THAI = "Trang thai"
    CAO = "CAO"; TRUNG_BINH = "TRUNG BINH"; THAP = "THAP"
    DANH_GIA = "Danh gia"; DIEM = "diem"
    CO = "Co"; KHONG = "Khong"
    HE_DIEU_HANH = "He dieu hanh"; BUILD = "Build"; CPU = "CPU"
    RAM = "RAM"; O_DIA = "O dia"
    PRODUCT_KEY = "Product Key"; KENH_BAN_QUYEN = "Kenh ban quyen"; KEY_OEM = "Key OEM (BIOS)"
    OFFICE = "Microsoft Office"; PHIEN_BAN = "Phien ban"; CHUA_CAI_DAT = "Chua cai dat"
    PHAT_HIEN = "Phat hien"; VAN_DE = "van de"; CRACK_PHAT_HIEN = "Sach - Khong phat hien dau vet crack"
    CANH_BAO_CRACK = "Phat hien crack!"; STARTUP_NGHI_VAN = "FILE NGHI VAN TRONG STARTUP/TASK"
    DANG_QUET = "Dang quet"; FILE_NGHI_VAN = "file nghi van"
    KHONG_FILE_CRACK = "Khong tim thay file crack nao"
    FILE_NGUY_HIEM = "PHAT HIEN FILE NGUY HIEM (MUC DO CAO)!"
    REGISTRY_SAU = "REGISTRY SAU"
    BEHAVIORAL = "BEHAVIORAL (WMI / TOKEN / SERVICES)"
    ADS = "ALTERNATE DATA STREAMS (ADS)"
    KMS_SERVER = "KMS SERVER"
    FORENSIC = "FORENSIC (PS HISTORY / EVENTLOG / HWID)"
    CANH_BAO = "CANH BAO"
    GO_BO = "DANG GO BO CRACK"
    GO_BO_MO_TA = "Dong tac nay se xoa key hien tai va dau vet crack."
    GO_BO_OEM = "Neu khong co key OEM trong BIOS, Windows se chua kich hoat."
    DA_DON_DEP = "Da don dep xong!"
    KHOI_DONG_LAI = "Khoi dong lai may de ap dung."
    KHOI_PHUC_OEM = "KHOI PHUC KEY OEM TU BIOS"
    OEM_KHONG_TIM_THAY = "Khong tim thay key OEM trong BIOS"
    OEM_THANH_CONG = "Khoi phuc key OEM thanh cong!"
    DA_LUU = "Da luu bao cao"
    CHUA_CO_DU_LIEU = "Chua co du lieu. Chay muc [1] truoc."
    NGUY_CO_CAO = "NGUY CO CAO"; RATING_WARN = "CANH BAO"; AN_TOAN = "AN TOAN"
    NGUY_CO_CAO_MO_TA = "He thong da bi crack hoac co the bi crack."
    CANH_BAO_MO_TA = "Phat hien diem bat thuong. Can kiem tra chi tiet."
    AN_TOAN_MO_TA = "Khong phat hien bat thuong. He thong sach."
    RUI_RO = "RUI RO BAO MAT:"
    BI_HACK = "May tinh co the bi hack, danh cap du lieu"
    VIRUS = "Virus, malware, ransomware an trong may"
    KHONG_CAP_NHAT = "He thong khong nhan duoc ban cap nhat bao mat"
    VI_PHAM = "Vi pham luat so huu tri tue"
    KHUYEN_NGHI = "KHUYEN NGHI:"
    GO_BO_CRACK = "Dung chuc nang [3] de GO BO CRACK"
    KHOI_PHUC_OEM_CRACK = "Dung chuc nang [4] de KHOI PHUC KEY OEM"
    CAI_DAT_LAI = "Cai dat lai Windows ban quyen chinh hang"
    DUNG_DICH_VU = "Dang dung dich vu..."
    XOA_KEY = "Dang xoa key va KMS..."
    XOA_SERVICE = "Dang xoa service crack..."
    XOA_TAC_VU = "Dang xoa tac vu..."
    DON_REGISTRY = "Dang don registry..."
    KHOI_PHUC_HOSTS = "Dang khoi phuc hosts..."
    CAI_KEY_OEM = "Dang cai key OEM..."
    LIEN_HE_MS = "Dang lien he Microsoft de kich hoat..."
    XONG = "Xong"
    CHON_CHUC_NANG = "CHON CHUC NANG"
    KIEM_TRA_TOAN_BO = "Kiem tra toan bo he thong"
    QUET_BAN_QUYEN = "Quet ban quyen & Crack"
    XUAT_HTML = "Xuat bao cao HTML"
    XUAT_TXT_JSON = "Xuat bao cao TXT + JSON"
    GIOI_THIEU = "Gioi thieu"
    THOAT = "Thoat"
    TIEP_TUC = "Tiep tuc"
    HUY = "Huy"
    QUAY_LAI = "Nhan phim bat ky de quay lai"
    GIOI_THIEU_CHUC_NANG = @"
    1. Quet thong tin he thong (CPU, RAM, o dia, OS)
    2. Doc key Windows tu Registry va BIOS
    3. Xac dinh kenh ban quyen (Retail/OEM/MAK/KMS)
    4. Phat hien dau vet crack (service, tac vu, hosts)
    5. Quet file crack toan bo o dia + Registry + Temp
    6. Phat hien nang cao (KMS, Forensic, WMI, AppInit, ADS)
    7. Go bo crack va khoi phuc key OEM
    8. Xuat bao cao HTML / TXT / JSON
"@
    PHAN_TRAM = "100% lenh he thong - Khong ma doc"
    MA_NGUON_MO = "Ma nguon mo - Minh bach"
    KHONG_PHAT_HIEN_ADV = "Khong phat hien bat thuong nang cao nao"
}
$MsgEN = @{
    SACH = "Safe"; KHONG_PHAT_HIEN = "Not detected"
    DA_KICH_HOAT = "Activated"; CHUA_KICH_HOAT = "Not activated"
    HE_THONG = "System"; BAN_QUYEN = "License"; FILE_CRACK = "Crack Files"
    KET_QUA = "Result"; CHI_TIET = "Details"; CHUC_NANG = "Features"
    THONG_TIN = "Information"; TRANG_THAI = "Status"
    CAO = "HIGH"; TRUNG_BINH = "MEDIUM"; THAP = "LOW"
    DANH_GIA = "Assessment"; DIEM = "points"
    CO = "Yes"; KHONG = "No"
    HE_DIEU_HANH = "Operating System"; BUILD = "Build"; CPU = "CPU"
    RAM = "RAM"; O_DIA = "Disk"
    PRODUCT_KEY = "Product Key"; KENH_BAN_QUYEN = "License Channel"; KEY_OEM = "OEM Key (BIOS)"
    OFFICE = "Microsoft Office"; PHIEN_BAN = "Version"; CHUA_CAI_DAT = "Not installed"
    PHAT_HIEN = "Detected"; VAN_DE = "issues found"; CRACK_PHAT_HIEN = "Clean - No crack traces found"
    CANH_BAO_CRACK = "Crack detected!"; STARTUP_NGHI_VAN = "SUSPICIOUS FILES IN STARTUP/TASK"
    DANG_QUET = "Scanning"; FILE_NGHI_VAN = "suspicious files found"
    KHONG_FILE_CRACK = "No crack files found"
    FILE_NGUY_HIEM = "HIGH RISK FILES DETECTED!"
    REGISTRY_SAU = "REGISTRY DEEP"
    BEHAVIORAL = "BEHAVIORAL (WMI / TOKEN / SERVICES)"
    ADS = "ALTERNATE DATA STREAMS (ADS)"
    KMS_SERVER = "KMS SERVER"
    FORENSIC = "FORENSIC (PS HISTORY / EVENTLOG / HWID)"
    CANH_BAO = "WARNING"
    GO_BO = "REMOVING CRACK"
    GO_BO_MO_TA = "This action will remove current key and crack traces."
    GO_BO_OEM = "Without OEM key in BIOS, Windows will not be activated."
    DA_DON_DEP = "Cleanup complete!"
    KHOI_DONG_LAI = "Reboot to apply changes."
    KHOI_PHUC_OEM = "RESTORING OEM KEY FROM BIOS"
    OEM_KHONG_TIM_THAY = "No OEM key found in BIOS"
    OEM_THANH_CONG = "OEM key restored successfully!"
    DA_LUU = "Report saved"
    CHUA_CO_DU_LIEU = "No data. Run [1] first."
    NGUY_CO_CAO = "HIGH RISK"; RATING_WARN = "WARNING"; AN_TOAN = "SAFE"
    NGUY_CO_CAO_MO_TA = "System has been cracked or may be cracked."
    CANH_BAO_MO_TA = "Suspicious activity detected. Check details."
    AN_TOAN_MO_TA = "No abnormalities found. System is clean."
    RUI_RO = "SECURITY RISKS:"
    BI_HACK = "System may be hacked, data may be stolen"
    VIRUS = "Virus, malware, ransomware may be present"
    KHONG_CAP_NHAT = "System won't receive security updates"
    VI_PHAM = "Copyright infringement"
    KHUYEN_NGHI = "RECOMMENDATION:"
    GO_BO_CRACK = "Use [3] to remove Crack"
    KHOI_PHUC_OEM_CRACK = "Use [4] to restore OEM Key"
    CAI_DAT_LAI = "Install genuine Windows"
    DUNG_DICH_VU = "Stopping services..."
    XOA_KEY = "Removing key and KMS..."
    XOA_SERVICE = "Removing crack services..."
    XOA_TAC_VU = "Removing tasks..."
    DON_REGISTRY = "Cleaning registry..."
    KHOI_PHUC_HOSTS = "Restoring hosts file..."
    CAI_KEY_OEM = "Installing OEM key..."
    LIEN_HE_MS = "Contacting Microsoft to activate..."
    XONG = "Done"
    CHON_CHUC_NANG = "SELECT FUNCTION"
    KIEM_TRA_TOAN_BO = "Full system check"
    QUET_BAN_QUYEN = "License & Crack scan"
    XUAT_HTML = "Export HTML report"
    XUAT_TXT_JSON = "Export TXT + JSON report"
    GIOI_THIEU = "About"
    THOAT = "Exit"
    TIEP_TUC = "Continue"
    HUY = "Cancel"
    QUAY_LAI = "Press any key to go back"
    GIOI_THIEU_CHUC_NANG = @"
    1. System info (CPU, RAM, Disk, OS)
    2. Read Windows key from Registry and BIOS
    3. License channel detection (Retail/OEM/MAK/KMS)
    4. Crack trace detection (service, task, hosts)
    5. Full drive crack file scan + Registry + Temp
    6. Advanced detection (KMS, Forensic, WMI, AppInit, ADS)
    7. Remove crack and restore OEM key
    8. Export reports HTML / TXT / JSON
"@
    PHAN_TRAM = "100% system commands - No malware"
    MA_NGUON_MO = "Open source - Transparent"
    KHONG_PHAT_HIEN_ADV = "No advanced abnormalities detected"
}
$msg = if ($EN) { $MsgEN } else { $MsgVI }

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
    $t1 = if ($EN) { "WINDOWS LICENSE CHECKER v1.0" } else { "KIEM TRA BAN QUYEN WINDOWS v1.0" }
    Write-Host "  $t1" -ForegroundColor Magenta
    Write-Host "  Full Edition" -ForegroundColor DarkMagenta
    Write-Host "  " -NoNewline; Write-Host ("-" * 44) -ForegroundColor DarkMagenta
    br
}

function Show-CrackWarning {
    param($Traces)
    $w1 = if ($EN) { "LICENSE WARNING" } else { "CANH BAO BAN QUYEN" }
    $w2 = if ($EN) { "YOUR COMPUTER IS USING" } else { "MAY TINH CUA BAN DANG SU DUNG WINDOWS" }
    $w3 = if ($EN) { "NON-GENUINE WINDOWS (CRACK/HACK)!" } else { "KHONG HOP LE (CRACK/HACK)!" }
    Write-Host @"

  ================================================
  $([char]0x26A0)$([char]0x26A0)$([char]0x26A0)  $w1  $([char]0x26A0)$([char]0x26A0)$([char]0x26A0)
  ================================================
"@ -ForegroundColor Red
    Write-Host "  $w2" -ForegroundColor Yellow
    Write-Host "  $w3" -ForegroundColor Yellow
    Write-Host "  ================================================" -ForegroundColor Red
    br
    fe "  $($msg.CHI_TIET):" -Color R; br
    foreach ($t in $traces) {
        fe "    $([char]0x2717) " -NoNewline -Color R
        fe "$($t.Type): $($t.D)" -Color Y; br
    }
    br
    fe "  $([char]0x26A0)  $($msg.RUI_RO)" -Color R; br
    fe "  - $($msg.BI_HACK)" -Color W; br
    fe "  - $($msg.VIRUS)" -Color W; br
    fe "  - $($msg.KHONG_CAP_NHAT)" -Color W; br
    fe "  - $($msg.VI_PHAM)" -Color W; br
    br
    fe "  $([char]0x2713) $($msg.KHUYEN_NGHI)" -Color G; br
    fe "  -> $($msg.GO_BO_CRACK)" -Color C; br
    fe "  -> $($msg.KHOI_PHUC_OEM_CRACK)" -Color C; br
    fe "  -> $($msg.CAI_DAT_LAI)" -Color C; br
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
    $a1 = if ($EN) { "FEAR Windows License Checker requires" } else { "FEAR Windows License Checker CAN QUYEN" }
    $a2 = if ($EN) { "Administrator privileges to function properly!" } else { "Administrator de hoat dong dung cach!" }
    $a3 = if ($EN) { "Functions requiring admin:" } else { "Cac chuc nang can admin:" }
    $a4 = if ($EN) { "Read Product Key from Registry" } else { "Doc Product Key tu Registry" }
    $a5 = if ($EN) { "Scan crack Services/Tasks" } else { "Kiem tra Service/Task crack" }
    $a6 = if ($EN) { "Full drive crack file scan" } else { "Quet file crack toan bo o dia" }
    $a7 = if ($EN) { "Remove crack and restore OEM key" } else { "Go bo crack va khoi phuc key OEM" }
    $a8 = if ($EN) { "Export HTML report" } else { "Xuat bao cao HTML" }
    $a9 = if ($EN) { "Restart WITH ADMIN PRIVILEGES" } else { "Khoi dong lai VOI QUYEN ADMIN" }
    $a10 = if ($EN) { "Exit" } else { "Thoat" }
    Write-Host "  $a1" -ForegroundColor Yellow
    Write-Host "  $a2" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  $a3" -ForegroundColor Yellow
    Write-Host "  $([char]0x2717) $a4" -ForegroundColor Yellow
    Write-Host "  $([char]0x2717) $a5" -ForegroundColor Yellow
    Write-Host "  $([char]0x2717) $a6" -ForegroundColor Yellow
    Write-Host "  $([char]0x2717) $a7" -ForegroundColor Yellow
    Write-Host "  $([char]0x2717) $a8" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  ================================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "  [1] $a9" -ForegroundColor Green
    Write-Host "  [2] $a10" -ForegroundColor Red
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
    fe "  $([char]0x25C6)  $($msg.HE_THONG)" -Color M; br
    hr; br
    fei $msg.HE_DIEU_HANH "$($si.OS) ($($si.Arch))" C
    fei $msg.BUILD $si.Build C
    fei $msg.CPU $si.CPU C
    fei $msg.RAM $si.RAM C
    fei $msg.O_DIA $si.Disk C; br
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
    fe "  $([char]0x2726)  $($msg.BAN_QUYEN)" -Color M; br
    hr; br
    fe "  $($msg.TRANG_THAI) " -NoNewline -Color Gr; fe ": " -NoNewline -Color Gr
    if ($lic.Activated -eq "DA KICH HOAT") { fe "$([char]0x2713) $($msg.DA_KICH_HOAT)" -Color G } else { fe "$([char]0x2717) $($msg.CHUA_KICH_HOAT)" -Color R }
    br
    fei $msg.PRODUCT_KEY $lic.FullPK Y
    fei $msg.KENH_BAN_QUYEN $lic.Channel C
    $bc = if ($lic.BIOS -ne "KHONG_TIM_THAY") { "G" } else { "Y" }
    fei $msg.KEY_OEM $lic.BIOS $bc; br
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
    fe "  $([char]0x2726)  $($msg.OFFICE)" -Color M; br
    hr; br
    if (-not $off.Installed) { fe "  $([char]0x2717) $($msg.CHUA_CAI_DAT)" -Color Y; br; return }
    fe "  $($msg.TRANG_THAI) " -NoNewline -Color Gr; fe ": " -NoNewline -Color Gr
    if ($off.Activated -eq "DA KICH HOAT") { fe "$([char]0x2713) $($msg.DA_KICH_HOAT)" -Color G } else { fe "$([char]0x2717) $($msg.CHUA_KICH_HOAT)" -Color R }
    br
    fei $msg.PHIEN_BAN $off.Version C; br
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
    $gvlks = @{ "T83GX" = "Win 10/11 Pro GVLK"; "3GPPG" = "Win 10/11 Enterprise GVLK"; "6F4BT" = "Win 10/11 Pro Edu GVLK"; "9F84F" = "Win 10/11 Pro Workstation GVLK"; "4VH34" = "Win 10/11 Home GVLK" }
    try {
        $pk2 = "XXXXX"; $lf3 = Join-Path $tmp "fear_lic_g.txt"
        cscript //Nologo $env:windir\system32\slmgr.vbs /dli > $lf3 2>$null
        if (Test-Path $lf3) { foreach ($l in (Get-Content $lf3)) { if ($l -match "Partial Product Key:\s*(.+)") { $pk2 = $Matches[1].Trim() } }; Remove-Item $lf3 -ErrorAction SilentlyContinue }
        $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
        $partOfDomain = if ($cs) { $cs.PartOfDomain } else { $false }
        if ($gvlks.ContainsKey($pk2) -and -not $partOfDomain) {
            $traces += @{ Type = "GVLK"; D = "Key GVLK mac dinh trong Workgroup - $pk2 ($($gvlks[$pk2]))" }
        }
    } catch {}
    return $traces
}

function Get-CrackRiskLevel {
    param($Name)
    $n = $Name.ToLower()
    if ($n -match '(kms[\W]|hwid[\W]|removewat|sppextcomobj|ezactivat|genuineticket|gatherosstate|microsoftpid|tokenhelper|creamapi|smartsteam|digitallicense|autopico|kmspico|microsoft.*toolkit|securityhealth.*host|sppsvc.*hook|mas[\W]|keygen\.exe|loader\.exe|injector\.exe|tsforge|heu.?kms|chew.*wga|antiwpa|cmwtat|kms365|kms.?matrix|giga.*kms|smokey.*kms|ab.?commander|genuine.*advantage|w10.*activ|w11.*activ|daz.*loader|windows.*loader.*\.exe|s.*microsoft|medic.*(window|office)|digital.*activation|token.*activation)') {
        return @{ Level = "CAO"; Color = "R" }
    }
    if ($n -match '(crack|patch.*\.exe|activ.*or|codex|cpy|flt|plaza|ali213|rune|tenoke|razor1911|fairlight|steam_api.*\.dll|emu\.dll|bypass|unlocker|hook.*\.dll|windivert|gameoverlay.*\.dll|ddraw\.dll|\.hta$|\.js$|\.wsf$|\.scr$|\.com$|waloader|chew.*wgat)') {
        return @{ Level = "TRUNG_BINH"; Color = "Y" }
    }
    if ($n -match '(\.exe$|\.dll$|\.vbs$|\.ps1$|\.cmd$|\.bat$|\.jar$|\.scr$|\.com$)') {
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
        "*crack*", "*patch*",
        "*TSforge*", "*HEU*KMS*", "*Chew*WGA*", "*AntiWPA*",
        "*CMWTAT*", "*KMS365*", "*KMS*Matrix*", "*GIGA*KMS*",
        "*Smokey*", "*AB*Commander*", "*WGA*",
        "*Windows*Loader*", "*DAZ*Loader*",
        "*Digital*Activation*", "*Token*Activation*",
        "*Medic*Window*", "*Medic*Office*",
        "*S*Microsoft*", "*waloader*",
        "*sppc.dll*", "*sppcs.dll*"
    )
    $extKw = @("*.hta", "*.wsf", "*.scr", "*.com")
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
        Write-Progress -Activity "Quet file Crack toan bo o dia" -Status "Dang quet file mo rong (.hta .wsf .scr .com)..." -PercentComplete 85
        foreach ($t in $scanTargets) {
            if ($files.Count -ge $limit) { break }
            if (-not (Test-Path $t.Path)) { continue }
            foreach ($ex in $extKw) {
                if ($files.Count -ge $limit) { break }
                try {
                    $d2 = if ($t.Depth -ge 99) { $null } else { $t.Depth }
                    $found = Get-ChildItem $t.Path -Filter $ex -Recurse -ErrorAction SilentlyContinue -Depth $d2 -File | Where-Object { $_.Name -match '(?i)(crack|activ|patch|keygen|loader|injector|emu|kms|hwid)' } | Select-Object -First 5
                    foreach ($f in $found) {
                        if (-not $f.FullName) { continue }
                        $rl = Get-CrackRiskLevel -Name $f.Name
                        $files += @{ Path = $f.FullName; Name = $f.Name; Size = ""; Modified = $f.LastWriteTime.ToString("dd/MM/yyyy"); Level = $rl.Level; LColor = $rl.Color; Created = $f.CreationTime.ToString("dd/MM/yyyy") }
                    }
                } catch {}
            }
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
    $h1 = if ($EN) { "CRACK FILE SCAN RESULTS" } else { "KET QUA QUET FILE CRACK" }
    fe "  $([char]0x2726)  $h1" -Color M; br
    hr; br
    if ($files.Count -eq 0) {
        fe "  $([char]0x2713) $($msg.KHONG_FILE_CRACK)" -Color G; br
    } else {
        $f1 = if ($EN) { "FOUND $($files.Count) SUSPICIOUS FILES!" } else { "TIM THAY $($files.Count) FILE NGHI VAN!" }
        fe "  $([char]0x26A0)  $f1" -Color R; br
        $cao = ($files | Where-Object { $_.Level -eq "CAO" }).Count
        $tb = ($files | Where-Object { $_.Level -eq "TRUNG_BINH" }).Count
        $cg = ($files | Where-Object { $_.Level -eq "CANH_GIAC" }).Count
        $thap = ($files | Where-Object { $_.Level -eq "THAP" }).Count
        $lblCao = if ($EN) { "HIGH RISK:" } else { "MUC DO CAO:" }
        $lblTb = if ($EN) { "MEDIUM:" } else { "MUC DO TRUNG BINH:" }
        $lblCg = if ($EN) { "WATCH (new files in Temp):" } else { "CANH GIAC (file moi trong Temp):" }
        $lblThap = if ($EN) { "LOW:" } else { "MUC DO THAP:" }
        if ($cao -gt 0) { fe "    $([char]0x26A0) $lblCao $cao file" -Color R; br }
        if ($tb -gt 0) { fe "    $([char]0x26A0) $lblTb $tb file" -Color Y; br }
        if ($cg -gt 0) { fe "    $([char]0x26A0) $lblCg $cg file" -Color Y; br }
        if ($thap -gt 0) { fe "    $([char]0x2717) $lblThap $thap file" -Color Gr; br }
        br

        $lblDir = if ($EN) { "Directory:" } else { "Thu muc:" }
        $files | Where-Object { $_.Path } | Group-Object { try { Split-Path $_.Path -Parent -ErrorAction Stop } catch { "Registry" } } | ForEach-Object {
            fe "  $lblDir $($_.Name)" -Color Y; br
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
            $w1 = if ($EN) { "HIGH RISK FILES DETECTED!" } else { "PHAT HIEN FILE NGUY HIEM (MUC DO CAO)!" }
            $w2 = if ($EN) { "These are crack tools for Windows/Office activation" } else { "Day la cac cong cu crack kich hoat Windows/Office" }
            $w3 = if ($EN) { "Use [3] to remove crack traces" } else { "Dung chuc nang [3] de go bo dau vet Crack" }
            fe "  $([char]0x26A0)  $w1" -Color R; br
            fe "  -> $w2" -Color R; br; br
            fe "  -> $w3" -Color C; br
        } else {
            $w3 = if ($EN) { "Use [3] to remove crack traces" } else { "Dung chuc nang [3] de go bo dau vet Crack" }
            fe "  -> $w3" -Color C; br
        }
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

function Find-CrackRegistryDeep {
    $issues = @()
    $checks = @(
        @{ Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"; Prop = "Userinit"; Desc = "Winlogon Userinit"; Good = "userinit.exe" }
        @{ Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"; Prop = "Shell"; Desc = "Winlogon Shell"; Good = "explorer.exe" }
        @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager"; Prop = "AppInit_DLLs"; Desc = "AppInit_DLLs"; Good = "" }
        @{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ShellServiceObjectDelayLoad"; Prop = $null; Desc = "ShellServiceObjectDelayLoad"; Good = "" }
        @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\sppsvc"; Prop = "Start"; Desc = "sppsvc (SPP)"; Good = "2" }
        @{ Path = "HKLM:\SYSTEM\CurrentControlSet\Services\osppsvc"; Prop = "Start"; Desc = "osppsvc (Office SPP)"; Good = "2" }
        @{ Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"; Prop = "AUOptions"; Desc = "Windows Update"; Good = "" }
    )
    foreach ($c in $checks) {
        try {
            if (-not (Test-Path $c.Path)) { continue }
            $val = if ($c.Prop -and $c.Prop -eq $null) { Get-Item $c.Path -ErrorAction Stop } else { (Get-ItemProperty $c.Path -ErrorAction Stop).$($c.Prop) }
            if ($c.Prop -eq $null) {
                $props = (Get-ItemProperty $c.Path).PSObject.Properties | Where-Object { $_.Name -notmatch '^PSPath|PSParentPath|PSChildName|PSDrive|PSProvider' }
                if ($props.Count -gt 0) { $issues += @{ Type = $c.Desc; Detail = "$($c.Path) co $($props.Count) entries"; Level = "TRUNG_BINH"; LColor = "Y" } }
            } elseif ($c.Prop -eq "Userinit") {
                if ($val -notmatch '^C:\\Windows\\system32\\userinit\.exe,?$') { $issues += @{ Type = $c.Desc; Detail = "Userinit = $val"; Level = "CAO"; LColor = "R" } }
            } elseif ($c.Prop -eq "Shell") {
                if ($val -notmatch '^explorer\.exe$') { $issues += @{ Type = $c.Desc; Detail = "Shell = $val"; Level = "CAO"; LColor = "R" } }
            } elseif ($c.Prop -eq "AppInit_DLLs") {
                if (-not [string]::IsNullOrEmpty($val)) { $issues += @{ Type = $c.Desc; Detail = "AppInit_DLLs = $val"; Level = "CAO"; LColor = "R" } }
            } elseif ($c.Prop -eq "Start") {
                if ($val -ne "2") { $issues += @{ Type = $c.Desc; Detail = "Start type = $val (phai la 2-Auto)"; Level = "CAO"; LColor = "R" } }
            } elseif ($c.Prop -eq "AUOptions") {
                if ($val -eq 1) { $issues += @{ Type = $c.Desc; Detail = "Windows Update bi tat (AUOptions=1)"; Level = "TRUNG_BINH"; LColor = "Y" } }
            } elseif ($val -and $val -ne $c.Good) {
                $issues += @{ Type = $c.Desc; Detail = "$($c.Prop) = $val"; Level = "CAO"; LColor = "R" }
            }
        } catch {}
    }
    try {
        $wu = Get-Service wuauserv -ErrorAction SilentlyContinue
        if ($wu -and $wu.StartType -ne "Automatic") { $issues += @{ Type = "Windows Update Service"; Detail = "wuauserv StartType = $($wu.StartType)"; Level = "TRUNG_BINH"; LColor = "Y" } }
    } catch {}
    try {
        $ohook = "HKCU:\Software\Microsoft\Office\16.0\Common\Licensing\Resiliency"
        if (Test-Path $ohook) {
            $hb = (Get-ItemProperty $ohook -Name "TimeOfLastHeartbeatFailure" -ErrorAction SilentlyContinue).TimeOfLastHeartbeatFailure
            if ($hb -and ($hb -like "*2038*" -or $hb -like "*2040*" -or $hb -like "*2050*")) {
                $issues += @{ Type = "Ohook"; Detail = "Registry Ohook pha hien (TimeOfLastHeartbeatFailure=$hb)"; Level = "CAO"; LColor = "R" }
            }
        }
    } catch {}
    return $issues
}

function Find-CrackBehavioral {
    $issues = @()
    try {
        $wmiFilters = Get-WmiObject -Namespace root\subscription -Class __EventFilter -ErrorAction SilentlyContinue
        foreach ($f in $wmiFilters) { $issues += @{ Type = "WMI EventFilter"; Detail = "$($f.Name): $($f.Query)"; Level = "CAO"; LColor = "R" } }
    } catch {}
    try {
        $wmiConsumers = Get-WmiObject -Namespace root\subscription -Class __EventConsumer -ErrorAction SilentlyContinue
        foreach ($c in $wmiConsumers) { $issues += @{ Type = "WMI EventConsumer"; Detail = "$($c.Name): $($c.__CLASS)"; Level = "CAO"; LColor = "R" } }
    } catch {}
    try {
        $bindings = Get-WmiObject -Namespace root\subscription -Class __FilterToConsumerBinding -ErrorAction SilentlyContinue
        foreach ($b in $bindings) { $issues += @{ Type = "WMI Binding"; Detail = "$($b.Filter) -> $($b.Consumer)"; Level = "CAO"; LColor = "R" } }
    } catch {}
    try {
        $tokenDir = "$env:windir\System32\spp\store\2.0"
        if (Test-Path $tokenDir) {
            $tokens = Get-ChildItem $tokenDir -File -ErrorAction SilentlyContinue
            $recent = $tokens | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-30) }
            if ($recent.Count -gt 0) { $issues += @{ Type = "Token Store"; Detail = "$($tokens.Count) token files, $($recent.Count) file sua trong 30 ngay"; Level = "THAP"; LColor = "Gr" } }
            if ($tokens.Count -gt 20) { $issues += @{ Type = "Token Store"; Detail = "So luong token bat thuong ($($tokens.Count))"; Level = "TRUNG_BINH"; LColor = "Y" } }
        }
    } catch {}
    try {
        $spp = Get-CimInstance -ClassName SoftwareLicensingProduct -Filter "ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f' AND LicenseIsAddon=False" -ErrorAction SilentlyContinue
        foreach ($p in $spp) {
            if ($p.GracePeriodRemaining -le 0 -and $p.LicenseStatus -eq 0) {
                $issues += @{ Type = "Licensing"; Detail = "$($p.Name): Het grace period, chua kich hoat"; Level = "CAO"; LColor = "R" }
            }
        }
    } catch {}
    return $issues
}

function Find-CrackADS {
    $found = @()
    $adsTargets = @("$env:USERPROFILE\Downloads", "$env:TEMP", "$env:APPDATA", "$env:LOCALAPPDATA\Temp")
    foreach ($t in $adsTargets) {
        if (-not (Test-Path $t)) { continue }
        try {
            $files = Get-ChildItem $t -File -ErrorAction SilentlyContinue | Select-Object -First 200
            foreach ($f in $files) {
                $streams = Get-Item $f.FullName -Stream * -ErrorAction SilentlyContinue | Where-Object { $_.Stream -ne ':$DATA' }
                foreach ($s in $streams) {
                    $found += @{ Path = "$($f.FullName):$($s.Stream)"; Name = "$($f.Name):$($s.Stream)"; Size = "{0:N0} KB" -f ($s.Length / 1KB); Level = "CAO"; LColor = "R" }
                }
            }
        } catch {}
    }
    return $found
}

function Get-CrackAdvanced {
    $reg = Find-CrackRegistryDeep; $beh = Find-CrackBehavioral; $ads = Find-CrackADS
    $kms = Find-CrackKMSServer; $forensic = Find-CrackForensic
    return @{ Registry = $reg; Behavioral = $beh; ADS = $ads; KMS = $kms; Forensic = $forensic }
}

function Show-CrackAdvanced {
    $adv = Get-CrackAdvanced
    $total = $adv.Registry.Count + $adv.Behavioral.Count + $adv.ADS.Count + $adv.KMS.Count + $adv.Forensic.Count

    if ($adv.KMS.Count -gt 0) {
        fe "  $([char]0x2726)  $($msg.KMS_SERVER)" -Color M; br; hr; br
        foreach ($i in $adv.KMS) { fe "    $([char]0x2717) " -NoNewline -Color $i.LColor; fe "$($i.Type): $($i.Detail)" -Color W; br }
        br
    }
    if ($adv.Forensic.Count -gt 0) {
        fe "  $([char]0x2726)  $($msg.FORENSIC)" -Color M; br; hr; br
        foreach ($i in $adv.Forensic) { fe "    $([char]0x2717) " -NoNewline -Color $i.LColor; fe "$($i.Type): $($i.Detail)" -Color W; br }
        br
    }
    if ($adv.Registry.Count -gt 0) {
        fe "  $([char]0x2726)  $($msg.REGISTRY_SAU)" -Color M; br; hr; br
        foreach ($i in $adv.Registry) { fe "    $([char]0x2717) " -NoNewline -Color $i.LColor; fe "$($i.Type): $($i.Detail)" -Color W; br }
        br
    }
    if ($adv.Behavioral.Count -gt 0) {
        fe "  $([char]0x2726)  $($msg.BEHAVIORAL)" -Color M; br; hr; br
        foreach ($i in $adv.Behavioral) { fe "    $([char]0x2717) " -NoNewline -Color $i.LColor; fe "$($i.Type): $($i.Detail)" -Color W; br }
        br
    }
    if ($adv.ADS.Count -gt 0) {
        fe "  $([char]0x2726)  $($msg.ADS)" -Color M; br; hr; br
        foreach ($i in $adv.ADS) { fe "    $([char]0x26A0) " -NoNewline -Color R; fe "$($i.Path)" -Color W; br }
        br
    }
    if ($total -eq 0) { fe "  $([char]0x2713) $($msg.KHONG_PHAT_HIEN_ADV)" -Color G; br }
    return $adv
}

function Get-FEARBiosKey {
    $key = $null
    try { $o = (Get-WmiObject -Query "select * from SoftwareLicensingService" -ErrorAction SilentlyContinue).OA3xOriginalProductKey; if ($o) { $key = $o } } catch {}
    if (-not $key) {
        try {
            $msdm = Get-CimInstance -Namespace root\wmi -ClassName MsAcpi_MsdmtblReceiver -ErrorAction SilentlyContinue
            if ($msdm -and $msdm.RawSelData) { $raw = [System.Text.Encoding]::ASCII.GetString($msdm.RawSelData[56..84]); if ($raw -match '^[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5}-[A-Z0-9]{5}$') { $key = $raw } }
        } catch {}
    }
    return $key
}

function Find-CrackKMSServer {
    $findings = @()
    $kmsHost = $null; $kmsPort = $null; $partOfDomain = $false
    try { $cs = Get-CimInstance Win32_ComputerSystem -ErrorAction Stop; $partOfDomain = $cs.PartOfDomain } catch {}
    try {
        $ls = Get-CimInstance -ClassName SoftwareLicensingService -ErrorAction Stop
        $kmsHost = $ls.KeyManagementServiceName
        $kmsPort = $ls.KeyManagementServicePort
        if (-not $kmsHost) {
            $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
            if (Test-Path $regPath) { $kmsHost = (Get-ItemProperty $regPath -Name "KeyManagementServiceName" -ErrorAction SilentlyContinue).KeyManagementServiceName }
        }
    } catch {}
    if (-not $kmsHost) { return $findings }
    $publicKms = @("kms.digiboy.ir","kms.lotro.cc","kms8.msguides.com","kms9.msguides.com","zh.us.to","kms.chinancce.com","kms.cangshui.net","kms.srv.crnet.co","kms.library.hk","kms.xspace.in","kms.shuax.com","kms.loli.best","kms.pub","kms.agwebs.com","kms.bige0.com","kms.catnet.link","ukms.cc","kms.03k.org","kms.v0v.bid","kms.tty.so","kms.jm33.me","kms.cx")
    $hostLower = $kmsHost.ToLower()
    if ($hostLower -eq "localhost" -or $hostLower -eq "127.0.0.1" -or $hostLower -eq "::1") {
        $findings += @{ Type = "KMS Server"; Detail = "KMS Emulator phat hien: $kmsHost (localhost)"; Level = "CAO"; LColor = "R" }
    } else {
        $matched = $false
        foreach ($bad in $publicKms) { if ($hostLower -like "*$bad*") { $findings += @{ Type = "KMS Server"; Detail = "KMS cong cong: $kmsHost (Port $kmsPort)"; Level = "CAO"; LColor = "R" }; $matched = $true; break } }
        if (-not $matched) {
            if (-not $partOfDomain -and $kmsHost -match '^(10\.\d+\.\d+\.\d+|192\.168\.\d+\.\d+|172\.(1[6-9]|2\d|3[0-1])\.\d+\.\d+)$') {
                $findings += @{ Type = "KMS Server"; Detail = "KMS noi bo tren Workgroup: $kmsHost (dang ngo)"; Level = "TRUNG_BINH"; LColor = "Y" }
            } elseif (-not $partOfDomain) {
                $findings += @{ Type = "KMS Server"; Detail = "KMS ngoai mang tren Workgroup: $kmsHost (can xac minh)"; Level = "TRUNG_BINH"; LColor = "Y" }
            } else {
                $findings += @{ Type = "KMS Server"; Detail = "KMS trong Domain: $kmsHost (binh thuong)"; Level = "THAP"; LColor = "Gr" }
            }
        }
    }
    return $findings
}

function Find-CrackForensic {
    $issues = @()
    $histPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    if (Test-Path $histPath) {
        try {
            $lines = Get-Content $histPath -ErrorAction SilentlyContinue
            $masLines = $lines | Where-Object { $_ -like "*get.activated.win*" -or $_ -like "*massgrave*" }
            if ($masLines) {
                $last = (Get-Item $histPath).LastWriteTime.ToString("dd/MM/yyyy HH:mm")
                $issues += @{ Type = "PS History"; Detail = "Da tung chay MAS (massgrave) vao $last"; Level = "CAO"; LColor = "R" }
            }
        } catch {}
    }
    try {
        $evt = Get-WinEvent -FilterHashtable @{LogName='Microsoft-Windows-PowerShell/Operational';ID=4104} -MaxEvents 100 -ErrorAction SilentlyContinue | Where-Object { $_.Message -like "*massgrave*" -or $_.Message -like "*get.activated.win*" }
        if ($evt) { $issues += @{ Type = "EventLog 4104"; Detail = "Tim thay $($evt.Count) EventLog PowerShell MAS script blocks"; Level = "CAO"; LColor = "R" } }
    } catch {}
    $biosKey = Get-FEARBiosKey
    try {
        $pk = "XXXXX"; $tmp2 = [System.IO.Path]::GetTempPath(); $lf = Join-Path $tmp2 "fear_lic_f.txt"
        cscript //Nologo $env:windir\system32\slmgr.vbs /dli > $lf 2>$null
        if (Test-Path $lf) { foreach ($l in (Get-Content $lf)) { if ($l -match "Partial Product Key:\s*(.+)") { $pk = $Matches[1].Trim() } }; Remove-Item $lf -ErrorAction SilentlyContinue }
        $hwidGeneric = @{ "DK7XB" = "Win 10/11 Pro HWID"; "8HVX7" = "Win 10/11 Home HWID"; "8DEC2" = "Win 10/11 Enterprise HWID"; "QPF8P" = "Win 10/11 Pro Edu HWID"; "3V66T" = "Win 10/11 Education HWID" }
        if ($hwidGeneric.ContainsKey($pk)) {
            if ($biosKey) {
                $issues += @{ Type = "MAS HWID"; Detail = "Key $pk ($($hwidGeneric[$pk])) khong khop BIOS key $biosKey"; Level = "CAO"; LColor = "R" }
            } else {
                $issues += @{ Type = "MAS HWID"; Detail = "Key $pk ($($hwidGeneric[$pk])) - khong co BIOS key"; Level = "CAO"; LColor = "R" }
            }
        }
    } catch {}
    return $issues
}

function Get-RiskRating {
    param($Traces, $Adv, $Files, $KmsFindings, $Forensic)
    $score = 0; $reasons = @()
    if ($Traces) { foreach ($t in $Traces) { $score += 3; $reasons += $t.D } }
    if ($Files) { $cao = ($Files | Where-Object { $_.Level -eq "CAO" }).Count; if ($cao -gt 0) { $score += 3; $reasons += "$cao file muc do CAO" } }
    if ($Adv.Registry) { foreach ($i in $Adv.Registry) { if ($i.Level -eq "CAO") { $score += 2; $reasons += $i.Detail } } }
    if ($Adv.Behavioral) { foreach ($i in $Adv.Behavioral) { if ($i.Level -eq "CAO") { $score += 2; $reasons += $i.Detail } } }
    if ($KmsFindings) { foreach ($k in $KmsFindings) { if ($k.Level -eq "CAO") { $score += 3; $reasons += "KMS: $($k.Detail)" } elseif ($k.Level -eq "TRUNG_BINH") { $score += 1 } } }
    if ($Forensic) { foreach ($f in $Forensic) { $score += 3; $reasons += $f.Detail } }
    $rCao = if ($EN) { "HIGH RISK" } else { "NGUY CO CAO" }
    $rWarn = if ($EN) { "WARNING" } else { "CANH BAO" }
    $rSafe = if ($EN) { "SAFE" } else { "AN TOAN" }
    $dCao = if ($EN) { "Detected $score risk points. System has been cracked or may be cracked." } else { "Phat hien $score diem nguy co. He thong da bi crack hoac co the bi crack." }
    $dWarn = if ($EN) { "Detected $score suspicious points. Check details." } else { "Phat hien $score diem bat thuong. Can kiem tra chi tiet." }
    $dSafe = if ($EN) { "No abnormalities detected. System is clean." } else { "Khong phat hien bat thuong. He thong sach." }
    if ($score -ge 6) { return @{ Rating = $rCao; Color = "R"; Desc = $dCao; Score = $score } }
    elseif ($score -ge 2) { return @{ Rating = $rWarn; Color = "Y"; Desc = $dWarn; Score = $score } }
    else { return @{ Rating = $rSafe; Color = "G"; Desc = $dSafe; Score = $score } }
}

function Show-CrackDetect {
    $traces = Find-CrackTraces
    $h1 = if ($EN) { "CRACK DETECTION (SYSTEM)" } else { "PHAT HIEN CRACK (HE THONG)" }
    fe "  $([char]0x2726)  $h1" -Color M; br
    hr; br
    if ($traces.Count -eq 0) {
        fe "  $([char]0x2713) $($msg.SACH)" -Color G; br
    } else {
        $v1 = if ($EN) { "DETECTED" } else { "PHAT HIEN" }
        $v2 = if ($EN) { "issues" } else { "VAN DE" }
        fe "  $([char]0x26A0)  $v1 $($traces.Count) $v2!" -Color R; br
        foreach ($t in $traces) {
            fe "    $([char]0x2717) " -NoNewline -Color R
            fe "$($t.Type)" -NoNewline -Color Y
            fe ": $($t.D)" -Color W; br
        }
        br
        $w1 = if ($EN) { "System has crack traces - Check recommended!" } else { "He thong co dau vet crack - De nghi kiem tra!" }
        $w2 = if ($EN) { "Use [3] to remove" } else { "Dung chuc nang [3] de go bo" }
        fe "  $([char]0x26A0) $w1" -Color R; br
        fe "  -> $w2" -Color C; br
    }
    br; return $traces
}

function Invoke-CrackCleanup {
    fe "  $([char]0x26A0)  $($msg.GO_BO)" -Color Y; br; hr; br
    fe "  $([char]0x2192) $($msg.DUNG_DICH_VU)" -NoNewline -Color C
    Stop-Service -Name sppsvc -Force -ErrorAction SilentlyContinue; Stop-Service -Name osppsvc -Force -ErrorAction SilentlyContinue
    fe " $($msg.XONG)" -Color G; br
    fe "  $([char]0x2192) $($msg.XOA_KEY)" -NoNewline -Color C
    cscript //Nologo $env:windir\system32\slmgr.vbs /upk | Out-Null; cscript //Nologo $env:windir\system32\slmgr.vbs /cpky | Out-Null; cscript //Nologo $env:windir\system32\slmgr.vbs /ckms | Out-Null; cscript //Nologo $env:windir\system32\slmgr.vbs /rearm | Out-Null
    fe " $($msg.XONG)" -Color G; br
    fe "  $([char]0x2192) $($msg.XOA_SERVICE)" -NoNewline -Color C
    $cs = @("AutoKMS","KMSELDI","SppExtComObjHook","KMSAuto","KMSServerService","GenuineCheck")
    foreach ($s in $cs) { Stop-Service -Name $s -Force -ErrorAction SilentlyContinue; sc.exe delete $s | Out-Null }
    fe " $($msg.XONG)" -Color G; br
    fe "  $([char]0x2192) $($msg.XOA_TAC_VU)" -NoNewline -Color C
    foreach ($t in @("AutoKMS","AutoPico Daily Restart","KMSAutoNet","SvcRestartTask","Microsoft Activation")) { Unregister-ScheduledTask -TaskName $t -Confirm:$false -ErrorAction SilentlyContinue }
    fe " $($msg.XONG)" -Color G; br
    fe "  $([char]0x2192) $($msg.DON_REGISTRY)" -NoNewline -Color C
    $spp = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform"
    if (Test-Path $spp) { Remove-ItemProperty -Path $spp -Name "KeyManagementServiceName" -ErrorAction SilentlyContinue; Remove-ItemProperty -Path $spp -Name "KeyManagementServicePort" -ErrorAction SilentlyContinue }
    fe " $($msg.XONG)" -Color G; br
    fe "  $([char]0x2192) $($msg.KHOI_PHUC_HOSTS)" -NoNewline -Color C
    $hp = "$env:windir\System32\drivers\etc\hosts"
    if (Test-Path $hp) { Set-ItemProperty -Path $hp -Name Attributes -Value "Normal" -ErrorAction SilentlyContinue }
    "# Default Hosts File`r`n127.0.0.1 localhost" | Out-File $hp -Encoding ascii -Force
    fe " $($msg.XONG)" -Color G; br; br
    fe "  $([char]0x2713) $($msg.DA_DON_DEP)" -Color G; br
    fe "  $([char]0x26A0) $($msg.KHOI_DONG_LAI)" -Color Y; br
}

function Invoke-OEMRestore {
    fe "  $([char]0x2726)  $($msg.KHOI_PHUC_OEM)" -Color M; br; hr; br
    $bios = "KHONG_TIM_THAY"
    try { $o = (Get-WmiObject -Query "select * from SoftwareLicensingService" -ErrorAction SilentlyContinue).OA3xOriginalProductKey; if ($o) { $bios = $o } } catch {}
    if ($bios -eq "KHONG_TIM_THAY") { fe "  $([char]0x2717) $($msg.OEM_KHONG_TIM_THAY)" -Color R; br; return $false }
    $f1 = if ($EN) { "Found OEM key:" } else { "Tim thay key OEM:" }
    fe "  $([char]0x2713) $f1 " -NoNewline -Color G; fe $bios -Color Y; br
    fe "  $([char]0x2192) $($msg.CAI_KEY_OEM)" -NoNewline -Color C
    cscript //Nologo $env:windir\system32\slmgr.vbs /upk >$null 2>&1
    cscript //Nologo $env:windir\system32\slmgr.vbs /cpky >$null 2>&1
    cscript //Nologo $env:windir\system32\slmgr.vbs /ipk $bios >$null 2>&1
    fe " $($msg.XONG)" -Color G; br
    fe "  $([char]0x2192) $($msg.LIEN_HE_MS)" -NoNewline -Color C
    cscript //Nologo $env:windir\system32\slmgr.vbs /ato >$null 2>&1
    fe " $($msg.XONG)" -Color G; br; br
    $f2 = if ($EN) { "Run [1] to verify." } else { "Chay muc [1] de kiem tra lai." }
    fe "  $([char]0x2713) $($msg.OEM_THANH_CONG)" -Color G; br
    fe "  $([char]0x2192) $f2" -Color C; br
    return $true
}

function Export-HTMLReport {
    param($SysInfo, $Lic, $Traces, $Office, $CrackFiles, $Advanced)
    $advancedFindings = if ($Advanced) { $Advanced } else { Get-CrackAdvanced }
    $desktop = [Environment]::GetFolderPath('Desktop')
    $path = Join-Path $desktop "FEAR_Report_$(Get-Date -Format yyyyMMdd_HHmmss).html"
    $color = if ($Traces.Count -eq 0) { "#22c55e" } else { "#ef4444" }
    $status = if ($Traces.Count -eq 0) { $msg.SACH } else { "$($msg.PHAT_HIEN) ($($Traces.Count) $($msg.VAN_DE))" }
    $acLabel = if ($Lic.Activated -eq "DA KICH HOAT") { $msg.DA_KICH_HOAT } else { $msg.CHUA_KICH_HOAT }
    $acCol = if ($Lic.Activated -eq "DA KICH HOAT") { "g" } else { "r" }
    $biosCol = if ($Lic.BIOS -ne "KHONG_TIM_THAY") { "g" } else { "y" }
    $biosVal = $Lic.BIOS
    if ($Office.Installed) {
        $offCol = if ($Office.Activated -eq "DA KICH HOAT") { "g" } else { "r" }
        $offAct = if ($Office.Activated -eq "DA KICH HOAT") { $msg.DA_KICH_HOAT } else { $msg.CHUA_KICH_HOAT }
        $officeHtml = '<div class="row"><span class="l">' + $msg.PHIEN_BAN + '</span><span class="v">' + $Office.Version + '</span></div><div class="row"><span class="l">' + $msg.TRANG_THAI + '</span><span class="v ' + $offCol + '">' + $offAct + '</span></div>'
    } else {
        $officeHtml = '<div class="row"><span class="l">' + $msg.TRANG_THAI + '</span><span class="v y">' + $msg.CHUA_CAI_DAT + '</span></div>'
    }
    $r1 = if ($EN) { "Clean - No issues" } else { "Sach - khong co van de" }
    $crackHtml = if ($Traces.Count -eq 0) { '<div class="row"><span class="l">' + $msg.KET_QUA + '</span><span class="v g">' + $r1 + '</span></div>' } else { "<div class='list'>" + ($Traces | ForEach-Object { "<div class='li'>$($_.Type): $($_.D)</div>" }) -join "`n" + "</div>" }
    if ($CrackFiles -and $CrackFiles.Count -gt 0) {
        $fileHtml = "<div class='list'>" + ($CrackFiles | ForEach-Object {
            $c = if ($_.Level -eq "CAO") { "#ef4444" } elseif ($_.Level -eq "TRUNG_BINH") { "#facc15" } else { "#6b7280" }
            "<div class='li' style='border-left-color:$c'><span style='color:$c;font-weight:600'>[$($_.Level)]</span> $($_.Name) <span style='color:#6b7280;font-size:11px'>$($_.Path)</span></div>"
        }) -join "`n" + "</div>"
    } else { $r2 = if ($EN) { "No suspicious files found" } else { "Khong tim thay file nghi van" }; $fileHtml = '<div class="row"><span class="l">' + $msg.KET_QUA + '</span><span class="v g">' + $r2 + '</span></div>' }
    if ($advancedFindings) {
        $allAdv = $advancedFindings.Registry + $advancedFindings.Behavioral + $advancedFindings.ADS + $advancedFindings.KMS + $advancedFindings.Forensic
        if ($allAdv.Count -gt 0) {
            $advHtml = "<div class='list'>" + ($allAdv | ForEach-Object {
                $c = if ($_.Level -eq "CAO") { "#ef4444" } elseif ($_.Level -eq "TRUNG_BINH") { "#facc15" } else { "#6b7280" }
                "<div class='li' style='border-left-color:$c'><span style='color:$c;font-weight:600'>[$($_.Level)]</span> $($_.Type): $($_.Detail)</div>"
            }) -join "`n" + "</div>"
        } else { $r3 = if ($EN) { "No abnormalities found" } else { "Khong phat hien bat thuong" }; $advHtml = '<div class="row"><span class="l">' + $msg.KET_QUA + '</span><span class="v g">' + $r3 + '</span></div>' }
    } else { $r3 = if ($EN) { "No abnormalities found" } else { "Khong phat hien bat thuong" }; $advHtml = '<div class="row"><span class="l">' + $msg.KET_QUA + '</span><span class="v g">' + $r3 + '</span></div>' }

$html = @"
<!DOCTYPE html>
<html lang="$(if($EN){'en'}else{'vi'})">
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
<div class="top"><div><h1>FEAR - $($msg.BAN_QUYEN)</h1><p>$(Get-Date -Format "dd/MM/yyyy HH:mm:ss")</p></div><div class="badge">$status</div></div>

<div class="card"><h2>$($msg.HE_THONG)</h2>
<div class="row"><span class="l">$($msg.HE_DIEU_HANH)</span><span class="v">$($SysInfo.OS) ($($SysInfo.Arch))</span></div>
<div class="row"><span class="l">$($msg.BUILD)</span><span class="v">$($SysInfo.Build)</span></div>
<div class="row"><span class="l">$($msg.CPU)</span><span class="v">$($SysInfo.CPU)</span></div>
<div class="row"><span class="l">$($msg.RAM)</span><span class="v">$($SysInfo.RAM)</span></div>
<div class="row"><span class="l">$($msg.O_DIA)</span><span class="v">$($SysInfo.Disk)</span></div>
</div>

<div class="card"><h2>$($msg.BAN_QUYEN)</h2>
<div class="row"><span class="l">$($msg.PRODUCT_KEY)</span><span class="v">$($Lic.FullPK)</span></div>
<div class="row"><span class="l">$($msg.KENH_BAN_QUYEN)</span><span class="v">$($Lic.Channel)</span></div>
<div class="row"><span class="l">$($msg.TRANG_THAI)</span><span class="v $acCol">$acLabel</span></div>
<div class="row"><span class="l">$($msg.KEY_OEM)</span><span class="v $biosCol">$biosVal</span></div>
</div>

<div class="card"><h2>$($msg.OFFICE)</h2>
$officeHtml
</div>

<div class="card"><h2>$($msg.CANH_BAO_CRACK)</h2>
$crackHtml
</div>

<div class="card"><h2>$($msg.FILE_CRACK)</h2>
$fileHtml
</div>

<div class="card"><h2>$($msg.PHAT_HIEN)</h2>
$advHtml
</div>

<div class="foot">FEAR Windows License Checker v1.0</div>
</div>
</body>
</html>
"@
    $html | Out-File $path -Encoding utf8
    $s1 = if ($EN) { "Report saved:" } else { "Da luu bao cao:" }
    fe "  $([char]0x2713) $s1 $path" -Color G; br
    Start-Process $path
}

function Export-TextReport {
    param($SysInfo, $Lic, $Traces, $Office, $CrackFiles, $Advanced)
    $desktop = [Environment]::GetFolderPath('Desktop')
    $path = Join-Path $desktop "FEAR_Report_$(Get-Date -Format yyyyMMdd_HHmmss).txt"
    $title = if ($EN) { "FEAR Windows License Checker - Report" } else { "FEAR Windows License Checker - Bao cao" }
    $timeLabel = if ($EN) { "Time:" } else { "Thoi gian:" }
    $s1 = if ($EN) { "--- SYSTEM INFORMATION ---" } else { "--- THONG TIN HE THONG ---" }
    $s2 = if ($EN) { "--- LICENSE INFORMATION ---" } else { "--- THONG TIN BAN QUYEN ---" }
    $s3 = if ($EN) { "--- CRACK DETECTIONS ---" } else { "--- PHAT HIEN CRACK ---" }
    $s4 = if ($EN) { "--- CRACK FILES ---" } else { "--- FILE CRACK ---" }
    $nd = if ($EN) { "Not found" } else { "Khong tim thay" }
    $lines = @()
    $lines += "================================================"
    $lines += " $title"
    $lines += " $timeLabel $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
    $lines += "================================================"
    $lines += ""
    $lines += $s1
    $lines += " OS: $($SysInfo.OS) ($($SysInfo.Arch))"
    $lines += " Build: $($SysInfo.Build)"
    $lines += " CPU: $($SysInfo.CPU)"
    $lines += " RAM: $($SysInfo.RAM)"
    $lines += " Disk: $($SysInfo.Disk)"
    $lines += ""
    $lines += $s2
    $lines += " Product Key: $($Lic.FullPK)"
    $lines += " $($msg.KENH_BAN_QUYEN): $($Lic.Channel)"
    $lines += " $($msg.TRANG_THAI): $(if($Lic.Activated -eq 'DA KICH HOAT'){$msg.DA_KICH_HOAT}else{$msg.CHUA_KICH_HOAT})"
    $lines += " $($msg.KEY_OEM): $($Lic.BIOS)"
    $lines += ""
    if ($Office.Installed) {
        $lines += "--- MICROSOFT OFFICE ---"
        $lines += " $($msg.PHIEN_BAN): $($Office.Version)"
        $lines += " $($msg.TRANG_THAI): $(if($Office.Activated -eq 'DA KICH HOAT'){$msg.DA_KICH_HOAT}else{$msg.CHUA_KICH_HOAT})"
        $lines += ""
    }
    $lines += $s3
    if ($Traces.Count -eq 0) { $lines += " $($msg.SACH)" } else { foreach ($t in $Traces) { $lines += " [X] $($t.Type): $($t.D)" } }
    $lines += ""
    if ($Advanced) {
        if ($Advanced.KMS.Count -gt 0) { $lines += "--- $($msg.KMS_SERVER) ---"; foreach ($k in $Advanced.KMS) { $lines += " [X] $($k.Detail)" }; $lines += "" }
        if ($Advanced.Forensic.Count -gt 0) { $lines += "--- $($msg.FORENSIC) ---"; foreach ($f in $Advanced.Forensic) { $lines += " [X] $($f.Type): $($f.Detail)" }; $lines += "" }
        if ($Advanced.Registry.Count -gt 0) { $lines += "--- $($msg.REGISTRY_SAU) ---"; foreach ($r in $Advanced.Registry) { $lines += " [$($r.Level)] $($r.Type): $($r.Detail)" }; $lines += "" }
        if ($Advanced.Behavioral.Count -gt 0) { $lines += "--- $($msg.BEHAVIORAL) ---"; foreach ($b in $Advanced.Behavioral) { $lines += " [$($b.Level)] $($b.Type): $($b.Detail)" }; $lines += "" }
    }
    $lines += $s4
    if ($CrackFiles.Count -eq 0) { $lines += " $nd" } else { foreach ($f in $CrackFiles) { $lines += " [$($f.Level)] $($f.Name) - $($f.Path)" } }
    $lines += ""
    $lines += "================================================"
    $lines | Out-File $path -Encoding utf8
    $s1 = if ($EN) { "TXT report saved:" } else { "Da luu bao cao TXT:" }
    fe "  $([char]0x2713) $s1 $path" -Color G; br
    notepad $path
}

function Export-JsonReport {
    param($SysInfo, $Lic, $Traces, $Office, $CrackFiles, $Advanced)
    $desktop = [Environment]::GetFolderPath('Desktop')
    $path = Join-Path $desktop "FEAR_Report_$(Get-Date -Format yyyyMMdd_HHmmss).json"
    $report = @{
        ScanTime = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        SystemInfo = @{ OS = $SysInfo.OS; Build = $SysInfo.Build; Arch = $SysInfo.Arch; CPU = $SysInfo.CPU; RAM = $SysInfo.RAM; Disk = $SysInfo.Disk }
        License = @{ ProductKey = $Lic.FullPK; Channel = $Lic.Channel; Activated = $Lic.Activated; BIOSKey = $Lic.BIOS }
        Office = if ($Office.Installed) { @{ Version = $Office.Version; Activated = $Office.Activated } } else { @{ Installed = $false } }
        CrackDetections = $Traces | ForEach-Object { @{ Type = $_.Type; Detail = $_.D } }
        Advanced = if ($Advanced) { @{ KMS = $Advanced.KMS; Forensic = $Advanced.Forensic; Registry = $Advanced.Registry; Behavioral = $Advanced.Behavioral; ADS = $Advanced.ADS } } else { $null }
        CrackFiles = $CrackFiles | ForEach-Object { @{ Name = $_.Name; Path = $_.Path; Level = $_.Level; Size = $_.Size; Modified = $_.Modified } }
    }
    $report | ConvertTo-Json -Depth 6 | Out-File $path -Encoding utf8
    $s1 = if ($EN) { "JSON report saved:" } else { "Da luu bao cao JSON:" }
    fe "  $([char]0x2713) $s1 $path" -Color G; br
}

function Show-About {
    br
    $t = if ($EN) { "ABOUT" } else { "GIOI THIEU" }
    $f = if ($EN) { "Features:" } else { "Chuc nang:" }
    fe "  $([char]0x2726)  $t" -Color M; br; hr; br
    fe "  $([char]0x2726) $f" -Color C; br
    $msg.GIOI_THIEU_CHUC_NANG -split "`n" | ForEach-Object { fe "  $_" -Color Gr; br }
    br
    fe "  $([char]0x2726) $($msg.PHAN_TRAM)" -Color C; br
    fe "  $([char]0x2726) $($msg.MA_NGUON_MO)" -Color C; br; br
}

$state = "MENU"
$gSys = $null; $gLic = $null; $gTraces = $null; $gOff = $null; $gFiles = @(); $gAdv = $null

while ($state -ne "EXIT") {
    switch ($state) {
        "MENU" {
            banner
            $gr = if ($EN) { "Remove Crack" } else { "Go bo Crack" }
            $oem = if ($EN) { "Restore OEM Key" } else { "Khoi phuc Key OEM" }
            $fscan = if ($EN) { "Scan Crack Files (full drive)" } else { "Quet file Crack (toan bo o dia)" }
            fe "  $($msg.CHON_CHUC_NANG)" -Color M; br; hr; br
            fe "  " -NoNewline; fe "[1]" -NoNewline -Color M; fe "  $($msg.KIEM_TRA_TOAN_BO)" -Color W; br
            fe "  " -NoNewline; fe "[2]" -NoNewline -Color M; fe "  $($msg.QUET_BAN_QUYEN)" -Color W; br
            fe "  " -NoNewline; fe "[3]" -NoNewline -Color M; fe "  $gr" -Color W; br
            fe "  " -NoNewline; fe "[4]" -NoNewline -Color M; fe "  $oem" -Color W; br
            fe "  " -NoNewline; fe "[5]" -NoNewline -Color M; fe "  $fscan" -Color W; br
            fe "  " -NoNewline; fe "[6]" -NoNewline -Color M; fe "  $($msg.XUAT_HTML)" -Color W; br
            fe "  " -NoNewline; fe "[7]" -NoNewline -Color M; fe "  $($msg.XUAT_TXT_JSON)" -Color W; br
            fe "  " -NoNewline; fe "[8]" -NoNewline -Color M; fe "  $($msg.GIOI_THIEU)" -Color W; br
            fe "  " -NoNewline; fe "[9]" -NoNewline -Color M; fe "  $($msg.THOAT)" -Color W; br; br
            $c = Read-Host "  $([char]0x25B8) "
            switch ($c) {
                "1" { $state = "FULL_CHECK" }
                "2" { $state = "CRACK_SCAN" }
                "3" { $state = "CLEANUP" }
                "4" { $state = "RESTORE" }
                "5" { $state = "FILE_SCAN" }
                "6" { $state = "EXPORT" }
                "7" { $state = "EXPORT_TXT_JSON" }
                "8" { $state = "ABOUT" }
                "9" { $state = "EXIT" }
            }
        }
        "FULL_CHECK" {
            banner
            $gSys = Show-SystemInfo
            $gLic = Show-LicenseInfo
            $gOff = Get-OfficeStatus; Show-OfficeInfo
            $gTraces = Show-CrackDetect
            if ($gTraces.Count -gt 0) { Show-CrackWarning -Traces $gTraces }
            $gAdv = Show-CrackAdvanced
            $gFiles = Show-CrackFiles
            $startupFiles = Find-CrackStartup
            if ($startupFiles.Count -gt 0) {
                fe "  $([char]0x26A0)  $($msg.STARTUP_NGHI_VAN):" -Color R; br
                foreach ($sf in $startupFiles) {
                    fe "    $([char]0x2717) $($sf.Name)" -Color Y; br
                }
                br
            }
            $rating = Get-RiskRating -Traces $gTraces -Adv $gAdv -Files $gFiles -KmsFindings ($gAdv.KMS) -Forensic ($gAdv.Forensic)
            $rHead = if ($EN) { "RISK ASSESSMENT" } else { "DANH GIA MUC DO RUI RO" }
            $rLabel = if ($EN) { "Result:" } else { "Ket qua:" }
            $rPoint = if ($EN) { "points" } else { "diem" }
            fe "  $([char]0x2726)  $rHead" -Color M; br; hr; br
            fe "  $rLabel " -NoNewline -Color Gr
            fe "$($rating.Rating) ($($rating.Score) $rPoint)" -Color $rating.Color; br
            fe "  $($rating.Desc)" -Color Gr; br; br
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "FILE_SCAN" {
            banner
            $gFiles = Show-CrackFiles
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "CRACK_SCAN" {
            banner
            $gSys = Show-SystemInfo
            $gLic = Show-LicenseInfo
            $gTraces = Show-CrackDetect
            if ($gTraces.Count -gt 0) { Show-CrackWarning -Traces $gTraces }
            $gAdv = Show-CrackAdvanced
            $rating = Get-RiskRating -Traces $gTraces -Adv $gAdv -Files @() -KmsFindings ($gAdv.KMS) -Forensic ($gAdv.Forensic)
            $rHead = if ($EN) { "RISK ASSESSMENT" } else { "DANH GIA MUC DO RUI RO" }
            $rLabel = if ($EN) { "Result:" } else { "Ket qua:" }
            $rPoint = if ($EN) { "points" } else { "diem" }
            fe "  $([char]0x2726)  $rHead" -Color M; br; hr; br
            fe "  $rLabel " -NoNewline -Color Gr
            fe "$($rating.Rating) ($($rating.Score) $rPoint)" -Color $rating.Color; br
            fe "  $($rating.Desc)" -Color Gr; br; br
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "CLEANUP" {
            banner
            fe "  $([char]0x26A0)  $($msg.CANH_BAO)" -Color Y; br; hr; br
            fe "  $($msg.GO_BO_MO_TA)" -Color W; br
            fe "  $($msg.GO_BO_OEM)" -Color W; br; br
            fe "  " -NoNewline; fe "[1]" -NoNewline -Color R; fe "  $($msg.TIEP_TUC)" -Color W; br
            fe "  " -NoNewline; fe "[2]" -NoNewline -Color M; fe "  $($msg.HUY)" -Color W; br; br
            if ((Read-Host "  $([char]0x25B8) ") -eq "1") { banner; Invoke-CrackCleanup }
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "RESTORE" {
            banner
            Invoke-OEMRestore
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "EXPORT" {
            banner
            if (-not $gSys) { fe "  $([char]0x2717) $($msg.CHUA_CO_DU_LIEU)" -Color Y; br }
            else { Export-HTMLReport -SysInfo $gSys -Lic $gLic -Traces $gTraces -Office $gOff -CrackFiles $gFiles -Advanced $gAdv }
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "EXPORT_TXT_JSON" {
            banner
            if (-not $gSys) { fe "  $([char]0x2717) $($msg.CHUA_CO_DU_LIEU)" -Color Y; br }
            else {
                Export-TextReport -SysInfo $gSys -Lic $gLic -Traces $gTraces -Office $gOff -CrackFiles $gFiles -Advanced $gAdv
                Export-JsonReport -SysInfo $gSys -Lic $gLic -Traces $gTraces -Office $gOff -CrackFiles $gFiles -Advanced $gAdv
            }
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
        "ABOUT" {
            banner; Show-About
            br; fe "  $([char]0x2190) $($msg.QUAY_LAI)" -Color Gr; Read-Host | Out-Null; $state = "MENU"
        }
    }
}
