import 'package:flutter/material.dart';
import 'package:shopping_app/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lora' //app font family
          ),
      home: SignUpScreen(),
    );
  }
}
