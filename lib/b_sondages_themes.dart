import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart'; // Correction de l'importation
import 'sondages_page.dart';
import 'a_home_page.dart'; // Accueil
import 'c_connecter.dart'; // Se connecter
import 'd_contact.dart'; // Nous contacter
import 'e_cgu.dart'; // CGU

class BSondagesThemes extends StatefulWidget {
  const BSondagesThemes({super.key});

  @override
  BSondagesThemesState createState() => BSondagesThemesState();
}

class BSondagesThemesState extends State<BSondagesThemes> {
  final Logger logger = Logger(); // Instanciation correcte du logger

  List<String> themes = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadThemes();
  }

  @override
  void dispose() {
    _controller.dispose(); // Libérer le contrôleur quand le widget est détruit
    super.dispose();
  }

  // Charger les thèmes enregistrés
  Future<void> _loadThemes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedThemes = prefs.getStringList('themes');

    if (savedThemes == null || savedThemes.isEmpty) {
      themes = ['Histoire', 'Politique', 'Sociologie', 'Divers'];
      await prefs.setStringList(
        'themes',
        themes,
      ); // Sauvegarde des valeurs par défaut
      logger.d(
          "Aucun thème trouvé, utilisation des valeurs par défaut : $themes");
    } else {
      themes = savedThemes;
      logger.d("Thèmes chargés après redémarrage : $themes");
    }

    setState(() {
      themes.sort();
    });
  }

  // Sauvegarder les thèmes
  Future<void> _saveThemes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('themes', themes);

    // Vérification immédiate après la sauvegarde
    List<String>? savedThemes = prefs.getStringList('themes');
    logger.d("Thèmes vérifiés après sauvegarde : $savedThemes");
  }

  // Ajouter un nouveau thème
  void addTheme(String newTheme) {
    if (newTheme.isNotEmpty && !themes.contains(newTheme)) {
      setState(() {
        themes.add(newTheme);
        themes.sort();
      });
      _saveThemes(); // Sauvegarde après ajout
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thèmes des sondages')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: themes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SondagesPage(theme: themes[index]),
                        ),
                      );
                    },
                    child: Text(themes[index]),
                  ),
                );
              },
            ),
          ),
          // Boutons de navigation en bas de la page
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors
                .grey[200], // Fond légèrement gris pour la barre de navigation
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AHomePage()),
                    );
                  },
                  child: const Text('Accueil'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CConnecter()),
                    );
                  },
                  child: const Text('Se connecter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DContact()),
                    );
                  },
                  child: const Text('Nous contacter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ECgu()),
                    );
                  },
                  child: const Text('CGU'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Test d'écriture et lecture manuelle (facultatif)
  void testSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Enregistrer un test
    await prefs.setString('test_key', 'test_value');
    logger.d("Valeur enregistrée : ${prefs.getString('test_key')}");

    // Lire le test
    String? testValue = prefs.getString('test_key');
    logger.d("Valeur lue : $testValue");
  }
}
