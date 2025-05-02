// screen: add_user_screen.dart
import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:grabai/features/add_data/presentation/widgets/user_form.dart';
import 'package:grabai/features/add_data/presentation/widgets/user_list.dart';


class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Add New User'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            UserForm(),
            SizedBox(height: 40),
            Text('Recently Added Users', style: AppTextStyles.heading2),
            SizedBox(height: 16),
            UserList(),
          ],
        ),
      ),
    );
  }
}
