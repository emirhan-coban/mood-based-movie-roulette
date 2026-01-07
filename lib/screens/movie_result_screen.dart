import 'package:flutter/material.dart';
import 'package:movie_roulette/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/mood_indicator.dart';
import '../widgets/movie_card.dart';
import 'home_screen.dart';

/// Screen displaying the movie recommendation result
class MovieResultScreen extends StatelessWidget {
  const MovieResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Önerisi Sonucu'),
        centerTitle: true,
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          final entry = provider.currentEntry;

          if (entry == null) {
            return const Center(child: Text('Hiç sonuç bulunamadı.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (entry.moodAnalysis != null) ...[
                  const Text(
                    'Duygu Analiziniz',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  MoodIndicator(moodAnalysis: entry.moodAnalysis!),
                  const SizedBox(height: 32),
                ],
                const Text(
                  'Önerilen Film',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (entry.recommendedMovie != null)
                  MovieCard(movie: entry.recommendedMovie!)
                else
                  const Text('Film bulunamadı.'),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Ana Sayfaya Dön',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
