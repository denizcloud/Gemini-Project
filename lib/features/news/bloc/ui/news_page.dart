import 'package:flutter/material.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';

class NewsPage extends StatelessWidget {
  final Map news;

  const NewsPage({super.key,
  required this.news});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Main "),
          leading: Builder(builder: (context){
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: const Icon(Icons.menu));
          })
        ),
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      drawer: PageNavigationDrawer(),

      body: Container(
        child: Center(child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(news['title'],
              style: const TextStyle(fontFamily: 'Georgia', color: Color.fromARGB(255, 31, 31, 31), fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 161, 47, 47)
                  ),
                  width: 390,
                  height: 52,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(news['genre'],
                      style: const TextStyle(fontFamily: 'Georgia', color: Color.fromARGB(255, 225, 225, 225), fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(news['article'],
                  style: const TextStyle(fontFamily: 'Georgia', color: Color.fromARGB(255, 31, 31, 31), fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ],
            ),
          ],),
        )),
    );
  }
}