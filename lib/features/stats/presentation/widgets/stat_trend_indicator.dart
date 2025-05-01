import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';

class StatTrendIndicator extends StatelessWidget {
  final double changePercent; // e.g. +0.12 or -0.08
  final String description;

  const StatTrendIndicator({
    super.key,
    required this.changePercent,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = changePercent >= 0;
    final color = isPositive ? AppColors.success : AppColors.error;
    final icon = isPositive ? IconlyBold.arrow_up : IconlyBold.arrow_down;
    final displayPercent = '${(changePercent.abs() * 100).toStringAsFixed(1)}%';

    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          '$displayPercent ',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          description,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
