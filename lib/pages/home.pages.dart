import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage_vs/Menu/drawer.widget.dart';

class HomePage extends StatelessWidget {
  Future<void> _onDeconnexion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('connecte', false);
    Navigator.pushReplacementNamed(context, '/authentification');
  }

  final List<_IconButtonData> buttons = [
    _IconButtonData('assets/meteo.png', 'Météo'),
    _IconButtonData('assets/gallerie.png', 'Galerie'),
    _IconButtonData('assets/pays.png', 'Pays'),
    _IconButtonData('assets/contact.png', 'Contact'),
    _IconButtonData('assets/parametres.png', 'Paramètres'),
    _IconButtonData('assets/deconnexion.png', 'Déconnexion'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Home'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: MyDrawer(onDeconnexion: () => _onDeconnexion(context)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200, // Forcer 2 par ligne
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemCount: buttons.length,
          itemBuilder: (context, index) {
            final item = buttons[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    switch (item.label) {
                      case 'Météo':
                        Navigator.pushNamed(context, '/meteo');
                        break;
                      case 'Galerie':
                        Navigator.pushNamed(context, '/galerie');
                        break;
                      case 'Pays':
                        Navigator.pushNamed(context, '/pays');
                        break;
                      case 'Contact':
                        Navigator.pushNamed(context, '/contact');
                        break;
                      case 'Paramètres':
                        Navigator.pushNamed(context, '/parametres');
                        break;
                      case 'Déconnexion':
                        _onDeconnexion(context);
                        break;
                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Pas d’action définie pour ${item.label}')),
                        );
                    }
                  },
                  child: ClipOval(
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(20),
                      child: Image.asset(
                        item.assetPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item.label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _IconButtonData {
  final String assetPath;
  final String label;

  _IconButtonData(this.assetPath, this.label);
}
