import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:task_manager/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:task_manager/features/auth/presentation/screens/forget_password_ptp_verification.dart';
import 'package:task_manager/core/constants/app_colors.dart';
import 'package:task_manager/core/widgets/show_snack_bar.dart';
import 'package:task_manager/core/widgets/screen_background.dart';

class ForgetPasswordEmailVerify extends StatefulWidget {
  const ForgetPasswordEmailVerify({super.key});

  @override
  State<ForgetPasswordEmailVerify> createState() =>
      _ForgetPasswordEmailVerifyState();
}

class _ForgetPasswordEmailVerifyState extends State<ForgetPasswordEmailVerify> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  Future<void> _verifyEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final forgotProvider = context.read<ForgotPasswordProvider>();
    String email = _emailController.text.trim();

    final response = await forgotProvider.verifyEmail(email);

    if (!mounted) return;

    if (response.isSuccess &&
        response.responseData['status'] == 'success') {
      showSnackbar(
        context,
        response.responseData['message'] ?? 'OTP sent to email',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ForgetPasswordOtpVerification(email: email),
        ),
      );
    } else {
      showSnackbar(context, 'Verification failed. Try again.');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150),
                  Text(
                    'Your email address',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<ForgotPasswordProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return FilledButton(
                        onPressed: _verifyEmail,
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: AppColors.Pcolor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUp,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
