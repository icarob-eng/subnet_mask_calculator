import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/providers/study_provider.dart';
import 'package:subnet_mask_calculator/providers/subnets.dart';
import 'package:subnet_mask_calculator/providers/subnets_controllers.dart';
import 'package:subnet_mask_calculator/providers/theme_manager.dart';
import 'package:subnet_mask_calculator/screens/input_screen.dart';
import 'package:subnet_mask_calculator/screens/output_screen.dart';
import 'package:subnet_mask_calculator/screens/settings_screen.dart';
import 'package:subnet_mask_calculator/screens/study_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Subnets(),
      ),
      ChangeNotifierProvider(create: (context) => SubnetsControllers.length(1)),
      ChangeNotifierProvider(create: (context) => ThemeManager()),
      ChangeNotifierProvider(create: (context) => StudyProvider())
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
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.indigoAccent),
            bodyMedium: TextStyle(color: Colors.black, fontSize: 17),
            bodySmall: TextStyle(color: Colors.indigoAccent),
          ),
          primarySwatch: Colors.indigo,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 10,
            backgroundColor: Colors.indigo,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              showUnselectedLabels: false,
              showSelectedLabels: true,
              selectedIconTheme: const IconThemeData(color: Colors.indigo),
              unselectedIconTheme:
                  IconThemeData(color: Colors.indigo.withOpacity(0.4)),
              selectedLabelStyle: const TextStyle(color: Colors.indigo),
              unselectedLabelStyle: TextStyle(
                  color: Colors.indigo.withOpacity(0.4), fontSize: 10)),
          cardTheme: CardTheme(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          inputDecorationTheme:
              const InputDecorationTheme(fillColor: Colors.white)),
      darkTheme: ThemeData(
          textTheme: TextTheme(
            bodyLarge: const TextStyle(color: Colors.indigoAccent),
            bodyMedium:
                TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 17),
            bodySmall: const TextStyle(color: Colors.indigoAccent),
          ),
          cardTheme: CardTheme(
              color: const Color(0xff404040),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          colorScheme: const ColorScheme.dark(
            primary: Colors.indigo,
            secondary: Colors.indigoAccent,
          ),
          primaryIconTheme: const IconThemeData(color: Colors.white),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              showUnselectedLabels: false,
              showSelectedLabels: true,
              selectedIconTheme:
                  const IconThemeData(color: Colors.indigoAccent),
              unselectedIconTheme: const IconThemeData(color: Colors.indigo),
              selectedLabelStyle: const TextStyle(color: Colors.white),
              unselectedLabelStyle:
                  TextStyle(color: Colors.white.withOpacity(0.4))),
          appBarTheme: const AppBarTheme(
            elevation: 10,
            centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
          listTileTheme: ListTileThemeData(
            textColor: Colors.white.withOpacity(0.6),
          ),
          inputDecorationTheme:
              const InputDecorationTheme(fillColor: Color(0xff404040))),
      themeMode: Provider.of<ThemeManager>(context).state,
      debugShowCheckedModeBanner: false,
      initialRoute: '/input',
      routes: {
        '/input': (context) => const InputScreen(),
        '/output': (context) => const OutputScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/study': (context) => const StudyScreen(),
      },
    );
  }
}
