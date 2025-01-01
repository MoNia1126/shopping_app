import 'package:flutter/material.dart';
import 'package:shopping_app/screens/hot_offer_list.dart';
import 'package:shopping_app/screens/product_grid.dart';
import 'package:shopping_app/screens/product_page_view.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  //List contains details about hot offers
  final List<Map<String, String>> hotOffers = [
    {'image': 'assets/images/product13.jpg', 'text': 'Hot Offer 1'},
    {'image': 'assets/images/product14.jpg', 'text': 'Hot Offer 2'},
    {'image': 'assets/images/product15.jpg', 'text': 'Hot Offer 3'},
    {'image': 'assets/images/product16.jpg', 'text': 'Hot Offer 4'},
    {'image': 'assets/images/product17.jpg', 'text': 'Hot Offer 5'},
    {'image': 'assets/images/product18.jpg', 'text': 'Hot Offer 6'},
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //get screen size using mediaQuery

    return Scaffold(
      backgroundColor: Colors.white, //background color
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Shopping App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
            // fontFamily: 'Lora'
          ),
        ),
        centerTitle: true, //make the title in center
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Our Products",
                style: TextStyle(
                    fontFamily: "Lora",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[900]),
              ),
            ),
            SizedBox(height: size.height * 0.003),
            ProductPageView(),
            const ProductsGrid(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hot Offers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // fontFamily: "Lora",
                  color: Colors.brown[900],
                ),
              ),
            ),
            HotOffersList(offers: hotOffers),
          ],
        ),
      ),
    );
  }
}
