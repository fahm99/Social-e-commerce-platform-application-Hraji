import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CommentsScreen extends StatefulWidget {
  final String listingId;
  final String listingTitle;

  const CommentsScreen({
    super.key,
    required this.listingId,
    required this.listingTitle,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _comments = [
    {
      'id': 'cmt_001',
      'author': 'أحمد محمد',
      'avatar':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
      'text': 'منتج ممتاز وجودة عالية جداً',
      'time': 'منذ ساعة',
      'likes': 5,
      'isLiked': false,
    },
    {
      'id': 'cmt_002',
      'author': 'فاطمة علي',
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=400&fit=crop&crop=face',
      'text': 'هل المنتج متوفر الآن؟',
      'time': 'منذ 30 دقيقة',
      'likes': 2,
      'isLiked': false,
    },
    {
      'id': 'cmt_003',
      'author': 'محمود سالم',
      'avatar':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop&crop=face',
      'text': 'السعر مناسب جداً',
      'time': 'منذ 15 دقيقة',
      'likes': 3,
      'isLiked': false,
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
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
              'التعليقات',
              style: GoogleFonts.cairo(
                color: AppTheme.textDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.listingTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                color: AppTheme.textGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // قائمة التعليقات
          Expanded(
            child: _comments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.comment_outlined,
                          size: 80,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد تعليقات',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textGrey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'كن أول من يعلق على هذا المنتج',
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      return _buildCommentCard(comment, index);
                    },
                  ),
          ),

          // حقل إضافة تعليق
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'أضف تعليقاً...',
                      hintStyle: GoogleFonts.cairo(
                        fontSize: 13,
                        color: AppTheme.textLight,
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
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
                        borderSide:
                            const BorderSide(color: AppTheme.primaryRed),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
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
                    onPressed: _submitComment,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentCard(Map<String, dynamic> comment, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس التعليق
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.divider),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    comment['avatar'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.background,
                        child: const Icon(Icons.person),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment['author'],
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    Text(
                      comment['time'],
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // نص التعليق
          Text(
            comment['text'],
            style: GoogleFonts.cairo(
              fontSize: 13,
              color: AppTheme.textDark,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // أزرار التفاعل
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    comment['isLiked'] = !comment['isLiked'];
                    if (comment['isLiked']) {
                      comment['likes']++;
                    } else {
                      comment['likes']--;
                    }
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      comment['isLiked']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: comment['isLiked']
                          ? AppTheme.primaryRed
                          : AppTheme.textLight,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      comment['likes'].toString(),
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرد على التعليقات قريباً'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.reply,
                      color: AppTheme.textLight,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'رد',
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: AppTheme.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.insert(0, {
          'id': 'cmt_${DateTime.now().millisecondsSinceEpoch}',
          'author': 'أنت',
          'avatar':
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
          'text': _commentController.text,
          'time': 'الآن',
          'likes': 0,
          'isLiked': false,
        });
        _commentController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إضافة التعليق بنجاح'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
