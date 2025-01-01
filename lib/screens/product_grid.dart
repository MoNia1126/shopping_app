import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  // List of product details
  final productDetails = const [
    {'image': 'assets/images/product7.jpg', 'name': 'Product 7'},
    {'image': 'assets/images/product8.jpg', 'name': 'Product 8'},
    {'image': 'assets/images/product9.jpg', 'name': 'Product 9'},
    {'image': 'assets/images/product10.jpg', 'name': 'Product 10'},
    {'image': 'assets/images/product11.jpg', 'name': 'Product 11'},
    {'image': 'assets/images/product12.jpg', 'name': 'Product 12'},
  ];

  // Function to display a SnackBar when a product is added to the cart
  void addToCart(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Item added to cart', //message
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple[200],
      // Display color
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), //rounded
      ),
      duration: const Duration(seconds: 2), // Display duration
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // Adjust size to fit content
      physics: const NeverScrollableScrollPhysics(),
      // Disable internal scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two products for row
        crossAxisSpacing: 8, // Horizontal spacing
        mainAxisSpacing: 8, // Vertical spacing
      ),
      itemCount: productDetails.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4, // Card shadow for visibility
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  productDetails[index]['image']!, // Product image
                  fit: BoxFit.cover,
                ),
              ),
              Text(productDetails[index]['name']!), // Product name
              IconButton(
                icon: const Icon(Icons.add_shopping_cart), //cart icon
                onPressed: () => addToCart(context), // Trigger SnackBar
              ),
            ],
          ),
        );
      },
    );
  }
}
