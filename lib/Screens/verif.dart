import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class verif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DuplicateDataScreen()),
            );
          },
          child: Text('Search for Duplicates'),
        ),
      ),
    );
  }
}

class DuplicateDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Duplicate Data'),
      ),
      body: DuplicateDataList(),
    );
  }
}

class DuplicateDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final List<String> duplicateModels = snapshot.data!;
          return ListView.builder(
            itemCount: duplicateModels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(duplicateModels[index]),
              );
            },
          );
        }
      },
    );
  }

  Future<List<String>> fetchData() async {
    try {
      // Fetch all car documents from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Cars').get();

      // List to store duplicate models
      List<String> duplicateModels = [];

      // Set to keep track of seen models
      Set<String> seenModels = {};

      // Iterate through car documents
      querySnapshot.docs.forEach((doc) {
        String model = doc['model'];
        if (seenModels.contains(model)) {
          // Model is duplicate
          duplicateModels.add(model);
        } else {
          // Mark model as seen
          seenModels.add(model);
        }
      });

      return duplicateModels;
    } catch (error) {
      throw ('Error fetching data: $error');
    }
  }
}
