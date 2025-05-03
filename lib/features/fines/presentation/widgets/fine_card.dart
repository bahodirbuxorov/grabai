import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';

class FineCard extends StatelessWidget {
  final String imageUrl;
  final String frameImgUrl;
  final String date;
  final String time;
  final String location;
  final bool isPaid;
  final int personId;

  const FineCard({
    super.key,
    required this.imageUrl,
    required this.frameImgUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.isPaid,
    required this.personId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 📱 Dynamic sizing
    double baseFont = screenWidth < 360
        ? 11
        : screenWidth < 400
        ? 12
        : 13;
    double headingFont = baseFont + 1;
    double iconSize = baseFont + 1;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/fine-detail',
          arguments: {
            'frameImgUrl': frameImgUrl,
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
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👤 Profile image
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

            // 📄 Text and Status container
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ℹ️ Text info (name, date, time)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tooltip(
                          message: location,
                          child: Text(
                            location,
                            style: AppTextStyles.heading2.copyWith(fontSize: headingFont),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(IconlyLight.calendar, size: iconSize, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                date,
                                style: AppTextStyles.caption.copyWith(fontSize: baseFont),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(IconlyLight.time_circle, size: iconSize, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                time,
                                style: AppTextStyles.caption.copyWith(fontSize: baseFont),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // ✅ Paid / Unpaid
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPaid
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPaid ? IconlyBold.tick_square : IconlyBold.close_square,
                          size: iconSize,
                          color: isPaid ? AppColors.success : AppColors.error,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isPaid ? 'Paid' : 'Unpaid',
                          style: TextStyle(
                            color: isPaid ? AppColors.success : AppColors.error,
                            fontWeight: FontWeight.w600,
                            fontSize: baseFont,
                          ),
                        ),
                      ],
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
