import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task/presentation/providers/add_task_provider.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/core/widgets/screen_background.dart';
import 'package:task_manager/core/widgets/tm_appbar.dart';
import 'package:task_manager/features/task/presentation/screens/main_nav_screen.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _addNewTask() async {
    final addTaskProvider = context.read<AddTaskProvider>();
    final token = context.read<AuthProvider>().accessToken;

    final response = await addTaskProvider.addTask(
      title: titleController.text,
      description: descriptionController.text,
      token: token,
    );

    if (!mounted) return;

    if (response.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task added..!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainNavScreen()),
        (predicate) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.responseData['data'] ?? response.errorMessage ?? 'Error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TmAppbar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Add new Task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 6,
                    decoration:
                        const InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<AddTaskProvider>(
                    builder: (context, addTaskProvider, child) {
                      if (addTaskProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addNewTask();
                          }
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
