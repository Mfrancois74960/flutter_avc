import 'package:flutter/material.dart';
import 'a_home_page.dart'; // Accueil
import 'b_sondages_themes.dart'; // Thèmes des sondages
import 'c_connecter.dart'; // Se connecter
import 'e_cgu.dart'; // CGU

class DContact extends StatelessWidget {
  const DContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nous contacter'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Cette page est dédiée aux contacts.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
