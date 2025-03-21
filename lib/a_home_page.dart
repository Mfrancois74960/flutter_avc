import 'package:flutter/material.dart';
import 'b_sondages_themes.dart';
import 'c_connecter.dart';
import 'd_contact.dart';
import 'e_cgu.dart';
import 'f_administrateur.dart'; // Importation de la nouvelle page

class AHomePage extends StatelessWidget {
  const AHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page d\'Accueil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BSondagesThemes()),
                );
              },
              child: Text('Thèmes des sondages'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CConnecter()),
                );
              },
              child: Text('Se connecter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DContact()),
                );
              },
              child: Text('Nous contacter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ECgu()),
                );
              },
              child: Text('CGU'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAdministrateur()),
                );
              },
              child: Text('Administrateur'),
            ),
          ],
        ),
      ),
    );
  }
}
