import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/models/subnets_controllers.dart';

import '../components/subnet_host_card.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController initialIpController = TextEditingController(),
    subnetMaskController = TextEditingController(),
    initialPrefixController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de sub-rede'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer<SubnetsControllers>(
          builder: (context, subnetsControllers, child) {
            return Form(
              key: _formKey,
              child: ListView.builder(
                  itemCount: subnetsControllers.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const Text(
                        'Definição de sub-redes',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      );
                    } else if (index == 1) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            TextFormField(
                              onTapOutside: (arg)=>FocusScope.of(context).unfocus(),
                              decoration: const InputDecoration(
                                labelText: 'IP inicial:',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskTextInputFormatter(mask: '###.###.###.###')
                              ],
                              controller: initialIpController,
                            ),
                            Row(children: [
                             Expanded(flex:7, child: TextFormField(
                               onTapOutside: (arg)=>FocusScope.of(context).unfocus(),
                               decoration: const InputDecoration(labelText: 'Máscara da rede primária:'),
                               keyboardType: TextInputType.number,
                               inputFormatters: [
                                 MaskTextInputFormatter(mask: "###.###.###.###")
                               ],
                               controller:subnetMaskController
                             )),
                             const Spacer(),
                             Expanded(flex: 3,child: TextFormField(
                               onTapOutside: (arg)=>FocusScope.of(context).unfocus(),
                               decoration: const InputDecoration(labelText: 'Prefixo de rede:'),
                               keyboardType: TextInputType.number,
                               inputFormatters: [MaskTextInputFormatter(mask:"/##")],
                               controller: initialPrefixController
                             )) ,
                            ],)
                          ],
                        ),
                      );
                    } else {
                      return SubnetHostCard(index: index);
                    }
                  }),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_formKey.currentState!.validate()){
            Navigator.pushNamed(context, '/output');
          }
        },
        child: const Icon(Icons.play_arrow_outlined),
      ),
    );
  }
}
