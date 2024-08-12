import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:news_app_empty/features/initialize/initialize_page.dart';
import 'package:news_app_empty/features/login/meintextfield.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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

  finalize(){
    String text = "";
    lock = true;
    for(int i = 0; i < conversation.length; i+=2){
      text += conversation[i];
    }
    try{
        gemini.streamGenerateContent("based on this conversation of gemini chat model and the user give me genres of newsthat the user might be interested in with the format of bullitin board, the chat is:" + text).listen((event) {
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
                LinearGradient gradient = const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors:[Color.fromARGB(255, 70, 162, 238), Color.fromARGB(255, 220, 72, 247), Color.fromARGB(255, 236, 29, 98)]);
    Color color = Color.fromARGB(255, 32, 32, 32);
    MainAxisAlignment alignment = MainAxisAlignment.start;
    if(users[index] == 0){ 
      alignment = MainAxisAlignment.end;
      color = Color.fromARGB(255, 31,31,31);
      gradient = LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors:[Color.fromARGB(255, 31, 31, 31), Color.fromARGB(255, 31, 31, 31)]);  
    };
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: alignment,
                  children: [
                    Container(
                      constraints: const BoxConstraints(minWidth: 160, maxWidth: 300),
                      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(25), 
                      gradient: gradient),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Center(child: 
                        Text(conversation[index], style: const TextStyle(
                          color: Color.fromARGB(255, 225, 225, 225),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        )),
),
                      ),
                    ),
                  ],
                ),
              );


            });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('lib/assets/chatground.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){finalize();}, icon: Icon(Icons.send_time_extension)),
                ],
              ),
              SizedBox(
              height: 620,
              width: 400,
              child: build_conv()),
            const SizedBox(height: 0),
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
                          child: MyField(controller: controller, hintText: 'enter prompt', obscureText: false),
                        ),
                      ),
                  ),
                   IconButton(onPressed: (){
                    sendText();
                   }, icon: const Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}