import 'package:flutter/material.dart';
import '../models/listing_model.dart';
import '../data/listings_data.dart';

class ListingsProvider extends ChangeNotifier {
  List<ListingModel> _listings = [];
  List<ListingModel> _filteredListings = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'الرئيسية';

  // Getters
  List<ListingModel> get listings =>
      _filteredListings.isEmpty ? _listings : _filteredListings;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  ListingsProvider() {
    _initializeListings();
  }

  // Initialize Listings
  void _initializeListings() {
    _listings = listingsData;
    _filteredListings = [];
  }

  // Get All Listings
  Future<void> fetchListings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _listings = listingsData;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'حدث خطأ: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get Listing by ID
  ListingModel? getListingById(String id) {
    try {
      return _listings.firstWhere((listing) => listing.id == id);
    } catch (e) {
      return null;
    }
  }

  // Filter by Category
  void filterByCategory(String category) {
    _selectedCategory = category;
    if (category == 'الرئيسية') {
      _filteredListings = [];
    } else {
      _filteredListings = _listings
          .where((listing) => listing.location.city == category)
          .toList();
    }
    notifyListeners();
  }

  // Search Listings
  void searchListings(String query) {
    if (query.isEmpty) {
      _filteredListings = [];
    } else {
      _filteredListings = _listings
          .where((listing) =>
              listing.title.contains(query) ||
              listing.description.contains(query))
          .toList();
    }
    notifyListeners();
  }

  // Filter by Price Range
  void filterByPriceRange(double minPrice, double maxPrice) {
    _filteredListings = _listings
        .where(
            (listing) => listing.price >= minPrice && listing.price <= maxPrice)
        .toList();
    notifyListeners();
  }

  // Filter by Condition
  void filterByCondition(String condition) {
    _filteredListings =
        _listings.where((listing) => listing.condition == condition).toList();
    notifyListeners();
  }

  // Get Featured Listings
  List<ListingModel> getFeaturedListings() {
    return _listings.where((listing) => listing.isFeatured).toList();
  }

  // Get User Listings
  List<ListingModel> getUserListings(String userId) {
    return _listings.where((listing) => listing.userId == userId).toList();
  }

  // Create Listing
  Future<bool> createListing(ListingModel listing) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _listings.add(listing);
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

  // Update Listing
  Future<bool> updateListing(ListingModel listing) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final index = _listings.indexWhere((l) => l.id == listing.id);
      if (index != -1) {
        _listings[index] = listing;
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

  // Delete Listing
  Future<bool> deleteListing(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _listings.removeWhere((listing) => listing.id == id);
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

  // Increment Views
  void incrementViews(String id) {
    final index = _listings.indexWhere((l) => l.id == id);
    if (index != -1) {
      _listings[index] = _listings[index].copyWith(
        views: _listings[index].views + 1,
      );
      notifyListeners();
    }
  }

  // Toggle Like
  void toggleLike(String id) {
    final index = _listings.indexWhere((l) => l.id == id);
    if (index != -1) {
      _listings[index] = _listings[index].copyWith(
        likes: _listings[index].likes + 1,
      );
      notifyListeners();
    }
  }

  // Clear Error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear Filters
  void clearFilters() {
    _filteredListings = [];
    _selectedCategory = 'الرئيسية';
    notifyListeners();
  }
}
