import 'package:flutter/material.dart';
import '../components/subnet_card.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OutputScreen();
}

class _OutputScreen extends State<StatefulWidget> {
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();

    // todo: calcular dados de rede
    cards.add(const SubnetCard(
      subnetNumber: 666,
      subnetIp: '10.0.0.0',
      totalIps: 8001,
      usableIps: 7999,
      prefix: '/69',
      mask: '10.0.0.0',
      firstHostIp: '10.0.0.0',
      lastHostIp: '10.0.0.0',
      broadcastIp: '10.0.0.0',
    ));
    cards.add(const SubnetCard(
      subnetNumber: 666,
      subnetIp: '10.0.0.0',
      totalIps: 8001,
      usableIps: 7999,
      prefix: '/69',
      mask: '10.0.0.0',
      firstHostIp: '10.0.0.0',
      lastHostIp: '10.0.0.0',
      broadcastIp: '10.0.0.0',
    ));
    cards.add(const SubnetCard(
      subnetNumber: 666,
      subnetIp: '10.0.0.0',
      totalIps: 8001,
      usableIps: 7999,
      prefix: '/69',
      mask: '10.0.0.0',
      firstHostIp: '10.0.0.0',
      lastHostIp: '10.0.0.0',
      broadcastIp: '10.0.0.0',
    ));
    cards.add(const SubnetCard(
      subnetNumber: 666,
      subnetIp: '10.0.0.0',
      totalIps: 8001,
      usableIps: 7999,
      prefix: '/69',
      mask: '10.0.0.0',
      firstHostIp: '10.0.0.0',
      lastHostIp: '10.0.0.0',
      broadcastIp: '10.0.0.0',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de sub-rede')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Sub-redes resultantes',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'IPs distribuídos nas sub-redes',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'IPs restantes na rede',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'IPs utilizados nas sub-redes',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('100'),
                              Text('100'),
                              Text('100'),
                            ],
                          ),
                        ],
                      )),
                )
              ] +
              cards,
        ),
      ),
    );
  }
}
