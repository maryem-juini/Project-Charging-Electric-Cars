import 'package:flutter/material.dart';
import 'package:project/Screens/Bottom.dart';
import 'package:project/Screens/Header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> previousSearches = ['Taffela Sousse', 'Hammam Sousse','Sahloul Sousse','Kantaoui Sousse','Hergla Sousse'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: HeaderPage(),
        bottomNavigationBar: BottomPage(selectedIndex: 1),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffFBAA1B),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffFBAA1B),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Previous search'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: previousSearches.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(previousSearches[index]),
                      onDismissed: (direction) {
                        setState(() {
                          if (direction == DismissDirection.startToEnd) {
                            previousSearches.removeAt(index);
                          } else {
                            previousSearches.removeAt(index);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item dismissed'),
                          ),
                        );
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        title: Text(previousSearches[index]),
                        trailing: Icon(Icons.close),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}