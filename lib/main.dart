import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voyage/pages/contact.page.dart';
import 'package:voyage/pages/gallerie.page.dart';
import 'package:voyage/pages/home.page.dart';
import 'package:voyage/pages/authentification.page.dart';
import 'package:voyage/pages/inscription.page.dart';
import 'package:voyage/pages/meteo.page.dart';
import 'package:voyage/pages/parametres.page.dart';
import 'package:voyage/pages/pays.page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'config/global.params.dart';

ThemeData theme = ThemeData.light();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await _onGetMode();
  GlobalParams.themeActuel.setMode(await _onGetMode());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final routes = {
    '/home': (context) => homePage(),
    '/inscription': (context) => inscriptionPage(),
    '/authentification': (context) => AuthentificationPage(),
    '/contact': (context) => ContactPage(),
    '/meteo': (context) => MeteoPage(),
    '/parametres': (context) => ParametresPage(),
    '/pays': (context) => PaysPage(),
    '/gallerie': (context) => GalleriePage(),
  };

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: widget.routes,
      theme: GlobalParams.themeActuel.getTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData)
            return homePage();
          else
            return AuthentificationPage();
        },
      ),
    );
  }
}

Future<String> _onGetMode() async {
  final snapshot = await ref.child('mode').get();
  if (snapshot.exists)
    mode = snapshot.value.toString();
  else
    mode = "Jour";
  print(mode);
  return mode;
}
