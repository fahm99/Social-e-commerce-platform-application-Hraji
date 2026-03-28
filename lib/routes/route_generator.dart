import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/main_layout.dart';
import '../screens/listing_detail_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/create_listing_screen.dart';
import '../screens/comments_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // معالجة المسارات الديناميكية
    if (settings.name?.startsWith('/listing/') ?? false) {
      final id = settings.name!.replaceFirst('/listing/', '');
      return MaterialPageRoute(
        builder: (_) => ListingDetailScreen(listingId: id),
      );
    }

    if (settings.name?.startsWith('/user/') ?? false) {
      final id = settings.name!.replaceFirst('/user/', '');
      return MaterialPageRoute(
        builder: (_) => UserProfileScreen(userId: id),
      );
    }

    if (settings.name?.startsWith('/chat/') ?? false) {
      final conversationId = settings.name!.replaceFirst('/chat/', '');
      return MaterialPageRoute(
        builder: (_) => ChatScreen(conversationId: conversationId),
      );
    }

    // معالجة المسارات الثابتة
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppRoutes.mainLayout:
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainLayout());

      // Search Route
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      // Settings Route
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      // Create Listing Route
      case AppRoutes.createListing:
        return MaterialPageRoute(builder: (_) => const CreateListingScreen());

      // Favorites Route
      case AppRoutes.favorites:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('المفضلة')),
            body: const Center(child: Text('Favorites Screen')),
          ),
        );

      // Messages Route
      case AppRoutes.messages:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('الرسائل')),
            body: const Center(child: Text('Messages Screen')),
          ),
        );

      // Notifications Route
      case AppRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('الإشعارات')),
            body: const Center(child: Text('Notifications Screen')),
          ),
        );

      // Create Listing Route
      case AppRoutes.createListing:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('إنشاء إعلان')),
            body: const Center(child: Text('Create Listing Screen')),
          ),
        );

      // Edit Profile Route
      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('تعديل الملف الشخصي')),
            body: const Center(child: Text('Edit Profile Screen')),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('خطأ')),
        body: const Center(
          child: Text('لم يتم العثور على الصفحة'),
        ),
      ),
    );
  }
}
