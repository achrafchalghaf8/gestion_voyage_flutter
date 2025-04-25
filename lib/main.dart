import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage_vs/pages/authentification.pages.dart';
import 'package:voyage_vs/pages/contact.page.dart';
import 'package:voyage_vs/pages/gallerie-details.page.dart';
import 'package:voyage_vs/pages/gallerie.page.dart';
import 'package:voyage_vs/pages/home.pages.dart';
import 'package:voyage_vs/pages/inscription.pages.dart';
import 'package:voyage_vs/pages/meteo.page.dart';
import 'package:voyage_vs/pages/parametre.page.dart';
import 'package:voyage_vs/pages/pays.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/authentification': (context) => AuthentificationPage(),
        '/inscription': (context) => InscriptionPage(),
        '/home': (context) => HomePage(),
          '/pays': (context) => PaysPage(),
          '/contact': (context) => ContactPage(),
          '/galerie': (context) => GaleriePage(),
          '/meteo': (context) => MeteoPage(),
          '/parametres': (context) => ParametrePage(),
        '/gallerie-details': (context) => const GallerieDetailsPage(),

      },
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isConnected = snapshot.data?.getBool('connecte') ?? false;
            return isConnected ? HomePage() : AuthentificationPage();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
