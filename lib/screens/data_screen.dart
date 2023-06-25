import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  void fetchDataFromFirebase() {
    // _database.child('your_database_node').once().then((DataSnapshot snapshot) {
    //   setState(() {
    //     dataList = List<String>.from(snapshot.value);
    //   });
    // }).catchError((error) {
    //   print('Error fetching data: $error');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your search history!!'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(dataList[index]),
          );
        },
      ),
    );
  }
}