import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/models/subnets_controllers.dart';

class SubnetHostCard extends StatefulWidget {
  final int index;

  const SubnetHostCard({Key? key, required this.index}) : super(key: key);

  @override
  State<SubnetHostCard> createState() => _SubnetHostCardState();
}

class _SubnetHostCardState extends State<SubnetHostCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SubnetsControllers>(
      builder: (context, subnets, child) {
        return Dismissible(
          key: ValueKey<int>(widget.index),
          onDismissed: (direction) {
            subnets.removeAt(index: widget.index - 2);
          },
          direction: subnets.length >= 2
              ? DismissDirection.horizontal
              : DismissDirection.none,
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: subnets[widget.index - 2],
                      decoration: InputDecoration(
                          labelText:
                              'Número de hosts da sub-rede ${widget.index - 1}:',
                          errorMaxLines: 3),
                      inputFormatters: [MaskTextInputFormatter(mask: '#' * 3)],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (widget.index - 1 == (subnets.length)) {
                          if (value.isNotEmpty) {
                            subnets.increment();
                          } else if (value.isEmpty) {
                            subnets.removeLast();
                          }
                        } else if (value == "" &&
                            widget.index - 1 == subnets.length - 1 &&
                            subnets[widget.index - 1].text == "") {
                          subnets.removeLast();
                        }
                      },
                      validator: (value) {
                        try {
                          if (value == null || value.isEmpty) {
                            if (widget.index - 1 != subnets.length) {
                              return "Por favor, preencha esse campo.";
                            } else {
                              return null;
                            }
                          } else {
                            int number = int.parse(value);
                            if (number <= 0) {
                              return "Não é possível ter número de host negativos.";
                            } else if (255 <= number) {
                              return "Não é possível ter mais de 254 host em uma rede.";
                            }
                          }
                          return null;
                        } on FormatException {
                          return "O valor informado não é, total ou parcialmente, um número.";
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Um erro inespecífico ocorreu.")));
                          return null;
                        }
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (subnets.length > 1) {
                            subnets.removeAt(index: widget.index - 2);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
