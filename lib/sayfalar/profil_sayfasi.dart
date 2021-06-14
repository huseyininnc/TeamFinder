import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_finder/provider/google_sign_in.dart';
import 'package:team_finder/sayfalar/konu_yaz.dart';
import 'package:team_finder/tema.dart';
import 'package:team_finder/widgets/kucuk_isimler.dart';
import 'package:team_finder/widgets/profil_stream_builder.dart';
import 'package:team_finder/widgets/temel_kategori_widget.dart';

class ProfilSayfasi extends StatefulWidget {
  final String ulke;
  ProfilSayfasi({@required this.ulke});
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  final user = FirebaseAuth.instance.currentUser;
  var oyun = FirebaseFirestore.instance.collection('oyun');
  var yazilim = FirebaseFirestore.instance.collection('yazilim');
  var tasarim = FirebaseFirestore.instance.collection('tasarim');

  List<String> oyunList = <String>[
    'OYUN',
    'FPS',
    'SPOR',
    'SURVİVOR',
    'KART',
    'RPG',
    'YARIŞ',
  ];

  List<String> yazilimList = <String>[
    'YAZILIM',
    'WEB',
    'MOBİL',
    'MASA ÜSTÜ',
    'YAPAY ZEKA',
    'VERİ TABANI',
    'VERİ ANALİZİ',
  ];

  List<String> tasarimList = <String>[
    'TASARIM',
    'PHOTO EDİT',
    'VİDEO EDİT',
    'ANİMASYON',
    '3D MODELLEME',
    'KARAKTER',
    'PİXEL',
  ];

  int secimKategori = 0;
  int secenek = 0;
  int sonucYoksa = 0;
  Tema renkPaleti = Tema();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(user.photoURL),
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(user.displayName),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: renkPaleti.temaRenk4,
                        onPrimary: renkPaleti.temaRenk2,
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
                      child: Text('Yeni Ekle'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: renkPaleti.temaRenk4,
                        onPrimary: renkPaleti.temaRenk2,
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                      },
                      child: Text('Çıkış Yap'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TemelKategoriWidget(
                  isim: 'YAZILIM',
                  renk: secenek == 1
                      ? renkPaleti.temaRenk4
                      : renkPaleti.temaRenk1,
                  outlineRenk:
                      secenek == 1 ? renkPaleti.temaRenk4 : Colors.black45,
                  textRenk: secenek == 1 ? renkPaleti.temaRenk2 : Colors.black,
                  onPress: () {
                    setState(
                      () {
                        secenek = 1;
                        secimKategori = 0;
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                TemelKategoriWidget(
                  isim: 'TASARIM',
                  renk: secenek == 2
                      ? renkPaleti.temaRenk4
                      : renkPaleti.temaRenk1,
                  outlineRenk:
                      secenek == 2 ? renkPaleti.temaRenk4 : Colors.black45,
                  textRenk: secenek == 2 ? renkPaleti.temaRenk2 : Colors.black,
                  onPress: () {
                    setState(
                      () {
                        secenek = 2;
                        secimKategori = 0;
                      },
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                TemelKategoriWidget(
                  isim: 'OYUN',
                  renk: secenek == 0
                      ? renkPaleti.temaRenk4
                      : renkPaleti.temaRenk1,
                  outlineRenk:
                      secenek == 3 ? renkPaleti.temaRenk4 : Colors.black45,
                  textRenk: secenek == 0 ? renkPaleti.temaRenk2 : Colors.black,
                  onPress: () {
                    setState(
                      () {
                        secenek = 0;
                        secimKategori = 0;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Divider(
              height: 18,
              thickness: 0.6,
              color: Colors.black45,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < 7; i++)
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            secenek == 0
                                ? buildKucukIsimler('oyun', oyunList, i)
                                : secenek == 1
                                    ? buildKucukIsimler(
                                        'yazilim', yazilimList, i)
                                    : secenek == 2
                                        ? buildKucukIsimler(
                                            'tasarim', tasarimList, i)
                                        : buildKucukIsimler(
                                            'oyun', oyunList, i),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: secenek == 0
                    ? ProfilStreamBuilder(
                        dataBase: oyun,
                        user: user,
                        ulke: widget.ulke,
                      )
                    : secenek == 1
                        ? ProfilStreamBuilder(
                            dataBase: yazilim,
                            user: user,
                            ulke: widget.ulke,
                          )
                        : secenek == 2
                            ? ProfilStreamBuilder(
                                dataBase: tasarim,
                                user: user,
                                ulke: widget.ulke,
                              )
                            : ProfilStreamBuilder(
                                dataBase: oyun,
                                user: user,
                                ulke: widget.ulke,
                              ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  KucukIsimler buildKucukIsimler(String kategori, List<String> liste, int i) {
    return KucukIsimler(
      isim: liste[i],
      isimRenk: Tema().temaRenk1,
      renk: secimKategori == i
          ? Tema().temaRenk4.withOpacity(0.6)
          : Tema().temaRenk4,
      onPress: () {
        setState(
          () {
            secimKategori = i;
            String genelKategori = liste[i]
                .toLowerCase()
                .replaceAll('ı', 'i')
                .replaceAll('ş', 's')
                .replaceAll('ü', 'u')
                .replaceAll(' ', '');
            switch (kategori) {
              case 'oyun':
                oyun = FirebaseFirestore.instance.collection(
                  genelKategori,
                );

                break;
              case 'yazilim':
                yazilim = FirebaseFirestore.instance.collection(
                  genelKategori,
                );

                break;
              case 'tasarim':
                tasarim = FirebaseFirestore.instance.collection(
                  genelKategori,
                );

                break;
            }
          },
        );
      },
    );
  }
}
