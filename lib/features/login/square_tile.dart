import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {

  final Function()? onTap;

  const SquareTile({super.key,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return

    GestureDetector(
      onTap: null, 
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Image.asset('lib/assets/google_logo.png'),
          height: 42,
        ),
      ));
  }
}