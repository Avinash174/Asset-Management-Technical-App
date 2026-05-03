import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../tasks/presentation/screens/ppm_checklist_screen.dart';
import '../../../tasks/presentation/screens/breakdown_repair_screen.dart';
import '../../../tasks/presentation/screens/task_list_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryGrid(context),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, "Today's Tasks", "View all"),
                  const SizedBox(height: 12),
                  _buildTaskList(context),
                  const SizedBox(height: 24),
                  _buildSectionHeader(context, "High Priority Jobs", null),
                  const SizedBox(height: 12),
                  _buildPriorityJobs(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          "Hello, Technician",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withAlpha(50),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Remix.notification_3_line),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSummaryGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildSummaryCard(context, "Assigned", "12", Remix.briefcase_line, AppColors.primary),
        _buildSummaryCard(context, "Pending", "05", Remix.time_line, AppColors.warning),
        _buildSummaryCard(context, "Completed", "07", Remix.checkbox_circle_line, AppColors.success),
        _buildSummaryCard(context, "Overdue", "02", Remix.error_warning_line, AppColors.danger),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildSummaryCard(BuildContext context, String title, String count, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskListScreen()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 20),
                  Text(
                    count,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String? actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskListScreen()),
              );
            },
            child: Text(actionText),
          ),
      ],
    );
  }

  Widget _buildTaskList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildTaskCard(
          context,
          "AC Unit Maintenance",
          "Server Room 1, Floor 2",
          "10:30 AM",
          "PPM",
          AppColors.info,
        );
      },
    );
  }

  Widget _buildPriorityJobs(BuildContext context) {
    return _buildTaskCard(
      context,
      "Water Leakage Issue",
      "Cafeteria, Ground Floor",
      "ASAP",
      "Breakdown",
      AppColors.danger,
      isHighPriority: true,
    );
  }

  Widget _buildTaskCard(
    BuildContext? context,
    String title,
    String location,
    String time,
    String type,
    Color typeColor, {
    bool isHighPriority = false,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          if (type == "PPM") {
            Navigator.push(
              context!,
              MaterialPageRoute(
                builder: (context) => PPMChecklistScreen(assetName: title),
              ),
            );
          } else {
            Navigator.push(
              context!,
              MaterialPageRoute(
                builder: (context) => BreakdownRepairScreen(
                  ticketId: "TK-8821",
                  assetName: title,
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Remix.map_pin_2_line, size: 14),
                        const SizedBox(width: 4),
                        Text(location, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Remix.time_line, size: 14),
                        const SizedBox(width: 4),
                        Text(time, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: typeColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
