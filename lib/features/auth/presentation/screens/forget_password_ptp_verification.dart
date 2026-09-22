import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:task_manager/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:task_manager/features/auth/presentation/screens/forget_password_set_password.dart';
import 'package:task_manager/core/constants/app_colors.dart';
import 'package:task_manager/core/widgets/show_snack_bar.dart';
import 'package:task_manager/core/widgets/screen_background.dart';

class ForgetPasswordOtpVerification extends StatefulWidget {
  final String email;

  const ForgetPasswordOtpVerification({
    super.key,
    required this.email,
  });

  @override
  State<ForgetPasswordOtpVerification> createState() =>
      _ForgetPasswordOtpVerificationState();
}

class _ForgetPasswordOtpVerificationState
    extends State<ForgetPasswordOtpVerification> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_otpController.text.length != 6) {
      showSnackbar(context, 'Please enter a 6-digit OTP');
      return;
    }

    final forgotProvider = context.read<ForgotPasswordProvider>();
    String otp = _otpController.text;

    final response = await forgotProvider.verifyOtp(widget.email, otp);

    if (!mounted) return;

    if (response.isSuccess &&
        response.responseData['status'] == 'success') {
      showSnackbar(
        context,
        response.responseData['message'] ?? 'OTP verified',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgetPasswordSetPassword(
            email: widget.email,
            otp: otp,
          ),
        ),
      );
    } else {
      showSnackbar(context, 'OTP verification failed. Try again.');
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
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
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 25),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    controller: _otpController,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(7),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey.shade300,
                      selectedColor: AppColors.Pcolor,
                    ),
                    backgroundColor: Colors.transparent,
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
                        onPressed: _verifyOtp,
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
                            text: 'Sign in',
                            style: TextStyle(
                              color: AppColors.Pcolor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignUp,
                          )
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
