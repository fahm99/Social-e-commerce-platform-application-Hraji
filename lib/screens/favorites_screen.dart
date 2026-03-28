import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/favorites_provider.dart';
import '../providers/listings_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'المفضلة',
          style: GoogleFonts.cairo(
            color: AppTheme.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer2<FavoritesProvider, ListingsProvider>(
        builder: (context, favoritesProvider, listingsProvider, child) {
          final favoriteListings = listingsProvider.listings
              .where((listing) => favoritesProvider.isFavorite(listing.id))
              .toList();

          if (favoriteListings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: AppTheme.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد عناصر مفضلة',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أضف عناصر إلى المفضلة لتتمكن من الوصول إليها بسهولة',
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
            padding: const EdgeInsets.all(16),
            itemCount: favoriteListings.length,
            itemBuilder: (context, index) {
              final listing = favoriteListings[index];
              return _buildFavoriteCard(
                  context, listing, index, favoritesProvider);
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, dynamic listing, int index,
      FavoritesProvider favoritesProvider) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/listing/${listing.id}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Image.network(
                  listing.images.first,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 30,
                        color: AppTheme.textLight,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${listing.price} ر.س',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryRed,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 12, color: AppTheme.textLight),
                        const SizedBox(width: 4),
                        Text(
                          listing.location.city,
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            color: AppTheme.textLight,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'منذ يومين',
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            color: AppTheme.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Remove Button
            Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  favoritesProvider.removeFromFavorites(listing.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppTheme.textLight,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
