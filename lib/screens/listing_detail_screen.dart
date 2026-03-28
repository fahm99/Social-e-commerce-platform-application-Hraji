import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/listing_model.dart';
import '../providers/listings_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/auth_provider.dart';

class ListingDetailScreen extends StatefulWidget {
  final String listingId;

  const ListingDetailScreen({
    super.key,
    required this.listingId,
  });

  @override
  State<ListingDetailScreen> createState() => _ListingDetailScreenState();
}

class _ListingDetailScreenState extends State<ListingDetailScreen> {
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    // زيادة عدد المشاهدات
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListingsProvider>(context, listen: false)
          .incrementViews(widget.listingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<ListingsProvider, FavoritesProvider, AuthProvider>(
      builder:
          (context, listingsProvider, favoritesProvider, authProvider, child) {
        final listing = listingsProvider.getListingById(widget.listingId);

        if (listing == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('الإعلان')),
            body: const Center(child: Text('لم يتم العثور على الإعلان')),
          );
        }

        final isFavorite = favoritesProvider.isFavorite(listing.id);

        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'تفاصيل الإعلان',
              style: GoogleFonts.cairo(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppTheme.primaryRed,
                ),
                onPressed: () {
                  favoritesProvider.toggleFavorite(listing.id);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صور الإعلان
                _buildImageCarousel(listing),

                // معلومات الإعلان
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العنوان والسعر
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              listing.title,
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${listing.price} ${listing.currency}',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryRed,
                        ),
                      ),
                      if (listing.priceNegotiable)
                        Text(
                          'السعر قابل للتفاوض',
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      const SizedBox(height: 16),

                      // الموقع والحالة
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: AppTheme.textGrey),
                          const SizedBox(width: 4),
                          Text(
                            '${listing.location.city}, ${listing.location.region}',
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: AppTheme.textGrey,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.background,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              listing.condition,
                              style: GoogleFonts.cairo(
                                fontSize: 12,
                                color: AppTheme.textGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // الوصف
                      Text(
                        'الوصف',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        listing.description,
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          color: AppTheme.textGrey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // معلومات البائع
                      _buildSellerInfo(context),
                      const SizedBox(height: 24),

                      // الإحصائيات
                      _buildStatistics(listing),
                      const SizedBox(height: 24),

                      // أزرار الإجراءات
                      _buildActionButtons(context, listing),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageCarousel(ListingModel listing) {
    return Stack(
      children: [
        Container(
          height: 300,
          color: AppTheme.background,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() => _currentImageIndex = index);
            },
            itemCount: listing.images.length,
            itemBuilder: (context, index) {
              return Image.network(
                listing.images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.image_not_supported),
                  );
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_currentImageIndex + 1}/${listing.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSellerInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryRed,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'البائع',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppTheme.textLight,
                  ),
                ),
                Text(
                  'أحمد محمد',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            '4.8',
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(ListingModel listing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('المشاهدات', listing.views.toString()),
        _buildStatItem('الإعجابات', listing.likes.toString()),
        _buildStatItem('التعليقات', listing.commentsCount.toString()),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryRed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12,
            color: AppTheme.textGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, ListingModel listing) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // التنقل إلى شاشة الرسالة
              Navigator.pushNamed(
                context,
                '/chat/conv_001',
              );
            },
            icon: const Icon(Icons.message),
            label: Text(
              'إرسال رسالة',
              style: GoogleFonts.cairo(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // الاتصال
            },
            icon: const Icon(Icons.phone),
            label: Text(
              'اتصال',
              style: GoogleFonts.cairo(),
            ),
          ),
        ),
      ],
    );
  }
}
