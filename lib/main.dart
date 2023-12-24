import 'package:flutter/material.dart';
import 'package:shoplist/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Groceries',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 34, 41, 62),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 48, 44, 44),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 92, 92, 92),
      ),
      home: const HomePage(),
    );
  }
}
