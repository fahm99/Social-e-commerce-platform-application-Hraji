import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'الإعدادات',
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
            // إعدادات الحساب
            _buildSectionHeader('حسابي'),
            _buildSettingsTile(
              icon: Icons.person,
              title: 'تعديل الملف الشخصي',
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
            ),
            _buildSettingsTile(
              icon: Icons.lock,
              title: 'تغيير كلمة المرور',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.email,
              title: 'تغيير البريد الإلكتروني',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),

            // إعدادات الإشعارات
            _buildSectionHeader('الإشعارات'),
            _buildSwitchTile(
              icon: Icons.notifications,
              title: 'تفعيل الإشعارات',
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
            if (_notificationsEnabled) ...[
              _buildSwitchTile(
                icon: Icons.mail,
                title: 'إشعارات البريد الإلكتروني',
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() => _emailNotifications = value);
                },
              ),
              _buildSwitchTile(
                icon: Icons.notifications_active,
                title: 'إشعارات الدفع',
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() => _pushNotifications = value);
                },
              ),
            ],

            // إعدادات الخصوصية
            _buildSectionHeader('الخصوصية والأمان'),
            _buildSettingsTile(
              icon: Icons.privacy_tip,
              title: 'سياسة الخصوصية',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.description,
              title: 'شروط الخدمة',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.security,
              title: 'الأمان',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),

            // معلومات التطبيق
            _buildSectionHeader('حول التطبيق'),
            _buildSettingsTile(
              icon: Icons.info,
              title: 'عن التطبيق',
              subtitle: 'الإصدار 1.0.0',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),
            _buildSettingsTile(
              icon: Icons.help,
              title: 'المساعدة والدعم',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('سيتم تطوير هذه الميزة قريباً')),
                );
              },
            ),

            // تسجيل الخروج
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(
                    'تسجيل الخروج',
                    style: GoogleFonts.cairo(),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.1),
                    foregroundColor: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryRed,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryRed),
        title: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: AppTheme.textLight,
                ),
              )
            : null,
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: AppTheme.textLight),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.divider),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryRed),
        title: Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textDark,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primaryRed,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تسجيل الخروج',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          style: GoogleFonts.cairo(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: GoogleFonts.cairo(color: AppTheme.textGrey),
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Text(
              'تسجيل الخروج',
              style: GoogleFonts.cairo(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
