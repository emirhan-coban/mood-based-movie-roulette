/// Application-wide constants
class Constants {
  // API Configuration
  static const int apiTimeoutSeconds = 30;
  static const int maxRetries = 3;

  // Journal Configuration
  static const int minJournalLength = 10;
  static const int maxJournalLength = 5000;

  // Movie Configuration
  static const int defaultMoviePage = 1;
  static const int moviesPerPage = 20;

  // Storage Keys
  static const String journalEntriesKey = 'journal_entries';
  static const String userPreferencesKey = 'user_preferences';

  // UI Configuration
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double cardElevation = 4.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
}

