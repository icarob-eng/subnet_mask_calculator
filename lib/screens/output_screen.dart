import 'package:flutter/material.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OutputScreen();
}

class _OutputScreen extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ze')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'Subredes resultantes',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            // IPs distribuidos = Soma IPs em subrede
            // IPs restantes = distribuídos - utilizados
            // IPs utilizados = Hosts + extras de infraestrutura

            /* Subrede:
              Total
              Usáveis
              Prefixo
              Máscara
              Ip de rede
              1° Ip de Host
              Último Ip de Host
              // Ip de Vlan
              // Ip de Gateway
              Ip de broadcast
             */
          ],
        ),
      ),
    );
  }

}