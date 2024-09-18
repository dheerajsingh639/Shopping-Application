

import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:googlelogin/Authorization/API.dart';
import 'package:googlelogin/Screen/OnBordBanners/BannerM1.dart';
import 'package:googlelogin/Screen/OnBordBanners/BannerM2.dart';
import 'package:googlelogin/Screen/OnBordBanners/BannerM3.dart';
import 'package:googlelogin/Screen/OnBordBanners/BannerM4.dart';
import 'package:googlelogin/Screen/Popular%20produts/Emptypage1.dart';
import 'package:googlelogin/Screen/Popular%20produts/Emptypage2.dart';
import 'package:googlelogin/Screen/Popular%20produts/Emptypage3.dart';
import 'package:googlelogin/Screen/Popular%20produts/Emptypage4.dart';
import 'package:googlelogin/Screen/Popular%20produts/Emptypage5.dart';
import 'package:googlelogin/Screen/Popular%20produts/Emptypage6.dart';
import 'package:googlelogin/Welcome%20Screen/02OnboardingScreen.dart';
import '../Screen/BestSeller/Bestsellers1.dart';
import '../Screen/BestSeller/Bestsellers2.dart';
import '../Screen/BestSeller/Bestsellers3.dart';
import '../Screen/BlackFriday.dart';
import '../Screen/Flash sale/Flashsale1.dart';
import '../Screen/Flash sale/Flashsale2.dart';
import '../Screen/Flash sale/Flashsale3.dart';
import '../Screen/SuperFlash.dart';
import '../Screen/Categories/allcat.dart';
import '../Screen/Categories/kidsScreenRoute.dart';
import '../Screen/Categories/mansScreenRoute.dart';
import '../Screen/Categories/onSaleScreenRoute.dart';
import '../Screen/specialOffers.dart';
import '../Screen/Categories/womansScreenRoute.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0; //Categories code logics s

  //OffersCarousel banner logics start   -------------------------->
  final AuthorizationController authorization =
      Get.put(AuthorizationController());

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
                onTap: () {
                 switch (index) {
                    case 0:
                      Get.to(BannerM1());
                      break;
                    case 1:
                      Get.to(BannerM2());
                      break;
                    case 2:
                       Get.to(BannerM3());
                      break;
                    case 3:
                      Get.to(BannerM4());
                      break;
                    default:
                      // Default navigation action if needed
                      break;
                  }
                },
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

  //OffersCarousel banner logics end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //BANNER CODE AND LOGIC START
                AspectRatio(
                  aspectRatio: 1.87,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      PageView.builder(
                        controller: pageController,
                        itemCount: offers.length,
                        onPageChanged: (int index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        itemBuilder: (context, index) => offers[index],
                      ),
                      FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            height: 16,
                            child: Row(
                              children: List.generate(
                                offers.length,
                                (index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(left: 16.0 / 4),
                                    child: DotIndicator(
                                     isActive: index == selectedIndex,
                                     activeColor: Colors.white70,
                                     inActiveColor: Colors.white54,
                                   ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //BANNER CODE AND LOGIC END

                const SizedBox(height: 16.0 / 2),

                // MY CATEGORIES CODE START
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        demoCategories.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(
                              left: index == 0 ? 16.0 : 16.0 / 2,
                              right: index == demoCategories.length - 1
                                  ? 16.0
                                  : 0),
                          child: CategoryBtn(
                            category: demoCategories[index].name,
                            svgSrc: demoCategories[index].svgSrc,
                            isActive: index == activeIndex,
                            press: () {
                              setState(() {
                                activeIndex = index;
                              });

                              // Navigate to the appropriate screen based on the category name
                              switch (demoCategories[index].name) {
                                case "On Sale":
                                  Get.to(const onSaleScreenRoute());
                                  break;
                                case "Man's":
                                  Get.to(const mansScreenRoute());
                                  break;
                                case "Woman’s":
                                  Get.to(const womansScreenRoute());
                                  break;
                                case "Kids":
                                  Get.to(const kidsScreenRoute());
                                  break;
                                default:
                                  Get.to(const allCat());
                                  break;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),

            // MY POPULAR PRODUTS CODE START
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Popular products",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: demoPopularProducts.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: index == demoPopularProducts.length - 1
                              ? 16.0
                              : 0,
                        ),
                        child: ProductCard(
                          image: demoPopularProducts[index].image,
                          brandName: demoPopularProducts[index].brandName,
                          title: demoPopularProducts[index].title,
                          price: demoPopularProducts[index].price,
                          priceAfetDiscount:
                              demoPopularProducts[index].priceAfetDiscount,
                          dicountpercent:
                              demoPopularProducts[index].dicountpercent,
                          press: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const EmptyPage1());
                                break;
                              case 1:
                                Get.to(() => const EmptyPage2());
                                break;
                              case 2:
                                Get.to(() => const EmptyPage3());
                                break;
                              case 3:
                                Get.to(() => const EmptyPage4());
                                break;
                              case 4:
                                Get.to(() => const EmptyPage5());
                                break;
                              case 5:
                                Get.to(() => const EmptyPage6());
                                break;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // MY POPULAR PRODUTS CODE END

            //SUPER FLASH CODE START
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16.0 * 1.5),
              sliver: SliverToBoxAdapter(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BannerMWithCounter(
                    duration: const Duration(hours: 8),
                    text: "Super Flash Sale \n50% Off",
                    press: () {
                      Get.to(const SuperFlash());
                    },
                  ),

                  //SUPER FLASH CODE END

                  const SizedBox(height: 16.0 / 2),

                  //FLAS CODE START
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Flash sale",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // Find demoFlashSaleProducts on models/ProductModel.dart
                      itemCount: demoFlashSaleProducts.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          right: index == demoFlashSaleProducts.length - 1
                              ? 16.0
                              : 0,
                        ),
                        child: ProductCard(
                          image: demoFlashSaleProducts[index].image,
                          brandName: demoFlashSaleProducts[index].brandName,
                          title: demoFlashSaleProducts[index].title,
                          price: demoFlashSaleProducts[index].price,
                          priceAfetDiscount:
                              demoFlashSaleProducts[index].priceAfetDiscount,
                          dicountpercent:
                              demoFlashSaleProducts[index].dicountpercent,
                          press: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const Flashsale1());
                                break;
                              case 1:
                                Get.to(() => const Flashsale2());
                                break;
                              case 2:
                                Get.to(() => const Flashsale3());
                                break;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            //FLASG CODE END

            //NEW ARRIVAL BANNER CODE
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BannerSStyle1(
                    title: "New \narrival",
                    subtitle: "SPECIAL OFFER",
                    discountParcent: 50,
                    press: () {
                      Get.to(const specialOffers());
                    },
                  ),

                  //NEW ARRIVAL BANNER CODE END

                  const SizedBox(height: 16.0 / 4),
                ],
              ),
            ),

            //BEST SELLER CODE SATRT

            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0 / 2),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Best sellers",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Find demoBestSellersProducts on models/ProductModel.dart
                    itemCount: demoBestSellersProducts.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: index == demoBestSellersProducts.length - 1
                            ? 16.0
                            : 0,
                      ),
                      child: ProductCard(
                        image: demoBestSellersProducts[index].image,
                        brandName: demoBestSellersProducts[index].brandName,
                        title: demoBestSellersProducts[index].title,
                        price: demoBestSellersProducts[index].price,
                        priceAfetDiscount:
                            demoBestSellersProducts[index].priceAfetDiscount,
                        dicountpercent:
                            demoBestSellersProducts[index].dicountpercent,
                        press: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const Bestsellers1());
                              break;
                            case 1:
                              Get.to(() => const Bestsellers2());
                              break;
                            case 2:
                              Get.to(() => const Bestsellers3());
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            )),

            //BEST SELLER CODE SATRT

            //MOST POPULAR CODE START
            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Most popular",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 114,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoPopularProducts.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right:
                            index == demoPopularProducts.length - 1 ? 16.0 : 0,
                      ),
                      child: SecondaryProductCard(
                        image: demoPopularProducts[index].image,
                        brandName: demoPopularProducts[index].brandName,
                        title: demoPopularProducts[index].title,
                        price: demoPopularProducts[index].price,
                        priceAfetDiscount:
                            demoPopularProducts[index].priceAfetDiscount,
                        dicountpercent:
                            demoPopularProducts[index].dicountpercent,
                        press: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const EmptyPage1());
                              break;
                            case 1:
                              Get.to(() => const EmptyPage2());
                              break;
                            case 2:
                              Get.to(() => const EmptyPage3());
                              break;
                            default:
                              Get.to(() => const DefaultEmptyPage());
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            )),

            //MOST POPULAR CODE START

            //BLACK FRIDAY BANNER CODE
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 16.0 * 1.5),
                  const SizedBox(height: 16.0 / 4),
                  BannerSStyle5(
                    title: "Black \nfriday",
                    subtitle: "50% Off",
                    bottomText: "Collection".toUpperCase(),
                    press: () {
                      Get.to(const BlackFriday());
                    },
                  ),
                  const SizedBox(height: 16.0 / 4),
                ],
              ),
            ),
            //BLACK FRIDAY BANNER CODE END

            //BEST SELLER CODE START
            SliverToBoxAdapter(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0 / 2),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Best sellers",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: demoBestSellersProducts.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: index == demoBestSellersProducts.length - 1
                            ? 16.0
                            : 0,
                      ),
                      child: ProductCard(
                        image: demoBestSellersProducts[index].image,
                        brandName: demoBestSellersProducts[index].brandName,
                        title: demoBestSellersProducts[index].title,
                        price: demoBestSellersProducts[index].price,
                        priceAfetDiscount:
                            demoBestSellersProducts[index].priceAfetDiscount,
                        dicountpercent:
                            demoBestSellersProducts[index].dicountpercent,
                        press: () {
                          switch (index) {
                            case 0:
                              Get.to(() => const Bestsellers1());
                              break;
                            case 1:
                              Get.to(() => const Bestsellers2());
                              break;
                            case 2:
                              Get.to(() => const Bestsellers3());
                              break;
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

//BEST SELLER CODE END

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    this.svgSrc,
    required this.isActive,
    required this.press,
  });

  final String category;
  final String? svgSrc;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF7B61FF) : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            if (svgSrc != null)
              SvgPicture.asset(
                svgSrc!,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            if (svgSrc != null) const SizedBox(width: 16.0 / 2),
            Text(
              category,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryModel {
  final String name;
  final String? svgSrc;

  CategoryModel({
    required this.name,
    this.svgSrc,
  });
}

List<CategoryModel> demoCategories = [
  CategoryModel(name: "All Categories"),
  CategoryModel(
    name: "On Sale",
    svgSrc: "./images/Sale.svg",
    //route: onSaleScreenRoute---------------------->
  ),
  CategoryModel(name: "Man's", svgSrc: "./images/Man.svg"),
  CategoryModel(name: "Woman’s", svgSrc: "./images/Woman.svg"),
  CategoryModel(
    name: "Kids", svgSrc: "./images/Child.svg",
    //route: kidsScreenRoute------------------------->
  ),
];

//------------------------------------------------------------------------------------HOME PATTERN END--------------------------------------------------------------------------------------------------------------------------------------------->

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    required this.press,
  });

  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(140, 220),
        maximumSize: const Size(140, 220),
        padding: const EdgeInsets.all(8),
        side: const BorderSide(color: Colors.black12, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),


      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(
                  image,
                  radius: 0.0,
                ),
                if (dicountpercent != null)
                  Positioned(
                    right: 8.0,
                    top: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Text(
                        "$dicountpercent% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandName.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  priceAfetDiscount != null
                      ? Row(
                          children: [
                            Text(
                              "Rs $priceAfetDiscount",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "Rs $price",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Rs $price",
                          style: const TextStyle(
                              color: Color(0xFF31B0D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class DefaultEmptyPage extends StatelessWidget {
  const DefaultEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Default Empty Page"),
      ),
      body: const Center(
        child: Text("This is the Default Empty Page"),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(
        child: Text('Details for ${product.title}'),
      ),
    );
  }
}

class ProductModel {
  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;

  ProductModel({
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
  });
}

List<ProductModel> demoPopularProducts = [
  ProductModel(
    image: "https://i.imgur.com/CGCyp1d.png",
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy london",
    price: 540,
    priceAfetDiscount: 420,
    dicountpercent: 20,
  ),
  ProductModel(
    image: "https://i.imgur.com/q9oF9Yq.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
  ),
  ProductModel(
    image: "https://i.imgur.com/MsppAcx.png",
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/JfyZlnO.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
];

class SecondaryProductCard extends StatelessWidget {
  const SecondaryProductCard({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
    this.press,
    this.style,
  });

  final String image, brandName, title;
  final double price;
  final double? priceAfetDiscount;
  final int? dicountpercent;
  final VoidCallback? press;

  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press, // Use the passed press callback
      style: style ??
          OutlinedButton.styleFrom(
            minimumSize: const Size(256, 114),
            maximumSize: const Size(256, 114),
            padding: const EdgeInsets.all(8),
            side: const BorderSide(color: Colors.black12, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0), // Rectangle shape
            ),
          ),
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                NetworkImageWithLoader(image, radius: 12.0),
                if (dicountpercent != null)
                  Positioned(
                    right: 16.0 / 2,
                    top: 16.0 / 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0 / 2),
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEA5B5B),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Text(
                        "$dicountpercent% off",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(width: 16.0 / 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0 / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandName.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 16.0 / 2),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  priceAfetDiscount != null
                      ? Row(
                          children: [
                            Text(
                              "Rs $priceAfetDiscount",
                              style: const TextStyle(
                                color: Color(0xFF31B0D8),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 16.0 / 4),
                            Text(
                              "Rs $price",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Rs $price",
                          style: const TextStyle(
                            color: Color(0xFF31B0D8),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerSStyle1 extends StatelessWidget {
  const BannerSStyle1({
    super.key,
    this.image = "https://i.imgur.com/K41Mj7C.png",
    required this.title,
    required this.press,
    this.subtitle,
    required this.discountParcent,
  });

  final String? image;
  final String title;
  final String? subtitle;
  final int discountParcent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerS(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Grandis Extended",
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 16.0 / 4),
                    if (subtitle != null)
                      Text(
                        subtitle!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: BannerDiscountTag(
            percentage: discountParcent,
            height: 56,
          ),
        ),
      ],
    );
  }
}

class BannerSStyle5 extends StatelessWidget {
  const BannerSStyle5({
    super.key,
    this.image = "https://i.imgur.com/wQ0sNHT.png",
    required this.title,
    required this.press,
    this.subtitle,
    this.bottomText,
  });

  final String? image;
  final String title;
  final String? subtitle, bottomText;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerS(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subtitle != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0 / 2, vertical: 16.0 / 8),
                        color: Colors.white70,
                        child: Text(
                          subtitle!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16.0 / 2),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Grandis Extended",
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    // const SizedBox(height: defaultPadding / 4),
                    if (bottomText != null)
                      Text(
                        bottomText!,
                        style: const TextStyle(
                          fontFamily: "Grandis Extended",
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              SvgPicture.asset(
                "./images/miniRight.svg",
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    image: "https://i.imgur.com/MsppAcx.png",
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/JfyZlnO.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: "https://i.imgur.com/q9oF9Yq.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];

List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 390.36,
    dicountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfetDiscount: 1200.8,
    dicountpercent: 5,
  ),
  ProductModel(
    image: "https://i.imgur.com/q9oF9Yq.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfetDiscount: 680,
    dicountpercent: 15,
  ),
];

List<ProductModel> kidsProducts = [
  ProductModel(
    image: "https://i.imgur.com/dbbT6PA.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfetDiscount: 590.36,
    dicountpercent: 24,
  ),
  ProductModel(
    image: "https://i.imgur.com/7fSxC7k.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 650.62,
  ),
  ProductModel(
    image: "https://i.imgur.com/pXnYE9Q.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath ",
    brandName: "Lipsy london",
    price: 400,
  ),
  ProductModel(
    image: "https://i.imgur.com/V1MXgfa.png",
    title: "Green Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 400,
    priceAfetDiscount: 360,
    dicountpercent: 20,
  ),
  ProductModel(
    image: "https://i.imgur.com/8gvE5Ss.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 654,
  ),
  ProductModel(
    image: "https://i.imgur.com/cBvB5YB.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 250,
  ),
];

class BannerMWithCounter extends StatefulWidget {
  const BannerMWithCounter({
    super.key,
    this.image = "https://i.imgur.com/pRgcbpS.png",
    required this.text,
    required this.duration,
    required this.press,
  });

  final String image, text;
  final Duration duration;
  final VoidCallback press;

  @override
  State<BannerMWithCounter> createState() => _BannerMWithCounterState();
}

class _BannerMWithCounterState extends State<BannerMWithCounter> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    _duration = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: widget.image,
      press: widget.press,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Grandis Extended",
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlurContainer(
                  text: _duration.inHours.toString().padLeft(2, "0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0 / 4),
                  child: SvgPicture.asset("./images/dot.svg"),
                ),
                BlurContainer(
                  text: _duration.inMinutes
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0 / 4),
                  child: SvgPicture.asset("./images/dot.svg"),
                ),
                BlurContainer(
                  text: _duration.inSeconds
                      .remainder(60)
                      .toString()
                      .padLeft(2, "0"),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class BlurContainer extends StatelessWidget {
  const BlurContainer({
    super.key,
    required this.text,
    this.height = 40,
    this.width = 40,
    this.fontSize = 18,
  });

  final String text;
  final double height, width, fontSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(12.0 / 2),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: height,
          width: height,
          color: Colors.white12,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BannerDiscountTag extends StatelessWidget {
  const BannerDiscountTag({
    super.key,
    this.width = 36,
    this.height = 60,
    required this.percentage,
    this.percentageFontSize = 10,
  });

  final double width, height;
  final int percentage;
  final double percentageFontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "./images/Discount_tag.svg",
            fit: BoxFit.fill,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          Text(
            "$percentage%\noff",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Grandis Extended",
              color: Colors.black54,
              fontSize: percentageFontSize,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class NetworkImageWithLoader extends StatelessWidget {
  final BoxFit fit;

  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
    this.radius = 16.0,
  });

  final String src;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: CachedNetworkImage(
        fit: fit,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      // padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor.withOpacity(0.04),
        color: Theme.of(context).iconTheme.color!.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}

class BannerS extends StatelessWidget {
  const BannerS(
      {super.key,
      required this.image,
      required this.press,
      required this.children});

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.56,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            NetworkImageWithLoader(image, radius: 0),
            Container(color: Colors.black45),
            ...children,
          ],
        ),
      ),
    );
  }
}

class BannerM extends StatelessWidget {
  const BannerM(
      {super.key,
      required this.image,
      required this.press,
      required this.children});

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            NetworkImageWithLoader(image, radius: 0),
            Container(color: Colors.black45),
            ...children,
          ],
        ),
      ),
    );
  }
}
