class User {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String avatar;
  final UserLocation location;
  final double rating;
  final int totalSales;
  final DateTime memberSince;
  final bool isVerified;
  final String onlineStatus;
  final DateTime lastSeen;

  User({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.location,
    required this.rating,
    required this.totalSales,
    required this.memberSince,
    required this.isVerified,
    required this.onlineStatus,
    required this.lastSeen,
  });
}

class UserLocation {
  final String city;
  final String region;
  final double lat;
  final double lng;

  UserLocation({
    required this.city,
    required this.region,
    required this.lat,
    required this.lng,
  });
}

final List<User> usersData = [
  User(
    id: 'usr_001',
    fullName: 'أحمد Mohammed',
    username: 'ahmed_2024',
    email: 'ahmed@example.com',
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
    memberSince: DateTime.parse('2023-08-15'),
    isVerified: true,
    onlineStatus: 'online',
    lastSeen: DateTime.parse('2026-03-28T19:00:00Z'),
  ),
  User(
    id: 'usr_002',
    fullName: 'أم فهد',
    username: 'um_fahad',
    email: 'umfahad@example.com',
    phone: '+966502345678',
    avatar:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=400&fit=crop&crop=face',
    location: UserLocation(
      city: 'الرياض',
      region: 'الرياض',
      lat: 24.7136,
      lng: 46.6753,
    ),
    rating: 4.9,
    totalSales: 128,
    memberSince: DateTime.parse('2022-03-10'),
    isVerified: true,
    onlineStatus: 'offline',
    lastSeen: DateTime.parse('2026-03-28T18:30:00Z'),
  ),
  User(
    id: 'usr_003',
    fullName: 'خالد العنزي',
    username: 'khalid_anzi',
    email: 'khalid@example.com',
    phone: '+966503456789',
    avatar:
        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&h=400&fit=crop&crop=face',
    location: UserLocation(
      city: 'الرياض',
      region: 'الرياض',
      lat: 24.7743,
      lng: 46.7386,
    ),
    rating: 4.5,
    totalSales: 23,
    memberSince: DateTime.parse('2024-01-20'),
    isVerified: false,
    onlineStatus: 'online',
    lastSeen: DateTime.parse('2026-03-28T19:05:00Z'),
  ),
  User(
    id: 'usr_004',
    fullName: 'محمد السبيعي',
    username: 'mohammed_sub',
    email: 'mohammed@example.com',
    phone: '+966504567890',
    avatar:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop&crop=face',
    location: UserLocation(
      city: 'الدمام',
      region: 'الشرقية',
      lat: 26.4207,
      lng: 50.0888,
    ),
    rating: 4.2,
    totalSales: 15,
    memberSince: DateTime.parse('2024-06-15'),
    isVerified: true,
    onlineStatus: 'offline',
    lastSeen: DateTime.parse('2026-03-28T16:00:00Z'),
  ),
  User(
    id: 'usr_005',
    fullName: 'عبدالله القحطاني',
    username: 'abdullah_q',
    email: 'abdullah@example.com',
    phone: '+966505678901',
    avatar:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400&h=400&fit=crop&crop=face',
    location: UserLocation(
      city: 'أبها',
      region: 'عسير',
      lat: 18.2164,
      lng: 42.5053,
    ),
    rating: 5.0,
    totalSales: 89,
    memberSince: DateTime.parse('2023-01-10'),
    isVerified: true,
    onlineStatus: 'online',
    lastSeen: DateTime.parse('2026-03-28T18:50:00Z'),
  ),
];
