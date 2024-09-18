
import 'package:flutter/material.dart';

class EmptyPage3 extends StatelessWidget {
  const EmptyPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empty Page 3"),
      ),
      body: const Center(
        child: Text("This is Empty Page 3"),
      ),
    );
  }
}
