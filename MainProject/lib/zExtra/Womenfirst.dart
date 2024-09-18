// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shimmer/shimmer.dart';
//
// class WomenBuyandAddtocart extends StatefulWidget {
//   final String photodata;
//   final String namesdata;
//   final String pricedata;
//   final stardata;
//
//   WomenBuyandAddtocart({
//     required this.photodata,
//     required this.namesdata,
//     required this.pricedata,
//     required this.stardata,
//   });
//
//   @override
//   State<WomenBuyandAddtocart> createState() => _WomenBuyandAddtocartState();
// }
//
// class _WomenBuyandAddtocartState extends State<WomenBuyandAddtocart> {
//   late bool IsLoding = false;
//   late bool isLoding = false;
//
//   // Review Text show hide logic
//   bool isTextVisible = true;
//
//   void toggleTextVisibility() {
//     setState(() {
//       isTextVisible = !isTextVisible;
//     });
//   }
//
//   // Review Text show hide logic
//
//   //Description text hiding logic
//   bool _isReadMoreVisible = false;
//   bool _isTextVisible = true;
//
//   void _toggleTextVisibility() {
//     setState(() {
//       _isTextVisible = !_isTextVisible;
//       _isReadMoreVisible = !_isReadMoreVisible;
//     });
//   }
//
//   //Description text hiding logic
//
//   //payment logic
//   late Razorpay _razorpay;
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear(); // Removes all listeners
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Do something when payment succeeds
//     print("Payment Success: ${response.paymentId}");
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//     print("Payment Error: ${response.code} - ${response.message}");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet is selected
//     print("External Wallet: ${response.walletName}");
//   }
//
//   void openCheckout() {
//     var options = {
//       'key': 'rzp_test_YRnnwNpzujfRjW', // Replace with your actual Razorpay key
//       'amount': 100, // Amount in paise (e.g., 100 paise = 1 INR)
//       'name': 'Test Payment',
//       'description': 'Payment for testing',
//       'prefill': {'contact': '8168124393', 'email': 'ds681145@gmail.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   // payment logic
//
//   bool isPlay = false;
//   late AnimationController controller;
//
//   List<int> _selectedIndices = [];
//
//   void _onContainerTap(int index) {
//     setState(() {
//       if (_selectedIndices.contains(index)) {
//         _selectedIndices.remove(index);
//       } else {
//         if (_selectedIndices.length < 2) {
//           _selectedIndices.add(index);
//         } else {
//           _selectedIndices[1] = index; // Replace the second selected container
//         }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Flexible(
//         flex: 0,
//         child: SingleChildScrollView(
//             child: Column(
//           children: [
//             SizedBox(
//               height: 580,
//               child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       CachedNetworkImage(
//                         key: UniqueKey(),
//                         imageUrl: widget.photodata,
//                         //maxHeightDiskCache: 200,
//                         placeholder: (context, url) => Shimmer.fromColors(
//                           baseColor: Colors.red,
//                           highlightColor: Colors.yellow,
//                           child: Center(
//                             child: SizedBox(
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                         ),
//                         errorWidget: (context, url, error) =>
//                             Shimmer.fromColors(
//                           baseColor: Colors.red,
//                           highlightColor: Colors.yellow,
//                           child: Container(
//                             height: 630,
//                             width: 410,
//                             color: Colors.black12,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       CachedNetworkImage(
//                         key: UniqueKey(),
//                         imageUrl: widget.photodata,
//                         //maxHeightDiskCache: 200,
//                         placeholder: (context, url) => Shimmer.fromColors(
//                           baseColor: Colors.red,
//                           highlightColor: Colors.yellow,
//                           child: Center(
//                             child: SizedBox(
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                         ),
//                         errorWidget: (context, url, error) =>
//                             Shimmer.fromColors(
//                           baseColor: Colors.red,
//                           highlightColor: Colors.yellow,
//                           child: Container(
//                             height: 630,
//                             width: 410,
//                             color: Colors.black12,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       CachedNetworkImage(
//                         key: UniqueKey(),
//                         imageUrl: widget.photodata,
//                         //maxHeightDiskCache: 200,
//                         placeholder: (context, url) => Shimmer.fromColors(
//                           baseColor: Colors.red,
//                           highlightColor: Colors.yellow,
//                           child: Center(
//                             child: SizedBox(
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                         ),
//                         errorWidget: (context, url, error) =>
//                             Shimmer.fromColors(
//                           baseColor: Colors.red,
//                           highlightColor: Colors.yellow,
//                           child: Container(
//                             height: 630,
//                             width: 410,
//                             color: Colors.black12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Text(
//               widget.namesdata,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             const Row(
//               children: [
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Icon(
//                   Icons.star,
//                   size: 14,
//                 ),
//                 Icon(
//                   Icons.star,
//                   size: 14,
//                 ),
//                 Icon(
//                   Icons.star,
//                   size: 14,
//                 ),
//                 Icon(
//                   Icons.star,
//                   size: 14,
//                 ),
//                 Icon(
//                   Icons.star_border,
//                   size: 14,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Divider(
//               color: Colors.black,
//               height: 10,
//               thickness: 1,
//               indent: 10,
//               endIndent: 10, // Right indent
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               widget.pricedata,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Divider(
//               color: Colors.black,
//               height: 10,
//               thickness: 1,
//               indent: 10,
//               endIndent: 10, // Right indent
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Row(
//               children: [
//                 SizedBox(
//                   width: 30,
//                 ),
//                 Text("Colour"),
//                 SizedBox(
//                   width: 190,
//                 ),
//                 Text("Size"),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 const SizedBox(width: 20),
//                 InteractiveContainer(
//                   index: 0,
//                   isSelected: _selectedIndices.contains(0),
//                   color: Colors.brown,
//                   onTap: _onContainerTap,
//                   child: SizedBox(width: 25, height: 25),
//                 ),
//                 const SizedBox(height: 20),
//                 InteractiveContainer(
//                   index: 1,
//                   isSelected: _selectedIndices.contains(1),
//                   color: Colors.white,
//                   onTap: _onContainerTap,
//                   child: SizedBox(width: 25, height: 25),
//                 ),
//                 const SizedBox(height: 20),
//                 InteractiveContainer(
//                   index: 2,
//                   isSelected: _selectedIndices.contains(2),
//                   color: Colors.red,
//                   onTap: _onContainerTap,
//                   child: SizedBox(width: 25, height: 25),
//                 ),
//                 const SizedBox(width: 120),
//                 SizedBox(width: 20),
//                 InteractiveContainer(
//                   index: 3,
//                   isSelected: _selectedIndices.contains(3),
//                   color: Colors.white,
//                   onTap: _onContainerTap,
//                   child: Center(child: Text('S')),
//                 ),
//                 SizedBox(height: 20),
//                 InteractiveContainer(
//                   index: 4,
//                   isSelected: _selectedIndices.contains(4),
//                   color: Colors.white,
//                   onTap: _onContainerTap,
//                   child: Center(child: Text('M')),
//                 ),
//                 SizedBox(height: 20),
//                 InteractiveContainer(
//                   index: 5,
//                   isSelected: _selectedIndices.contains(5),
//                   color: Colors.white,
//                   onTap: _onContainerTap,
//                   child: Center(child: Text('L')),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//
//             // Description Text show hide logic
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(width: 20),
//                       Text(
//                         'Description',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                       Spacer(),
//                       IconButton(
//                         icon: Icon(_isTextVisible
//                             ? Icons.arrow_forward_ios
//                             : Icons.arrow_downward),
//                         onPressed: _toggleTextVisibility,
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: RichText(
//                       text: TextSpan(
//                         text: _isTextVisible
//                             ? 'Step into the spotlight with the Radiant Midnight Blue Evening Gown, a masterpiece of sophistication and style. This exquisite gown is designed to make you the center of attention at any formal event, from glamorous galas to elegant weddings dress.'
//                             : 'Step into the spotlight with the Radiant Midnight Blue Evening Gown, a masterpiece of sophistication and style. This exquisite gown is designed to make you the center of attention at any formal event, from glamorous galas to elegant weddings. The deep midnight blue hue exudes a sense of mystery and elegance. The fabric has a subtle sheen that catches the light beautifully, adding an extra touch of glamour to your ensemble. The gown showcases a timeless A-line silhouette that flatters all body types. The fitted bodice accentuates the waist, while the flowing skirt drapes gracefully to the floor, creating a stunning silhouette that moves beautifully with every step. The sweetheart neckline adds a romantic touch, framing the face and décolletage with elegance. Delicate off-the-shoulder sleeves provide a feminine and alluring look, perfect for showcasing your shoulders and collarbones. Intricate beadwork and sequins adorn the bodice, catching the light and adding a hint of sparkle to your evening. Whether you\'re attending a black-tie event, prom, or a sophisticated dinner party, the Radiant Midnight Blue Evening Gown ensures you make a lasting impression.',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14.0,
//                         ),
//                         children: [
//                           WidgetSpan(
//                             alignment: PlaceholderAlignment.middle,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 0),
//                               child: TextButton(
//                                 onPressed: _toggleTextVisibility,
//                                 child: Text(
//                                   _isTextVisible ? ' Read More' : ' Show Less',
//                                   style: TextStyle(
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Description Text show hide logic
//
//             // Review Text show hide logic
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       const SizedBox(width: 20),
//                       const Text(
//                         'Review',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.w600),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         icon: Icon(isTextVisible
//                             ? Icons.arrow_forward_ios
//                             : Icons.arrow_downward),
//                         onPressed: toggleTextVisibility,
//                       ),
//                     ],
//                   ),
//                   if (isTextVisible)
//                     Column(
//                       children: [
//                         Row(
//                           children: [
//                             RatingBarIndicator(
//                               rating: 4.5,
//                               itemBuilder: (context, index) => Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                               ),
//                               itemCount: 5,
//                               itemSize: 20.0,
//                             ),
//                             SizedBox(width: 8),
//                             Text(
//                               '4.5 (200 reviews)',
//                               style: TextStyle(
//                                   fontSize: 16, color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Customer Reviews',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 16),
//
//                         // Review 1
//                         ReviewCard(
//                           reviewerName: 'John Doe',
//                           reviewDate: 'July 20, 2024',
//                           rating: 5.0,
//                           reviewText:
//                               'Excellent product! I absolutely love it. The quality is top-notch and it exceeds my expectations. Highly recommend!',
//                         ),
//                         SizedBox(height: 16),
//
//                         // Review 2
//                         ReviewCard(
//                           reviewerName: 'Jane Smith',
//                           reviewDate: 'July 15, 2024',
//                           rating: 4.0,
//                           reviewText:
//                               'Great product, but it took a while to arrive. The quality is good, but I had some issues with the delivery.',
//                         ),
//                         SizedBox(height: 16),
//                         // Review 3
//                         ReviewCard(
//                           reviewerName: 'Alice Johnson',
//                           reviewDate: 'July 10, 2024',
//                           rating: 3.5,
//                           reviewText:
//                               'The product is okay, but I expected more based on the description. It works, but it’s not as impressive as I hoped.',
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             // Review Text show hide logic
//
//             SizedBox(
//               height: 20,
//             ),
//             // Add to Cart button ------------>
//             // ElevatedButton(
//             //   onPressed: () {
//             //     setState(() {
//             //       IsLoding = true;
//             //     });
//             //     Future.delayed(Duration(seconds: 1), () {
//             //       setState(() {
//             //         IsLoding = false;
//             //       });
//             //     });
//             //     Get.to(Cart(Photodata: widget.photodata));
//             //   },
//             //   style: ElevatedButton.styleFrom(
//             //     backgroundColor: Colors.black,
//             //     textStyle: const TextStyle(fontSize: 16),
//             //   ),
//             //   child: IsLoding
//             //       ? CircularProgressIndicator(
//             //           color: Colors.white,
//             //         )
//             //       : Text(
//             //           'Add to Cart',
//             //           style: const TextStyle(
//             //               fontSize: 17,
//             //               fontWeight: FontWeight.w400,
//             //               color: Colors.white),
//             //         ),
//             // ),
//             // Add to Cart button ------------>
//             SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 openCheckout();
//                 setState(() {
//                   isLoding = true;
//                 });
//                 Future.delayed(Duration(seconds: 3), () {
//                   setState(() {
//                     isLoding = false;
//                   });
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.black,
//                 textStyle: const TextStyle(fontSize: 16),
//               ),
//               child: isLoding
//                   ? CircularProgressIndicator(
//                       color: Colors.white,
//                     )
//                   : Text(
//                       'Buy Now',
//                       style: const TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.white),
//                     ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
//
// // Colours Border hover in this class ------------------------->
// class InteractiveContainer extends StatefulWidget {
//   final int index;
//   final bool isSelected;
//   final Color color;
//   final Widget child;
//   final Function(int) onTap;
//
//   InteractiveContainer({
//     required this.index,
//     required this.isSelected,
//     required this.color,
//     required this.child,
//     required this.onTap,
//   });
//
//   @override
//   _InteractiveContainerState createState() => _InteractiveContainerState();
// }
//
// class _InteractiveContainerState extends State<InteractiveContainer> {
//   bool _isHovered = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: () => widget.onTap(widget.index),
//         child: Container(
//           width: 25.0,
//           height: 25.0,
//           decoration: BoxDecoration(
//             color: widget.color,
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: widget.isSelected
//                   ? Colors.black
//                   : (_isHovered ? Colors.blue : Colors.white),
//               width: 1.5,
//             ),
//           ),
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }
// // Colours Border hover in this class ------------------------->
//
// // Rating and reviews class
// class ReviewCard extends StatelessWidget {
//   final String reviewerName;
//   final String reviewDate;
//   final double rating;
//   final String reviewText;
//
//   const ReviewCard({
//     required this.reviewerName,
//     required this.reviewDate,
//     required this.rating,
//     required this.reviewText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               reviewerName,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               reviewDate,
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             SizedBox(height: 8),
//             RatingBarIndicator(
//               rating: rating,
//               itemBuilder: (context, index) => Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               itemCount: 5,
//               itemSize: 20.0,
//             ),
//             SizedBox(height: 8),
//             Text(
//               reviewText,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
