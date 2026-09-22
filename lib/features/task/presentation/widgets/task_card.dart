import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task/data/models/task_model.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/features/task/presentation/providers/task_provider.dart';
import 'package:task_manager/core/widgets/show_snack_bar.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback onRefresh;

  const TaskCard({
    super.key,
    required this.taskModel,
    required this.cardColor,
    required this.onRefresh,
  });

  Future<void> _deleteTask(BuildContext context) async {
    final taskProvider = context.read<TaskProvider>();
    final token = context.read<AuthProvider>().accessToken;

    final success = await taskProvider.deleteTask(taskModel.id, token);

    if (!context.mounted) return;

    if (success) {
      onRefresh();
      showSnackbar(context, 'Task Deleted');
    } else {
      showSnackbar(context, 'Failed to delete task');
    }
  }

  Future<void> _changeStatus(BuildContext context, String status) async {
    final taskProvider = context.read<TaskProvider>();
    final token = context.read<AuthProvider>().accessToken;

    final success =
        await taskProvider.changeTaskStatus(taskModel.id, status, token);

    if (!context.mounted) return;

    if (success) {
      onRefresh();
      Navigator.pop(context);
      showSnackbar(context, 'Task Status updated');
    } else {
      showSnackbar(context, 'Failed to update status');
    }
  }

  void _showChangeStatusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () => _changeStatus(context, 'New'),
                title: const Text('New'),
                trailing: taskModel.status == 'New'
                    ? const Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () => _changeStatus(context, 'Progress'),
                title: const Text('Progress'),
                trailing: taskModel.status == 'Progress'
                    ? const Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () => _changeStatus(context, 'Completed'),
                title: const Text('Completed'),
                trailing: taskModel.status == 'Completed'
                    ? const Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () => _changeStatus(context, 'Cancelled'),
                title: const Text('Cancelled'),
                trailing: taskModel.status == 'Cancelled'
                    ? const Icon(Icons.done)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(
            taskModel.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.description),
              Text('Date: ${taskModel.createdDate}'),
              Row(
                children: [
                  Chip(
                    label: Text(taskModel.status),
                    backgroundColor: cardColor,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _showChangeStatusDialog(context),
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _deleteTask(context),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
