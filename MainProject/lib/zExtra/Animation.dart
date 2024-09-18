// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(ButtonApp());
// }
//
// class ButtonApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ButtonScreen(),
//     );
//   }
// }
//
// class ButtonScreen extends StatefulWidget {
//   const ButtonScreen({super.key});
//
//   @override
//   State<ButtonScreen> createState() => _ButtonScreenState();
// }
//
// class _ButtonScreenState extends State<ButtonScreen> with TickerProviderStateMixin {
//   bool isPlay = false;
//   late AnimationController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       duration: Duration(seconds: 3),
//       vsync: this,
//     );
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             if (isPlay == false) {
//               controller.forward();
//             } else {
//               controller.reverse();
//             }
//             setState(() {
//               isPlay = !isPlay;
//             });
//           },
//           child: AnimatedIcon(
//             icon: AnimatedIcons.play_pause,
//             progress: controller,
//             size: 200,
//           ),
//         ),
//       ),
//     );
//   }
// }
// //home menu,menu_home