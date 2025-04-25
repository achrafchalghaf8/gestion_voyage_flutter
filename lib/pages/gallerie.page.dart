import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage_vs/Menu/drawer.widget.dart';

class GaleriePage extends StatefulWidget {
  const GaleriePage({Key? key}) : super(key: key);

  @override
  State<GaleriePage> createState() => _GaleriePageState();
}

class _GaleriePageState extends State<GaleriePage> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _onDeconnexion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('connecte', false);
    Navigator.pushReplacementNamed(context, '/authentification');
  }

  void _onGetGallerieDetails() {
    final saisie = _controller.text.trim();
    if (saisie.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/gallerie-details',
        arguments: saisie,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page des galeries'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyDrawer(onDeconnexion: () => _onDeconnexion(context)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bienvenue sur la page de galerie',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Écris quelque chose...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _onGetGallerieDetails,
              child: Text('Chercher'),
            ),
          ],
        ),
      ),
    );
  }
}
