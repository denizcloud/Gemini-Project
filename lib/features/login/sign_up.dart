import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_empty/features/login/auth_page.dart';
import 'package:news_app_empty/features/login/meintextfield.dart';
import 'package:news_app_empty/features/login/services/auth_service.dart';
import 'package:news_app_empty/features/login/signup_button.dart';
import 'package:news_app_empty/features/login/square_tile.dart';

class SignUpPage extends StatelessWidget {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final re_passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/assets/signup_page.png'))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 160),
                MyField(controller: usernameController, hintText: 'Email', obscureText: false),
                const SizedBox(height: 50),
                MyField(controller: passwordController, hintText: 'Password', obscureText: true),
                const SizedBox(height: 60),
                MyField(controller: re_passwordController, hintText: 'Password', obscureText: true),
                const SizedBox(height: 25),
                const SignupButton(onTap: null),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(onTap: () => AuthService().signInWithGoogle()),
                  ],
                ),

                const SizedBox(height: 100),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text('Sign DONT',
                    style: TextStyle(color: Color.fromARGB(255, 226, 226, 226),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Georgia',
                    fontSize: 16),),),
                    height: 50,
                  )),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}