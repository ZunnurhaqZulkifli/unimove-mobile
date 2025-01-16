import 'package:flutter/material.dart';

class UnverifiedHomePage extends StatefulWidget {
  const UnverifiedHomePage({super.key});

  @override
  State<UnverifiedHomePage> createState() => _UnverifiedHomePageState();
}

class _UnverifiedHomePageState extends State<UnverifiedHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('Welcome To Your Home'),
            // PhotoCarousel(),
          ],
        ),
      ),
    );
  }
}
