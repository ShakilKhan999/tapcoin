import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_coin/common/custom_button.dart';
import 'package:tap_coin/common/custom_textfiled.dart';
import 'package:tap_coin/controller/auth_controller.dart';
import 'package:tap_coin/screens/signup_screen.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Welcome Back',
                  style: Get.textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (!GetUtils.isEmail(value ?? '')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if ((value?.length ?? 0) < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Obx(() => CustomButton(
                      text: 'Login',
                      isLoading: controller.isLoading.value,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.signIn(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    )),
                TextButton(
                  onPressed: () => Get.to(() => const SignupView()),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
