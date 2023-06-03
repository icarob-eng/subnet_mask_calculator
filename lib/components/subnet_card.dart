import 'package:flutter/material.dart';

class SubnetCard extends StatelessWidget {
  final int subnetNumber, totalIps, usableIps;
  final String subnetIp, prefix, mask, firstHostIp, lastHostIp, broadcastIp;

  const SubnetCard(
      {required this.subnetIp,
      required this.mask,
      required this.prefix,
      required this.subnetNumber,
      required this.totalIps,
      required this.usableIps,
      required this.firstHostIp,
      required this.lastHostIp,
      required this.broadcastIp,
      Key? key})
      : super(key: key);

  Map<String, dynamic> _toMap() {
    return {
      "Máscara de rede:": mask,
      "Prefixo:": prefix,
      "Total de IPs": totalIps,
      "IPs usáveis:": usableIps,
      "Primeiro IP de Host:": firstHostIp,
      "Último IP de Host:": lastHostIp,
      "IP de Broadcast:": broadcastIp,
    };
  }

  List<Widget> _buildCardContent() {
    return _toMap()
        .entries
        .map((entry) => Padding(
              padding: const EdgeInsets.only(top: 1, bottom: 1),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text(entry.value is String
                          ? entry.value
                          : entry.value.toString())
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo.withOpacity(0.3),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              subnetIp,
                              style: const TextStyle(
                                  color: Colors.indigo, fontSize: 40),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      "IP de Rede",
                      style: TextStyle(color: Colors.indigo, fontSize: 15),
                    ),
                  ],
                ),
                ..._buildCardContent(),
              ],
            )));
  }
}
