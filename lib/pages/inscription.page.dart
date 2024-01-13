import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class inscriptionPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = TextEditingController();
  TextEditingController txt_motPass = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Page Inscription')),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_login,
              decoration: InputDecoration(
                // Correction de la syntaxe pour InputDecoration
                prefixIcon: Icon(Icons.person),
                hintText: "Utilisateur",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: txt_motPass,
              obscureText: true,
              decoration: InputDecoration(
                // Correction de la syntaxe pour InputDecoration
                prefixIcon: Icon(Icons.lock),
                hintText: "Mot de passe",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                _onInscrire(context);
                // Mettez votre logique de gestion de l'inscription ici
                // Par exemple, vous pouvez accéder au texte saisi dans le champ txt_login avec txt_login.text
              },
              child: Text('Inscription', style: TextStyle(fontSize: 22)),
            ),
          ),
          TextButton (
              child: Text ("J'ai déjà un compte",
                  style: TextStyle(fontSize: 22)),
              onPressed: () {
                Navigator.pop (context);
                Navigator.pushNamed (context,
                    '/authentification');
              }),
        ],
      ),
    );
  }
  Future <void> _onInscrire(BuildContext context)async {
    prefs=await SharedPreferences.getInstance();
    if(txt_login.text.isNotEmpty && txt_motPass.text.isNotEmpty){
     try{
       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: txt_login.text.trim(), password: txt_motPass.text.trim());
      Navigator.pop(context);
      Navigator.pushNamed(context, "/home");
    } on FirebaseAuthException catch (e){
       SnackBar snackBar=SnackBar(content: Text(""));
       if(e.code=='weak-password'){
         snackBar=SnackBar(
           content: Text('Mot de passe faible'),
         );
       } else if (e.code=='email-already-in-use'){
    snackBar = SnackBar(
    content: Text('Email deja existant'),
    );
    }

    ScaffoldMessenger.of(context).showSnackBar (snackBar) ;
  }
    }else {
    const snackBar = SnackBar(
    content: Text('Id ou mot de passe vides'),
    );
    ScaffoldMessenger.of(context).showSnackBar (snackBar) ;
    }
  }
}