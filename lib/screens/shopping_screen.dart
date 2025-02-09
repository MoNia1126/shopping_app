import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/cubits/change_language_cubit.dart';
import 'package:shopping_app/screens/biometric_helper.dart';
import 'package:shopping_app/screens/profile_screen.dart';
import 'package:shopping_app/widgets/hot_offer_list.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/widgets/product_grid.dart';
import 'package:shopping_app/widgets/product_page_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {


  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  // List contains details about hot offers
  List<Map<String, String>> getTranslatedHotOffers(BuildContext context) {
    return [
      {
        'image': 'assets/images/product13.jpg',
        'text': AppLocalizations.of(context)!.hot_offer_1
      },
      {
        'image': 'assets/images/product14.jpg',
        'text': AppLocalizations.of(context)!.hot_offer_2
      },
      {
        'image': 'assets/images/product15.jpg',
        'text': AppLocalizations.of(context)!.hot_offer_3
      },
      {
        'image': 'assets/images/product16.jpg',
        'text': AppLocalizations.of(context)!.hot_offer_4
      },
      {
        'image': 'assets/images/product17.jpg',
        'text': AppLocalizations.of(context)!.hot_offer_5
      },
      {
        'image': 'assets/images/product18.jpg',
        'text': AppLocalizations.of(context)!.hot_offer_6
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final translatedHotOffers = getTranslatedHotOffers(context);

    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: opacity,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.shopping_app,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
              // fontFamily: 'Lora'
            ),
          ),
          actions: [
            DropdownButton<Locale>(
              icon: const Icon(Icons.language, color: Colors.white),
              onChanged: (locale) {
                if (locale != null) {
                  context
                      .read<ChangeLanguageCubit>()
                      .changeLanguage(locale.languageCode);
                }
              },
              items: [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text(AppLocalizations.of(context)!.english),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text(AppLocalizations.of(context)!.arabic),
                ),
              ],
              underline: const SizedBox(),
            ),
            // IconButton(
            //     onPressed: () {
            //       handleLogout(context);
            //     },
            //     icon: Icon(Icons.logout, color: Colors.white)),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () async {
                bool isAuthenticated = await BiometricHelper().authenticate();
                if (isAuthenticated) {
                  if (mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  }
                }
              },
            ),
          ],
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.5),
                child: Text(
                  AppLocalizations.of(context)!.our_products,
                  style: TextStyle(
                    fontFamily: "Lora",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[900],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.003),
              ProductPageView(),
              const ProductsGrid(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.hot_offers,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // fontFamily: "Lora",
                    color: Colors.brown[900],
                  ),
                ),
              ),
              HotOffersList(offers: translatedHotOffers),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleLogout(BuildContext context) async {
    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logout),
          content: Text(AppLocalizations.of(context)!.logout_confirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        );
      },
    );

    if (confirmLogout) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}