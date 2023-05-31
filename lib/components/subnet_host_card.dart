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
  bool _visible = false;

  void _opacityTransitionSimultaneously() {
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _visible = !_visible;
      });
    });
  }

  @override
  void initState() {
    _opacityTransitionSimultaneously();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Consumer<SubnetsControllers>(
        builder: (context, subnets, child) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              subnets.removeAt(index: widget.index - 1);
            },
            direction: subnets.length >= 2
                ? DismissDirection.horizontal
                : DismissDirection.none,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: subnets[widget.index - 1],
                        decoration: InputDecoration(
                            labelText:
                                'Número de hosts da sub-rede ${widget.index}:',
                            errorMaxLines: 3),
                        inputFormatters: [
                          MaskTextInputFormatter(mask: '#' * 3)
                        ],
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
                              subnets[widget.index].text == "") {
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
                          if (subnets.length > 1) {
                            setState(() {
                              _visible = !_visible;
                            });
                            Future.delayed(const Duration(milliseconds: 400),
                                () {
                              subnets.removeAt(index: widget.index - 1);
                            });
                          }
                        },
                        icon: const Icon(Icons.remove))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
