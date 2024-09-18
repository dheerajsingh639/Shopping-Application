// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '03AddtoCart.dart';
//
// class FileTwo extends StatelessWidget {
//   var variable;
//
//   FileTwo({super.key, required this.variable});
//
//   final Controller cont = Get.put(Controller());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detail screen'),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 width: MediaQuery.of(context).size.width * 1,
//                 child: Image.asset(variable),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   cont.addtocart.add(variable);
//                   Get.to(() => FileThree());
//                 },
//                 child: Text('Add to cart'))
//           ],
//         ),
//       ),
//     );
//   }
// }
