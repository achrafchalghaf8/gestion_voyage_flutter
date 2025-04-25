import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;

  const MeteoDetailsPage(this.ville, {super.key});

  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  Future<void> getMeteoData(String ville) async {
    print("Météo de la ville de $ville");

    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=c109c07bc4df77a88c923e6407aef864&units=metric&lang=fr";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        print(jsonBody);

        setState(() {
          meteoData = jsonBody;
        });
      } else {
        print("Erreur HTTP : ${response.statusCode}");
      }
    } catch (e) {
      print("Erreur lors de la récupération des données météo : $e");
    }
  }

  String getWeatherIcon(String weatherCondition) {
    final lower = weatherCondition.toLowerCase();
    final availableIcons = ['clear', 'rain', 'clouds', 'snow', 'thunderstorm'];

    if (availableIcons.contains(lower)) {
      return 'assets/$lower.png';
    } else {
      return 'assets/meteo.png'; // Fallback par défaut
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Météo - ${widget.ville}"),
        backgroundColor: Colors.blue,
      ),
      body: meteoData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: meteoData['list'].length,
              itemBuilder: (context, index) {
                var item = meteoData['list'][index];

                String dateTime = item['dt_txt'];
                String description = item['weather'][0]['description'];
                double temperature = item['main']['temp'];
                String weatherCondition = item['weather'][0]['main'];

                String formattedDate = DateFormat('dd/MM/yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
                );

                String formattedTime = DateFormat('HH:mm').format(
                  DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
                );

                return Card(
                  color: Colors.blue.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(
                                getWeatherIcon(weatherCondition),
                              ),
                              radius: 30,
                              onBackgroundImageError: (_, __) {
                                print("Image introuvable pour $weatherCondition");
                              },
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : $formattedDate",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "$formattedTime - $description",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "$temperature°C",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
