class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String mainLayout = '/main';
  static const String listingDetail = '/listing/:id';
  static const String userProfile = '/user/:id';
  static const String chat = '/chat/:conversationId';
  static const String favorites = '/favorites';
  static const String messages = '/messages';
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String createListing = '/create-listing';
  static const String editProfile = '/edit-profile';

  // Generate routes with parameters
  static String listingDetailRoute(String id) => '/listing/$id';
  static String userProfileRoute(String id) => '/user/$id';
  static String chatRoute(String conversationId) => '/chat/$conversationId';
}
