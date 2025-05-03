import 'package:flutter/material.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:iconly/iconly.dart';

class FineDetailInfoBlock extends StatelessWidget {
  final String date, time, location, cameraId, personName, genderAge, statusText;
  final Color statusColor;
  final bool isPaid;

  const FineDetailInfoBlock({
    super.key,
    required this.date,
    required this.time,
    required this.location,
    required this.cameraId,
    required this.personName,
    required this.genderAge,
    required this.statusText,
    required this.statusColor,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB), // Light gray tone
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          _infoTile(IconlyLight.calendar, 'Date', date),
          _infoTile(IconlyLight.time_circle, 'Time', time),
          _infoTile(IconlyLight.location, 'Location', location),
          _infoTile(IconlyLight.document, 'Camera ID', cameraId),
          _infoTile(IconlyLight.profile, 'Person', personName),
          _infoTile(IconlyLight.profile, 'Gender / Age', genderAge),
          _infoTile(
            isPaid ? IconlyBold.tick_square : IconlyBold.close_square,
            'Status',
            statusText,
            valueColor: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value, {Color? valueColor}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: Colors.grey[700]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyles.body.copyWith(
                      color: valueColor ?? Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Divider(height: 1, thickness: 0.7, color: Colors.grey.shade300),
        const SizedBox(height: 8),
      ],
    );
  }
}
