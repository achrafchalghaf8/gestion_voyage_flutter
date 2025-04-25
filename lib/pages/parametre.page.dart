import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage_vs/Menu/drawer.widget.dart'; // Pour utiliser ton Drawer !

class ParametrePage extends StatelessWidget {
  const ParametrePage({Key? key}) : super(key: key);

  Future<void> _onDeconnexion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('connecte', false);
    Navigator.pushReplacementNamed(context, '/authentification');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page des parametre'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyDrawer(onDeconnexion: () => _onDeconnexion(context)),
      body: Center(
        child: Text(
          'Bienvenue sur la page de parametre',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
