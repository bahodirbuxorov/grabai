import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';

class StatPercentageIndicator extends StatelessWidget {
  final String title;
  final double percentage; // 0.0 to 1.0
  final Color color;

  const StatPercentageIndicator({
    super.key,
    required this.title,
    required this.percentage,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final percentText = '${(percentage * 100).toStringAsFixed(1)}%';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(15, 0, 0, 0),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage.clamp(0.0, 1.0),
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(percentText, style: AppTextStyles.caption),
          ),
        ],
      ),
    );
  }
}
