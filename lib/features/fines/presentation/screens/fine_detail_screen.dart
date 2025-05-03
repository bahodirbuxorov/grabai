import 'package:flutter/material.dart';
import 'package:grabai/core/theme/app_colors.dart';
import 'package:grabai/core/theme/text_styles.dart';
import 'package:grabai/core/services/person_service.dart';
import 'package:grabai/features/fines/presentation/widgets/fine_detail_header.dart';
import 'package:grabai/features/fines/presentation/widgets/fine_detail_info_block.dart';
import 'package:grabai/features/fines/presentation/widgets/fine_detail_info_shimmer.dart';
import 'package:grabai/core/widgets/custom_app_bar.dart'; // ✅ Custom App Bar import

class FineDetailScreen extends StatefulWidget {
  final String frameImgUrl;
  final String date;
  final String time;
  final String location;
  final bool isPaid;
  final int personId;

  const FineDetailScreen({
    super.key,
    required this.frameImgUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.isPaid,
    required this.personId,
  });

  @override
  State<FineDetailScreen> createState() => _FineDetailScreenState();
}

class _FineDetailScreenState extends State<FineDetailScreen> {
  String personName = '-';
  String gender = '-';
  int age = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPerson();
  }

  Future<void> _fetchPerson() async {
    final data = await PersonService().getPersonById(widget.personId);
    if (data != null) {
      setState(() {
        personName = data['name'] ?? '-';
        gender = data['gender'] ?? '-';
        age = data['age'] ?? 0;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusText = widget.isPaid ? 'PAID' : 'UNPAID';
    final statusColor = widget.isPaid ? AppColors.success : AppColors.error;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fine Details',
        centerTitle: true,
        actions: const [],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: const Color(0xFFF4F6FA),
      body: isLoading
          ? const ShimmerFineDetail()
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FineDetailHeader(
            imageUrl: widget.frameImgUrl,
            statusText: statusText,
            statusColor: statusColor,
          ),
          const SizedBox(height: 20),
          _fineAmountBox(),
          FineDetailInfoBlock(
            date: widget.date,
            time: widget.time,
            location: widget.location,
            cameraId: '#CAM-2025-03',
            personName: personName,
            genderAge: '$gender / $age',
            statusText: statusText,
            statusColor: statusColor,
            isPaid: widget.isPaid,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: widget.isPaid ? null : () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isPaid ? Colors.grey : AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            widget.isPaid ? 'Already Paid' : 'Pay Fine Now',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _fineAmountBox() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          const Text('Fine Amount', style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Text(
            widget.isPaid ? '0 UZS' : '375,000 UZS',
            style: AppTextStyles.heading1.copyWith(
              color: widget.isPaid ? Colors.grey : AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
