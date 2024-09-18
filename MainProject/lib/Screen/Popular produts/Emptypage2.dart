
import 'package:flutter/material.dart';

class EmptyPage2 extends StatelessWidget {
  const EmptyPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empty Page 2"),
      ),
      body: const Center(
        child: Text("This is Empty Page 2"),
      ),
    );
  }
}
