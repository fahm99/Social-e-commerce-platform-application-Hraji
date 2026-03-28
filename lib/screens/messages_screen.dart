import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haraji_app/data/conversations_data.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/conversations_provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'الرسائل',
          style: GoogleFonts.cairo(
            color: AppTheme.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<ConversationsProvider>(
        builder: (context, conversationsProvider, child) {
          if (conversationsProvider.conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 80,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد رسائل',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ابدأ محادثة مع البائعين والمشترين',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: AppTheme.textLight,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: conversationsProvider.conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversationsProvider.conversations[index];
              return _buildConversationTile(context, conversation);
            },
          );
        },
      ),
    );
  }

  Widget _buildConversationTile(
      BuildContext context, Conversation conversation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: conversation.isUnread ? Colors.white : AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: conversation.isUnread
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: Stack(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: conversation.isOnline
                      ? AppTheme.primaryRed
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.network(
                  conversation.avatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.primaryRed,
                      child: Center(
                        child: Text(
                          conversation.name[0],
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (conversation.isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                conversation.name,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight:
                      conversation.isUnread ? FontWeight.bold : FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(
          conversation.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cairo(
            fontSize: 12,
            color:
                conversation.isUnread ? AppTheme.textGrey : AppTheme.textLight,
            fontWeight:
                conversation.isUnread ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              conversation.time,
              style: GoogleFonts.cairo(
                fontSize: 11,
                color: AppTheme.textLight,
              ),
            ),
            if (conversation.isUnread && conversation.unreadCount > 0)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primaryRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  conversation.unreadCount.toString(),
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          // Navigate to chat screen
          Navigator.pushNamed(
            context,
            '/chat/${conversation.id}',
          );
        },
      ),
    );
  }
}
