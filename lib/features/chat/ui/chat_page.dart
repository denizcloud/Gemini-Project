import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final Gemini gemini = Gemini.instance;
  TextEditingController controller = TextEditingController();
   List conversation = [];
   List users = [];
   bool lock = false;
   

    ScrollController _scrollController = ScrollController();
    
      _scrollToBottom() {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }

  sendText(){
    String text = controller.text.trim();
    if(text.isNotEmpty){
      controller.clear();
      conversation.add(text);
      users.add(0);
      lock = true;
      try{
        gemini.streamGenerateContent(text).listen((event) {
          if (lock){
            String response = event.content?.parts?.fold("", (previous, current) => "$previous${current.text}") ?? ""; 
            conversation.add(response);
            users.add(1);
            setState(() {});
            lock = false;
          }else{
            String lastMessage = conversation[conversation.length-1];
            String response = event.content?.parts?.fold("", (previous, current) => "$previous${current.text}") ?? ""; 
            conversation.removeLast();
            conversation.add(lastMessage + " " + response);
            setState(() {});
          }
        });
      }catch(e){
        print(e);
      }
      setState(() {});
    }

  }

  Widget build_conv(){
  return ListView.builder(itemCount: conversation.length,
              controller: _scrollController,
              itemBuilder: (context, index){
    Color color = Color.fromARGB(255, 141, 204, 141);
    MainAxisAlignment alignment = MainAxisAlignment.start;
    if(users[index] == 0){ 
      alignment = MainAxisAlignment.end;
      color = Color.fromARGB(255, 225,225,225);
    };
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: alignment,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minWidth: 160, maxWidth: 300),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(child: Text(conversation[index], style: const TextStyle(
                          color: Color.fromARGB(255, 31, 31, 31),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia'
                        ),)),
                      ),
                    ),
                  ],
                ),
              );


            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        leading: Builder(builder: (context){
          return IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.menu));
        })
      ),
      drawer: PageNavigationDrawer(),
      body: Column(
        children: [
            SizedBox(
            height: 620,
            width: 400,
            child: build_conv()),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 320,
                  decoration: BoxDecoration(color:  const Color.fromARGB(255, 225, 225, 225),
                  borderRadius: BorderRadius.circular(25)),
                  clipBehavior: Clip.antiAlias,
                  child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                        child: TextField(controller: controller,
                        cursorColor: Colors.transparent,
                        style: const TextStyle(color:  Color.fromARGB(255, 31,31,31),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',),),
                      ),
                    ),
                ),
                 IconButton(onPressed: (){
                  sendText();
                 }, icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}