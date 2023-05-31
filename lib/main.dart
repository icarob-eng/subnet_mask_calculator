import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/models/subnets.dart';
import 'package:subnet_mask_calculator/models/subnets_controllers.dart';
import 'package:subnet_mask_calculator/screens/input_screen.dart';
import 'package:subnet_mask_calculator/screens/output_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Subnets(),
      ),
      ChangeNotifierProvider(create: (context) => SubnetsControllers.length(1))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subnet Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
          elevation: 10,
          backgroundColor: Colors.indigo,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
        ),
      ),
      darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(
        primary: Color.fromARGB(255, 25, 40, 120),
        secondary: Color.fromARGB(255, 25, 40, 120),
      )),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/input',
      routes: {
        '/input': (context) => const InputScreen(),
        '/output': (context) => const OutputScreen(),
      },
    );
  }
}
