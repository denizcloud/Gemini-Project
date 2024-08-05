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
@override
    Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocConsumer<SavedNewsBloc, SavedNewsState>(
        bloc: snBloc,
        listener: (context, state) {
          
        },
        listenWhen: (previous, current) => current is SNActionState,
        buildWhen: (previous, current) => current is! SNActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case SavedSuccessState:
              final successState = state as SavedSuccessState;
              return ListView.builder(
                  itemCount: successState.snItems.length,
                  itemBuilder: (context, index) {
                    return NewsTileWidget(
                        snBloc: snBloc,
                        newsDataModel: successState.snItems[index]);
                  });

            default:
          }
          return Container();
        },
      ),
      drawer: const PageNavigationDrawer(),
    );
  }
}
