import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:subnet_mask_calculator/providers/subnets_controllers.dart';

class SubnetHostCard extends StatefulWidget {
  final int index; // index of the data at the SubnetControllers
  // (not at the InputScreen AnimatedList

  final Animation<double> animation;

  const SubnetHostCard({Key? key, required this.index, required this.animation})
      : super(key: key);

  @override
  State<SubnetHostCard> createState() => _SubnetHostCardState();
}

class _SubnetHostCardState extends State<SubnetHostCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubnetsControllers>(
      builder: (context, subnets, child) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            AnimatedList.of(context)
                .removeItem(widget.index, (context, animation) => widget);
            subnets.removeAt(index: widget.index);
          },
          direction: subnets.length >= 2
              ? DismissDirection.horizontal
              : DismissDirection.none,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: widget.index < subnets.length
                          ? subnets[widget.index]
                          : null,
                      decoration: InputDecoration(
                          labelText:
                              'Número de hosts da sub-rede ${widget.index + 1}:',
                          errorMaxLines: 3),
                      inputFormatters: [MaskTextInputFormatter(mask: '#' * 3)],
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        /* if (widget.index == subnets.length - 1) {
                          if (value.isNotEmpty) {
                            subnets.increment(value: 1);
                            AnimatedList.of(context)
                                .insertItem(subnets.length);
                          } else {
                            subnets.removeLast();
                            AnimatedList.of(context).removeItem(
                                subnets.length,
                                (context, animation) => widget);
                          }
                        } */
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
                          AnimatedList.of(context).removeItem(
                              widget.index + 1,
                              (context, animation) => FadeTransition(
                                  opacity: animation, child: widget),
                              duration: const Duration(milliseconds: 400));
                          subnets.removeAt(index: widget.index);
                        }
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
