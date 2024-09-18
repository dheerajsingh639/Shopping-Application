// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FileThree extends StatelessWidget {
//   FileThree({super.key});
//
//   final Controller cont = Get.put(Controller());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Items List'),
//       ),
//       body: Obx(
//         () => Container(
//           child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 mainAxisSpacing: 3,
//               ),
//               itemCount: cont.addtocart.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   child: Column(
//                     children: [
//                       Image.asset(
//                         cont.addtocart[index],
//                         width: 100,
//                         height: 100,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {
//                             cont.addtocart.remove(cont.addtocart[index]);
//                           },
//                           child: Text('Remove'))
//                     ],
//                   ),
//                 );
//               }),
//         ),
//       ),
//     );
//   }
// }
