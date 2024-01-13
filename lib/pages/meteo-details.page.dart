import 'package:flutter/material.dart';


import '../menu/drawer.widget.dart';
import'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class MeteoDetailsPage extends StatefulWidget {
  String ville="";
  MeteoDetailsPage(this.ville);


  @override
  State<MeteoDetailsPage> createState() => _MeteoDetailsPageState();


}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;
  void initState(){
    super.initState();
    getMeteoData(widget.ville);
  }
  void getMeteoData( String ville) {
    print("Meteo de la ville de "+ville);
    String url="https://api.openweathermap.org/data/2.5/forecast?q=sfax&appid=c109c07bc4df77a88c923e6407aef864";
    http.get(Uri.parse(url)).then((resp){
      setState(() {
        this.meteoData=json.decode(resp.body);
        print(this.meteoData);
      });

    }).catchError((err){
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Page de Meteo Details ${widget.ville}'),
      ),
      body: meteoData==null?
      Center(
        child: CircularProgressIndicator(),
      ):
      ListView.builder(
          itemCount:(meteoData == null ? 0 :meteoData['list'].length),
          itemBuilder: (context,index){
            return Card(
              color: Colors.white,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            "images/${meteoData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"
                        ),
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
                      )
                    ],
                  ),
                  Text(
                    "Température : ${meteoData != null && meteoData['list'] != null && meteoData['list'][index] != null && meteoData['list'][index]['main'] != null ? meteoData['list'][index]['main']['temp'].toString() + ' °C' : 'N/A'}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}