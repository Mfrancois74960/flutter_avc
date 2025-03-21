import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final Map<String, List<Map<String, dynamic>>> initialSondages = {
  'Histoire': [
    {
      'question': 'Napoleon est un grand homme ?',
      'type': 'OUI ou NON',
      'ouiCount': 0,
      'nonCount': 0
    },
    {
      'question': 'Aimerais tu être Marie Antoinette ?',
      'type': 'POUR ou CONTRE',
      'ouiCount': 0,
      'nonCount': 0
    }
  ],
  'Politique': [
    {
      'question': 'Sondage A',
      'type': 'VRAI ou FAUX',
      'ouiCount': 0,
      'nonCount': 0
    },
    {
      'question': 'Sondage B',
      'type': 'OUI ou NON',
      'ouiCount': 0,
      'nonCount': 0
    }
  ],
  'Sociologie': [
    {
      'question': 'Sondage X',
      'type': 'POUR ou CONTRE',
      'ouiCount': 0,
      'nonCount': 0
    },
    {
      'question': 'Sondage Y',
      'type': 'VRAI ou FAUX',
      'ouiCount': 0,
      'nonCount': 0
    }
  ],
  'Divers': [
    {
      'question': 'Sondage P',
      'type': 'OUI ou NON',
      'ouiCount': 0,
      'nonCount': 0
    },
    {
      'question': 'Sondage Q',
      'type': 'VRAI ou FAUX',
      'ouiCount': 0,
      'nonCount': 0
    }
  ],
};

class SondagesPage extends StatefulWidget {
  final String theme;

  const SondagesPage({super.key, required this.theme});

  @override
  State<SondagesPage> createState() => _SondagesPageState();
}

class _SondagesPageState extends State<SondagesPage> {
  late Map<String, List<Map<String, dynamic>>> sondages;
  late String theme;

  @override
  void initState() {
    super.initState();
    theme = widget.theme;
    sondages = Map.from(initialSondages);
    _loadSondages();
  }

  @override
  void didUpdateWidget(covariant SondagesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.theme != widget.theme) {
      theme = widget.theme;
      if (!sondages.containsKey(theme)) {
        sondages[theme] = initialSondages[theme] ?? [];
      }
      setState(() {});
    }
  }

  Future<void> _loadSondages() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('sondages');
    if (jsonString != null) {
      try {
        Map<String, dynamic> decodedMap = jsonDecode(jsonString);
        for (var key in decodedMap.keys) {
          sondages[key] = (decodedMap[key] as List<dynamic>)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }
      } catch (e) {
        print('Invalid JSON: $e');
      }
    }
    // Assurez-vous que le thème actuel existe
    if (!sondages.containsKey(theme)) {
      sondages[theme] = initialSondages[theme] ?? [];
    }
    setState(() {});
  }

  Future<void> _saveSondages() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(sondages);
    await prefs.setString('sondages', jsonString);
  }

  void _addNewSurvey() {
    final TextEditingController controller = TextEditingController();
    String selectedType = 'OUI ou NON'; // Valeur par défaut

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un nouveau sondage'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Question',
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedType,
                items: ['OUI ou NON', 'POUR ou CONTRE', 'VRAI ou FAUX']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedType = value;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Type de réponse',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Soumettre'),
              onPressed: () async {
                String question = controller.text;
                if (question.isNotEmpty) {
                  if (!sondages.containsKey(theme)) {
                    sondages[theme] = [];
                  }
                  sondages[theme]!.add({
                    'question': question,
                    'type': selectedType,
                    'ouiCount': 0,
                    'nonCount': 0,
                  });
                  await _saveSondages();
                  Navigator.pop(context);
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _vote(String voteType, int index) async {
    // Vérifiez si ouiCount et nonCount existent, sinon initialisez-les à 0
    sondages[theme]![index]['ouiCount'] ??= 0;
    sondages[theme]![index]['nonCount'] ??= 0;

    if (voteType == 'oui') {
      sondages[theme]![index]['ouiCount'] += 1;
    } else if (voteType == 'non') {
      sondages[theme]![index]['nonCount'] += 1;
    }

    await _saveSondages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sondages : $theme')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: sondages.containsKey(theme) && sondages[theme]!.isNotEmpty
                  ? ListView.builder(
                      itemCount: sondages[theme]!.length,
                      itemBuilder: (context, index) {
                        final survey = sondages[theme]![index];
                        // Assurez-vous que ouiCount et nonCount existent
                        survey['ouiCount'] ??= 0;
                        survey['nonCount'] ??= 0;

                        // Mapper le type de réponse aux labels appropriés
                        String positiveLabel = 'Oui';
                        String negativeLabel = 'Non';
                        switch (survey['type']) {
                          case 'OUI ou NON':
                            positiveLabel = 'Oui';
                            negativeLabel = 'Non';
                            break;
                          case 'POUR ou CONTRE':
                            positiveLabel = 'Pour';
                            negativeLabel = 'Contre';
                            break;
                          case 'VRAI ou FAUX':
                            positiveLabel = 'Vrai';
                            negativeLabel = 'Faux';
                            break;
                        }

                        return ListTile(
                          title: Text(
                            '${survey['question']} (${survey['type']})',
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () => _vote('oui', index),
                                child: Text(
                                    '$positiveLabel (${survey['ouiCount']})'),
                              ),
                              ElevatedButton(
                                onPressed: () => _vote('non', index),
                                child: Text(
                                    '$negativeLabel (${survey['nonCount']})'),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text('Aucun sondage pour ce thème')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewSurvey,
        tooltip: 'Ajouter un nouveau sondage',
        child: const Icon(Icons.add),
      ),
    );
  }
}
