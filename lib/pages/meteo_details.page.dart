import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class MeteoDetailsPage extends StatefulWidget {
  final String ville;

  MeteoDetailsPage(this.ville);

  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  var meteoData;

  void getMeteoData(String ville) {
    print("Météo de la ville " + ville);
    String url = "https://api.openweathermap.org/data/2.5/forecast?q=${ville}&appid=c109c07bc4df77a88c923e6407aef864";
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        meteoData = json.decode(resp.body);
        print(meteoData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Meteo Details ${widget.ville}'),
      ),
      body: ListView.builder(
        itemCount: (meteoData == null ? 0 : meteoData['list'].length),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Heure et État : ${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(meteoData['list'][index]['dt'] * 1000000))}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Température : ${meteoData != null && meteoData['list'] != null && meteoData['list'][index] != null && meteoData['list'][index]['main'] != null ? meteoData['list'][index]['main']['temp'].toString() + ' °C' : 'N/A'}",
                  style: TextStyle(fontSize: 16),
                ),


              ],
            ),
          );
        },
      ),
    );
  }
}