import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/features/task/presentation/providers/task_provider.dart';
import 'package:task_manager/core/widgets/tm_appbar.dart';
import 'package:task_manager/features/task/presentation/widgets/task_card.dart';
import 'package:task_manager/features/task/presentation/widgets/task_count_by_status.dart';
import 'package:task_manager/features/task/presentation/screens/add_new_task.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final token = context.read<AuthProvider>().accessToken;
    final taskProvider = context.read<TaskProvider>();
    taskProvider.fetchTaskCounts(token);
    taskProvider.fetchTasksByStatus('New', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TmAppbar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 90,
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskProvider.taskCountList.length,
                    itemBuilder: (context, index) {
                      final item = taskProvider.taskCountList[index];
                      return TaskCountByStatus(
                        title: item.status,
                        count: item.count,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                return ListView.separated(
                  itemCount: taskProvider.newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskModel: taskProvider.newTaskList[index],
                      cardColor: Colors.blue,
                      onRefresh: _loadData,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewTask()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
