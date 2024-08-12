import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_empty/features/login/auth_page.dart';
import 'package:news_app_empty/features/login/meintextfield.dart';
import 'package:news_app_empty/features/login/services/auth_service.dart';
import 'package:news_app_empty/features/login/sign_up.dart';
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
      
            const SizedBox(height: 60),
      
            MyButton(
              onTap: signUserIn
            ),
            
            const SizedBox(height: 95),
      
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
              SquareTile(onTap:  () => AuthService().signInWithGoogle())
            ],),  

            const SizedBox(height: 150),
            
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
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
          )
      )
      ),
    );
  }
}