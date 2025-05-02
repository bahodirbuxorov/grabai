import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:iconly/iconly.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.document),
          activeIcon: Icon(IconlyBold.document),
          label: 'Fines',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.camera),
          activeIcon: Icon(IconlyBold.camera),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.graph),
          activeIcon: Icon(IconlyBold.graph),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.setting),
          activeIcon: Icon(IconlyBold.setting),
          label: 'Settings',
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.add_user),
          activeIcon: Icon(IconlyBold.add_user),
          label: 'Add User',
        ),
      ],
    );
  }
}
