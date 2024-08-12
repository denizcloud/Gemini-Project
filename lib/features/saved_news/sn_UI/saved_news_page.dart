import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_empty/features/home/home.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:news_app_empty/features/posts/ui/posts_page.dart';
import 'package:news_app_empty/features/saved_news/bloc/saved_news_bloc.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/sn_tile_widget.dart';
import 'package:news_app_empty/features/settings/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedNewsPage extends StatefulWidget{
  const SavedNewsPage ({super.key});

  @override
  State<SavedNewsPage> createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNewsPage>{
  final SavedNewsBloc snBloc = SavedNewsBloc();
  @override
  void initState() {
    snBloc.add(SNInitialEvent());
    super.initState();
}

Future<List> getSaved() async {
  var pref = await SharedPreferences.getInstance();
  List saved = pref.getStringList('saved') ?? [];
  return saved;
}


@override
    Widget build(BuildContext context) {
    Future<List> saved = getSaved();
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/assets/news_background.png'))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Saved Items'),
          leading: Builder(builder: (context){
              return IconButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
            }),
        ),
        body: FutureBuilder(future: saved, builder: (context, snapshot) {
          if(snapshot.hasData){
            return Column(children: [Text(snapshot.data.toString())],);
          }else{
            return const Center(
               child: CircularProgressIndicator(),
               );
          }
        },),
        drawer: PageNavigationDrawer(),
      ),
    );
  }
}
