import 'package:flutter/material.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 1),
        body: const Center(
          child: Text('SearchPage'),
        ),
      ));
  }
}