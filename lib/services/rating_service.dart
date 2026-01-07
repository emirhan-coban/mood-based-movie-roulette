import '../models/mood_analysis.dart';

/// Lightweight category holder
class _MoodCategory {
  final String id; // display/summary
  final String genre; // tmdb genre key
  final List<String> keywords;

  const _MoodCategory({
    required this.id,
    required this.genre,
    required this.keywords,
  });
}

/// Service for keyword-based sentiment analysis
class RatingService {
  // Positive/negative keyword banks (short, bilingual)
  static const List<String> positiveKeywords = [
    'mutlu',
    'sevinçli',
    'neşeli',
    'harika',
    'güzel',
    'iyi',
    'huzurlu',
    'heyecanlı',
    'enerjik',
    'eğlenceli',
    'memnun',
    'rahat',
    'umutlu',
    'romantik',
    'aşık',
    'cesur',
    'macera',
    'ilham',
    'meraklı',
    'dingin',
    'happy',
    'great',
    'good',
    'love',
    'joy',
    'excited',
    'cheerful',
    'hopeful',
    'romantic',
    'brave',
    'calm',
    'curious',
    'serene',
  ];

  static const List<String> negativeKeywords = [
    'üzgün',
    'kötü',
    'kızgın',
    'sinirli',
    'stresli',
    'endişeli',
    'yorgun',
    'bıkkın',
    'hayal kırıklığı',
    'mutsuz',
    'karamsar',
    'gergin',
    'sıkıntılı',
    'korkmuş',
    'tedirgin',
    'yalnız',
    'depresif',
    'korku',
    'kaygılı',
    'sad',
    'bad',
    'angry',
    'stressed',
    'worried',
    'tired',
    'frustrated',
    'afraid',
    'anxious',
    'scared',
    'tense',
    'lonely',
  ];

  // Mood categories mapped to target genres
  static const List<_MoodCategory> _categories = [
    _MoodCategory(
      id: 'Keyif & Komedi',
      genre: 'comedy',
      keywords: [
        'mutlu',
        'neşeli',
        'komik',
        'eğlenceli',
        'keyifli',
        'harika',
        'hafif',
        'rahat',
      ],
    ),
    _MoodCategory(
      id: 'Hüzün & Drama',
      genre: 'drama',
      keywords: [
        'üzgün',
        'hüzünlü',
        'melankolik',
        'kırgın',
        'yalnız',
        'mutsuz',
        'duygusal',
        'yorgun',
      ],
    ),
    _MoodCategory(
      id: 'Öfke & Gerilim',
      genre: 'thriller',
      keywords: [
        'öfkeli',
        'sinirli',
        'gergin',
        'bunalmış',
        'stresli',
        'sert',
        'tepkili',
      ],
    ),
    _MoodCategory(
      id: 'Korku & Gerilim',
      genre: 'horror',
      keywords: [
        'korkmuş',
        'tedirgin',
        'kaygılı',
        'ürkmüş',
        'gerilmiş',
        'dehşetli',
      ],
    ),
    _MoodCategory(
      id: 'Romantik',
      genre: 'romance',
      keywords: ['aşık', 'romantik', 'sevgidolu', 'duygusal', 'hassas'],
    ),
    _MoodCategory(
      id: 'Aksiyon & Macera',
      genre: 'adventure',
      keywords: [
        'maceraperest',
        'cesur',
        'heyecanlı',
        'hızlı',
        'kahraman',
        'savaşçı',
      ],
    ),
    _MoodCategory(
      id: 'Sakin & Huzur',
      genre: 'family',
      keywords: ['sakin', 'huzurlu', 'dingin', 'meditatif', 'rahatlamış'],
    ),
    _MoodCategory(
      id: 'Merak & Bilimkurgu',
      genre: 'sci-fi',
      keywords: [
        'meraklı',
        'hayalperest',
        'bilimkurgu hayranı',
        'kaşif',
        'kozmos',
        'fantastik',
        'büyülü',
      ],
    ),
  ];

  String _normalizeTurkish(String text) {
    return text
        .replaceAll('ı', 'i')
        .replaceAll('ş', 's')
        .replaceAll('ğ', 'g')
        .replaceAll('ü', 'u')
        .replaceAll('ö', 'o')
        .replaceAll('ç', 'c')
        .replaceAll('İ', 'I')
        .replaceAll('Ş', 'S')
        .replaceAll('Ğ', 'G')
        .replaceAll('Ü', 'U')
        .replaceAll('Ö', 'O')
        .replaceAll('Ç', 'C');
  }

  /// Analyze mood based on user-selected keywords
  Future<MoodAnalysis> analyzeMoodFromSelectedKeywords(
    List<String> selectedKeywords,
  ) async {
    if (selectedKeywords.isEmpty) {
      throw Exception('Lütfen en az bir kelime seçin');
    }

    int positiveCount = 0;
    int negativeCount = 0;

    // Normalize once for reuse
    final normalizedSelected = selectedKeywords
        .map((k) => _normalizeTurkish(k.toLowerCase()))
        .toList();

    // Category tracking
    _MoodCategory? topCategory;
    int topHit = 0;

    for (final normalized in normalizedSelected) {
      if (positiveKeywords.any(
        (k) => _normalizeTurkish(k.toLowerCase()) == normalized,
      )) {
        positiveCount++;
      } else if (negativeKeywords.any(
        (k) => _normalizeTurkish(k.toLowerCase()) == normalized,
      )) {
        negativeCount++;
      }
    }

    // Determine dominant category by keyword hits
    for (final category in _categories) {
      int hits = 0;
      for (final word in category.keywords) {
        final normWord = _normalizeTurkish(word.toLowerCase());
        if (normalizedSelected.contains(normWord)) {
          hits++;
        }
      }

      if (hits > topHit) {
        topHit = hits;
        topCategory = category;
      }
    }

    final total = positiveCount + negativeCount;
    final sentimentScore = total > 0
        ? (positiveCount - negativeCount) / total
        : 0.0;

    final primaryMood = sentimentScore > 0.3
        ? MoodType.happy
        : sentimentScore < -0.3
        ? MoodType.sad
        : MoodType.neutral;

    final double positiveRatio = total > 0 ? positiveCount / total : 0.33;
    final double negativeRatio = total > 0 ? negativeCount / total : 0.33;
    final double neutralRatio = total > 0
        ? (1 - (positiveRatio + negativeRatio)).clamp(0.0, 1.0)
        : 0.34;

    final moodScores = {
      MoodType.happy: positiveRatio,
      MoodType.sad: negativeRatio,
      MoodType.neutral: neutralRatio,
    };

    final recommendedGenre =
        topCategory?.genre ?? (sentimentScore < 0.2 ? 'drama' : 'comedy');

    return MoodAnalysis(
      primaryMood: primaryMood,
      moodScores: moodScores,
      sentimentScore: sentimentScore,
      recommendedGenre: recommendedGenre,
      analysisSummary:
          'Seçilen: ${selectedKeywords.join(", ")}${topCategory != null ? ' | Kategori: ${topCategory.id}' : ''}',
    );
  }
}
