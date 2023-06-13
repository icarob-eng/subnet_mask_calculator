import 'package:yaml/yaml.dart';

class Section {
  String title, content;
  bool isExpanded;
  List<String>? seeAlso;

  Section(
      {required this.title,
      required this.content,
      this.isExpanded = false,
      this.seeAlso});
  factory Section.fromYaml(YamlMap yaml) {
    List<String>? temporarySeeAlso;
    if (yaml["see also"] != null && yaml["see also"] is YamlList) {
      for (var element in yaml["see also"] as YamlList) {
        temporarySeeAlso!.add(element);
      }
    }
    return Section(
        title: yaml["title"] ?? "",
        content: yaml["content"] ?? "",
        seeAlso: temporarySeeAlso,
        isExpanded: false);
  }
}
