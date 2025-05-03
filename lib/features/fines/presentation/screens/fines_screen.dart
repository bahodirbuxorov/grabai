// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:grabai/core/services/detection_service.dart';
import 'package:grabai/core/services/person_service.dart';
import 'package:grabai/features/fines/presentation/widgets/fine_card.dart';
import 'package:grabai/features/fines/presentation/widgets/shimmer_fine_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_overview_card.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class FinesScreen extends StatefulWidget {
  const FinesScreen({super.key});

  @override
  State<FinesScreen> createState() => _FinesScreenState();
}

class _FinesScreenState extends State<FinesScreen> {
  bool isLoading = true;
  int selectedFilter = 0;
  bool sortByDate = true;

  List<Map<String, dynamic>> fines = [];
  int totalFines = 0;
  int unpaidFines = 0;

  @override
  void initState() {
    super.initState();
    _fetchFines();
  }

  Future<void> _fetchFines() async {
    setState(() => isLoading = true);
    try {
      final data = await DetectionService().getDetections();
      final List<Map<String, dynamic>> enrichedFines = [];

      for (final detection in data) {
        final personId = detection['person_id'];
        final person = await PersonService().getPersonById(personId);
        final name = person?['name'] ?? 'Unknown';

        enrichedFines.add({
          'imageUrl': 'http://10.30.11.44:1111/${detection['crop_img']}',
          'frameImgUrl': 'http://10.30.11.44:1111/${detection['frame_img']}',
          'date': detection['datetime_att'].toString().substring(0, 10),
          'time': detection['datetime_att'].toString().substring(11, 16),
          'location': name,
          'personId': personId,
          'isPaid': false,
        });
      }

      setState(() {
        fines = enrichedFines;
        totalFines = fines.length;
        unpaidFines = fines.where((f) => f['isPaid'] == false).length;
      });
    } catch (e) {
      debugPrint('Error fetching fines: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  List<Map<String, dynamic>> _getFilteredSortedFines() {
    List<Map<String, dynamic>> filtered = fines.where((fine) {
      if (selectedFilter == 1) return fine['isPaid'] == true;
      if (selectedFilter == 2) return fine['isPaid'] == false;
      return true;
    }).toList();

    filtered.sort((a, b) {
      if (sortByDate) {
        return a['date'].compareTo(b['date']);
      } else {
        return a['isPaid'] == b['isPaid'] ? 0 : (a['isPaid'] ? 1 : -1);
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Detected Fines'),
      backgroundColor: const Color(0xFFF3F6FC),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchFines,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildStatsOverview(),
              const SizedBox(height: 24),
              _buildFilterChips(),
              const SizedBox(height: 16),
              _buildSortToggle(),
              const SizedBox(height: 16),
              _buildFinesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    return Row(
      children: [
        Expanded(
          child: StatOverviewCard(
            title: 'Total',
            value: '$totalFines',
            icon: IconlyBold.document,
            backgroundColor: const Color(0xFFE3F2FD),
            iconColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatOverviewCard(
            title: 'Unpaid',
            value: '$unpaidFines',
            icon: IconlyBold.close_square,
            backgroundColor: const Color(0xFFFFEBEE),
            iconColor: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    final labels = ['All', 'Paid', 'Unpaid'];
    return Wrap(
      spacing: 10,
      children: List.generate(labels.length, (index) {
        return ChoiceChip(
          label: Text(labels[index]),
          selected: selectedFilter == index,
          selectedColor: AppColors.primary.withOpacity(0.2),
          backgroundColor: Colors.grey.shade100,
          labelStyle: TextStyle(
            color: selectedFilter == index ? AppColors.primary : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          onSelected: (_) => setState(() => selectedFilter = index),
        );
      }),
    );
  }

  Widget _buildSortToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Violation Records', style: AppTextStyles.heading2),
        TextButton.icon(
          onPressed: () => setState(() => sortByDate = !sortByDate),
          icon: Icon(sortByDate ? Icons.calendar_month : Icons.sort, size: 20),
          label: Text(sortByDate ? 'Sort by Date' : 'Sort by Status'),
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildFinesList() {
    if (isLoading) {
      return Column(
        children: List.generate(4, (_) => const ShimmerFineCard()),
      );
    }

    if (fines.isEmpty) {
      return Column(
        children: [

          Text('No fines detected', style: AppTextStyles.heading2),
          const SizedBox(height: 6),
          Text('Great job! Keep your record clean.', style: AppTextStyles.caption),
        ],
      );
    }

    return Column(
      children: _getFilteredSortedFines().map((fine) {
        return FineCard(
          imageUrl: fine['imageUrl'],
          frameImgUrl: fine['frameImgUrl'],
          date: fine['date'],
          time: fine['time'],
          location: fine['location'],
          isPaid: fine['isPaid'],
          personId: fine['personId'],
        );
      }).toList(),
    );
  }
}
