import 'package:flutter/material.dart';
import 'package:grabai/features/add_data/presentation/screens/add_user_screen.dart';

import 'package:grabai/features/fines/presentation/screens/fines_screen.dart';
import 'package:grabai/features/stats/presentation/screens/stats_screen.dart';
import 'package:grabai/core/widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    FinesScreen(),
    StatsScreen(),
    AddUserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
