import 'package:flutter/material.dart';

class SignupButton extends StatelessWidget {
  final Function()? onTap;
  const SignupButton({
    super.key,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 31, 31, 31),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: Text('Sign Up',
          style: TextStyle(color: Color.fromARGB(255, 226, 226, 226),
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia',
          fontSize: 16),),),
          height: 50,
        )),
    );;
  }
}