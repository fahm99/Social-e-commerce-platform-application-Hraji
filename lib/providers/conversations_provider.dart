import 'package:flutter/material.dart';
import '../data/conversations_data.dart';

class ConversationsProvider extends ChangeNotifier {
  List<Conversation> _conversations = [];
  bool _isLoading = false;
  String? _error;

  List<Conversation> get conversations => _conversations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ConversationsProvider() {
    _initializeConversations();
  }

  void _initializeConversations() {
    _conversations = conversationsData;
  }

  Future<void> fetchConversations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _conversations = conversationsData;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'حدث خطأ: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  Conversation? getConversationById(String id) {
    try {
      return _conversations.firstWhere((conv) => conv.id.toString() == id);
    } catch (e) {
      return null;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
