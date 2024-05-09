import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyApp extends StatelessWidget {
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
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 450
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 380
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 310
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 360
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 300
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 480
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 420
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 370
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 360
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 410
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 390
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 320
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 370
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 310
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 490
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 430
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 460
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 380
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 370
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 420
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 400
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 330
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 380
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 320
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 500
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 440
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 470
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 390
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 380
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 430
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 410
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 340
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 390
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 330
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 490
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 450
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 480
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 400
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 390
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 440
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 420
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 350
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 400
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 340
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 480
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 460
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 490
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 410
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 400
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 450
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 430
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 360
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 410
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 350
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 470
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 470
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 500
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 420
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 410
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 460
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 440
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 370
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 420
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 360
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 480
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 480
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 510
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 430
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 420
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 470
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 450
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 380
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 430
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 370
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 490
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 490
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 520
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 440
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 430
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 480
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 460
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 390
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 440
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 380
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 500
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 500
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 530
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 450
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 440
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 490
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 470
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 400
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 450
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 390
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 510
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 510
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 540
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 460
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 450
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 500
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 480
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 410
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 460
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 400
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 520
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 520
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 550
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 470
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 460
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 510
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 490
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 420
  },
  {
    "model": "Kona Electric",
    "make": "Hyundai",
    "max_power_kw": 470
  },
  {
    "model": "e-Golf",
    "make": "Volkswagen",
    "max_power_kw": 410
  },
  {
    "model": "Taycan",
    "make": "Porsche",
    "max_power_kw": 530
  },
  {
    "model": "I-PACE",
    "make": "Jaguar",
    "max_power_kw": 530
  },
  {
    "model": "Model X",
    "make": "Tesla",
    "max_power_kw": 560
  },
  {
    "model": "Model Y",
    "make": "Tesla",
    "max_power_kw": 480
  },
  {
    "model": "Model 3",
    "make": "Tesla",
    "max_power_kw": 470
  },
  {
    "model": "Model S",
    "make": "Tesla",
    "max_power_kw": 520
  },
  {
    "model": "Bolt EV",
    "make": "Chevrolet",
    "max_power_kw": 500
  },
  {
    "model": "Leaf",
    "make": "Nissan",
    "max_power_kw": 430
  },
    ];
     CollectionReference Cars = FirebaseFirestore.instance.collection('Cars');

    for (var data in jsonData) {
      await Cars.add(data);
    }

  print('All data saved to Firestore');
}
  }

