import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/listings_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_drawer.dart';
import 'filter_sort_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> categories = [
    'الرئيسية',
    'سيارات',
    'سكن',
    'أجهزة',
    'حيوانات وطيور'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.background,
      appBar: CustomAppBar(
        onDrawerTap: () {
          // فتح الـ Drawer باستخدام GlobalKey
          _scaffoldKey.currentState?.openDrawer();
        },
        onFilterTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FilterSortScreen(),
            ),
          );
        },
      ),
      drawer: const CustomDrawer(),
      body: Consumer<ListingsProvider>(
        builder: (context, listingsProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories Tabs
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedCategory == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedCategory = index);
                          if (index == 0) {
                            listingsProvider.clearFilters();
                          } else {
                            listingsProvider
                                .filterByCategory(categories[index]);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryRed
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? null
                                  : Border.all(color: AppTheme.divider),
                            ),
                            child: Center(
                              child: Text(
                                categories[index],
                                style: GoogleFonts.cairo(
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Products List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listingsProvider.listings.length,
                    itemBuilder: (context, index) {
                      final listing = listingsProvider.listings[index];
                      return ProductCard(
                        listing: listing,
                        index: index,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
