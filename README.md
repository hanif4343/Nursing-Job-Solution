# Edu App (Flutter)

## GitHub এ তুলে APK বানানোর নিয়ম
1. GitHub এ নতুন রিপো বানাও। zip এর সব ফাইল (`.github` ফোল্ডারসহ) আপলোড/push করো, branch = `main`।
2. রিপোর **Actions** ট্যাবে `Build APK & Web` চলবে (বা "Run workflow" চাপো)।
3. শেষ হলে run এর নিচে **Artifacts → app-release-apk** ডাউনলোড করে ZIP খুলে APK ফোনে ইনস্টল করো।
4. Web: **Settings → Pages → Source = GitHub Actions**। লিংক: `https://<username>.github.io/<repo>/`

## স্ট্রাকচার
- `lib/data/home_items.dart` — টাইলের নাম/রঙ/আইকন
- `lib/screens/` — স্ক্রিনসমূহ
- `lib/widgets/` — রিইউজেবল উইজেট
- `assets/icons/` — আসল আইকন PNG
