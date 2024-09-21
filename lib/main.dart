import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/idea_info.dart';
import 'package:flutter_app/screen/edit_screen.dart';
import 'package:flutter_app/screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 데모',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => const MainScreen()},
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final IdeaInfo? idea = settings.arguments as IdeaInfo?;
          return MaterialPageRoute(
              builder: (context) => EditScreen(idea: idea));
        }
        return null;
      },
    );
  }
}
