import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../home/presentation/screens/home_screen.dart';
import '../tasks/presentation/screens/task_list_screen.dart';
import '../scanner/presentation/screens/scanner_screen.dart';
import '../profile/presentation/screens/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TaskListScreen(),
    const ScannerScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Remix.home_4_line),
              activeIcon: Icon(Remix.home_4_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Remix.task_line),
              activeIcon: Icon(Remix.task_fill),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Remix.qr_scan_2_line),
              activeIcon: Icon(Remix.qr_scan_2_fill),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Remix.user_3_line),
              activeIcon: Icon(Remix.user_3_fill),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
