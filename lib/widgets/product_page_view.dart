import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductPageView extends StatelessWidget {
  //List of features
  final List<String> productImages = [
    'assets/images/product1.jpg',
    'assets/images/product2.jpg',
    'assets/images/product3.jpg',
    'assets/images/product4.jpg',
    'assets/images/product5.jpg',
    'assets/images/product6.jpg',
  ];

  ProductPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width, //full screen width
      child: PageView.builder(
        itemCount: productImages.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(productImages[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.black.withOpacity(0.3), //transparent
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      '${AppLocalizations.of(context)!.product} ${index + 1}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )));
        },
      ),
    );
  }
}
