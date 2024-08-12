import 'package:flutter/material.dart';
import 'package:news_app_empty/features/chat/ui/chat_page.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:news_app_empty/features/login/meintextfield.dart';

class NewsPage extends StatefulWidget {
  final Map news;

  const NewsPage({super.key, required this.news});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final Gemini gemini = Gemini.instance;
  TextEditingController controller = TextEditingController();
  List conversation = [];
  List users = [];
  bool lock = false;

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

    sendText() {
    String text = controller.text.trim();
    if (text.isNotEmpty) {
      controller.clear();
      conversation.add(text);
      users.add(0);
      lock = true;
      text = "$text, in the article: ${widget.news['article']}";
      try {
         gemini.streamGenerateContent(text).listen((event) {
          if (lock) {
            String response = event.content?.parts?.fold("", (previous, current) => "$previous${current.text}") ?? "";
            conversation.add(response);
            users.add(1);
            setState(() {});
            lock = false;
          } else {
            String lastMessage = conversation[conversation.length - 1];
            String response = event.content?.parts?.fold("", (previous, current) => "$previous${current.text}") ?? "";
            conversation.removeLast();
            conversation.add(lastMessage + " " + response);
            setState(() {});
          }

          showDialog(context: context, builder: (context){
              return AlertDialog(content: Text(conversation.last.toString(),
          style: TextStyle(color: Color.fromARGB(255, 225, 225, 225)),),
          actions: [
              TextButton(onPressed: (){
                setState(() {});
              }, child: Text('refresh')),TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('done'))],);
          });
            setState(() {});


        });
      } catch (e) {
        print(e);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Main "),
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          })),
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      drawer: PageNavigationDrawer(),
      body: Container(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(widget.news['title'],
                  style: const TextStyle(
                      fontFamily: 'Georgia',
                      color: Color.fromARGB(255, 31, 31, 31),
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 161, 47, 47)),
                  width: 390,
                  height: 52,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(widget.news['genre'],
                          style: const TextStyle(
                              fontFamily: 'Georgia',
                              color: Color.fromARGB(255, 225, 225, 225),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
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
                  child: SizedBox(
                    height: 500,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(widget.news['article'],
                          style: const TextStyle(
                              fontFamily: 'Georgia',
                              color: Color.fromARGB(255, 31, 31, 31),
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 320,
                      child: MyField(
                          controller: controller,
                          hintText: "Ask About Article",
                          obscureText: false),
                    ),
                    IconButton(
                      onPressed: () {
                        sendText();
                      },
                      icon: const Icon(Icons.send),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}