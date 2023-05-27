import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController ipInicial = TextEditingController();
  List<Widget> formWidgets = [];
  List<TextEditingController?> subnetHostControllers = [null];

  @override
  void initState() {
    super.initState();
    formWidgets = [
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'IP inicial:',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [MaskTextInputFormatter(mask: '###.###.###.###')],
          controller: ipInicial,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subnet calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // alignment: Alignment.center,
          children: [
            const Text(
              'Definição de subredes',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Form(
              child: Column(
                children: formWidgets,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, left: 100, right: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() {
                      subnetHostControllers.add(TextEditingController());
                      formWidgets.add(
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12, left: 12, right: 12, top: 2,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Número de hosts da subrede ${formWidgets.length - 1}:',
                              ),
                              initialValue: '0',
                              keyboardType: TextInputType.number,
                              controller: subnetHostControllers.last,
                            ),
                          ),
                        ),
                      );
                    }),
                    child: const Icon(Icons.add),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      if (formWidgets.length > 2 &&
                          subnetHostControllers.length > 2) {
                        formWidgets.removeLast();
                        subnetHostControllers.removeLast();
                      }
                    }),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/output'),
        child: const Icon(Icons.play_arrow_outlined),
      ),
    );
  }
}
