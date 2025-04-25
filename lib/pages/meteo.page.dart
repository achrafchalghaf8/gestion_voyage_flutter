import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage_vs/Menu/drawer.widget.dart';
import 'package:voyage_vs/pages/meteo-details.page.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  final TextEditingController _cityController = TextEditingController();
  String? _errorText;

  void _onGetMeteoDetails() {
    final ville = _cityController.text.trim();

    if (ville.isEmpty) {
      setState(() {
        _errorText = "Veuillez entrer une ville.";
      });
    } else {
      setState(() {
        _errorText = null;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeteoDetailsPage(ville),
        ),
      );

      _cityController.clear(); // Réinitialise le champ
    }
  }

  void _handleDeconnexion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Efface les données de session

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(onDeconnexion: _handleDeconnexion),
      appBar: AppBar(
        title: const Text("Météo"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Consultez la météo",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: "Entrez une ville",
                  hintText: "ex: Paris",
                  prefixIcon: const Icon(Icons.location_city),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  errorText: _errorText,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.search),
                  label: const Text("Rechercher"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  onPressed: _onGetMeteoDetails,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
