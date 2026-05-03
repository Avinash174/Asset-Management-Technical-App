import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../core/theme/app_colors.dart';

class BreakdownRepairScreen extends StatefulWidget {
  final String ticketId;
  final String assetName;
  const BreakdownRepairScreen({
    super.key,
    required this.ticketId,
    required this.assetName,
  });

  @override
  State<BreakdownRepairScreen> createState() => _BreakdownRepairScreenState();
}

class _BreakdownRepairScreenState extends State<BreakdownRepairScreen> {
  final List<Map<String, dynamic>> _materials = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breakdown Repair"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIssueSummary(),
            const SizedBox(height: 24),
            const Text(
              "Repair Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTextField("Action Taken", "Describe what was done to fix the issue", 4),
            const SizedBox(height: 16),
            _buildImageUpload(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Materials Used",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () => _showAddMaterialDialog(),
                  icon: const Icon(Remix.add_line),
                  label: const Text("Add Part"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildMaterialList(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueSummary() {
    return Card(
      color: AppColors.danger.withAlpha(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.danger, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Remix.error_warning_fill, color: AppColors.danger, size: 20),
                const SizedBox(width: 8),
                Text(
                  widget.ticketId,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.danger),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.assetName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Reported Issue: Motor is overheating and making grinding noises. Tripped the main breaker.",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, int lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: lines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUpload() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.border.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          const Icon(Remix.image_add_line, size: 48, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          const Text(
            "Upload Repair Photos",
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
          const Text(
            "Before and after photos required",
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppColors.primary),
              ),
            ),
            child: const Text("Select Photos"),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialList() {
    if (_materials.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: const Text(
          "No materials added yet",
          style: TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
        ),
      );
    }

    return Column(
      children: _materials.map((m) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          title: Text(m['name']),
          subtitle: Text("Qty: ${m['qty']} | Vendor: ${m['vendor']}"),
          trailing: IconButton(
            icon: const Icon(Remix.delete_bin_line, color: AppColors.danger, size: 20),
            onPressed: () => setState(() => _materials.remove(m)),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () => _showCompletionSheet(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text("Complete Repair Job"),
    );
  }

  void _showAddMaterialDialog() {
    String name = "";
    String qty = "";
    String vendor = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Material"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (v) => name = v,
              decoration: const InputDecoration(labelText: "Material Name"),
            ),
            TextField(
              onChanged: (v) => qty = v,
              decoration: const InputDecoration(labelText: "Quantity"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (v) => vendor = v,
              decoration: const InputDecoration(labelText: "Vendor/Store"),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty) {
                setState(() => _materials.add({'name': name, 'qty': qty, 'vendor': vendor}));
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _showCompletionSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Remix.checkbox_circle_fill, color: AppColors.success, size: 48),
            const SizedBox(height: 16),
            const Text(
              "Job Completed?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "This will mark the ticket as closed and notify the facility manager.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
                    child: const Text("Review"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close sheet
                      Navigator.pop(context); // Go back
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 48),
                    ),
                    child: const Text("Confirm Close"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
