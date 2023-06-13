import 'dart:async';

import 'package:flutter/material.dart';
import 'package:subnet_mask_calculator/models/section.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';

class StudyProvider extends ChangeNotifier {
  final String _path;

  Future<Set<Section>?> get sections => loadData();

  Future<Set<Section>?> loadData() async {
    Completer<Set<Section>?> completer = Completer<Set<Section>?>();

    try {
      String value = await rootBundle.loadString(_path);
      YamlMap document = loadYaml(value);

      if (document["sections"] != null) {
        YamlList sections = document["sections"];
        Set<Section> listOfSections = {};

        for (YamlMap section in sections) {
          try {
            if (section.keys.every((key) =>
                key == "title" || key == "content" || key == "see also")) {
              if (section["title"] != null) {
                listOfSections.add(Section.fromYaml(section));
              } else {
                throw Exception("The title cannot be null.");
              }
            } else if (section.keys.length > 2) {
              throw Exception("The number of keys is higher than expected.");
            } else if (section.keys.length < 2) {
              throw Exception("The number of keys is lower than expected.");
            } else {
              throw Exception(
                  "The section does not contain the expected keys: title and content.");
            }
          } on Exception {
            continue;
          }
        }

        completer.complete(listOfSections);
      } else {
        completer.complete(null);
      }
    } catch (error) {
      completer.completeError(error);
    }

    return completer.future;
  }

  StudyProvider({String path = "assets/study.yaml"}) : _path = path;
}
