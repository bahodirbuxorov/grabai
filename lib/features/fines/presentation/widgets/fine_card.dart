import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:iconly/iconly.dart';

class FineCard extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String time;
  final String location;
  final bool isPaid;
  final int personId;

  const FineCard({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.personId,
    this.isPaid = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/fine-detail',
          arguments: {
            'imageUrl': imageUrl,
            'date': date,
            'time': time,
            'location': location,
            'isPaid': isPaid,
            'personId': personId,
          },
        );

      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(20, 0, 0, 0),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  IconlyBold.image,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(location, style: AppTextStyles.heading2),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(IconlyLight.calendar, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(date, style: AppTextStyles.caption),
                      const SizedBox(width: 10),
                      Icon(IconlyLight.time_circle, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(time, style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isPaid
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    isPaid ? IconlyBold.tick_square : IconlyBold.close_square,
                    size: 16,
                    color: isPaid ? AppColors.success : AppColors.error,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isPaid ? 'Paid' : 'Unpaid',
                    style: TextStyle(
                      color: isPaid ? AppColors.success : AppColors.error,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
