import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/models/subnets_controllers.dart';

import '../components/my_navigation_bar.dart';
import '../components/subnet_host_card.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  final _animateKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Definição de sub-redes'),
        centerTitle: true,
      ),
      body: Consumer<SubnetsControllers>(
        builder: (context, subnetsControllers, child) {
          return Form(
            key: _formKey,
            child: AnimatedList(
                key: _animateKey,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.only(
                    left: 20, bottom: 250, right: 20, top: 100),
                initialItemCount: 2,
                itemBuilder: (context, index, animation) {
                  if (index == 0) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 12, right: 12, bottom: 12),
                        child: Column(
                          children: [
                            TextFormField(
                              // onTapOutside: (arg) =>
                              //     FocusScope.of(context).unfocus(),
                              decoration: const InputDecoration(
                                labelText: 'IP inicial:',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                MaskTextInputFormatter(mask: '###.###.###.###')
                              ],
                              controller:
                                  subnetsControllers.initialIpController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Preencha esse campo.";
                                }
                                if (value.length < 12) {
                                  return "Informe o valor corretamente.";
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: TextFormField(
                                      // onTapOutside: (arg) =>
                                      //     FocusScope.of(context).unfocus(),
                                      decoration: const InputDecoration(
                                          labelText:
                                              'Máscara da rede primária:'),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                            mask: "###.###.###.###")
                                      ],
                                      controller: subnetsControllers
                                          .initialsubnetMaskController,
                                      onChanged: (_) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Preencha esse campo, por favor.";
                                        }
                                        if (value.length < 12) {
                                          return "Preencha esse camo corretamente.";
                                        }
                                        return null;
                                      },
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      // onTapOutside: (arg) =>
                                      //     FocusScope.of(context).unfocus(),
                                      decoration: const InputDecoration(
                                          labelText: 'Prefixo:',
                                          errorMaxLines: 2,
                                          errorStyle: TextStyle(fontSize: 9)),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        MaskTextInputFormatter(mask: "/##")
                                      ],
                                      controller: subnetsControllers
                                          .initialPrefixController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Preencha esse campo.";
                                        }
                                        return null;
                                      },
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SubnetHostCard(
                        key: UniqueKey(),
                        index: index - 1,
                        animation: animation);
                  }
                }),
          );
        },
      ),
      bottomNavigationBar: const MyNavigationBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: UniqueKey(),
            onPressed: () {
              Provider.of<SubnetsControllers>(context, listen: false)
                  .increment(value: 1);
              _animateKey.currentState?.insertItem(
                  Provider.of<SubnetsControllers>(context, listen: false)
                      .length);
            },
            tooltip: "Adicionar",
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, '/output');
              }
            },
            tooltip: "Ir",
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
