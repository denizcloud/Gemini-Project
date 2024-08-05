import 'package:flutter/material.dart';
import 'package:news_app_empty/features/login/auth_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/assets/welcome_page.png'))
      ),
      child: Column(
        children: [
          const SizedBox(height: 350),
          const Text('Welcome',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          decoration: TextDecoration.none
          ),),

          const SizedBox(height: 100),
            GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AuthPage()
              ));
            },
            
            child: Container(
              padding: EdgeInsets.all(25),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image(image: AssetImage('lib/assets/sign_in.png')),
              ),
            ))



        ],
      ),
    );
  }
}