import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyDrawer extends StatelessWidget{
  late SharedPreferences prefs;
  MyDrawer ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.white,Colors.blue])),
              child: Center(
                child: CircleAvatar(
                  backgroundImage:AssetImage("images/personnage.jpg"),
                  radius: 80,
                ),
              )
          ),
          ListTile(
            title: Text('Accueil',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.home,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          Divider(height: 4,color: Colors.blue),
          ListTile(
            title: Text('Météo',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.sunny_snowing,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/meteo');
            },
          ),
          Divider(height: 4,color: Colors.blue),
          ListTile(
            title: Text('Gallerie',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.photo,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/gallerie');
            },
          ),
          Divider(height: 4,color: Colors.blue),
          ListTile(
            title: Text('Pays',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.location_city,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: (){

              Navigator.pop(context);
              Navigator.pushNamed(context, '/pays');
            },
          ),
          Divider(height: 4,color: Colors.blue),
          ListTile(
            title: Text('Contact',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.contact_page,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
          ),
          Divider(height: 4,color: Colors.blue),
          ListTile(
            title: Text('Parametres',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.settings,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, '/parametres');
            },
          ),
          Divider(height: 4,color: Colors.blue),
          ListTile(
            title: Text('Deconnexion',style: TextStyle(fontSize: 22)),
            leading: Icon(Icons.logout,color: Colors.blue),
            trailing: Icon(Icons.arrow_right,color: Colors.blue ),
            onTap: () async{
             Navigator.pushNamedAndRemoveUntil(context, '/authentification', (route) => false);
            },
          ),
          Divider(height: 4,color: Colors.blue)
        ],
      ),
    );
  }
}