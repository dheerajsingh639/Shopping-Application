import 'package:flutter/material.dart';

class SuperFlash extends StatefulWidget {
  const SuperFlash({super.key});

  @override
  State<SuperFlash> createState() => _SuperFlashState();
}

class _SuperFlashState extends State<SuperFlash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('SuperFlash'),),);
  }
}
