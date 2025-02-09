import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/shopping_screen.dart';
import 'package:shopping_app/widgets/sign_up_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hidePassword = true;
  bool confirmPassword = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool showShoppingScreen = false;
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          "assets/images/main_back.jpg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: showShoppingScreen
                ? ShoppingScreen()
                : AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: opacity,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2),
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.sign_up,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05),
                            SignUpForm(
                              fullNameController: fullNameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              confirmPasswordController:
                                  confirmPasswordController,
                              formKey: formKey,
                              hidePassword: hidePassword,
                              confirmPassword: confirmPassword,
                              togglePassword: togglePassword,
                              toggleConfirmPassword: toggleConfirmPassword,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 100)),
                                onPressed: _validateDialog,
                                child: Text(
                                  AppLocalizations.of(context)!.sign_up,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .already_have_an_account,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ))
      ],
    ));
  }

  void _validateDialog() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (credential.user != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.success,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          content:
              Text(AppLocalizations.of(context)!.account_created_successfully),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  opacity = 0.0;
                });
                await Future.delayed(const Duration(seconds: 1));
                setState(() {
                  showShoppingScreen = true;
                });
              },
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = AppLocalizations.of(context)!.weak_password;
        } else if (e.code == 'email-already-in-use') {
          errorMessage = AppLocalizations.of(context)!.email_already_in_use;
        } else {
          errorMessage = AppLocalizations.of(context)!.unexpected_error;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.unexpected_error,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void toggleConfirmPassword() {
    setState(() {
      confirmPassword = !confirmPassword;
    });
  }
}
