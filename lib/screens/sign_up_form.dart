import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              label: AppLocalizations.of(context)!.full_name,
              controller: fullNameController,
              prefixIcon: const Icon(Icons.person),
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return AppLocalizations.of(context)!.please_enter_full_name;
                }
                if (text[0] != text[0].toUpperCase()) {
                  return AppLocalizations.of(context)!
                      .first_letter_must_be_capitalized;
                }
                return null;
              },
            ),
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
            CustomTextFormField(
              label: AppLocalizations.of(context)!.confirm_password,
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
                  return AppLocalizations.of(context)!
                      .please_enter_confirm_password;
                }
                if (text != passwordController.text) {
                  return AppLocalizations.of(context)!.password_do_not_match;
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
