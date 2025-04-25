import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GallerieDetailsPage extends StatefulWidget {
  const GallerieDetailsPage({Key? key}) : super(key: key);

  @override
  State<GallerieDetailsPage> createState() => GallerieDetailsPageState();
}

class GallerieDetailsPageState extends State<GallerieDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> hits = [];
  Map<String, dynamic>? galleryData;
  int currentPage = 1;
  final int size = 10;
  int totalPages = 0;
  String keyword = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is String) {
        keyword = args;
        getGalleryData();
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getGalleryData();
        }
      }
    });
  }

  Future<void> getGalleryData() async {
    const String apiKey = '49927866-00852b0e8acc37d05eee10ffc';
    final String url =
        "https://pixabay.com/api/?key=$apiKey&q=$keyword&page=$currentPage&per_page=$size";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          galleryData = data;
          hits.addAll(data['hits']);
          totalPages = (data['totalHits'] / size).ceil();
        });
      } else {
        print("❌ Erreur HTTP : ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Erreur : $e");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Libérer le controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (totalPages == 0)
            ? const Text('Chargement...')
            : Text("Résultats: Page $currentPage / $totalPages"),
        backgroundColor: Colors.blueAccent,
      ),
      body: (galleryData == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: hits.length,
              itemBuilder: (context, index) {
                final item = hits[index];
                return Column(
                  children: [
                    // Image Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.network(
                          item['webformatURL'],
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                    ),
                    // Tags Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(
                            item['tags'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
