import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  final Widget child;

  const PaddedCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
          left: 12,
          right: 12,
          top: 2,
        ),
        child: child,
      ),
    );
  }
}

class SubnetCard extends StatelessWidget {
  final int subnetNumber;
  final String subnetIp;
  final int totalIps;
  final int usableIps;
  final String prefix;
  final String mask;
  final String firstHostIp;
  final String lastHostIp;
  final String broadcastIp;

  const SubnetCard(
      {required this.subnetNumber,
      required this.subnetIp,
      required this.totalIps,
      required this.usableIps,
      required this.prefix,
      required this.mask,
      required this.firstHostIp,
      required this.lastHostIp,
      required this.broadcastIp,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).brightness == Brightness.light ?
        Colors.white70 : Colors.black12,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-rede $subnetNumber',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    const Text(
                      'IP da rede:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text(
                      subnetIp,
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1,),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Total de IPs:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text('IPs usáveis:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text('Prefixo:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text('Máscara:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text('Primeiro IP para host:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text('Último IP para host:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                    Text('IP de broadcast:',
                      style: TextStyle(fontWeight: FontWeight.w700),
                      softWrap: false,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$totalIps'),
                    Text('$usableIps'),
                    Text(prefix),
                    Text(mask),
                    Text(firstHostIp),
                    Text(lastHostIp),
                    Text(broadcastIp),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
