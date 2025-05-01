import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:iconly/iconly.dart';

class FineDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String time;
  final String location;
  final bool isPaid;

  const FineDetailScreen({
    super.key,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    final statusText = isPaid ? 'PAID' : 'UNPAID';
    final statusColor = isPaid ? AppColors.success : AppColors.error;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text('Fine Details'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🖼 Image + status badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(IconlyBold.image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                bottom: -12,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 💰 Amount
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                const Text('Fine Amount', style: AppTextStyles.caption),
                const SizedBox(height: 8),
                Text(
                  isPaid ? '0 UZS' : '210,000 UZS',
                  style: AppTextStyles.heading1.copyWith(
                    color: isPaid ? Colors.grey : AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 📋 Detail block
          _infoSection([
            _infoTile(IconlyLight.calendar, 'Date', date),
            _infoTile(IconlyLight.time_circle, 'Time', time),
            _infoTile(IconlyLight.location, 'Location', location),
            _infoTile(IconlyLight.document, 'Camera ID', '#CAM-2025-03'),
            _infoTile(IconlyLight.profile, 'Officer', 'Inspector Davronov'),
            _infoTile(
              isPaid ? IconlyBold.tick_square : IconlyBold.close_square,
              'Status',
              statusText,
              valueColor: statusColor,
            ),
          ]),
        ],
      ),

      // 🔘 Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isPaid ? Colors.grey.shade400 : AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: isPaid ? null : () {}, // TODO: implement payment
          child: Text(
            isPaid ? 'Already Paid' : 'Pay Fine Now',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _infoSection(List<Widget> children) {
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
      child: Column(children: children),
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
