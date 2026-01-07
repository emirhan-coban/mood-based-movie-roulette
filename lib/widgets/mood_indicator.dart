import 'package:flutter/material.dart';
import '../models/mood_analysis.dart';

/// Widget displaying mood analysis results
class MoodIndicator extends StatelessWidget {
  final MoodAnalysis moodAnalysis;

  const MoodIndicator({super.key, required this.moodAnalysis});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getMoodIcon(moodAnalysis.primaryMood),
                  color: _getMoodColor(moodAnalysis.primaryMood),
                ),
                const SizedBox(width: 8),
                Text(
                  'Duygu Durumunuz: ${_getMoodLabel(moodAnalysis.primaryMood)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: (moodAnalysis.sentimentScore + 1) / 2,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getMoodColor(moodAnalysis.primaryMood),
              ),
            ),
            const SizedBox(height: 8),

            if (moodAnalysis.recommendedGenre != null) ...[
              const SizedBox(height: 8),
              Text(
                'Önerilen Tür: ${moodAnalysis.recommendedGenre}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getMoodIcon(MoodType mood) {
    switch (mood) {
      case MoodType.happy:
        return Icons.sentiment_very_satisfied;
      case MoodType.sad:
        return Icons.sentiment_very_dissatisfied;
      case MoodType.anxious:
        return Icons.sentiment_dissatisfied;
      case MoodType.angry:
        return Icons.sentiment_very_dissatisfied;
      case MoodType.calm:
        return Icons.sentiment_satisfied;
      case MoodType.excited:
        return Icons.sentiment_very_satisfied;
      case MoodType.melancholic:
        return Icons.sentiment_dissatisfied;
      case MoodType.neutral:
        return Icons.sentiment_neutral;
    }
  }

  Color _getMoodColor(MoodType mood) {
    switch (mood) {
      case MoodType.happy:
      case MoodType.excited:
        return Colors.green;
      case MoodType.sad:
      case MoodType.melancholic:
        return Colors.blue;
      case MoodType.anxious:
      case MoodType.angry:
        return Colors.red;
      case MoodType.calm:
        return Colors.teal;
      case MoodType.neutral:
        return Colors.grey;
    }
  }

  String _getMoodLabel(MoodType mood) {
    switch (mood) {
      case MoodType.happy:
        return 'Mutlu';
      case MoodType.sad:
        return 'Üzgün';
      case MoodType.anxious:
        return 'Endişeli';
      case MoodType.angry:
        return 'Kızgın';
      case MoodType.calm:
        return 'Sakin';
      case MoodType.excited:
        return 'Heyecanlı';
      case MoodType.melancholic:
        return 'Melankolik';
      case MoodType.neutral:
        return 'Nötr';
    }
  }
}
