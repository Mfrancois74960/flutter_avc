import 'package:flutter/material.dart';
import 'a_home_page.dart'; // Accueil
import 'b_sondages_themes.dart'; // Thèmes des sondages
import 'd_contact.dart'; // Nous contacter
import 'e_cgu.dart'; // CGU

class CConnecter extends StatefulWidget {
  const CConnecter({super.key});

  @override
  State<CConnecter> createState() => _CConnecterState();
}

class _CConnecterState extends State<CConnecter> {
  // État pour basculer entre Connexion et Inscription
  bool _isLoginMode = true;

  // Contrôleurs pour les champs de saisie
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  // Clé pour la validation du formulaire
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Méthode pour soumettre le formulaire
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isLoginMode) {
        // Mode Connexion
        String pseudo = _pseudoController.text;
        String password = _passwordController.text;
        _loginUser(pseudo, password);
      } else {
        // Mode Inscription
        String firstName = _firstNameController.text;
        String lastName = _lastNameController.text;
        String pseudo = _pseudoController.text;
        String password = _passwordController.text;
        _registerUser(firstName, lastName, pseudo, password);
      }
    }
  }

  // Simulation de connexion
  void _loginUser(String pseudo, String password) {
    print('Connexion avec pseudo: $pseudo et mot de passe: $password');
    // TODO: Appeler une API ou vérifier les identifiants localement
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Connexion réussie avec pseudo: $pseudo')),
    );
  }

  // Simulation d'inscription
  void _registerUser(
      String firstName, String lastName, String pseudo, String password) {
    print(
        'Inscription avec prénom: $firstName, nom: $lastName, pseudo: $pseudo, mot de passe: $password');
    // TODO: Envoyer les données à une API ou les enregistrer localement
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Inscription réussie pour $firstName $lastName')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Se connecter' : "S'inscrire"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!_isLoginMode)
                        TextFormField(
                          controller: _firstNameController,
                          decoration:
                              const InputDecoration(labelText: 'Prénom'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                        ),
                      if (!_isLoginMode)
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(labelText: 'Nom'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                        ),
                      TextFormField(
                        controller: _pseudoController,
                        decoration: const InputDecoration(labelText: 'Pseudo'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un pseudo';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Mot de passe'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child:
                            Text(_isLoginMode ? 'Se connecter' : "S'inscrire"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLoginMode =
                                !_isLoginMode; // Basculer entre Connexion et Inscription
                          });
                        },
                        child: Text(_isLoginMode
                            ? "Pas encore inscrit ? S'inscrire"
                            : 'Déjà inscrit ? Se connecter'),
                      ),
                    ],
                  ),
                ),
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
