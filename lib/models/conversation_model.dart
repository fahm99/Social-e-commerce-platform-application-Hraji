class ConversationModel {
  final String id;
  final List<String> participants;
  final String? listingId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int unreadCount;
  final MessageModel lastMessage;

  ConversationModel({
    required this.id,
    required this.participants,
    this.listingId,
    required this.createdAt,
    required this.updatedAt,
    required this.unreadCount,
    required this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? '',
      participants: List<String>.from(json['participants'] ?? []),
      listingId: json['listing_id'],
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
      unreadCount: json['unread_count'] ?? 0,
      lastMessage: MessageModel.fromJson(json['last_message'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'listing_id': listingId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'unread_count': unreadCount,
      'last_message': lastMessage.toJson(),
    };
  }
}

class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isRead;
  final String type;
  final List<String> attachments;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isRead,
    required this.type,
    required this.attachments,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      conversationId: json['conversation_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      text: json['text'] ?? '',
      timestamp:
          DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      isRead: json['is_read'] ?? false,
      type: json['type'] ?? 'text',
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'is_read': isRead,
      'type': type,
      'attachments': attachments,
    };
  }

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? text,
    DateTime? timestamp,
    bool? isRead,
    String? type,
    List<String>? attachments,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      attachments: attachments ?? this.attachments,
    );
  }
}
