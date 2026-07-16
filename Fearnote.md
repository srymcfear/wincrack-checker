# FEAR Windows License Checker

## Đã làm

- **Bilingual (VI/EN) hoàn tất**: Mọi text trong UI (banner, menu, system info, license, office, crack detect, file scan, advanced, cleanup, export, about, risk rating, warnings) đều dùng `$msg.KEY`
- **Thêm EN keys cho Export**: HTML, TXT, JSON report tự động theo ngôn ngữ
- **Fix duplicate keys** trong MsgVI/MsgEN hashtable (`SACH`, `CANH_BAO`)
- Script parse OK, không lỗi cú pháp

## Còn lại

- `Find-CrackKMSServer`, `Find-CrackForensic` có detail text hardcoded (EN) nhưng dynamic - cần song ngữ nếu muốn
- **Chạy thử nghiệm thực tế** trên máy thật
- Risk rating hiện dùng `Get-RiskRating` với `if ($EN)` inline — nên chuyển qua `$msg.RATING_CAO` pattern
- Gom `if ($EN) { ... }` lặp lại thành hàm/phím tắt?

## Cần fix

- (none)
