import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/diger_kullanicilar_profil_sayfasi/diger_kullanicilar_profil_stream_widget.dart';
import 'package:team_finder/tema.dart';
import 'package:team_finder/widgets/kucuk_isimler.dart';
import 'package:team_finder/widgets/temel_kategori_widget.dart';

class DigerKullanicilarProfilSayfasi extends StatefulWidget {
  final String userId;
  final String photoUrl;
  final String isim;
  final String ulke;
  DigerKullanicilarProfilSayfasi({
    @required this.userId,
    @required this.photoUrl,
    @required this.isim,
    @required this.ulke,
  });
  @override
  _DigerKullanicilarProfilSayfasiState createState() =>
      _DigerKullanicilarProfilSayfasiState();
}

class _DigerKullanicilarProfilSayfasiState
    extends State<DigerKullanicilarProfilSayfasi> {
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
    Tema renkPaleti = Tema();
    return Scaffold(
      backgroundColor: renkPaleti.temaRenk1,
      appBar: AppBar(
        iconTheme: renkPaleti.iconTema,
        backgroundColor: renkPaleti.temaRenk1,
        title: Text(
          widget.isim,
          style: renkPaleti.textTema,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.photoUrl),
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.isim),
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
                    textRenk:
                        secenek == 1 ? renkPaleti.temaRenk2 : Colors.black,
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
                    textRenk:
                        secenek == 2 ? renkPaleti.temaRenk2 : Colors.black,
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
                        secenek == 0 ? renkPaleti.temaRenk4 : Colors.black45,
                    textRenk:
                        secenek == 0 ? renkPaleti.temaRenk2 : Colors.black,
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
                      ? DigerKullanicilarProfilStreamBuilder(
                          dataBase: oyun,
                          userId: widget.userId,
                          ulke: widget.ulke,
                        )
                      : secenek == 1
                          ? DigerKullanicilarProfilStreamBuilder(
                              dataBase: yazilim,
                              userId: widget.userId,
                              ulke: widget.ulke,
                            )
                          : secenek == 2
                              ? DigerKullanicilarProfilStreamBuilder(
                                  dataBase: tasarim,
                                  userId: widget.userId,
                                  ulke: widget.ulke,
                                )
                              : DigerKullanicilarProfilStreamBuilder(
                                  dataBase: oyun,
                                  userId: widget.userId,
                                  ulke: widget.ulke,
                                ),
                ),
              ],
            ),
          ],
        ),
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
            String genelKategori = liste[i]
                .toLowerCase()
                .replaceAll('ı', 'i')
                .replaceAll('ş', 's')
                .replaceAll('ü', 'u')
                .replaceAll(' ', '');
            secimKategori = i;
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
