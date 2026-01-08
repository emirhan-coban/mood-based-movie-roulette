# 🎬 Mood Based Movie Roulette

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

**Ruh halinize göre film önerileri sunan interaktif bir mobil uygulama.**

</div>

---

## 📖 Hakkında

Mood Based Movie Roulette, kullanıcıların o anki ruh hallerine göre film önerileri almalarını sağlayan eğlenceli ve kullanıcı dostu bir Flutter uygulamasıdır. Mutlu, üzgün, heyecanlı veya rahat hissettiğinizde, uygulama size ruh halinize uygun filmleri rulet tarzında sunar.

### 🎯 Motivasyon

Film seçiminde kararsız kalmak yaygın bir sorundur. Bu proje, kullanıcıların duygusal durumlarına göre hızlı ve eğlenceli bir şekilde film keşfetmelerini sağlamak için geliştirilmiştir.

---

## ✨ Özellikler

- 🎭 **Ruh Hali Tabanlı Filtreleme**: Kullanıcının seçtiği ruh haline göre film önerileri
- 🎲 **Rulet Mekanizması**: Eğlenceli ve rastgele film keşfi deneyimi
- 🎨 **Modern UI/UX**: Kullanıcı dostu ve görsel olarak çekici arayüz
- 📱 **Çoklu Platform Desteği**: iOS, Android ve Web
- 🌐 **Film Veritabanı Entegrasyonu**: Güncel film bilgileri
- ⭐ **Favoriler**: Beğendiğiniz filmleri kaydedin
- 🔍 **Detaylı Film Bilgileri**: Özet, oyuncular, yönetmen ve puanlar

---

## 🚀 Kurulum

### Gereksinimler

- Flutter SDK (3.0 veya üzeri)
- Dart SDK (3.0 veya üzeri)
- Android Studio / Xcode (mobil geliştirme için)
- VSCode veya Android Studio (IDE)

### Adım Adım Kurulum

1. **Repoyu klonlayın**

```bash
git clone https://github.com/emirhan-coban/mood-based-movie-roulette.git
cd mood-based-movie-roulette
```

2. **Bağımlılıkları yükleyin**

```bash
flutter pub get
```

3. **API Anahtarı Yapılandırması**

`.env` dosyası oluşturun:

```env
MOVIE_API_KEY=your_api_key_here
```

4. **Uygulamayı çalıştırın**

```bash
# Android için
flutter run

# iOS için (macOS gerekir)
flutter run

# Web için
flutter run -d chrome
```

---

## 💻 Kullanım

1. **Ruh Hali Seçimi**: Uygulamayı açın ve mevcut ruh halinizi seçin
   - 😊 Mutlu
   - 😢 Üzgün
   - 😱 Heyecanlı
   - 😌 Rahat
   - 🤔 Düşünceli

2. **Rulet Çevirme**: "Ruleti Çevir" butonuna tıklayın

3. **Film Keşfi**: Ruh halinize uygun rastgele bir film önerisi alın

4. **Detayları İnceleyin**: Film hakkında daha fazla bilgi edinin

5. **Favorilere Ekleyin**: Beğendiğiniz filmleri kaydedin

---

## 🏗️ Proje Yapısı

```
lib/
├── main.dart                 # Uygulama giriş noktası
├── models/                   # Veri modelleri
│   ├── movie.dart
│   └── mood.dart
├── screens/                  # Ekran widgetları
│   ├── home_screen.dart
│   ├── roulette_screen.dart
│   └── movie_detail_screen.dart
├── widgets/                  # Yeniden kullanılabilir widgetlar
│   ├── mood_selector.dart
│   ├── roulette_wheel.dart
│   └── movie_card.dart
├── services/                 # API ve servis katmanı
│   └── movie_service.dart
└── utils/                    # Yardımcı fonksiyonlar
    ├── constants.dart
    └── theme.dart
```

---

## 🛠️ Teknoloji Stack

- **Framework**: Flutter
- **Dil**: Dart
- **State Management**: Provider / Riverpod / Bloc (projeye göre)
- **HTTP İstekleri**: http / dio
- **Animasyonlar**: Flutter Animations
- **Veritabanı**: Hive / SharedPreferences (yerel veri için)

---

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Katkıda bulunmak için:

1. Projeyi fork edin
2. Feature branch oluşturun (`git checkout -b feature/AmazingFeature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add some AmazingFeature'`)
4. Branch'inizi push edin (`git push origin feature/AmazingFeature`)
5. Pull Request açın

---

## 👤 Geliştirici

**Emirhan ÇOBAN**

- GitHub: [@emirhan-coban](https://github.com/emirhan-coban)

---

## 🙏 Teşekkürler

- Film verileri için [TMDB API](https://www.themoviedb.org/documentation/api)

---

## 📞 İletişim

Sorularınız veya önerileriniz için:

- Issue açın: [GitHub Issues](https://github.com/emirhan-coban/mood-based-movie-roulette/issues)

---

<div align="center">

**⭐ Projeyi beğendiyseniz yıldız vermeyi unutmayın!**

</div>
