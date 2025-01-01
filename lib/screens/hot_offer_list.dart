import 'package:flutter/material.dart';

class HotOffersList extends StatelessWidget {
  final List<Map<String, String>> offers;

  const HotOffersList({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      // Display message if no offers are available
      return Center(
        child: Text(
          'No offers available',
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: offers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  offers[index]['image']!,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.27,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    offers[index]['text']!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
