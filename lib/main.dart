import 'package:flutter/material.dart';
import 'package:subnet_mask_calculator/screens/input_screen.dart';
import 'package:subnet_mask_calculator/screens/output_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      darkTheme: ThemeData(colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 25, 40, 120),
        secondary: Color.fromARGB(255, 25, 40, 120),
      )),
      title: 'Subnet Calculator',
      initialRoute: '/input',
      routes: {
        '/input': (context) => InputScreen(),
        '/output': (context) => OutputScreen(),
      },

    );
  }
}
