import 'package:F4Lab/const.dart';
import 'package:F4Lab/page/PageConfig.dart';
import 'package:F4Lab/page/PageHome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData THEME_DARK = ThemeData(
    primaryColor: Colors.black,
    accentColor: Colors.deepOrange,
    brightness: Brightness.dark);
ThemeData THEME_LIGHT = ThemeData(
    primaryColor: Colors.deepOrange,
    accentColor: Colors.black,
    brightness: Brightness.light);

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool(KEY_THEME_IS_DARK) ?? false;
  print(isDark);
  runApp(MyApp(isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;

  MyApp(this.isDark);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeData themeData;

  @override
  void initState() {
    super.initState();
    themeData = widget.isDark ? THEME_DARK : THEME_LIGHT;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitLab',
      initialRoute: '/',
      theme: themeData,
      routes: {
        '/': (context) => HomePage(widget.isDark, themeChanger),
        '/config': (context) => ConfigPage()
      },
    );
  }

  themeChanger(bool isDark) {
    ThemeData t = isDark ? THEME_DARK : THEME_LIGHT;
    setState(() {
      themeData = t;
    });
    SharedPreferences.getInstance()
        .then((sp) => sp.setBool(KEY_THEME_IS_DARK, isDark));
  }
}
