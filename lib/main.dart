import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopping_app/cubits/change_language_cubit.dart';
import 'package:shopping_app/firebase_options.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/shopping_screen.dart';

import 'cubits/change_language_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeLanguageCubit(),
      child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Shopping App',
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              theme: ThemeData(fontFamily: 'Lora'),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            home: FirebaseAuth.instance.currentUser != null
                ? const ShoppingScreen()
                : LoginScreen(),
          );
        },
      ),
    );
  }
}