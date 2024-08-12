import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController controller = TextEditingController();
   List conversation = [];

   

  sendText(){
    String text = controller.text.trim();
    if(text.isNotEmpty){
      conversation.add(text);
      setState(() {});
    }

  }

  Widget build_conv(){
  return ListView.builder(itemCount: conversation.length,itemBuilder: (context, index){
    MainAxisAlignment alignment = MainAxisAlignment.end;
    if(index %2 == 0) alignment = MainAxisAlignment.start;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: alignment,
                  children: [
                    Container(
                      width: 160,
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 225,225,225), borderRadius: BorderRadius.circular(25)),
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
            height: 600,
            width: 400,
            child: build_conv()),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 60,
                width: 350,
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
        ],
      ),
    );
  }
}