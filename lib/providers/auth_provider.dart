import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  // Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // محاكاة تأخير الشبكة
      await Future.delayed(const Duration(seconds: 1));

      // التحقق من البيانات (محاكاة)
      if (email.isEmpty || password.isEmpty) {
        _error = 'البريد الإلكتروني وكلمة المرور مطلوبة';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // محاكاة تسجيل دخول ناجح
      _currentUser = UserModel(
        id: 'usr_001',
        fullName: 'أحمد محمد',
        username: 'ahmed_2024',
        email: email,
        phone: '+966501234567',
        avatar:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
        location: UserLocation(
          city: 'جدة',
          region: 'مكة المكرمة',
          lat: 21.4858,
          lng: 39.1925,
        ),
        rating: 4.8,
        totalSales: 47,
        memberSince: DateTime(2023, 8, 15),
        isVerified: true,
        onlineStatus: 'online',
        lastSeen: DateTime.now(),
      );

      _isAuthenticated = true;
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

  // Register
  Future<bool> register(String fullName, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
        _error = 'جميع الحقول مطلوبة';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      _currentUser = UserModel(
        id: 'usr_new',
        fullName: fullName,
        username: fullName.replaceAll(' ', '_').toLowerCase(),
        email: email,
        phone: '',
        avatar:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
        location: UserLocation(
          city: '',
          region: '',
          lat: 0,
          lng: 0,
        ),
        rating: 0,
        totalSales: 0,
        memberSince: DateTime.now(),
        isVerified: false,
        onlineStatus: 'online',
        lastSeen: DateTime.now(),
      );

      _isAuthenticated = true;
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

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _currentUser = null;
      _isAuthenticated = false;
      _error = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'حدث خطأ: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update Profile
  Future<bool> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = updatedUser;
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

  // Clear Error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
