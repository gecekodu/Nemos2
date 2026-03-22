# Nemos

Nemos, Türkçe odaklı bir Flutter uygulaması olarak tasarlanan sosyal oyun keşif ve “oyununu oluştur” deneyimidir. Bu sürümde mevcut GitHub deposundaki önceki yapıyı dikkate almadan, Firebase entegrasyonuna hazır olacak şekilde sıfırdan profesyonel bir temel mimari kurulmuştur.

## Ürün vizyonu

Kullanıcı iki ana deneyim yaşar:

1. **Keşfet akışı**: TikTok / Reels benzeri dikey kaydırmalı oyun kartları arasında gezinir, beğeni, yorum ve paylaşım benzeri sosyal etkileşimler bırakır.
2. **Oyununu oluştur akışı**: Kullanıcı adım adım seçim yapar ve sistem, sanki ona özel bir oyun üretilmiş gibi hazır oyun kütüphanesinden en uygun oyunu önüne getirir.

## Bu sürümde neler var?

- Flutter tabanlı temiz başlangıç mimarisi
- Alt sekmeli ana kabuk: Ana Sayfa, Keşfet, Oyun Oluştur, Liderlik, Profil
- Tamamen Türkçe metinler ve yerel mock veri yapısı
- **100 olası tercih kombinasyonu** üreten seçim sistemi
- Bu 100 kombinasyonu karşılamak için eşleşen **20 adet başlangıç oyunu**
- Arkadaşlık sistemi, etkileşim, yorum ve skor tabloları için örnek veri modeli
- İleride Firebase, remote config, auth ve backend servisleri bağlanabilecek klasörleme yaklaşımı

## 100 ihtimal nasıl oluşturuluyor?

Oyun oluşturma akışında dört seçim ekseni bulunur:

- Oyun modu: 5 seçenek
- Tempo: 5 seçenek
- Sosyal stil: 2 seçenek
- Dünya teması: 2 seçenek

Toplam kombinasyon: `5 x 5 x 2 x 2 = 100`

İlk fazda bu 100 ihtimali temsil edecek şekilde 20 oyunluk bir editoryal kütüphane oluşturuldu. Eşleştirme sistemi, kullanıcının seçimine göre bu kütüphaneden en uyumlu oyunu seçer.

## Önerilen sonraki sprintler

### 1) Firebase entegrasyonu
- Firebase Auth
- Firestore koleksiyonları: `users`, `friendships`, `game_posts`, `comments`, `leaderboards`, `game_profiles`
- Cloud Functions ile leaderboard ve feed enrichment

### 2) Oyun içerik entegrasyonu
- Hazır HTML5 / Web oyunlarının metadata ile yönetilmesi
- WebView ya da native wrapper entegrasyonu
- Oyun launch analytics olayları

### 3) Sosyal büyüme
- Takip / arkadaşlık istekleri
- Davet kodu ve arkadaşla oyun önerme
- Yorum moderasyonu ve raporlama

### 4) Operasyonel katman
- Admin panel
- Oyun editörleri için içerik yönetimi
- A/B testleri ve kişiselleştirilmiş sıralama

## Kurulum

Flutter kurulu bir ortamda:

```bash
flutter pub get
flutter run
```

## Mimari özeti

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

Bu yapı özellikle ileride repository + service + state management katmanlarını büyütmek için seçildi.
