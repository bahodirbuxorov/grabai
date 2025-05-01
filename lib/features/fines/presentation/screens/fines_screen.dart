import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:grabai/features/fines/presentation/widgets/fine_card.dart';
import 'package:grabai/features/fines/presentation/widgets/shimmer_fine_card.dart';
import 'package:grabai/features/stats/presentation/widgets/stat_overview_card.dart';
import 'package:iconly/iconly.dart';
import 'package:grabai/features/stats/presentation/widgets/shimmer_stat_card.dart';
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

  @override
  void initState() {
    super.initState();
    _loadFines();
  }

  Future<void> _loadFines() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      fines = List.generate(5, (index) => {
        'imageUrl': 'https://picsum.photos/id/${index + 10}/200/200',
        'date': '2025-05-0${index + 1}',
        'time': '14:${index}0',
        'location': 'Buxoro, Street ${index + 1}',
        'isPaid': index % 2 == 0,
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadFines,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              // Header
              Row(
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
                    backgroundImage: AssetImage('assets/images/user.jpg'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Stats summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: StatOverviewCard(
                      title: 'Total',
                      value: '124',
                      icon: IconlyBold.document,
                      backgroundColor: Color(0xFFE0F7FA),
                      iconColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: StatOverviewCard(
                      title: 'Unpaid',
                      value: '26',
                      icon: IconlyBold.close_square,
                      backgroundColor: Color(0xFFFFEBEE),
                      iconColor: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Filter chips
              Wrap(
                spacing: 8,
                children: List.generate(3, (index) {
                  final labels = ['All', 'Paid', 'Unpaid'];
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
              ),

              const SizedBox(height: 20),

              // Sort toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Fines', style: AppTextStyles.heading2),
                  TextButton.icon(
                    onPressed: () => setState(() => sortByDate = !sortByDate),
                    icon: Icon(sortByDate ? Icons.date_range : Icons.sort_by_alpha),
                    label: Text(sortByDate ? 'Sort by Date' : 'Sort by Status'),
                  ),
                ],
              ),

              // Fines List
              if (isLoading)
                Column(
                  children: List.generate(5, (index) => const ShimmerFineCard()),
                )
              else if (fines.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/empty.png', height: 160),
                    const SizedBox(height: 20),
                    Text('No fines yet 🎉', style: AppTextStyles.heading2),
                    const SizedBox(height: 6),
                    Text('You are clean! Keep it up.', style: AppTextStyles.caption),
                  ],
                )
              else
                Column(
                  children: _getSortedAndFilteredFines().map((fine) => FineCard(
                    imageUrl: fine['imageUrl'],
                    date: fine['date'],
                    time: fine['time'],
                    location: fine['location'],
                    isPaid: fine['isPaid'],
                  )).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSortedAndFilteredFines() {
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
}

