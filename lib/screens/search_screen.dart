import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/listings_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  double _minPrice = 0;
  double _maxPrice = 1000000;
  String _selectedCondition = 'الكل';

  @override
  void dispose() {
    _searchController.dispose();
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
        title: Text(
          'البحث',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // حقل البحث
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  Provider.of<ListingsProvider>(context, listen: false)
                      .searchListings(value);
                },
                decoration: InputDecoration(
                  hintText: 'ابحث عن منتج...',
                  hintStyle: const TextStyle(color: AppTheme.textLight),
                  prefixIcon:
                      const Icon(Icons.search, color: AppTheme.textLight),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            Provider.of<ListingsProvider>(context,
                                    listen: false)
                                .clearFilters();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.divider),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppTheme.divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppTheme.primaryRed,
                    ),
                  ),
                ),
              ),
            ),

            // الفلاتر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الفلاتر',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // نطاق السعر
                  Text(
                    'نطاق السعر',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'من',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _minPrice = double.parse(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'إلى',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _maxPrice = double.parse(value);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // الحالة
                  Text(
                    'الحالة',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['الكل', 'جديد', 'مستعمل'].map((condition) {
                      final isSelected = _selectedCondition == condition;
                      return FilterChip(
                        label: Text(condition),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedCondition = condition);
                          if (condition != 'الكل') {
                            Provider.of<ListingsProvider>(context,
                                    listen: false)
                                .filterByCondition(condition);
                          }
                        },
                        backgroundColor: Colors.white,
                        selectedColor: AppTheme.primaryRed,
                        labelStyle: GoogleFonts.cairo(
                          color: isSelected ? Colors.white : AppTheme.textDark,
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // زر البحث
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<ListingsProvider>(context, listen: false)
                            .filterByPriceRange(_minPrice, _maxPrice);
                      },
                      child: Text(
                        'بحث',
                        style: GoogleFonts.cairo(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // النتائج
            Consumer<ListingsProvider>(
              builder: (context, listingsProvider, child) {
                final results = listingsProvider.listings;

                if (results.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'لا توجد نتائج',
                        style: GoogleFonts.cairo(
                          color: AppTheme.textGrey,
                        ),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'النتائج (${results.length})',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final listing = results[index];
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
                                        const SizedBox(height: 4),
                                        Text(
                                          listing.location.city,
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
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
