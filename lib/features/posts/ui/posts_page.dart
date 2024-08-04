import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_empty/features/home/home.dart';
import 'package:news_app_empty/features/posts/bloc/posts_bloc.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/saved_news_page.dart';
import 'package:news_app_empty/features/settings/settings_page.dart';

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
            child: Icon(Icons.add),
            onPressed: () {
              postsBloc.add(PostsInitialFetchEvent());
              setState(() {

              });
            }),
        body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostsFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PostFetchingSuccessfulState:
                final successState = state as PostFetchingSuccessfulState;

                return Container(
                  child: ListView.builder(
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
                                alignment: Alignment(-0.1, -0.4),
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //Text('  ' +successState.posts[index].q,
                                      //style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),),
                                                Container( 
                                                  child: Text('  Tekir',
                                                style: TextStyle(color: Color.fromARGB(255, 241, 230, 230), fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),),
                                                  decoration: BoxDecoration(
                                                  color: Color.fromARGB(255, 148, 14, 14)),
                                                  height:52,
                                                  width: 520),
                                      //Text('  ' + successState.posts[index].a,
                                      //style: TextStyle(color: Color.fromARGB(255, 0, 51, 170), fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),)
                                    ],
                                  ),
                                height: 200,
                                width: 380,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
        drawer: NavigationDrawer()));
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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

  Widget buildMenuItems(BuildContext context) =>
      Wrap(runSpacing: 16, children: [
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
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SettingsPage())), //need to create a settings page feature
        ),
      ]);
}
