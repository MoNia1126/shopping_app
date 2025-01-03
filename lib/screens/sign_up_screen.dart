import 'package:flutter/material.dart';
import 'package:shopping_app/screens/shopping_screen.dart';
import 'package:shopping_app/screens/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hidePassword = true;
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
                ? const ShoppingScreen()
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
                            const Center(
                              child: Text(
                                "Sign Up",
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
                              togglePassword: togglePassword,
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
                                        vertical: 10, horizontal: 120)),
                                onPressed: _validateDialog,
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Already have an account?",
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

  void _validateDialog() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Success',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          content: const Text('Account created successfully!'),
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
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix the errors.',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }
}
