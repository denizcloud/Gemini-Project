import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_empty/features/login/meintextfield.dart';
import 'package:news_app_empty/features/login/signin_button.dart';
import 'package:news_app_empty/features/login/square_tile.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});


  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameController.text
    , password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/login_page.png'),
          fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
            children: [
              const SizedBox(height: 175),           
            MyField(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 45),
            MyField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
      
            const SizedBox(height: 40),
      
            MyButton(
              onTap: signUserIn
            ),
            
            const SizedBox(height: 25),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 52.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                    thickness: 2.5,
                    color: Colors.grey[400],
                  ),),
              
                  const Text('   Or login with   ',
                  style: TextStyle(fontFamily: 'Georgia')),  
              
                  Expanded(
                    child: Divider(
                    thickness: 2.5,
                    color: Colors.grey[400],
                  ),),
                ],
              ),
            ),
      
            const SizedBox(height: 25,),
      
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              SquareTile()
            ],),  
            ],
                  ),
          )
      )
      ),
    );
  }
}