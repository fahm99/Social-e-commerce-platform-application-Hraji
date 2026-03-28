import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onDrawerTap;
  final VoidCallback? onFilterTap;

  const CustomAppBar({
    super.key,
    required this.onDrawerTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: GestureDetector(
          onTap: onDrawerTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppTheme.divider, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.menu, color: AppTheme.textDark, size: 20),
          ),
        ),
      ),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.divider, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'ابحث...',
                  hintStyle: const TextStyle(
                    color: AppTheme.textLight,
                    fontSize: 13,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(Icons.search, color: AppTheme.textGrey, size: 18),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryRed,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.apps, color: Colors.white, size: 18),
              onPressed: onFilterTap,
              padding: EdgeInsets.zero,
              iconSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
