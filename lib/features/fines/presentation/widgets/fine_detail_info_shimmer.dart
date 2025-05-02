import 'package:flutter/material.dart';
import 'package:grabai/core/widgets/shimmer_box.dart';

class ShimmerFineDetail extends StatelessWidget {
  const ShimmerFineDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ShimmerBox(width: double.infinity, height: 220, borderRadius: BorderRadius.circular(16)),
        const SizedBox(height: 24),
        ShimmerBox(width: double.infinity, height: 80, borderRadius: BorderRadius.circular(14)),
        const SizedBox(height: 16),
        Column(
          children: List.generate(
            6,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ShimmerBox(width: double.infinity, height: 60, borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
