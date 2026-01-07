import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/mood_indicator.dart';

/// Screen displaying journal entry history
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal History'),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          final entries = provider.journalHistory;

          if (entries.isEmpty) {
            return const Center(
              child: Text('No journal entries yet'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.createdAt.toString().split(' ')[0],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (entry.moodAnalysis != null) ...[
                        const SizedBox(height: 16),
                        MoodIndicator(moodAnalysis: entry.moodAnalysis!),
                      ],
                      if (entry.recommendedMovie != null) ...[
                        const SizedBox(height: 16),
                        MovieCard(movie: entry.recommendedMovie!),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

