import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../screens/comments_screen.dart';

class ProductCard extends StatelessWidget {
  final dynamic listing;
  final int index;

  const ProductCard({
    super.key,
    required this.listing,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Product Image
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/listing/${listing.id}');
                },
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      listing.images.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.background,
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Product Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/listing/${listing.id}');
                        },
                        child: Text(
                          listing.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                            height: 1.3,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Location and Price
                      Row(
                        children: [
                          Text(
                            listing.location.city,
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              color: AppTheme.textLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              color: AppTheme.textLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'الآن',
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              color: AppTheme.textLight,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Price and Comments
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${listing.price} ر.س',
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryRed,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'تعليقات ${listing.commentsCount}',
                                style: GoogleFonts.cairo(
                                  fontSize: 11,
                                  color: AppTheme.textLight,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            listing.userId,
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              color: AppTheme.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // زر التعليق (أسفل اليسار)
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.comment_outlined,
                    color: AppTheme.textGrey, size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(
                        listingId: listing.id,
                        listingTitle: listing.title,
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
