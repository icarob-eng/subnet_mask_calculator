import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  final Widget? title, body, floatingActionButton;

  const MyNavigationBar(
      {Key? key, this.title, this.body, this.floatingActionButton})
      : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBar();
}

class _MyNavigationBar extends State<MyNavigationBar> {
  int _currentRouter() {
    String? routerName = ModalRoute.of(context)?.settings.name;
    if (routerName == "/settings") {
      return 0;
    } else if (routerName == "/input") {
      return 1;
    } else if (routerName == "/output") {
      return 2;
    } else if (routerName == "/study") {
      return 3;
    }
    return 0;
  }

  bool _isAlredyInRoute({required String router}) {
    return ModalRoute.of(context)?.settings.name == router;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  onTap: (currentIndex) {
                    if (currentIndex == 0 &&
                        !_isAlredyInRoute(router: '/settings')) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/settings',
                        (Route<dynamic> route) => false,
                      );
                    }
                    if (currentIndex == 1 &&
                        !_isAlredyInRoute(router: "/input")) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/input',
                        (Route<dynamic> route) => false,
                      );
                    }
                    if (currentIndex == 2 &&
                        !_isAlredyInRoute(router: "/output")) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/output',
                        (Route<dynamic> route) => false,
                      );
                    }
                    if (currentIndex == 3 &&
                        !_isAlredyInRoute(router: "/study")) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/study',
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  currentIndex: _currentRouter(),
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
    );
  }
}
