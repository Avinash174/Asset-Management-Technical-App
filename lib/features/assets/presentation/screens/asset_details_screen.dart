import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../core/theme/app_colors.dart';

class AssetDetailsScreen extends StatelessWidget {
  final String assetName;
  const AssetDetailsScreen({super.key, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusBadge(),
                  const SizedBox(height: 16),
                  _buildMainInfo(),
                  const SizedBox(height: 24),
                  _buildSpecificationGrid(),
                  const SizedBox(height: 24),
                  const Text(
                    "Recent History",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildHistoryList(),
                  const SizedBox(height: 100), // Space for bottom actions
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomActions(context),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              "https://images.unsplash.com/photo-1581092160562-40aa08e78837?q=80&w=1000",
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withAlpha(150), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
        ),
        title: Text(assetName, style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.success.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Remix.checkbox_circle_fill, color: AppColors.success, size: 14),
          SizedBox(width: 4),
          Text(
            "ACTIVE",
            style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Centrifugal Pump CP-04",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text(
          "HVAC System | Cooling Tower A",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Remix.map_pin_2_line, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            const Text("Basement 1, Pump Room 2", style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecificationGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.border.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: [
          _buildSpecItem("Manufacturer", "Grundfos"),
          _buildSpecItem("Model", "CR 32-2-2"),
          _buildSpecItem("Serial No.", "GF-8849-X0"),
          _buildSpecItem("Install Date", "12 Jan 2024"),
          _buildSpecItem("Warranty", "Ends 2026"),
          _buildSpecItem("Capacity", "32 m³/h"),
        ],
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildHistoryList() {
    return Column(
      children: [
        _buildHistoryItem("Monthly PPM", "Completed by Avinash M.", "24 Sep 2026", Remix.tools_line, AppColors.success),
        _buildHistoryItem("Seal Replacement", "Breakdown Repair", "15 Aug 2026", Remix.error_warning_line, AppColors.danger),
        _buildHistoryItem("Quarterly Audit", "Passed with A+", "12 Jun 2026", Remix.shield_check_line, AppColors.info),
      ],
    );
  }

  Widget _buildHistoryItem(String title, String subtitle, String date, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withAlpha(20), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: const Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Remix.tools_line),
              label: const Text("Perform PPM"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.danger.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Remix.error_warning_line, color: AppColors.danger),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
