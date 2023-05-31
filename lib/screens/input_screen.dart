import 'package:flutter/material.dart';
import 'package:ipaddr/ipaddr.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/models/subnets_controllers.dart';

import '../components/subnet_host_card.dart';
import '../service/subnet_mask_to_prefix.dart';

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

  void _updateSubnetMask() {
    subnetMaskController.text =
        prefixToSubnetMask(prefix: int.parse(initialPrefixController.text));
  }

  void _updatePrefix() {
    initialPrefixController.text =
        subnetMaskToPrefix(mask: subnetMaskController.text).toString();
  }

  @override
  void initState() {
    super.initState();
    subnetMaskController.addListener(_updatePrefix);
    initialPrefixController.addListener(_updateSubnetMask);
  }

  @override
  void dispose() {
    subnetMaskController.dispose();
    initialPrefixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Definição de sub-redes'),
        centerTitle: true,
      ),
      body: Consumer<SubnetsControllers>(
        builder: (context, subnetsControllers, child) {
          return Form(
            key: _formKey,
            child: ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: subnetsControllers.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 12, right: 12, bottom: 12),
                        child: Column(
                          children: [
                            TextFormField(
                              onTapOutside: (arg) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: const InputDecoration(
                                labelText: 'IP inicial:',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskTextInputFormatter(mask: '###.###.###.###')
                              ],
                              controller: initialIpController,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: TextFormField(
                                      onTapOutside: (arg) =>
                                          FocusScope.of(context).unfocus(),
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Máscara da rede primária:'),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                            mask: "###.###.###.###")
                                      ],
                                      controller: subnetMaskController,
                                      onChanged: (_) {
                                        initialPrefixController =
                                            TextEditingController(
                                                text: subnetMaskToPrefix(
                                                        mask:
                                                            subnetMaskController
                                                                .text)
                                                    .toString());
                                      },
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                        onTapOutside: (arg) =>
                                            FocusScope.of(context).unfocus(),
                                        decoration: const InputDecoration(
                                            labelText: 'Prefixo:',
                                            labelStyle: TextStyle(
                                                overflow:
                                                    TextOverflow.visible)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          MaskTextInputFormatter(mask: "/##")
                                        ],
                                        controller: initialPrefixController)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SubnetHostCard(index: index);
                  }
                }),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              Provider.of<SubnetsControllers>(context, listen: false)
                  .increment(value: 1);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, '/output');
              }
            },
            child: const Icon(Icons.play_arrow_outlined),
          ),
        ],
      ),
    );
  }
}
