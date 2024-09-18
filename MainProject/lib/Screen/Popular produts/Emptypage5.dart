
import 'package:flutter/material.dart';

class EmptyPage5 extends StatelessWidget {
  const EmptyPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Empty Page 5"),
      ),
      body: const Center(
        child: Text("This is Empty Page 5"),
      ),
    );
  }
}
