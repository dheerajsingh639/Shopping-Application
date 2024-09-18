// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '02AddtoCart.dart';
//
// class FileOne extends StatelessWidget {
//   FileOne({super.key});
//
//   final Controller cont = Get.put(Controller());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('shopping'),
//       ),
//       body: Obx(
//         () => Container(
//           child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 3,
//               ),
//               itemCount: cont.photos.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                   onTap: () {
//                     //print('done');
//                     Get.to(() => FileTwo(
//                           variable: cont.photos[index],
//                         ));
//                   },
//                   child: Card(
//                     color: Colors.amber,
//                     child: Image.asset(cont.photos[index]),
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
