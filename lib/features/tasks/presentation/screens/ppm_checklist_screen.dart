import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../core/theme/app_colors.dart';

class PPMChecklistScreen extends StatefulWidget {
  final String assetName;
  const PPMChecklistScreen({super.key, required this.assetName});

  @override
  State<PPMChecklistScreen> createState() => _PPMChecklistScreenState();
}

class _PPMChecklistScreenState extends State<PPMChecklistScreen> {
  final List<ChecklistItem> _items = [
    ChecklistItem(title: "Check Power Supply Connection", status: null),
    ChecklistItem(title: "Inspect for unusual noise/vibration", status: null),
    ChecklistItem(title: "Clean external surfaces", status: null),
    ChecklistItem(title: "Check oil levels and top up if needed", status: null),
    ChecklistItem(title: "Verify safety sensors functionality", status: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PPM Checklist"),
      ),
      body: Column(
        children: [
          _buildAssetInfo(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _buildChecklistItem(_items[index]),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildAssetInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: AppColors.primary.withAlpha(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.assetName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text(
            "Task ID: PPM-2026-4402",
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(ChecklistItem item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildStatusButton(item, "PASS", AppColors.success, true),
                const SizedBox(width: 12),
                _buildStatusButton(item, "FAIL", AppColors.danger, false),
                const Spacer(),
                IconButton(
                  icon: const Icon(Remix.camera_line, color: AppColors.textSecondary),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Remix.chat_2_line, color: AppColors.textSecondary),
                  onPressed: () => _showNotesDialog(item),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(ChecklistItem item, String label, Color color, bool status) {
    final bool isSelected = item.status == status;
    return InkWell(
      onTap: () => setState(() => item.status = status),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          border: Border.all(color: isSelected ? color : AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Save Draft"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showSuccessDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Submit Report"),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotesDialog(ChecklistItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Notes"),
        content: TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Enter inspection notes here...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Save")),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Remix.checkbox_circle_fill, color: AppColors.success, size: 64),
            const SizedBox(height: 16),
            const Text(
              "Report Submitted",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Maintenance report has been synced successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to task list
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Done"),
            ),
          ],
        ),
      ),
    );
  }
}

class ChecklistItem {
  final String title;
  bool? status; // true = PASS, false = FAIL, null = UNCHECKED
  String? notes;
  String? imagePath;

  ChecklistItem({required this.title, this.status, this.notes, this.imagePath});
}
