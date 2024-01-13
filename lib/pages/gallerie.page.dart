import 'package:flutter/material.dart';

import 'gallerie-details.page.dart';

class GalleriePage extends StatefulWidget {
  @override
  _GalleryFormState createState() => _GalleryFormState();
}

class _GalleryFormState extends State<GalleriePage> {
  final TextEditingController _textController = TextEditingController();

  // Méthode pour naviguer vers GalleryDetailsPage
  void _navigateToDetailsPage(String key) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GallerieDetailPage(key), // Utilisez le nouveau nom du paramètre
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galerie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Entrez du texte ici',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers GalleryDetailsPage avec la clé saisie
                String inputText = _textController.text;
                _navigateToDetailsPage(inputText);
              },
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: GalleriePage(),
  ));
}