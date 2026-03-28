import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/listings_provider.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ListingsProvider>(
      builder: (context, authProvider, listingsProvider, child) {
        final currentUser = authProvider.currentUser;

        if (currentUser == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('الملف الشخصي')),
            body: const Center(child: Text('يرجى تسجيل الدخول أولاً')),
          );
        }

        final userListings = listingsProvider.getUserListings(userId);

        return Scaffold(
          backgroundColor: AppTheme.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'الملف الشخصي',
              style: GoogleFonts.cairo(
                color: AppTheme.textDark,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // رأس الملف الشخصي
                _buildProfileHeader(currentUser),

                // معلومات المستخدم
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الإحصائيات
                      _buildStatistics(currentUser),
                      const SizedBox(height: 24),

                      // الإعلانات
                      Text(
                        'الإعلانات (${userListings.length})',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (userListings.isEmpty)
                        Center(
                          child: Text(
                            'لا توجد إعلانات',
                            style: GoogleFonts.cairo(
                              color: AppTheme.textGrey,
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userListings.length,
                          itemBuilder: (context, index) {
                            final listing = userListings[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/listing/${listing.id}');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppTheme.divider),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppTheme.background,
                                      ),
                                      child: Image.network(
                                        listing.images.first,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listing.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.cairo(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${listing.price} ر.س',
                                            style: GoogleFonts.cairo(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.primaryRed,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      const SizedBox(height: 24),

                      // أزرار الإجراءات
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/chat/conv_001');
                          },
                          icon: const Icon(Icons.message),
                          label: Text(
                            'إرسال رسالة',
                            style: GoogleFonts.cairo(),
                          ),
                        ),
                      ),
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

  Widget _buildProfileHeader(dynamic user) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primaryRed,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppTheme.divider, width: 3),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            user.fullName,
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${user.rating}',
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (user.isVerified)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'موثق',
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            user.location.city,
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: AppTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(dynamic user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('المبيعات', user.totalSales.toString()),
        _buildStatItem('التقييم', user.rating.toString()),
        _buildStatItem(
            'عضو منذ', '${DateTime.now().year - user.memberSince.year}'),
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
}
