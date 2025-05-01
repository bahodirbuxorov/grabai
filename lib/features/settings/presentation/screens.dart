import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Account', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          _settingsTile(
            icon: IconlyLight.profile,
            title: 'Profile Information',
            onTap: () {},
          ),
          _settingsTile(
            icon: IconlyLight.lock,
            title: 'Change Password',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text('App', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          _settingsTile(
            icon: IconlyLight.setting,
            title: 'Preferences',
            onTap: () {},
          ),
          _settingsTile(
            icon: IconlyLight.notification,
            title: 'Notifications',
            onTap: () {},
          ),
          _settingsTile(
            icon: IconlyLight.info_square,
            title: 'About App',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            leading: const Icon(IconlyLight.logout, color: AppColors.error),
            title: const Text('Logout', style: TextStyle(color: AppColors.error)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
