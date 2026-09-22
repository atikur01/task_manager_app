import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app/app.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:task_manager/features/auth/presentation/providers/login_provider.dart';
import 'package:task_manager/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:task_manager/features/profile/presentation/providers/profile_provider.dart';
import 'package:task_manager/features/task/presentation/providers/add_task_provider.dart';
import 'package:task_manager/features/task/presentation/providers/task_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const TaskManagerApp(),
    ),
  );
}