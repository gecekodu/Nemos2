# Nemos

Nemos, kullanıcıya seçim adımları gösterip sonunda uygun HTML oyun konseptini sunacak **Flutter tabanlı mobil uygulama** başlangıcıdır.

## Bu sürümde neler var?

- Flutter + Material 3 mobil uygulama iskeleti
- 4 adımlı oyun üretim akışı
- Builder, Kütüphane ve Sistem ekranları
- HTML oyun paketi mantığına uygun veri modeli
- Multiplayer genişleme notları ve sistem yol haritası

## Proje yapısı

- `lib/main.dart`: uygulama kabuğu ve alt navigasyon
- `lib/models/game.dart`: domain modelleri ve enum etiketleri
- `lib/data/game_data.dart`: builder adımları, oyun kütüphanesi ve eşleme mantığı
- `lib/screens/`: mobil ekranlar

## Çalıştırma

Flutter kurulu bir ortamda:

```bash
flutter pub get
flutter run
```

## GitHub'a yükleme

Bu ortamda henüz `git remote` tanımlı değil. Kendi GitHub repone yüklemek için:

```bash
git remote add origin <GITHUB_REPO_URL>
git push -u origin <BRANCH_ADI>
```

## Sonraki adımlar

1. Sonuç ekranında gerçek HTML oyun paketlerini açacak `webview_flutter` entegrasyonunu eklemek
2. Her oyun için `manifest.json` benzeri bir içerik formatı tanımlamak
3. Uzaktan çok oyunculu oyunlar için lobby/room/match-state backend sözleşmesini tasarlamak
4. Android ve iOS native klasörlerini oluşturup ilk cihaz build'ini almak
