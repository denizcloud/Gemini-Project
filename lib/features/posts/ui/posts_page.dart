import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_empty/features/home/home.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:news_app_empty/features/posts/bloc/posts_bloc.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/saved_news_page.dart';
import 'package:news_app_empty/features/settings/settings_page.dart';
import 'package:news_app_empty/features/posts/ui/filterbar.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  String title = "Kedicikler";
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/news_background.png'), 
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(title),
                  leading: Builder(builder: (context){
                    return IconButton(onPressed: (){
                      Scaffold.of(context).openDrawer();
                    }, icon: const Icon(Icons.menu));
                  })
                ),
                floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      postsBloc.add(PostsInitialFetchEvent());
                      setState(() {

                      });
                    }),
                body: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: FilterBar(options: {'Sports', 'Tech', 'Whatever user wants'}),
                    ),
                    Expanded(
                      child: BlocConsumer<PostsBloc, PostsState>(
                        bloc: postsBloc,
                        listenWhen: (previous, current) => current is PostsActionState,
                        buildWhen: (previous, current) => current is! PostsActionState,
                        listener: (context, state) {},
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case PostsFetchingLoadingState _:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case PostFetchingSuccessfulState _:
                              final successState = state as PostFetchingSuccessfulState;

                              return ListView.builder(
                                  itemCount: successState.posts.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(0),
                                      child: Stack(
                                        children: [
                                          Image.asset('lib/assets/news_paper.png'),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: const Alignment(-0.1, -0.4),
                                              child: SizedBox(

                                                height: 200,
                                              width: 380,

                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    //Text('  ' +successState.posts[index].q,
                                                    //style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),),
                                                              Container( 
                                                                decoration: const BoxDecoration(
                                                                color: Color.fromARGB(255, 148, 14, 14)),
                                                                height:52,
                                                                width: 520, 
                                                                child: const Text('  Tekir',
                                                              style: TextStyle(color: Color.fromARGB(255, 241, 230, 230), fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),)),
                                                    //Text('  ' + successState.posts[index].a,
                                                    //style: TextStyle(color: Color.fromARGB(255, 0, 51, 170), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                            default:
                              return const SizedBox();
                          }
                        },
                    )
                  )]
                ),
                drawer: const PageNavigationDrawer()
              )
    );
  }
}