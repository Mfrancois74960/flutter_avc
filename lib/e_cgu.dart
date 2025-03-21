import 'package:flutter/material.dart';
import 'dart:async';
import 'a_home_page.dart'; // Accueil
import 'b_sondages_themes.dart'; // Thèmes des sondages
import 'c_connecter.dart'; // Se connecter
import 'd_contact.dart'; // Nous contacter

class ECgu extends StatefulWidget {
  const ECgu({super.key});

  @override
  ECguState createState() => ECguState();
}

class ECguState extends State<ECgu> {
  String _cguText = "Chargement des CGU...";

  @override
  void initState() {
    super.initState();
    _loadCguText();
  }

  // Charger le contenu du fichier texte
  Future<void> _loadCguText() async {
    String text =
        await DefaultAssetBundle.of(context).loadString('assets/cgu.txt');
    setState(() {
      _cguText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conditions Générales d\'Utilisation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _cguText,
                style: const TextStyle(fontSize: 16),
              ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
