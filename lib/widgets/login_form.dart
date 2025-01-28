import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final bool hidePassword;
  final VoidCallback togglePassword;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
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
              label: AppLocalizations.of(context)!.email,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email),
              validator: (text) {
                if (text == null ||
                    text.trim().isEmpty ||
                    !text.contains('@')) {
                  return AppLocalizations.of(context)!.please_enter_email;
                }
                return null;
              },
            ),
            CustomTextFormField(
              label: AppLocalizations.of(context)!.password,
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
                  return AppLocalizations.of(context)!.please_enter_password;
                }
                if (text.length < 6) {
                  return AppLocalizations.of(context)!
                      .password_must_be_at_least_6_chars;
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
