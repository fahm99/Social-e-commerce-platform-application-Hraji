import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/listings_provider.dart';

class FilterSortScreen extends StatefulWidget {
  const FilterSortScreen({super.key});

  @override
  State<FilterSortScreen> createState() => _FilterSortScreenState();
}

class _FilterSortScreenState extends State<FilterSortScreen> {
  late RangeValues _priceRange;
  String _selectedCategory = 'الكل';
  String _selectedCondition = 'الكل';
  String _selectedSort = 'الأحدث';

  final List<String> categories = [
    'الكل',
    'سيارات',
    'سكن',
    'أجهزة',
    'أثاث',
    'حيوانات وطيور'
  ];

  final List<String> conditions = ['الكل', 'جديد', 'مستعمل'];

  final List<String> sortOptions = [
    'الأحدث',
    'الأقدم',
    'السعر: من الأقل للأعلى',
    'السعر: من الأعلى للأقل',
    'الأكثر مشاهدة',
  ];

  @override
  void initState() {
    super.initState();
    _priceRange = const RangeValues(0, 1000000);
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
          'الفلترة والفرز',
          style: GoogleFonts.cairo(
            color: AppTheme.textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الفرز
              _buildSectionHeader('الفرز'),
              const SizedBox(height: 12),
              _buildSortOptions(),
              const SizedBox(height: 24),

              // الفئة
              _buildSectionHeader('الفئة'),
              const SizedBox(height: 12),
              _buildCategoryFilter(),
              const SizedBox(height: 24),

              // الحالة
              _buildSectionHeader('الحالة'),
              const SizedBox(height: 12),
              _buildConditionFilter(),
              const SizedBox(height: 24),

              // نطاق السعر
              _buildSectionHeader('نطاق السعر'),
              const SizedBox(height: 12),
              _buildPriceRangeSlider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'من: ${_priceRange.start.toStringAsFixed(0)} ر.س',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Text(
                    'إلى: ${_priceRange.end.toStringAsFixed(0)} ر.س',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // أزرار الإجراءات
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryRed,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'تطبيق الفلاتر',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetFilters,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: AppTheme.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'إعادة تعيين',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.textDark,
      ),
    );
  }

  Widget _buildSortOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        children: sortOptions.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;

          return Column(
            children: [
              ListTile(
                title: Text(
                  option,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
                trailing: Radio<String>(
                  value: option,
                  groupValue: _selectedSort,
                  onChanged: (value) {
                    setState(() => _selectedSort = value ?? 'الأحدث');
                  },
                  activeColor: AppTheme.primaryRed,
                ),
                onTap: () {
                  setState(() => _selectedSort = option);
                },
              ),
              if (index < sortOptions.length - 1)
                const Divider(height: 1, indent: 16, endIndent: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) {
        final isSelected = _selectedCategory == category;
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() => _selectedCategory = category);
          },
          backgroundColor: Colors.white,
          selectedColor: AppTheme.primaryRed,
          labelStyle: GoogleFonts.cairo(
            color: isSelected ? Colors.white : AppTheme.textDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(
            color: isSelected ? AppTheme.primaryRed : AppTheme.divider,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConditionFilter() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: conditions.map((condition) {
        final isSelected = _selectedCondition == condition;
        return FilterChip(
          label: Text(condition),
          selected: isSelected,
          onSelected: (selected) {
            setState(() => _selectedCondition = condition);
          },
          backgroundColor: Colors.white,
          selectedColor: AppTheme.primaryRed,
          labelStyle: GoogleFonts.cairo(
            color: isSelected ? Colors.white : AppTheme.textDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          side: BorderSide(
            color: isSelected ? AppTheme.primaryRed : AppTheme.divider,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceRangeSlider() {
    return RangeSlider(
      values: _priceRange,
      min: 0,
      max: 1000000,
      divisions: 100,
      activeColor: AppTheme.primaryRed,
      inactiveColor: AppTheme.divider,
      onChanged: (RangeValues values) {
        setState(() => _priceRange = values);
      },
    );
  }

  void _applyFilters() {
    final provider = Provider.of<ListingsProvider>(context, listen: false);

    // تطبيق الفلاتر
    if (_selectedCategory != 'الكل') {
      provider.filterByCategory(_selectedCategory);
    }

    if (_selectedCondition != 'الكل') {
      provider.filterByCondition(_selectedCondition);
    }

    provider.filterByPriceRange(_priceRange.start, _priceRange.end);

    // تطبيق الفرز
    _applySorting(provider);

    Navigator.pop(context);
  }

  void _applySorting(ListingsProvider provider) {
    final listings = provider.listings;

    switch (_selectedSort) {
      case 'الأحدث':
        listings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'الأقدم':
        listings.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'السعر: من الأقل للأعلى':
        listings.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'السعر: من الأعلى للأقل':
        listings.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'الأكثر مشاهدة':
        listings.sort((a, b) => b.views.compareTo(a.views));
        break;
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = 'الكل';
      _selectedCondition = 'الكل';
      _selectedSort = 'الأحدث';
      _priceRange = const RangeValues(0, 1000000);
    });

    final provider = Provider.of<ListingsProvider>(context, listen: false);
    provider.clearFilters();
  }
}
