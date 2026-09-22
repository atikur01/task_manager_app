import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_provider.dart';
import 'package:task_manager/features/auth/presentation/screens/login_screen.dart';
import 'package:task_manager/features/task/presentation/screens/main_nav_screen.dart';
import 'package:task_manager/core/constants/asset_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    movetoNextScreen();
  }

  Future<void> movetoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;
    final authProvider = context.read<AuthProvider>();
    final bool isLoggedIn = await authProvider.isUserLoggedIn();

    if (!mounted) return;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(AssetPaths.backgroundSVG),
          Center(child: SvgPicture.asset(AssetPaths.logoSVG)),
        ],
      ),
    );
  }
}
