import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_app_empty/features/chat/ui/chat_page.dart';
import 'package:news_app_empty/features/home/home.dart';
import 'package:news_app_empty/features/login/auth_page.dart';
import 'package:news_app_empty/features/login/start_page.dart';
import 'package:news_app_empty/features/posts/ui/posts_page.dart';
import '/config/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: 'AIzaSyCP1zqfDhDSxM8LH84xtzFvwTlzfl_LThs');
  runApp(DevicePreview(
    enabled: true,
    builder: (context)=> (const MainApp())));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App Demo",
      theme: AppTheme.darkTheme,
      home: Banner(
        message: 'hey',
        location: BannerLocation.topEnd,
        child: StartPage()
    ),
    );
  }
}



