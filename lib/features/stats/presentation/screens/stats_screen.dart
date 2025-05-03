import 'package:flutter/material.dart';
import 'package:grabai/core/widgets/custom_app_bar.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_overview_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_graph_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_percentage_indicator.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_trend_indicator.dart';

import '../widgets/stat_monthly_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Statistics'),
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
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
            const SizedBox(height: 16),
            const StatGraphCard(
              data: [2, 5, 4, 7, 3, 6, 2],
              labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: StatTrendIndicator(
                changePercent: 0.18,
                description: 'compared to last week',
              ),
            ),
            const StatPercentageIndicator(
              title: 'Fines Paid',
              percentage: 0.79,
              color: Colors.green,
            ),
            const SizedBox(height: 20),
            StatMonthlyLineChart(
              title: 'Monthly Fines Overview',
              data: [12, 30, 18, 40, 25, 34],
              labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            ),
          ],
        ),
      ),
    );
  }
}
