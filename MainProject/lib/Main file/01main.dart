import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../Welcome Screen/03SharedPerference.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   
  @override

  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //    colorScheme: ColorScheme.fromSeed(
      //    seedColor: const Color.fromARGB(255, 103, 58, 183)),
      //    useMaterial3: true,
      // ),

      debugShowCheckedModeBanner: false,
      home: const LoginCheck(),
    );
  }
}