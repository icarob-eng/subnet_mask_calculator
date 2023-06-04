import 'package:flutter/material.dart';
import 'package:subnet_mask_calculator/components/expansible_card.dart';
import 'package:subnet_mask_calculator/components/list_tile_with_switch.dart';
import 'package:subnet_mask_calculator/components/my_navigation_bar.dart';
import 'package:subnet_mask_calculator/providers/theme_manager.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void Function(bool)? _switchDarkThemeEnable(BuildContext context) {
    if (Provider.of<ThemeManager>(context).state != ThemeMode.system) {
      return (bool value) {
        if (value) {
          Provider.of<ThemeManager>(context, listen: false)
              .switchTo(ThemeMode.dark);
        } else {
          Provider.of<ThemeManager>(context, listen: false)
              .switchTo(ThemeMode.light);
        }
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding:
              const EdgeInsets.only(left: 20, bottom: 250, right: 20, top: 100),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Consumer<ThemeManager>(builder: (context, value, child) {
                return ExpansibleCard(
                  title: "Opções de Tema",
                  children: [
                    ListTitleWithSwitch(
                        title: const Text("Tema do sistema."),
                        switchInitialValue: value.state == ThemeMode.system,
                        onSwitchChange: (switchValue) {
                          if (switchValue) {
                            value.switchTo(ThemeMode.system);
                          } else {
                            value.switchTo(null);
                          }
                        }),
                    ListTitleWithSwitch(
                        title: const Text("Tema escuro"),
                        switchInitialValue: value.state == ThemeMode.light,
                        onSwitchChange: _switchDarkThemeEnable(context))
                  ],
                );
              });
            }
            return null;
          }),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
