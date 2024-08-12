import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flet/flet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app_empty/features/login/auth_page.dart';
import 'package:news_app_empty/features/news/bloc/ui/news_page.dart';
import 'package:news_app_empty/features/posts/ui/posts_page.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/saved_news_page.dart';
import 'package:news_app_empty/features/settings/settings_page.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    this.index,
  });

  final int? index;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseReference reference = FirebaseDatabase.instance.ref('news');
  

  int _selectedIndex = 0;

  @override
  void initState() {
    if (widget.index != null) {
      _selectedIndex = widget.index!;
    }
    super.initState();
  }

  final _screens = [
    const Center(
      child: Text("Genres of Today"),
    ),
    const Center(
      child: Text("Saved News"),
    ),
  ];

  saveNews(int newsId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList('saved') ?? [];
    String newd = newsId.toString();
    if(saved!.contains(newd)){
      saved.remove(newd);
    }else{
      saved.add(newd);
    }
    await prefs.setStringList('saved', saved);
  }

  openNews(Map news, context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsPage(news: news)));
  }

  Widget listItem({required Map news}) {
    return Container(
      child:GestureDetector(
            onTap: (){
              
              openNews(news, context);
            },
      child: Stack(
        children:[ 
            Image.asset('lib/assets/news_paper.png'), 
          Align(
            alignment: Alignment(-1, 0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height:45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(news['title'],style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(decoration: const BoxDecoration(color: Color.fromARGB(255, 161, 47, 47)),height:42,width: 340, 
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(news['genre'],style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),),
                      IconButton(onPressed: (){
                        saveNews(news['id']);
                      }, icon: Icon(Icons.bookmark)),
                    ],
                  ),
                )),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(news['summary'],style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),),
              ),
                    
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
              )
            ],),
          ),
      ]),)
    );
  }




  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/news_background.png'), 
            fit: BoxFit.cover,
          ),
        ),
       child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: FirebaseAnimatedList(query: reference, itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
 
            Map news = snapshot.value as Map;
            news['key'] = snapshot.key;
 
            return listItem(news: news);
 
          }, )),
        appBar: AppBar(
          title: const Text("Main "),
          leading: Builder(builder: (context){
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: const Icon(Icons.menu));
          })
        ),
        drawer: PageNavigationDrawer()));
    });
  }
}



