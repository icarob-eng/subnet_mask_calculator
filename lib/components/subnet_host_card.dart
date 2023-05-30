import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SubnetHostCard extends StatefulWidget {

  List<TextEditingController> subnetHostControllers;
  int index;

  SubnetHostCard({Key? key, required this.subnetHostControllers, required this.index}) : super(key: key);

  @override
  State<SubnetHostCard> createState() => _SubnetHostCardState();
}

class _SubnetHostCardState extends State<SubnetHostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: widget.subnetHostControllers[widget.index-2],
                decoration: InputDecoration(
                  labelText:
                  'Número de hosts da sub-rede ${widget.index-1}:',
                ),
                inputFormatters: [
                  MaskTextInputFormatter(mask: '#' * 30)
                ],
                keyboardType: TextInputType.number,
                onChanged: (value){
                  if(widget.index-1 == (widget.subnetHostControllers.length)){
                    if(value.isNotEmpty){
                      setState(() {
                        widget.subnetHostControllers.add(TextEditingController());
                      });
                    }
                    else if(value.isEmpty){
                      setState(() {
                        widget.subnetHostControllers.removeLast();
                      });
                    }
                  }
                  else if(value=="" && widget.index-1 == widget.subnetHostControllers.length-1 && widget.subnetHostControllers[widget.index-1].text==""){
                    setState(() {
                      widget.subnetHostControllers.removeLast();
                    });
                  }
                },
              ),
            ),
            IconButton(
                onPressed: (){
                  setState(() {
                    if(widget.subnetHostControllers.length>1){
                      widget.subnetHostControllers.removeAt(widget.index-2);
                    }
                  });
                },
                icon: const Icon(Icons.remove))
          ],
        ),
      ),
    );
  }
}
