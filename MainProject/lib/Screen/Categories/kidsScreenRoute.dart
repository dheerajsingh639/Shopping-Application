import 'package:flutter/material.dart';

class kidsScreenRoute extends StatefulWidget {
  const kidsScreenRoute({super.key});

  @override
  State<kidsScreenRoute> createState() => _kidsScreenRouteState();
}

class _kidsScreenRouteState extends State<kidsScreenRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(child: Text('hello kidsScreenRoute'),));
  }
}
