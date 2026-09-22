import 'package:flutter/material.dart';
import 'package:task_manager/features/task/presentation/screens/cancle_task_screen.dart';
import 'package:task_manager/features/task/presentation/screens/completed_task_screen.dart';
import 'package:task_manager/features/task/presentation/screens/new_task_screen.dart';
import 'package:task_manager/features/task/presentation/screens/progress_task_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTabChange,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.refresh),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel),
            label: 'Cancel',
          ),
        ],
      ),
    );
  }
}
