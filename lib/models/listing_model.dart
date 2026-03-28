class ListingModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String currency;
  final bool priceNegotiable;
  final String categoryId;
  final String subcategoryId;
  final String userId;
  final ListingLocation location;
  final List<String> images;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int views;
  final int likes;
  final int commentsCount;
  final bool isFeatured;
  final String condition;

  ListingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.priceNegotiable,
    required this.categoryId,
    required this.subcategoryId,
    required this.userId,
    required this.location,
    required this.images,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.views,
    required this.likes,
    required this.commentsCount,
    required this.isFeatured,
    required this.condition,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? 'SAR',
      priceNegotiable: json['price_negotiable'] ?? false,
      categoryId: json['category_id'] ?? '',
      subcategoryId: json['subcategory_id'] ?? '',
      userId: json['user_id'] ?? '',
      location: ListingLocation.fromJson(json['location'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      condition: json['condition'] ?? 'جديد',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'currency': currency,
      'price_negotiable': priceNegotiable,
      'category_id': categoryId,
      'subcategory_id': subcategoryId,
      'user_id': userId,
      'location': location.toJson(),
      'images': images,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'views': views,
      'likes': likes,
      'comments_count': commentsCount,
      'is_featured': isFeatured,
      'condition': condition,
    };
  }

  ListingModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? currency,
    bool? priceNegotiable,
    String? categoryId,
    String? subcategoryId,
    String? userId,
    ListingLocation? location,
    List<String>? images,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? views,
    int? likes,
    int? commentsCount,
    bool? isFeatured,
    String? condition,
  }) {
    return ListingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      priceNegotiable: priceNegotiable ?? this.priceNegotiable,
      categoryId: categoryId ?? this.categoryId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      userId: userId ?? this.userId,
      location: location ?? this.location,
      images: images ?? this.images,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      commentsCount: commentsCount ?? this.commentsCount,
      isFeatured: isFeatured ?? this.isFeatured,
      condition: condition ?? this.condition,
    );
  }
}

class ListingLocation {
  final String city;
  final String region;
  final String? district;

  ListingLocation({
    required this.city,
    required this.region,
    this.district,
  });

  factory ListingLocation.fromJson(Map<String, dynamic> json) {
    return ListingLocation(
      city: json['city'] ?? '',
      region: json['region'] ?? '',
      district: json['district'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'region': region,
      'district': district,
    };
  }
}
