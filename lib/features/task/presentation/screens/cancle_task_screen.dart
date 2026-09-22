import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/features/task/presentation/providers/task_provider.dart';
import 'package:task_manager/core/widgets/tm_appbar.dart';
import 'package:task_manager/features/task/presentation/widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final token = context.read<AuthProvider>().accessToken;
    context.read<TaskProvider>().fetchTasksByStatus('Cancelled', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TmAppbar(),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.separated(
            itemCount: taskProvider.cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: taskProvider.cancelledTaskList[index],
                cardColor: Colors.red,
                onRefresh: _loadData,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 4);
            },
          );
        },
      ),
    );
  }
}
