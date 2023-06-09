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
    return ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.only(left: 20, top: 100, right: 20, bottom: 80),
      children: <Widget>[
            Card(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('IPs distribuídos nas sub-redes:'),
                                Text('100')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'IPs restantes na rede',
                                ),
                                Text('100')
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'IPs utilizados nas sub-redes',
                                ),
                                Text('100')
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ] +
          cards,
    );
  }
}
