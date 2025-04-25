import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
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

  Future<void> _onInscrire() async {
    if (txtLogin.text.isNotEmpty && txtPassword.text.isNotEmpty) {
      prefs.setString("login", txtLogin.text);
      prefs.setString("password", txtPassword.text);
      prefs.setBool("connecte", true);

Navigator.pushReplacementNamed(context, '/authentification');
    } else {
      const snackBar = SnackBar(content: Text("Veuillez remplir tous les champs"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Inscription"),
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
              onPressed: _onInscrire,
              child: Text("S'inscrire"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/authentification');
              },
              child: Text("J'ai déjà un compte"),
            ),
          ],
        ),
      ),
    );
  }
}