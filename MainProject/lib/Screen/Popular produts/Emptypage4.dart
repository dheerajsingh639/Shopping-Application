
import 'package:flutter/material.dart';

class EmptyPage4 extends StatelessWidget {
  const EmptyPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empty Page 4"),
      ),
      body: const Center(
        child: Text("This is Empty Page 4"),
      ),
    );
  }
}
