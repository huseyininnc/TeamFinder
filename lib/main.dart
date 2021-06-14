import 'package:country_codes/country_codes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_finder/sayfalar/home_page.dart';
import 'package:team_finder/tema.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  await Firebase.initializeApp();

  runApp(TeamFinder());
}

class TeamFinder extends StatelessWidget {
  static final String title = 'Team Finder';
  String ulke;
  final Locale deviceLocale = CountryCodes.getDeviceLocale();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ulke = deviceLocale.languageCode;
    return MaterialApp(
      color: Tema().temaRenk3,
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: HomePage(
        ulke: ulke,
      ),
    );
  }
}
