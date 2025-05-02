import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:grabai/core/services/detection_service.dart';
import 'package:grabai/core/services/person_service.dart';
import 'package:grabai/features/fines/presentation/widgets/fine_card.dart';
import 'package:grabai/features/fines/presentation/widgets/shimmer_fine_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_overview_card.dart';

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
          'date': detection['datetime_att'].toString().substring(0, 10),
          'time': detection['datetime_att'].toString().substring(11, 16),
          'location': name,
          'personId': personId,
          'isPaid': false, // You can replace this with real API value if available
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
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchFines,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildStatsOverview(),
              const SizedBox(height: 20),
              _buildFilterChips(),
              const SizedBox(height: 20),
              _buildSortToggle(),
              const SizedBox(height: 10),
              _buildFinesList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: AppTextStyles.caption),
            const SizedBox(height: 4),
            Text('User 👋', style: AppTextStyles.heading2),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/grab_ai_logo.png'),
        ),
      ],
    );
  }

  Widget _buildStatsOverview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: StatOverviewCard(
            title: 'Total',
            value: '$totalFines',
            icon: IconlyBold.document,
            backgroundColor: const Color(0xFFE0F7FA),
            iconColor: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
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
      spacing: 8,
      children: List.generate(labels.length, (index) {
        return ChoiceChip(
          label: Text(labels[index]),
          selected: selectedFilter == index,
          selectedColor: AppColors.primary.withOpacity(0.15),
          backgroundColor: Colors.grey.shade100,
          labelStyle: TextStyle(
            color: selectedFilter == index ? AppColors.primary : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onSelected: (_) => setState(() => selectedFilter = index),
        );
      }),
    );
  }

  Widget _buildSortToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fines', style: AppTextStyles.heading2),
        TextButton.icon(
          onPressed: () => setState(() => sortByDate = !sortByDate),
          icon: Icon(sortByDate ? Icons.date_range : Icons.sort_by_alpha),
          label: Text(sortByDate ? 'Sort by Date' : 'Sort by Status'),
        ),
      ],
    );
  }

  Widget _buildFinesList() {
    if (isLoading) {
      return Column(
        children: List.generate(5, (index) => const ShimmerFineCard()),
      );
    }

    if (fines.isEmpty) {
      return Column(
        children: [
          Image.asset('assets/images/empty.png', height: 160),
          const SizedBox(height: 20),
          Text('No fines yet 🎉', style: AppTextStyles.heading2),
          const SizedBox(height: 6),
          Text('You are clean! Keep it up.', style: AppTextStyles.caption),
        ],
      );
    }

    return Column(
      children: _getFilteredSortedFines().map((fine) {
        return FineCard(
          imageUrl: fine['imageUrl'],
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
