// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:grabai/core/widgets/shimmer_box.dart';

class ShimmerFineCard extends StatelessWidget {
  const ShimmerFineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: const [
          ShimmerBox(width: 60, height: 60),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 160, height: 14),
                SizedBox(height: 6),
                Row(
                  children: [
                    ShimmerBox(width: 80, height: 12),
                    SizedBox(width: 10),
                    ShimmerBox(width: 60, height: 12),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          ShimmerBox(width: 60, height: 24, borderRadius: BorderRadius.all(Radius.circular(20))),
        ],
      ),
    );
  }
}
