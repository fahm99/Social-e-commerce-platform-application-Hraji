class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatar: json['avatar'] ?? '',
      location: UserLocation.fromJson(json['location'] ?? {}),
      rating: (json['rating'] ?? 0).toDouble(),
      totalSales: json['total_sales'] ?? 0,
      memberSince: DateTime.parse(
          json['member_since'] ?? DateTime.now().toIso8601String()),
      isVerified: json['is_verified'] ?? false,
      onlineStatus: json['online_status'] ?? 'offline',
      lastSeen:
          DateTime.parse(json['last_seen'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'location': location.toJson(),
      'rating': rating,
      'total_sales': totalSales,
      'member_since': memberSince.toIso8601String(),
      'is_verified': isVerified,
      'online_status': onlineStatus,
      'last_seen': lastSeen.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? phone,
    String? avatar,
    UserLocation? location,
    double? rating,
    int? totalSales,
    DateTime? memberSince,
    bool? isVerified,
    String? onlineStatus,
    DateTime? lastSeen,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      totalSales: totalSales ?? this.totalSales,
      memberSince: memberSince ?? this.memberSince,
      isVerified: isVerified ?? this.isVerified,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }
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

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      city: json['city'] ?? '',
      region: json['region'] ?? '',
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'region': region,
      'lat': lat,
      'lng': lng,
    };
  }
}
