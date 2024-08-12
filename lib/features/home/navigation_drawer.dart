import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_empty/features/chat/ui/chat_page.dart';
import 'package:news_app_empty/features/home/home.dart';
import 'package:news_app_empty/features/login/auth_page.dart';
import 'package:news_app_empty/features/posts/ui/posts_page.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/saved_news_page.dart';
import 'package:news_app_empty/features/settings/settings_page.dart';

class PageNavigationDrawer extends StatelessWidget {



  PageNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ));
  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );


  Widget buildMenuItems(BuildContext context){
      return Wrap(runSpacing: 16, children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Main'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Home())),
        ),
        ListTile(
          leading: const Icon(Icons.deck),
          title: const Text('Genre'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PostsPage())),
        ),
        ListTile(
          leading: const Icon(Icons.bookmark),
          title: const Text('Saved'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SavedNewsPage())), //need to create the saved news page in sn_UI.dart
        ),
        ListTile(
          leading: const Icon(Icons.chat_bubble),
          title: const Text('Chat'),
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ChatPage()));
          } //need to create a settings page feature
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SettingsPage())), //need to create a settings page feature
        ),
        const SizedBox(height: 410),
        const SizedBox(height: 30),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage()));
          } //need to create a settings page feature
        ),
        
      ]);}
}