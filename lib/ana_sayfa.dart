import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:team_finder/sayfalar/oyun_ana_sayfa.dart';
import 'package:team_finder/sayfalar/profil_sayfasi.dart';
import 'package:team_finder/sayfalar/tasarim_ana_sayfa.dart';
import 'package:team_finder/sayfalar/yazilim_ana_sayfa.dart';
import 'package:team_finder/tema.dart';

import 'sayfalar/konu_yaz.dart';

class AnaSayfa extends StatefulWidget {
  final String ulke;

  AnaSayfa({@required this.ulke});

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-4830234578288128~8885991724');
  }

  Tema renkPaleti = Tema();

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      OyunSayfa(
        ulke: widget.ulke,
      ),
      YazilimSayfa(
        ulke: widget.ulke,
      ),
      TasarimSayfa(
        ulke: widget.ulke,
      ),
      ProfilSayfasi(
        ulke: widget.ulke,
      ),
    ];
    List<IconButton> appBarWidgets = <IconButton>[
      IconButton(
        icon: Icon(
          FontAwesomeIcons.paperPlane,
          size: 20,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KonuYaz(
                ulke: widget.ulke,
              ),
            ),
          );
        },
      ),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: renkPaleti.temaRenk1,
        appBar: AppBar(
          iconTheme: IconThemeData(color: renkPaleti.temaRenk4),
          backgroundColor: renkPaleti.temaRenk1,
          title: Text(
            'TeamFinder',
            style: TextStyle(color: renkPaleti.temaRenk4),
          ),
          actions: _selectedIndex < 3 ? appBarWidgets : null,
        ),
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: renkPaleti.temaRenk1,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.gamepad), label: '  Oyun'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.code), label: '  Yazılım'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.pencilRuler), label: 'Tasarım'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user), label: 'Profil'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: renkPaleti.temaRenk4,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
