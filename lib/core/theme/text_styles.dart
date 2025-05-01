import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
  );

  static const TextStyle fineStatusPaid = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.finePaidText,
  );

  static const TextStyle fineStatusUnpaid = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.fineUnpaidText,
  );
}
