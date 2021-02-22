import 'package:flutter/material.dart';
import 'package:todolist/ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TodoList", // App name
      home: Home(), // Definisi halaman
      debugShowCheckedModeBanner: false, //Ngilangin Pita Debug
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
