import 'package:flutter/material.dart';

class EmptyPage1 extends StatelessWidget {
  const EmptyPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empty Page 1"),
      ),
      body: const Center(
        child: Text("This is Empty Page 1"),
      ),
    );
  }
}
