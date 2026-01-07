import 'mood_analysis.dart';
import 'movie.dart';

/// Journal entry model representing user's daily journal entry
class JournalEntry {
  final String id;
  final String text;
  final DateTime createdAt;
  final MoodAnalysis? moodAnalysis;
  final Movie? recommendedMovie;

  JournalEntry({
    required this.id,
    required this.text,
    required this.createdAt,
    this.moodAnalysis,
    this.recommendedMovie,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      moodAnalysis: json['mood_analysis'] != null
          ? MoodAnalysis.fromJson(json['mood_analysis'] as Map<String, dynamic>)
          : null,
      recommendedMovie: json['recommended_movie'] != null
          ? Movie.fromJson(json['recommended_movie'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'created_at': createdAt.toIso8601String(),
      'mood_analysis': moodAnalysis?.toJson(),
      'recommended_movie': recommendedMovie?.toJson(),
    };
  }

  JournalEntry copyWith({
    String? id,
    String? text,
    DateTime? createdAt,
    MoodAnalysis? moodAnalysis,
    Movie? recommendedMovie,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      moodAnalysis: moodAnalysis ?? this.moodAnalysis,
      recommendedMovie: recommendedMovie ?? this.recommendedMovie,
    );
  }
}

