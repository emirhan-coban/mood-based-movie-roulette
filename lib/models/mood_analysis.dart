/// Mood analysis result from sentiment analysis API
enum MoodType {
  happy,
  sad,
  anxious,
  angry,
  calm,
  excited,
  melancholic,
  neutral,
}

class MoodAnalysis {
  final MoodType primaryMood;
  final Map<MoodType, double> moodScores;
  final double sentimentScore; // -1.0 to 1.0 (negative to positive)
  final String? recommendedGenre;
  final String? analysisSummary;

  MoodAnalysis({
    required this.primaryMood,
    required this.moodScores,
    required this.sentimentScore,
    this.recommendedGenre,
    this.analysisSummary,
  });

  factory MoodAnalysis.fromJson(Map<String, dynamic> json) {
    return MoodAnalysis(
      primaryMood: MoodType.values.firstWhere(
        (e) => e.toString().split('.').last == json['primary_mood'],
        orElse: () => MoodType.neutral,
      ),
      moodScores: Map<MoodType, double>.from(
        (json['mood_scores'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            MoodType.values.firstWhere(
              (e) => e.toString().split('.').last == key,
              orElse: () => MoodType.neutral,
            ),
            (value as num).toDouble(),
          ),
        ),
      ),
      sentimentScore: (json['sentiment_score'] as num).toDouble(),
      recommendedGenre: json['recommended_genre'] as String?,
      analysisSummary: json['analysis_summary'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primary_mood': primaryMood.toString().split('.').last,
      'mood_scores': moodScores.map(
        (key, value) => MapEntry(key.toString().split('.').last, value),
      ),
      'sentiment_score': sentimentScore,
      'recommended_genre': recommendedGenre,
      'analysis_summary': analysisSummary,
    };
  }

  bool get needsUplifting => sentimentScore < 0.2;
  bool get needsCatharsis => sentimentScore < -0.3;
}
