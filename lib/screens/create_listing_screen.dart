import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/listing_model.dart';
import '../providers/listings_provider.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _cityController = TextEditingController();
  final _regionController = TextEditingController();

  String _selectedCategory = 'cat_001';
  String _selectedCondition = 'جديد';
  bool _priceNegotiable = false;
  final List<String> _selectedImages = [
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&h=600&fit=crop'
  ];

  final List<Map<String, String>> categories = [
    {'id': 'cat_001', 'name': 'سيارات'},
    {'id': 'cat_002', 'name': 'سكن'},
    {'id': 'cat_003', 'name': 'أجهزة'},
    {'id': 'cat_004', 'name': 'أثاث'},
    {'id': 'cat_005', 'name': 'حيوانات وطيور'},
  ];

  final List<String> conditions = ['جديد', 'مستعمل'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _cityController.dispose();
    _regionController.dispose();
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
          'إضافة منتج جديد',
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصور
                _buildSectionHeader('الصور'),
                const SizedBox(height: 12),
                _buildImageUploadSection(),
                const SizedBox(height: 24),

                // معلومات الإعلان
                _buildSectionHeader('معلومات الإعلان'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _titleController,
                  label: 'عنوان الإعلان',
                  hint: 'أدخل عنوان الإعلان',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'العنوان مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // الوصف
                _buildTextField(
                  controller: _descriptionController,
                  label: 'الوصف',
                  hint: 'أدخل وصف تفصيلي للمنتج',
                  maxLines: 4,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'الوصف مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // الفئة
                _buildDropdownField(
                  label: 'الفئة',
                  value: _selectedCategory,
                  items: categories,
                  onChanged: (value) {
                    setState(() => _selectedCategory = value ?? 'cat_001');
                  },
                ),
                const SizedBox(height: 12),

                // الحالة
                _buildDropdownField(
                  label: 'الحالة',
                  value: _selectedCondition,
                  items: conditions.map((c) => {'id': c, 'name': c}).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCondition = value ?? 'جديد');
                  },
                ),
                const SizedBox(height: 24),

                // السعر
                _buildSectionHeader('السعر'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _priceController,
                  label: 'السعر',
                  hint: '0.00',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'السعر مطلوب';
                    }
                    if (double.tryParse(value!) == null) {
                      return 'أدخل سعر صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // السعر قابل للتفاوض
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'السعر قابل للتفاوض',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      Switch(
                        value: _priceNegotiable,
                        onChanged: (value) {
                          setState(() => _priceNegotiable = value);
                        },
                        activeColor: AppTheme.primaryRed,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // الموقع
                _buildSectionHeader('الموقع'),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _cityController,
                  label: 'المدينة',
                  hint: 'أدخل المدينة',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'المدينة مطلوبة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _regionController,
                  label: 'المنطقة',
                  hint: 'أدخل المنطقة',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'المنطقة مطلوبة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // أزرار الإجراءات
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'نشر الإعلان',
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppTheme.divider),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
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

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عرض الصور المختارة
        if (_selectedImages.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length + 1,
              itemBuilder: (context, index) {
                if (index == _selectedImages.length) {
                  // زر إضافة صورة جديدة
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: _addImage,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.primaryRed,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: const Icon(
                          Icons.add_photo_alternate,
                          color: AppTheme.primaryRed,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                }

                // عرض الصورة مع زر الحذف
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.divider),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            _selectedImages[index],
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
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        else
          GestureDetector(
            onTap: _addImage,
            child: Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryRed,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_photo_alternate,
                    color: AppTheme.primaryRed,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'اضغط لإضافة صور',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  void _addImage() {
    // قائمة الصور المتاحة للاختيار
    final availableImages = [
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&h=600&fit=crop',
      'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800&h=600&fit=crop',
      'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&h=600&fit=crop',
      'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800&h=600&fit=crop',
      'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800&h=600&fit=crop',
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اختر صورة',
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availableImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!_selectedImages
                              .contains(availableImages[index])) {
                            _selectedImages.add(availableImages[index]);
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.divider),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            availableImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: GoogleFonts.cairo(
          fontSize: 13,
          color: AppTheme.textGrey,
        ),
        hintStyle: GoogleFonts.cairo(
          fontSize: 13,
          color: AppTheme.textLight,
        ),
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
          borderSide: const BorderSide(color: AppTheme.primaryRed),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<Map<String, String>> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.cairo(
          fontSize: 13,
          color: AppTheme.textGrey,
        ),
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
          borderSide: const BorderSide(color: AppTheme.primaryRed),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: items
          .map((item) => DropdownMenuItem(
                value: item['id'],
                child: Text(
                  item['name'] ?? '',
                  style: GoogleFonts.cairo(fontSize: 13),
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newListing = ListingModel(
        id: 'lst_${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        currency: 'SAR',
        priceNegotiable: _priceNegotiable,
        categoryId: _selectedCategory,
        subcategoryId: 'sub_001',
        userId: 'usr_current',
        location: ListingLocation(
          city: _cityController.text,
          region: _regionController.text,
        ),
        images: _selectedImages,
        status: 'active',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        views: 0,
        likes: 0,
        commentsCount: 0,
        isFeatured: false,
        condition: _selectedCondition,
      );

      Provider.of<ListingsProvider>(context, listen: false)
          .createListing(newListing)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم نشر الإعلان بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      });
    }
  }
}
