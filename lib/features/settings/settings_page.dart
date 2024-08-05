import 'package:flutter/material.dart';
import 'package:news_app_empty/features/home/home.dart';
import 'package:news_app_empty/features/home/navigation_drawer.dart';
import 'package:news_app_empty/features/posts/ui/posts_page.dart';
import 'package:news_app_empty/features/saved_news/sn_UI/saved_news_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';
  bool _isDarkTheme = false;
  double _fontSize = 14.0;
  bool _screenReaderEnabled = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          }),
        ),
        drawer: const PageNavigationDrawer(),
        body: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Language',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    dropdownColor: Colors.black, // Ensure dropdown color matches theme
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                    },
                    items: <String>['English', 'Spanish', 'French', 'German']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Theme',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SwitchListTile(
                    title: const Text('Dark Theme', style: TextStyle(color: Colors.white)),
                    value: _isDarkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        _isDarkTheme = value;
                      });
                    },
                    activeColor: Colors.white,
                    tileColor: Colors.transparent,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Font Size',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Slider(
                    value: _fontSize,
                    min: 10,
                    max: 30,
                    divisions: 20,
                    label: _fontSize.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Accessibility',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SwitchListTile(
                    title: const Text('Enable Screen Reader', style: TextStyle(color: Colors.white)),
                    value: _screenReaderEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _screenReaderEnabled = value;
                      });
                    },
                    activeColor: Colors.white,
                    tileColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}