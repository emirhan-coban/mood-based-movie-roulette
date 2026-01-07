import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/primary_button.dart';
import 'movie_result_screen.dart';

/// Screen for selecting mood keywords
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final Set<String> _selectedKeywords = {};

  static const Map<String, List<String>> _keywordCategories = {
    '🎉 Keyif & Komedi': [
      'mutlu',
      'neşeli',
      'komik',
      'eğlenceli',
      'keyifli',
      'harika',
      'hafif',
      'rahat',
    ],
    '🎭 Hüzün & Drama': [
      'üzgün',
      'hüzünlü',
      'melankolik',
      'kırgın',
      'yalnız',
      'mutsuz',
      'duygusal',
      'yorgun',
    ],
    '⚡ Öfke & Gerilim': [
      'öfkeli',
      'sinirli',
      'gergin',
      'bunalmış',
      'stresli',
      'sert',
      'tepkili',
    ],
    '👻 Korku': [
      'korkmuş',
      'tedirgin',
      'kaygılı',
      'ürkmüş',
      'gerilmiş',
      'dehşetli',
    ],
    '💘 Romantik': ['aşık', 'romantik', 'sevgi dolu', 'duygusal', 'hassas'],
    '🚀 Aksiyon & Macera': [
      'maceraperest',
      'cesur',
      'heyecanlı',
      'hızlı',
      'kahraman',
      'savaşçı',
    ],
    '🌿 Sakin & Huzur': [
      'sakin',
      'huzurlu',
      'dingin',
      'meditatif',
      'rahatlamış',
    ],
    '🪐 Merak & Bilimkurgu': [
      'meraklı',
      'hayalperest',
      'bilimkurgu hayranı',
      'kaşif',
      'kozmos',
      'fantastik',
      'büyülü',
    ],
  };

  Future<void> _analyzeAndRecommend() async {
    if (_selectedKeywords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen en az bir kelime seçin.'),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final provider = Provider.of<AppStateProvider>(context, listen: false);
    await provider.analyzeKeywordsAndRecommend(_selectedKeywords.toList());

    if (provider.errorMessage != null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } else if (provider.currentEntry != null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MovieResultScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Film Önerisi Al'), centerTitle: true),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Şu anda nasıl hissediyorsun? Duygularını en iyi anlatan kelimeleri seç!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_selectedKeywords.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _selectedKeywords.map((keyword) {
                              return Chip(
                                label: Text(keyword),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () {
                                  setState(
                                    () => _selectedKeywords.remove(keyword),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      const SizedBox(height: 16),
                      ..._keywordCategories.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: entry.value.map((keyword) {
                                final isSelected = _selectedKeywords.contains(
                                  keyword,
                                );
                                return FilterChip(
                                  label: Text(keyword),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedKeywords.add(keyword);
                                      } else {
                                        _selectedKeywords.remove(keyword);
                                      }
                                    });
                                  },
                                  selectedColor: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.3),
                                  checkmarkColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: PrimaryButton(
                    text:
                        'Film Önerisi Al (${_selectedKeywords.length} kelime)',
                    onPressed: _analyzeAndRecommend,
                    isLoading: provider.isLoading,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
