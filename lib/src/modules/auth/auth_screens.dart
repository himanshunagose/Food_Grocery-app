import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'login'.tr,
      subtitle: 'Order meals & groceries in one app',
      primaryButtonLabel: 'login'.tr,
      secondaryText: 'New here?',
      secondaryButtonLabel: 'signup'.tr,
      onPrimaryPressed: () => Get.offAllNamed(AppRoutes.home),
      onSecondaryPressed: () => Get.toNamed(AppRoutes.signup),
      form: const AuthForm(),
      footer: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
          child: Text('forgot_password'.tr),
        ),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'signup'.tr,
      subtitle: 'Create a unified food & grocery account',
      primaryButtonLabel: 'Continue',
      secondaryText: 'Already have an account?',
      secondaryButtonLabel: 'login'.tr,
      onPrimaryPressed: () => Get.toNamed(AppRoutes.otp),
      onSecondaryPressed: () => Get.back(),
      form: const Column(
        children: [
          AuthTextField(label: 'Full name'),
          SizedBox(height: 12),
          AuthTextField(label: 'Phone number', keyboardType: TextInputType.phone),
          SizedBox(height: 12),
          AuthTextField(label: 'Email'),
          SizedBox(height: 12),
          AuthTextField(label: 'Password', obscureText: true),
        ],
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Reset password',
      subtitle: 'Enter your registered email or phone',
      primaryButtonLabel: 'Send OTP',
      form: const Column(
        children: [
          AuthTextField(label: 'Email / Phone'),
        ],
      ),
      onPrimaryPressed: () => Get.toNamed(AppRoutes.otp),
    );
  }
}

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Verify OTP',
      subtitle: 'Enter the 4 digit code sent to you',
      primaryButtonLabel: 'Verify & continue',
      form: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          4,
          (index) => SizedBox(
            width: 64,
            child: TextField(
              decoration: const InputDecoration(counterText: ''),
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ),
      onPrimaryPressed: () => Get.offAllNamed(AppRoutes.home),
    );
  }
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryButtonLabel,
    required this.form,
    this.secondaryText,
    this.secondaryButtonLabel,
    this.footer,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final String title;
  final String subtitle;
  final String primaryButtonLabel;
  final Widget form;
  final String? secondaryText;
  final String? secondaryButtonLabel;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(subtitle, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 32),
              form,
              if (footer != null) ...[
                const SizedBox(height: 16),
                footer!,
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onPrimaryPressed,
                  child: Text(primaryButtonLabel),
                ),
              ),
              if (secondaryText != null && secondaryButtonLabel != null) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(secondaryText!),
                    TextButton(
                      onPressed: onSecondaryPressed,
                      child: Text(secondaryButtonLabel!),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AuthTextField(label: 'Email'),
        SizedBox(height: 12),
        AuthTextField(label: 'Password', obscureText: true),
      ],
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
  });

  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

