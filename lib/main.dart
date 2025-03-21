import 'package:flutter/material.dart';
// Utilise uniquement shared_preferences
import 'a_home_page.dart'; // Import de la page d'accueil

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Aucun besoin d'ajouter SharedPreferencesStoreFactory ici.
  // shared_preferences fonctionne nativement avec Flutter Web.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Site de Sondages',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AHomePage(), // La page d'accueil est maintenant AHomePage
    );
  }
}
