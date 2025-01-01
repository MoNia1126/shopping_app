import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/custom_text_form_field.dart';
import 'package:shopping_app/screens/shopping_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Center(
                      child: Text(
                        "Sign Up",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    CustomTextFormField(
                      label: 'Full Name',
                      controller: fullNameController,
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
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null ||
                            text.trim().isEmpty ||
                            !text.contains('@')) {
                          return 'Please Enter Email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      keyboardType: TextInputType.number,
                      controller: passwordController,
                      obscureText: true,
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
                      keyboardType: TextInputType.number,
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Confirm Password';
                        }
                        if (text != passwordController.text) {
                          return "Password doesn't match.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 19)),
                          onPressed: _validateDialog,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .pushNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          "Already have an account",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _validateDialog() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // backgroundColor: Colors.white.withOpacity(0.5),
          title: Text(
            'Success',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          content: Text(
            'Account created successfully!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingScreen(),
                  ),
                );
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fix the errors.',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
