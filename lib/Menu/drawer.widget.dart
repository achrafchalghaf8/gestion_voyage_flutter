import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final VoidCallback onDeconnexion;

  const MyDrawer({Key? key, required this.onDeconnexion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.white, Colors.blue]),
            ),
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 80,
              ),
            ),
          ),
          _createDrawerItem(Icons.home, 'Accueil', () {
            Navigator.pushNamed(context, '/home');
          }),
          _createDrawerItem(Icons.cloud, 'Météo', () {
            Navigator.pushNamed(context, '/meteo');
          }),
          _createDrawerItem(Icons.photo, 'Galerie', () {
            Navigator.pushNamed(context, '/galerie');
          }),
          _createDrawerItem(Icons.flag, 'Pays', () {
            Navigator.pushNamed(context, '/pays'); // 👈 Naviguer vers la page Pays
          }),
          _createDrawerItem(Icons.contact_mail, 'Contact', () {
            Navigator.pushNamed(context, '/contact');
          }),
          _createDrawerItem(Icons.settings, 'Paramètres', () {
            Navigator.pushNamed(context, '/parametres');
          }),
          _createDrawerItem(Icons.logout, 'Déconnexion', onDeconnexion),
        ],
      ),
    );
  }

  Widget _createDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title),
      onTap: onTap,
    );
  }
}
