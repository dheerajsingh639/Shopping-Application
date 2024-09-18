import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:googlelogin/Authorization/API.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final AuthorizationController authorization = Get.put(AuthorizationController());

  late PageController pageController;
  late Timer timer;
  int selectedIndex = 0;
  List<Map<String, dynamic>> fetchedOffers = [];
  List<Widget> offers = [];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);

    // Fetch images initially and set up a timer to periodically refresh the images
    _fetchAndUpdateOffers();

    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      // Auto swipe to the next page
      if (selectedIndex < fetchedOffers.length - 1) {
        selectedIndex++;
      } else {
        selectedIndex = 0; // Go back to the first offer
      }

      // Change the page with animation
      pageController.animateToPage(
        selectedIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      _fetchAndUpdateOffers(); // Refresh offers every 10 seconds
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  // Function to fetch offers and update the list
  void _fetchAndUpdateOffers() async {
    try {
      final images = await authorization.fetchImageUrls();
      setState(() {
        fetchedOffers = _generateOffersData(images);
        offers = buildOffers(); // Update offers with new data
      });
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  // Function to generate data (title, subtitle, discount, etc.) for each offer
  List<Map<String, dynamic>> _generateOffersData(List<String> images) {
    return [
      {
        "image": images[0],
        "title": "New items with \nFree shipping",
        "subtitle": "Shop now",
        "discount": 30,
      },
      {
        "image": images[1],
        "title": "Black \nfriday",
        "subtitle": "Collection",
        "discount": 20,
      },
      {
        "image": images[2],
        "title": "Grab \nyours now",
        "subtitle": "Up to 50% off",
        "discount": 50,
      },
      {
        "image": images[3],
        "title": "SUMMER \nSALE",
        "subtitle": "SPECIAL OFFER",
        "discount": 40,
      },
      {
        "image": images[4],
        "title": "SUMMER \nSALE",
        "subtitle": "SPECIAL OFFER",
        "discount": 40,
      },
      {
        "image": images[5],
        "title": "SUMMER \nSALE",
        "subtitle": "SPECIAL OFFER",
        "discount": 40,
      },
    ];
  }

  // A function to build the offers list with dynamic text and images
  List<Widget> buildOffers() {
    return fetchedOffers.isEmpty
        ? [] // Show an empty list while data is loading
        : List.generate(
            fetchedOffers.length,
            (index) {
              final offer = fetchedOffers[index];
              return GestureDetector(
                // onTap: () {
                //   // Handle tap event
                // },
                child: Stack(
                  children: [
                    // Display the image as a background
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(offer['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Add dynamic title, subtitle, and discount
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 2),
                          Text(
                            offer['title'].toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Grandis Extended',
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            offer['subtitle'].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${offer['discount']}% OFF".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 64,
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.87,
            child: PageView.builder(
              controller: pageController,
              itemCount: offers.length,
              onPageChanged: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return offers[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
