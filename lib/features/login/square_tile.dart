import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('lib/assets/google_logo.png'),
      height: 42,
    );
  }
}