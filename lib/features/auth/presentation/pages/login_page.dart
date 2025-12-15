import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final schoolIdController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'LMS Mobile',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Multi-Tenant Learning Management System',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              CustomTextField(
                controller: schoolIdController,
                label: 'School ID',
                hint: 'Enter your school ID',
                prefixIcon: Icons.school,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                hint: 'Enter your email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                label: 'Password',
                hint: 'Enter your password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              Obx(
                () => CustomButton(
                  text: 'Login',
                  isLoading: controller.isLoading,
                  onPressed: () {
                    controller.login(
                      schoolId: schoolIdController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
