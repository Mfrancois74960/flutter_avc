import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'a_home_page.dart'; // Accueil
import 'b_sondages_themes.dart'; // Thèmes des sondages
import 'c_connecter.dart'; // Se connecter
import 'd_contact.dart'; // Nous contacter
import 'e_cgu.dart'; // CGU

class FAdministrateur extends StatefulWidget {
  const FAdministrateur({super.key});

  @override
  FAdministrateurState createState() => FAdministrateurState();
}

class FAdministrateurState extends State<FAdministrateur> {
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
          'themes', themes); // Sauvegarde des valeurs par défaut
    } else {
      themes = savedThemes;
    }

    setState(() {
      themes.sort();
    });
  }

  // Sauvegarder les thèmes
  Future<void> _saveThemes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('themes', themes);
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
      appBar: AppBar(
        title: const Text('Page Administrateur'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Ajouter un nouveau thème'),
                          content: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Entrez un thème',
                            ),
                            onSubmitted: (value) {
                              addTheme(value);
                              Navigator.pop(context);
                              _controller
                                  .clear(); // Réinitialisation du contrôleur
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _controller
                                    .clear(); // Réinitialisation en cas d'annulation
                              },
                              child: const Text('Annuler'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Nouveau thème de sondage'),
                ),
              ],
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
                      MaterialPageRoute(
                          builder: (context) => BSondagesThemes()),
                    );
                  },
                  child: const Text('Thèmes des sondages'),
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
}
