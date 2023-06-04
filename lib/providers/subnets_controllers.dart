import 'package:flutter/material.dart';
import 'package:ipaddr/ipaddr.dart';
import 'package:subnet_mask_calculator/models/network_data.dart';

class SubnetsControllers extends ChangeNotifier {
  TextEditingController initialIpController = TextEditingController(),
      initialsubnetMaskController = TextEditingController(),
      initialPrefixController = TextEditingController();

  List<TextEditingController> cardHostsControllers;

  SubnetsControllers({required this.cardHostsControllers});

  SubnetsControllers.length(int length)
      : cardHostsControllers = List<TextEditingController>.generate(
            length, (_) => TextEditingController());

  TextEditingController operator [](int index) {
    return cardHostsControllers[index];
  }

  void increment({int value = 0}) {
    for (int i = 1; i <= value; i++) {
      cardHostsControllers.add(TextEditingController());
    }
    notifyListeners();
  }

  void removeAt({required int index}) {
    cardHostsControllers.removeAt(index);
    notifyListeners();
  }

  void removeLast() {
    cardHostsControllers.removeLast();
    notifyListeners();
  }

  int get length => cardHostsControllers.length;

  NetworkData get data {
    return NetworkData(
        networkData: IPv4Network(
            initialIpController.text + initialPrefixController.text),
        subnetsData:
            cardHostsControllers.map((e) => IPv4Interface(e.text)).toList());
  }
}
