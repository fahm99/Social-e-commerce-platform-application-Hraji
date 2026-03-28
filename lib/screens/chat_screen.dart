import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final String conversationId;

  const ChatScreen({
    super.key,
    required this.conversationId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'id': 'msg_001',
      'sender': 'other',
      'text': 'السلام عليكم، هل السعر قابل للتفاوض؟',
      'time': '08:30',
      'isRead': true,
    },
    {
      'id': 'msg_002',
      'sender': 'me',
      'text': 'وعليكم السلام، نعم فيه مجال بسيط',
      'time': '08:35',
      'isRead': true,
    },
    {
      'id': 'msg_003',
      'sender': 'other',
      'text': 'كم آخر سعر؟',
      'time': '09:00',
      'isRead': true,
    },
    {
      'id': 'msg_004',
      'sender': 'me',
      'text': 'نعم، السعر قابل للتفاوض.',
      'time': '19:00',
      'isRead': true,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أحمد محمد',
              style: GoogleFonts.cairo(
                color: AppTheme.textDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'نشط الآن',
              style: GoogleFonts.cairo(
                color: Colors.green,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: AppTheme.primaryRed),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // الرسائل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // حقل الإدخال
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: AppTheme.primaryRed),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة...',
                      hintStyle: const TextStyle(color: AppTheme.textLight),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppTheme.divider),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: AppTheme.divider),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppTheme.primaryRed,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryRed,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          _messages.add({
                            'id': 'msg_${_messages.length + 1}',
                            'sender': 'me',
                            'text': _messageController.text,
                            'time':
                                '${DateTime.now().hour}:${DateTime.now().minute}',
                            'isRead': false,
                          });
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['sender'] == 'me';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? AppTheme.primaryRed : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isMe ? null : Border.all(color: AppTheme.divider),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: GoogleFonts.cairo(
                color: isMe ? Colors.white : AppTheme.textDark,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message['time'],
                  style: GoogleFonts.cairo(
                    color: isMe ? Colors.white70 : AppTheme.textLight,
                    fontSize: 11,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    message['isRead'] ? Icons.done_all : Icons.done,
                    color: Colors.white70,
                    size: 14,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
