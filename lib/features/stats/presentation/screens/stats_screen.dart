import 'package:flutter/material.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_overview_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_graph_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_percentage_indicator.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_trend_indicator.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // 💡 Overview Cards
          const StatOverviewCard(
            title: 'Total Fines',
            value: '124',
            icon: Icons.receipt_long_rounded,
          ),
          const StatOverviewCard(
            title: 'Paid Fines',
            value: '98',
            icon: Icons.check_circle_outline,
            backgroundColor: Color(0xFFEAFBF2),
            iconColor: Colors.green,
          ),
          const StatOverviewCard(
            title: 'Unpaid Fines',
            value: '26',
            icon: Icons.cancel_outlined,
            backgroundColor: Color(0xFFFDECEA),
            iconColor: Colors.red,
          ),

          // 📊 Weekly Graph
          const StatGraphCard(
            data: [2, 5, 4, 7, 3, 6, 2],
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          ),

          // 📈 Trend and Progress
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: const StatTrendIndicator(
              changePercent: 0.18,
              description: 'compared to last week',
            ),
          ),

          const StatPercentageIndicator(
            title: 'Fines Paid',
            percentage: 0.79,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
