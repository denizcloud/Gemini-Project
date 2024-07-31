import 'package:flutter/material.dart';

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
      return Scaffold(
          body: Container(
            child: _screens[_selectedIndex],
          ),
          drawer: const NavigationDrawer());
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
          leading: const Icon(Icons.deck),
          title: const Text('Genre'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Home())),
        ),
        ListTile(
          leading: const Icon(Icons.bookmark),
          title: const Text('Saved'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const saved_news())), //need to create the saved news page in sn_UI.dart
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const settings_page())), //need to create a settings page feature
        ),
      ]);
}
