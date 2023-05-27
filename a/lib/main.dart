import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text("Recommendations from the virtual world"),
        ),
        body: Column(children: const [
          Center(child: Text('data')),
          Text('data1'),
          Text('data2'),
          Text('data3'),
          Text('data4'),
          Text('data5'),
        ],),
      ),
    );
  }
}