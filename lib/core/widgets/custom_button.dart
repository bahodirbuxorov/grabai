import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isFilled;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFilled = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(label, style: AppTextStyles.body),
      style: ElevatedButton.styleFrom(
        backgroundColor: isFilled ? AppColors.primary : AppColors.white,
        foregroundColor: isFilled ? AppColors.white : AppColors.primary,
        side: isFilled
            ? null
            : BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      onPressed: onPressed,
    );
  }
}
