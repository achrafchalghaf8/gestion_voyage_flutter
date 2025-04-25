import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatefulWidget {
  @override
  _AuthentificationPageState createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {
  TextEditingController txtLogin = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _onAuthentifier() async {
    String login = txtLogin.text;
    String password = txtPassword.text;

    if (login == "achraf" && password == "achraf") {
      prefs.setBool("connecte", true);
      Navigator.pushNamed(context, '/home'); // Utilisation directe de context
    } else {
      const snackBar = SnackBar(content: Text("Identifiant ou mot de passe incorrect"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Authentification"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txtLogin,
              decoration: InputDecoration(labelText: "Identifiant"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: txtPassword,
              obscureText: true,
              decoration: InputDecoration(labelText: "Mot de passe"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _onAuthentifier(); // Appelle la fonction sans paramètre
              },
              child: Text("Connexion"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/inscription');
              },
              child: Text("Nouvel Utilisateur"),
            ),
          ],
        ),
      ),
    );
  }
}
