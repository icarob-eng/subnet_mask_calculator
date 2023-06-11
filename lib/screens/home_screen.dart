import 'package:flutter/material.dart';
import 'package:subnet_mask_calculator/screens/settings_screen.dart';

import 'input_screen.dart';
import 'output_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentIndex = 1;

  final List<Widget> _appBarTitles = const <Widget>[
    Text("Configurações"),
    Text("Entrada"),
    Text("Saída")
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: _appBarTitles[_currentIndex],
      ),
      body: PageView(
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          reverse: false,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: _pageController,
          children: const [
            SettingsScreen(),
            InputScreen(),
            OutputScreen(),
          ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 23, right: 23, bottom: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Container(
            decoration: const BoxDecoration(color: Colors.indigo),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: BottomNavigationBar(
                    onTap: (newIndex) {
                      if (newIndex != 3) {
                        _pageController.animateToPage(newIndex,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      }
                    },
                    currentIndex: _currentIndex,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings_outlined),
                        label: "Opções",
                        activeIcon: Icon(Icons.settings),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: "Inserir",
                        activeIcon: Icon(Icons.home),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.description_outlined),
                        label: "Resultado",
                        activeIcon: Icon(Icons.description),
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.book_outlined), label: "Estudo"),
                      /* BottomNavigationBarItem(
                        icon: Icon(Icons.bookmark_outline),
                        label: "Salvos",
                        activeIcon: Icon(Icons.bookmark)) */
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
