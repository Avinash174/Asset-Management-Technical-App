import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Mark all as read"),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildNotificationItem(index),
      ),
    );
  }

  Widget _buildNotificationItem(int index) {
    final List<Map<String, dynamic>> notifications = [
      {
        "title": "New Task Assigned",
        "body": "PPM for Chiller Unit A-12 has been assigned to you.",
        "time": "2 mins ago",
        "icon": Remix.task_line,
        "color": AppColors.primary,
        "isRead": false,
      },
      {
        "title": "Task Overdue",
        "body": "Breakdown repair for Pump CP-04 is 1 hour overdue.",
        "time": "1 hour ago",
        "icon": Remix.error_warning_line,
        "color": AppColors.danger,
        "isRead": false,
      },
      {
        "title": "Material Approved",
        "body": "Request for Seal Kit (Qty: 2) has been approved by Manager.",
        "time": "3 hours ago",
        "icon": Remix.checkbox_circle_line,
        "color": AppColors.success,
        "isRead": true,
      },
    ];

    final item = notifications[index % notifications.length];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item['color'].withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icon'], color: item['color'], size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontWeight: item['isRead'] ? FontWeight.normal : FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (!item['isRead'])
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['body'],
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: item['isRead'] ? FontWeight.normal : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['time'],
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
