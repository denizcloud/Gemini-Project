import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:news_app_empty/features/home/home.dart';
import '/config/app_theme.dart';

void main() {
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
      home: const Banner(
        message: 'hey',
        location: BannerLocation.topEnd,
        child: Home()
    ),
    );
  }
}



