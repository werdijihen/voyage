import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../menu/drawer.widget.dart';

class homePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser;
    return Scaffold(
        drawer :  MyDrawer(),
        appBar: AppBar(title: Text('Page Home')),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Utilisateur: ${user?.email}",style: TextStyle(fontSize: 22)),
            ),
            Center(
                child: Wrap(
                  children:[
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('images/meteo.png',),),
                      onTap: (){
                        Navigator.pushNamed(context, '/meteo');
                      },
                    ),
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('images/contact.png',),),
                      onTap: (){
                        Navigator.pushNamed(context, '/contact');
                      },
                    ),
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('images/gallerie.png',),),
                      onTap: (){
                        Navigator.pushNamed(context, '/gallerie');
                      },
                    ),
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('images/parameters.png',),),
                      onTap: (){
                        Navigator.pushNamed(context, '/parametres');
                      },
                    ),
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('images/pays.png',),),
                      onTap: (){
                        Navigator.pushNamed(context, '/pays');
                      },
                    ),
                    InkWell(
                      child: Ink.image(
                        height: 180,
                        width: 180,
                        image: AssetImage('images/deconnexion.png',),),
                      onTap: (){
                        Navigator.pushNamed(context, '/');
                      },
                    ),
                  ],
                )
            )
          ],
        )
    );
  }
  Future<void> _Deconnexion (context) async {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil (context, '/authentification', (route) =>
    false);
  }

}






