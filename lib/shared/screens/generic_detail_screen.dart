import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../../core/theme/app_colors.dart';

class GenericDetailScreen extends StatelessWidget {
  final String title;
  const GenericDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Remix.information_line, size: 64, color: AppColors.textSecondary.withAlpha(50)),
            const SizedBox(height: 16),
            Text(
              "Details for $title will appear here",
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
