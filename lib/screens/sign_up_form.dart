import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/custom_text_form_field.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final bool hidePassword;
  final VoidCallback togglePassword;

  const SignUpForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
    required this.hidePassword,
    required this.togglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              label: 'Full Name',
              controller: fullNameController,
              prefixIcon: const Icon(Icons.person),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Please Enter Full Name';
                }
                if (text[0] != text[0].toUpperCase()) {
                  return 'First letter must be capitalized';
                }
                return null;
              },
            ),
            CustomTextFormField(
              label: 'Email',
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
              validator: (text) {
                if (text == null ||
                    text.trim().isEmpty ||
                    !text.contains('@')) {
                  return 'Please Enter Email';
                }
                return null;
              },
            ),
            CustomTextFormField(
              label: 'Password',
              controller: passwordController,
              obscureText: hidePassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Please Enter Password';
                }
                if (text.length < 6) {
                  return 'Password must be at least 6 chars.';
                }
                return null;
              },
            ),
            CustomTextFormField(
              label: 'Confirm Password',
              controller: confirmPasswordController,
              obscureText: hidePassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Please Enter Confirm Password';
                }
                if (text != passwordController.text) {
                  return "Passwords do not match.";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
