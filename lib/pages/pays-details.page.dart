import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class paysDetailsPage extends StatefulWidget {
  final String ville;

  paysDetailsPage(this.ville);

  @override
  _paysDetailsPageState createState() => _paysDetailsPageState();
}

class _paysDetailsPageState extends State<paysDetailsPage> {
  bool isLoading = true;
  var infos;

  @override
  void initState() {
    super.initState();
    getvilleData(widget.ville);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page ville-Details'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white60,
        ),
        child: isLoading
            ? _buildLoadingIndicator()
            : Column(
          children: [
            const SizedBox(height: 70),
            _buildFlagImage(),
            _buildDetailsContent(),
          ],
        ),
      ),
    );
  }



  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDetailsContent() {
    return Padding(
      padding: EdgeInsets.only(left: 70.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          _buildSection('ADMINISTRATION', [
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: buildInfoRow('Capitale', infos[0]['capital']),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: buildInfoRow('Language(s)', infos[0]['languages'][0]['name']),
            ),
          ]),
          _buildSection('GEOGRAPHIE', [
            Padding(padding: EdgeInsets.only(left: 20.0),
              child: buildInfoRow('Région', infos[0]['region']),
            ),
            Padding(padding: EdgeInsets.only(left: 20.0),
              child: buildInfoRow('Superficie', infos[0]['area'].toString()),
            ),
            Padding(padding: EdgeInsets.only(left: 20.0),
              child: buildInfoRow('Fuseau horaire', infos[0]['timezones'][0]),
            )

          ]),
          _buildSection('DEMOGRAPHIE', [
            Padding(padding: EdgeInsets.only(left: 20.0),
              child: buildInfoRow('Population', infos[0]['population'].toString()),
            )
          ]),
        ],
      ),
    );
  }

  Widget _buildFlagImage() {
    return Image.network(
      infos[0]['flags']['png'],
      height: 200,
      width: 300,
    );
  }

  Widget _buildSection(String title, List<Widget> infoRows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...infoRows,
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 8),
        Text(value),
      ],
    );
  }

  Future<void> getvilleData(String ville) async {
    try {
      final response = await http.get(Uri.parse('https://restcountries.com/v2/name/$ville'));

      if (response.statusCode == 200) {
        setState(() {
          infos = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Échec de la requête. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API call: $e');
      throw Exception('Échec de la requête. $e');
    }
  }
}
