# Nemos

Nemos, Türkçe odaklı bir Flutter sosyal oyun keşif uygulamasıdır.
Bu sürümde hedefimiz, kullanıcıya kısa sürede kişisel bir oyun önerisi çıkaran güçlü bir temel ürün akışı sunmaktır.

## Ürün Deneyimi

Kullanıcı iki ana akış yaşar:

1. **Keşfet**: TikTok / Reels benzeri dikey kaydırmalı oyun kartları arasında gezinir.
2. **Oyununu Oluştur**: Çok adımlı seçim akışıyla profilini çıkarır, sistem en uyumlu oyunu önerir.

## Bu Sürümde Neler Var?

- Flutter tabanlı, ölçeklenebilir klasör mimarisi
- Alt sekmeli ana kabuk: Ana Sayfa, Keşfet, Oluştur, Liderlik, Profil
- Tamamen Türkçe metinler ve yerel mock veri
- 6 adımlı oyun oluşturma akışı
- **1200 olasılık kombinasyonu** üreten tercih sistemi
- Bu kombinasyonları temsil eden 20 oyunluk başlangıç kütüphanesi
- Kademeli öneri: Kullanıcı tüm adımları tamamlamadan da ara öneri
- Arkadaş, etkileşim, liderlik verileri için örnek domain modelleri

## 1200 İhtimal Nasıl Oluşuyor?

Oyun oluşturma akışında 6 seçim ekseni bulunur:

- Oyun modu: 5 seçenek
- Tempo: 5 seçenek
- Sosyal stil: 2 seçenek
- Dünya teması: 2 seçenek
- Zorluk seviyesi: 3 seçenek
- Oturum süresi: 4 seçenek

Toplam kombinasyon:

```text
5 x 5 x 2 x 2 x 3 x 4 = 1200
```

## Kurulum

Flutter kurulu bir ortamda:

```bash
flutter pub get
flutter run
```

## Test ve Analiz

```bash
flutter analyze
flutter test
```

## Mimari Özeti

```text
lib/
  main.dart
  src/
    app.dart
    core/
      theme/
      utils/
    features/
      games/
        data/
        domain/
        presentation/
```

Bu yapı, ileride Firebase, servis katmanları ve state management entegrasyonlarını büyütmek için seçildi.
