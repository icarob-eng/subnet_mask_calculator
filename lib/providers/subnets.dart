import 'package:flutter/material.dart';
import 'package:ipaddr/ipaddr.dart' as ipaddr;

class Subnets extends ChangeNotifier {
  ipaddr.IPv4Network? network;
  List<ipaddr.IPv4Network>? subnets;

  Subnets({this.network, this.subnets});

  void add(ipaddr.IPv4Network value) {
    subnets?.add(value);
    notifyListeners();
  }

  void removeAt(int index) {
    subnets?.removeAt(index);
    notifyListeners();
  }

  void removeLast() {
    subnets?.removeLast();
    notifyListeners();
  }
}
