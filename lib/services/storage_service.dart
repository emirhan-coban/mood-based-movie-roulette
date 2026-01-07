import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/journal_entry.dart';

/// Service for local storage using SharedPreferences
class StorageService {
  static const String _journalEntriesKey = 'journal_entries';

  /// Save a journal entry
  Future<void> saveJournalEntry(JournalEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getAllJournalEntries();
    
    // Add or update entry
    final existingIndex = entries.indexWhere((e) => e.id == entry.id);
    if (existingIndex >= 0) {
      entries[existingIndex] = entry;
    } else {
      entries.add(entry);
    }

    // Save to storage
    final entriesJson = entries.map((e) => e.toJson()).toList();
    await prefs.setString(_journalEntriesKey, json.encode(entriesJson));
  }

  /// Get all journal entries
  Future<List<JournalEntry>> getAllJournalEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getString(_journalEntriesKey);

    if (entriesJson == null) {
      return [];
    }

    try {
      final List<dynamic> decoded = json.decode(entriesJson);
      return decoded
          .map((json) => JournalEntry.fromJson(json as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      return [];
    }
  }

  /// Get a specific journal entry by ID
  Future<JournalEntry?> getJournalEntry(String id) async {
    final entries = await getAllJournalEntries();
    try {
      return entries.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Delete a journal entry
  Future<void> deleteJournalEntry(String id) async {
    final entries = await getAllJournalEntries();
    entries.removeWhere((e) => e.id == id);

    final prefs = await SharedPreferences.getInstance();
    final entriesJson = entries.map((e) => e.toJson()).toList();
    await prefs.setString(_journalEntriesKey, json.encode(entriesJson));
  }

  /// Clear all journal entries
  Future<void> clearAllEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_journalEntriesKey);
  }
}

