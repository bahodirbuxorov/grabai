import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grabai/core/theme/text_styles.dart';

class StatGraphCard extends StatelessWidget {
  final List<double> data;
  final List<String> labels;

  const StatGraphCard({
    super.key,
    required this.data,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(15, 0, 0, 0),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Weekly Fine Trend', style: AppTextStyles.heading2),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.6,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        if (index < labels.length) {
                          return Text(labels[index], style: AppTextStyles.caption);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: data
                    .asMap()
                    .entries
                    .map(
                      (entry) => BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(toY: entry.value, width: 18),
                    ],
                  ),
                )
                    .toList(),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
