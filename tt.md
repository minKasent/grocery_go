# Tài liệu “CI/CD grocery_go” (để demo cho thầy)

## 1) Repo này đang có những workflow nào?

Thư mục: `.github/workflows/`

1. `android-dev-ci.yml`
  - Đã bật để chạy CI Android khi `push`/`pull_request` vào `main` và `develop`.
2. `android-dev-cd.yml`
  - Đây là workflow **đang chạy thật**.
3. `ios-dev-ci.yml`
  - Hiện tại đang bị comment gần như toàn bộ nội dung (nên **CI iOS thực tế có thể không chạy**).

## 2) CD Android: `android-dev-cd.yml` chạy khi nào?

- `push` vào `develop` hoặc `main`
- Build APK flavor `dev` rồi deploy lên Firebase App Distribution bằng fastlane

## 3) Cách demo/kiểm tra CI/CD trực tiếp trên GitHub

### 3.1 Kiểm tra workflow có chạy không?

1. Vào GitHub repo của bạn
2. Tab `Actions`
3. Tìm workflow có tên `CD Dev Android`
4. Xem các run gần nhất:
  - Nếu có run khi bạn push vào `develop/main` thì trigger đang hoạt động.

### 3.2 Nếu thầy hỏi “đã build ra file gì?”

Bạn có thể chỉ ra trong log job:

- Step “Build APK (dev flavor)” đã chạy lệnh flutter build.
Và artifact mà fastlane dùng là:
- `build/app/outputs/flutter-apk/app-dev-release.apk`

### 3.3 Nếu deploy lên Firebase thất bại: xem ở đâu?

Trong run của workflow:

- Mở run gần nhất
- Vào job `Build Android Dev`
- Tìm bước “Deploy APK to Firebase (Dev)”
- Đọc message lỗi ở cuối log bước đó.

## 4) Tóm tắt ngắn gọn để nói trước thầy

- CI Android (`CI Dev Android`) chạy khi push/PR vào `develop` hoặc `main`: `pub get` -> `analyze` -> `test` -> build APK `dev` -> upload artifact.
- CD Dev Android (`CD Dev Android`) chạy khi push `develop/main`: build APK dev rồi deploy lên Firebase App Distribution bằng fastlane.

