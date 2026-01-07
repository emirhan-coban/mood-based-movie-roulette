import 'package:flutter/foundation.dart';
import '../models/journal_entry.dart';
import '../services/rating_service.dart';
import '../services/tmdb_service.dart';
import '../services/storage_service.dart';

/// App state provider using ChangeNotifier for state management
class AppStateProvider extends ChangeNotifier {
  final RatingService _huggingFaceService = RatingService();
  final TMDBService _tmdbService = TMDBService();
  final StorageService _storageService = StorageService();

  bool _isLoading = false;
  String? _errorMessage;
  JournalEntry? _currentEntry;
  List<JournalEntry> _journalHistory = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  JournalEntry? get currentEntry => _currentEntry;
  List<JournalEntry> get journalHistory => _journalHistory;

  AppStateProvider() {
    _loadJournalHistory();
  }

  /// Load journal history from storage
  Future<void> _loadJournalHistory() async {
    try {
      _journalHistory = await _storageService.getAllJournalEntries();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load journal history: $e';
      notifyListeners();
    }
  }

  /// Analyze selected keywords and get movie recommendation
  Future<void> analyzeKeywordsAndRecommend(
    List<String> selectedKeywords,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final moodAnalysis = await _huggingFaceService
          .analyzeMoodFromSelectedKeywords(selectedKeywords);
      final movie = await _tmdbService.getRandomMovieByMood(
        genre: moodAnalysis.recommendedGenre ?? 'drama',
        needsUplifting: moodAnalysis.needsUplifting,
      );

      final entry = JournalEntry(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Seçilen kelimeler: ${selectedKeywords.join(", ")}',
        createdAt: DateTime.now(),
        moodAnalysis: moodAnalysis,
        recommendedMovie: movie,
      );

      await _storageService.saveJournalEntry(entry);
      _currentEntry = entry;
      await _loadJournalHistory();
    } catch (e) {
      _errorMessage = 'Kelime analizi başarısız: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clear current entry
  void clearCurrentEntry() {
    _currentEntry = null;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
