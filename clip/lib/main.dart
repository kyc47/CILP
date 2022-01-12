import 'package:clip/signin.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    document.documentElement!.requestFullscreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CLIP',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: "/",
      home: LoginPage(),
    );
  }
}
