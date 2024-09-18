import 'package:flutter/material.dart';

class mansScreenRoute extends StatefulWidget {
  const mansScreenRoute({super.key});

  @override
  State<mansScreenRoute> createState() => _mansScreenRouteState();
}

class _mansScreenRouteState extends State<mansScreenRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(child: Text('hello mansScreenRoute'),));
  }
}
