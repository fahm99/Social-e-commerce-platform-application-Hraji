import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String> _favoriteIds = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<String> get favoriteIds => _favoriteIds;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get favoritesCount => _favoriteIds.length;

  // Check if Listing is Favorite
  bool isFavorite(String listingId) {
    return _favoriteIds.contains(listingId);
  }

  // Add to Favorites
  Future<bool> addToFavorites(String listingId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!_favoriteIds.contains(listingId)) {
        _favoriteIds.add(listingId);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'حدث خطأ: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Remove from Favorites
  Future<bool> removeFromFavorites(String listingId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _favoriteIds.remove(listingId);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'حدث خطأ: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Toggle Favorite
  Future<bool> toggleFavorite(String listingId) async {
    if (isFavorite(listingId)) {
      return removeFromFavorites(listingId);
    } else {
      return addToFavorites(listingId);
    }
  }

  // Clear All Favorites
  Future<void> clearAllFavorites() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _favoriteIds.clear();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'حدث خطأ: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear Error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
