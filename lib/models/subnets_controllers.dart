import 'package:flutter/material.dart';

class SubnetsControllers extends ChangeNotifier{

  List<TextEditingController> controllers;

  SubnetsControllers({required this.controllers});

  SubnetsControllers.length(int length):controllers=List<TextEditingController>.generate(length, (_) => TextEditingController());

  TextEditingController operator [](int index){
    return controllers[index];
  }

  void increment({int value=0}){
    controllers.add(TextEditingController());
    notifyListeners();
  }

  void removeAt({required int index}){
    controllers.removeAt(index);
    notifyListeners();
  }

  void removeLast(){
    controllers.removeLast();
    notifyListeners();
  }

  int get length => controllers.length;

}