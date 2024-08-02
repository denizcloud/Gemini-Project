import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app_empty/features/posts/ui/posts_page.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/saved_news_page.dart';
import 'package:news_app_empty/features/settings/settings_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://cdn.discordapp.com/attachments/1247192970214768684/1268274351715913879/image.png?ex=66adce48&is=66ac7cc8&hm=30970f8a5163fb8e4be2de41593d09b9602429eee05e5ebd2659f89b4be6ba69&"),
            fit: BoxFit.cover,
          ),
        ),
       child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Main "),
          leading: Builder(builder: (context){
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: const Icon(Icons.menu));
          })
        ),
          body: ListView.builder(
            itemBuilder: (_, index)=>
            Stack(
              children: [
                Image.network("https://cdn.discordapp.com/attachments/1137731863482466314/1268886043617398898/newspaper.png?ex=66ae0db7&is=66acbc37&hm=8fbf68ec4f89096c40132836d6f1386abfcac70da55f95e34e248109f5ef64d9&"),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'sample test $index',
                      style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Georgia'),
                    ),
                  ),
                )                
              ],  
            ),
          ),
          drawer: const NavigationDrawer(),
        ));
    });
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

