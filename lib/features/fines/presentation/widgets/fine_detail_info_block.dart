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
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.body.copyWith(color: valueColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
