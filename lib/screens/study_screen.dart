import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:subnet_mask_calculator/components/expansible_card.dart';
import 'package:subnet_mask_calculator/components/my_navigation_bar.dart';
import 'package:subnet_mask_calculator/providers/study_provider.dart';

import '../models/section.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  late final Set<Section>? allSections;
  late Set<Section>? suggestion;

  TextEditingController searchController = TextEditingController();

  bool _showMagnifier = false;

  Offset _magnifierPosition = Offset.zero;

  void _initializer() async {
    allSections = suggestion =
        await Provider.of<StudyProvider>(context, listen: false).loadData();
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(
      () => filterSearch(searchController.text),
    );
    _initializer();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  double _similarity({required Section field, required String query}) {
    double titleSimilarity =
        StringSimilarity.compareTwoStrings(field.title, query);
    double contentSimilarity =
        StringSimilarity.compareTwoStrings(field.content, query);

    double titleWeight = 0.7;
    double contentWeight = 1 - titleWeight;

    double overallSimilarityA =
        (titleSimilarity * titleWeight + contentSimilarity * contentWeight) /
            (titleWeight + contentWeight);

    return overallSimilarityA;
  }

  double _stringSimilarity({required String first, required String second}) {
    return StringSimilarity.compareTwoStrings(first, second);
  }

  void filterSearch(String query) {
    List<Section>? temp = allSections?.toList();
    temp?.sort((a, b) {
      return _similarity(field: b, query: query)
          .compareTo(_similarity(field: a, query: query));
    });
    List<Section>? listWithCompatibility = temp
        ?.where((element) => _similarity(field: element, query: query) > 0.1)
        .toList();
    if (listWithCompatibility!.isEmpty) {
      temp = listWithCompatibility;
    }
    temp = temp?.map((e) {
      if (_stringSimilarity(first: e.content, second: query) >
          _stringSimilarity(first: e.title, second: query)) {
        e.isExpanded = true;
      }
      return e;
    }).toList();
    setState(() {
      if (query != "") {
        suggestion = temp?.toSet();
      } else {
        suggestion = allSections?.map((e) {
          e.isExpanded = false;
          return e;
        }).toSet();
      }
    });
  }

  void _clear() {
    setState(() {
      searchController.text = "";
      suggestion = allSections?.toSet();
    });
  }

  void _closeAll() {
    setState(() {
      suggestion?.forEach((element) {
        element.isExpanded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Definição de sub-redes'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: Provider.of<StudyProvider>(context).loadData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _showMagnifier = true;
                    });
                    _magnifierPosition = details.localPosition;
                  },
                  onPanEnd: (details) {
                    setState(() {
                      _showMagnifier = false;
                    });
                  },
                  child: ListView.builder(
                    itemCount: suggestion?.length,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.only(
                        left: 20, bottom: 250, right: 20, top: 170),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: ExpansibleCard(
                            title: suggestion!.elementAt(index).title,
                            isExpanded: suggestion!.elementAt(index).isExpanded,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child:
                                    Text(suggestion!.elementAt(index).content),
                              )
                            ],
                          ));
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Não há nada aqui."),
                )),
              );
            },
          ),
          Positioned(
              top: 100,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar',
                      prefixIcon: const Icon(Icons.search_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.indigoAccent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    controller: searchController,
                  ))
                ],
              )),
          if (_showMagnifier) ...[
            Positioned(
              left: _magnifierPosition.dx - 100,
              top: _magnifierPosition.dy - 100,
              child: RawMagnifier(
                decoration: MagnifierDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.indigoAccent.withOpacity(0.5))),
                ),
                size: const Size(100, 50),
                magnificationScale: 1.5,
              ),
            )
          ]
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
