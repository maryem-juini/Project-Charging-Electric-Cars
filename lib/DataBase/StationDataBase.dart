import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StationDataBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Save JSON data to Firestore
              saveDataToFirestore();
            },
            child: Text('Save Data to Firestore'),
          ),
        ),
      ),
    );
  }

  void saveDataToFirestore() async {
    // JSON data to be saved
    List<Map<String, dynamic>> jsonData = [
      {
        "station_name": "Tunis Central",
        "address": {
          "latitude": 36.8188,
          "longitude": 10.1658,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 7
      },
      {
        "station_name": "Sfax Downtown",
        "address": {
          "latitude": 34.7477,
          "longitude": 10.7626,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 3
      },
      {
        "station_name": "Sousse Transit",
        "address": {
          "latitude": 35.8288,
          "longitude": 10.6407,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 6
      },
      {
        "station_name": "Kairouan Hub",
        "address": {
          "latitude": 35.6784,
          "longitude": 10.0956,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 8
      },
      {
        "station_name": "Bizerte Terminal",
        "address": {
          "latitude": 37.2692,
          "longitude": 9.8635,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 4
      },
      {
        "station_name": "Gabès Point",
        "address": {
          "latitude": 33.8886,
          "longitude": 10.1033,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 2
      },
      {
        "station_name": "Ariana Stop",
        "address": {
          "latitude": 36.8663,
          "longitude": 10.1932,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 9
      },
      {
        "station_name": "Gafsa Square",
        "address": {
          "latitude": 34.4305,
          "longitude": 8.7789,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 5
      },
      {
        "station_name": "Monastir Junction",
        "address": {
          "latitude": 35.7664,
          "longitude": 10.8272,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 1
      },
      {
        "station_name": "Tataouine Transit",
        "address": {
          "latitude": 32.9269,
          "longitude": 10.4518,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 0
      },
      {
        "station_name": "Nabeul Central",
        "address": {
          "latitude": 36.4562,
          "longitude": 10.7351,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 6
      },
      {
        "station_name": "Ben Arous Hub",
        "address": {
          "latitude": 36.7538,
          "longitude": 10.2316,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 3
      },
      {
        "station_name": "Mahdia Transit",
        "address": {
          "latitude": 35.5078,
          "longitude": 11.0741,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 7
      },
      {
        "station_name": "Zarzis Point",
        "address": {
          "latitude": 33.5044,
          "longitude": 11.1029,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 4
      },
      {
        "station_name": "Hammamet Central",
        "address": {
          "latitude": 36.4054,
          "longitude": 10.568,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 8
      },
      {
        "station_name": "Jendouba Point",
        "address": {
          "latitude": 36.5003,
          "longitude": 8.7803,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 6
      },
      {
        "station_name": "Kef Terminal",
        "address": {
          "latitude": 36.1791,
          "longitude": 8.7048,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 2
      },
      {
        "station_name": "Kasserine Junction",
        "address": {
          "latitude": 35.1686,
          "longitude": 8.837,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 5
      },
      {
        "station_name": "Zaghouan Transit",
        "address": {
          "latitude": 36.4041,
          "longitude": 10.1426,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 1
      },
      {
        "station_name": "Medenine Point",
        "address": {
          "latitude": 33.3547,
          "longitude": 10.4937,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 9
      },
      {
        "station_name": "Manouba Stop",
        "address": {
          "latitude": 36.8167,
          "longitude": 9.8669,
          "accuracy": 100.0,
          "altitude": 0.0,
          "speed": 0.0,
          "speed_accuracy": 0.0,
          "heading": 0.0,
          "time": 1620696220000,
          "vertical_accuracy": 0.0
        },
        "slots": 3
      },
      {
      "station_name": "Djerba Port",
      "address": {
        "latitude": 33.8763,
        "longitude": 10.8575,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 6
    },
    {
      "station_name": "Nabeul East",
      "address": {
        "latitude": 36.4566,
        "longitude": 10.7376,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 3
    },
    {
      "station_name": "Kelibia Transit",
      "address": {
        "latitude": 36.8532,
        "longitude": 11.0888,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 5
    },
    {
      "station_name": "El Jem Point",
      "address": {
        "latitude": 35.2994,
        "longitude": 10.7102,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 8
    },
    {
      "station_name": "Kairouan Central",
      "address": {
        "latitude": 35.6816,
        "longitude": 10.1004,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 4
    },
    {
      "station_name": "Beja Downtown",
      "address": {
        "latitude": 36.7261,
        "longitude": 9.1847,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 7
    },
    {
      "station_name": "Tunis Central",
      "address": {
        "latitude": 36.8065,
        "longitude": 10.1815,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 2
    },
    {
      "station_name": "Monastir Point",
      "address": {
        "latitude": 35.7696,
        "longitude": 10.8251,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 9
    },
    {
      "station_name": "Hammamet West",
      "address": {
        "latitude": 36.3949,
        "longitude": 10.6033,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 3
    },
    {
      "station_name": "Sousse Hub",
      "address": {
        "latitude": 35.8252,
        "longitude": 10.6368,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 6
    },
    {
      "station_name": "Tunis Airport",
      "address": {
        "latitude": 36.8514,
        "longitude": 10.2275,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 4
    },
    {
      "station_name": "Mahdia Transit",
      "address": {
        "latitude": 35.5061,
        "longitude": 11.0604,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 5
    },
    {
      "station_name": "Gabes Central",
      "address": {
        "latitude": 33.8848,
        "longitude": 10.0982,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 7
    },
    {
      "station_name": "Sfax Central",
      "address": {
        "latitude": 34.7486,
        "longitude": 10.7626,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 2
    },
    {
      "station_name": "Sousse Central",
      "address": {
        "latitude": 35.8288,
        "longitude": 10.6407,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 9
    },
    {
      "station_name": "Kairouan Central",
      "address": {
        "latitude": 35.6816,
        "longitude": 10.1004,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 3
    },
    {
      "station_name": "Bizerte Central",
      "address": {
        "latitude": 37.2692,
        "longitude": 9.8635,
        "accuracy": 100.0,
        "altitude": 0.0,
        "speed": 0.0,
        "speed_accuracy": 0.0,
        "heading": 0.0,
        "time": 1620696220000,
        "vertical_accuracy": 0.0
      },
      "slots": 6
    },
    ];
    CollectionReference Stations = FirebaseFirestore.instance.collection('Stations');

    for (var data in jsonData) {
      await Stations.add(data);
    }

    print('All data saved to Firestore');
  }
}
