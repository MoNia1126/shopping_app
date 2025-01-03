import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  List<Map<String, String>> getTranslatedProductDetails(BuildContext context) {
    return [
      {
        'image': 'assets/images/product7.jpg',
        'name': AppLocalizations.of(context)!.product_7
      },
      {
        'image': 'assets/images/product8.jpg',
        'name': AppLocalizations.of(context)!.product_8
      },
      {
        'image': 'assets/images/product9.jpg',
        'name': AppLocalizations.of(context)!.product_9
      },
      {
        'image': 'assets/images/product10.jpg',
        'name': AppLocalizations.of(context)!.product_10
      },
      {
        'image': 'assets/images/product11.jpg',
        'name': AppLocalizations.of(context)!.product_11
      },
      {
        'image': 'assets/images/product12.jpg',
        'name': AppLocalizations.of(context)!.product_12
      },
    ];
  }

  void addToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        AppLocalizations.of(context)!.item_added_to_cart,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple[200],
      // Display color
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final translatedProductDetails = getTranslatedProductDetails(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: translatedProductDetails.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  translatedProductDetails[index]['image']!,
                  fit: BoxFit.cover,
                ),
              ),
              Text(translatedProductDetails[index]['name']!),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () => addToCart(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
