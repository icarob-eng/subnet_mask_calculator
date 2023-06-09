import 'package:flutter/material.dart';
import 'package:subnet_mask_calculator/components/expansible_card.dart';
import 'package:subnet_mask_calculator/components/my_navigation_bar.dart';
import 'package:subnet_mask_calculator/providers/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double radius = 50;

  static const Tuple2<double, double> pairNotScaled = Tuple2(1, 1);
  static const Tuple2<double, double> pairScaled = Tuple2(1.2, 0.8);

  static const Duration scaleTransitionDuaration = Duration(milliseconds: 400);

  late Tuple2<double, double> whiteOptionScale;
  late Tuple2<double, double> blackOptionScale;
  late Tuple2<double, double> systemOptionScale;

  void _scale(ThemeMode value, Tuple2<double, double> variable) {
    whiteOptionScale = blackOptionScale = systemOptionScale = pairNotScaled;
    if (value == Provider.of<ThemeManager>(context, listen: false).state) {
      setState(() {
        variable = pairScaled;
      });
    } else {
      setState(() {
        variable = pairNotScaled;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    whiteOptionScale =
        blackOptionScale = systemOptionScale = const Tuple2(1, 1);
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode? state = Provider.of<ThemeManager>(context, listen: false).state;
    if (state != null) {
      if (state == ThemeMode.system) {
        systemOptionScale = pairScaled;
      } else if (state == ThemeMode.dark) {
        blackOptionScale = pairScaled;
      } else if (state == ThemeMode.light) {
        whiteOptionScale = pairScaled;
      }
    } else {
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        blackOptionScale = pairScaled;
      } else {
        whiteOptionScale = pairScaled;
      }
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding:
              const EdgeInsets.only(left: 20, bottom: 250, right: 20, top: 100),
          children: [
            ExpansibleCard(title: "Opções de Tema", children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<ThemeManager>(context, listen: false)
                            .switchTo(ThemeMode.light);
                        _scale(ThemeMode.light, whiteOptionScale);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: AnimatedScale(
                                  duration: scaleTransitionDuaration,
                                  scale: whiteOptionScale.item1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey)),
                                    child: AnimatedScale(
                                      duration: scaleTransitionDuaration,
                                      scale: whiteOptionScale.item2,
                                      child: Container(
                                        height: radius,
                                        width: radius,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Text("Claro")
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<ThemeManager>(context, listen: false)
                            .switchTo(ThemeMode.dark);
                        _scale(ThemeMode.dark, blackOptionScale);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: AnimatedScale(
                                  scale: blackOptionScale.item1,
                                  duration: const Duration(milliseconds: 400),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey)),
                                    child: AnimatedScale(
                                      duration: scaleTransitionDuaration,
                                      scale: blackOptionScale.item2,
                                      child: Container(
                                        height: radius,
                                        width: radius,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Text("Escuro")
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<ThemeManager>(context, listen: false)
                            .switchTo(ThemeMode.system);
                        _scale(ThemeMode.system, systemOptionScale);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: AnimatedScale(
                                  duration: scaleTransitionDuaration,
                                  scale: systemOptionScale.item1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.grey)),
                                    child: AnimatedScale(
                                      duration: scaleTransitionDuaration,
                                      scale: systemOptionScale.item2,
                                      child: Container(
                                        height: radius,
                                        width: radius,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Text("Sistema")
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ]),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
