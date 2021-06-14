import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/tema.dart';

class DetayAciklama extends StatelessWidget {
  final String ulke;
  final String tarih;
  final Timestamp siralama;
  final String userId;
  final String id;
  final String kategori;
  final String baslik;
  final String aciklama;
  final String yas1;
  final String yas2;
  final String ulke2;
  final String sehir;
  final String gereksinimler;
  final String iletisimBilgileri;
  final String gonderenIsim;
  final String gonderenProfileUrl;
  DetayAciklama({
    this.ulke,
    this.tarih,
    this.siralama,
    this.userId,
    this.id,
    this.kategori,
    this.baslik,
    this.aciklama,
    this.yas1,
    this.yas2,
    this.ulke2,
    this.sehir,
    this.gereksinimler,
    this.iletisimBilgileri,
    this.gonderenIsim,
    this.gonderenProfileUrl,
  });

  final user = FirebaseAuth.instance.currentUser;
  var oyun = FirebaseFirestore.instance.collection('oyun');
  var yazilim = FirebaseFirestore.instance.collection('yazilim');
  var tasarim = FirebaseFirestore.instance.collection('tasarim');
  var datas = FirebaseFirestore.instance.collection('datas');

  double fontSize = 15;
  double defaultHeight1 = 5;
  double defaultHeight2 = 20;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String temelKategori = kategori
        .toLowerCase()
        .replaceAll('ı', 'i')
        .replaceAll('ş', 's')
        .replaceAll('ü', 'u')
        .replaceAll(' ', '');

    TextStyle textTema = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    gonderiYayinlandiSnackBar(BuildContext context) {
      final snackBar = SnackBar(content: Text('Gönderi Yayınlandı.'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    Map bilgiler = <String, dynamic>{
      'baslik': baslik,
      'searchBaslik': baslik.toLowerCase(),
      'aciklama': aciklama,
      'yas1': yas1,
      'yas2': yas2,
      'ulke': ulke2,
      'sehir': sehir,
      'gereksinimler': gereksinimler,
      'iletisimBilgileri': iletisimBilgileri,
      'profilUrl': user.photoURL,
      'kullaniciAdi': user.displayName,
      'kategori': kategori,
      'tarih': tarih,
      'siralama': siralama,
      'userId': userId,
    };

    Tema renkPaleti = Tema();
    return Scaffold(
      backgroundColor: renkPaleti.temaRenk1,
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: renkPaleti.temaRenk3),
        backgroundColor: renkPaleti.temaRenk1,
        title: Text(
          'Detaylar',
          style: TextStyle(color: renkPaleti.temaRenk4),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                gonderenProfileUrl,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        gonderenIsim,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: renkPaleti.temaRenk4,
                              onPrimary: renkPaleti.temaRenk2,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection(
                                    temelKategori,
                                  )
                                  .doc(user.uid)
                                  .collection(ulke)
                                  .doc(id)
                                  .delete();

                              datas
                                  .doc(
                                    temelKategori,
                                  )
                                  .collection(ulke)
                                  .doc(id)
                                  .delete();

                              Navigator.of(context).pop();
                            },
                            child: Text('Gönderiyi Sil'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: renkPaleti.temaRenk4,
                              onPrimary: renkPaleti.temaRenk2,
                            ),
                            onPressed: () {
                              datas
                                  .doc(
                                    temelKategori,
                                  )
                                  .collection(ulke)
                                  .doc(id)
                                  .set(bilgiler);
                              gonderiYayinlandiSnackBar(context);
                            },
                            child: Text('     Yayınla     '),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('$tarih'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Başlık:',
                      style: textTema,
                    ),
                    SizedBox(
                      height: defaultHeight1,
                    ),
                    Text(
                      '$baslik',
                      style: TextStyle(fontSize: fontSize),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: defaultHeight2,
                    ),
                    Text(
                      'Açıklama:',
                      style: textTema,
                    ),
                    SizedBox(
                      height: defaultHeight1,
                    ),
                    Text(
                      '$aciklama',
                      style: TextStyle(fontSize: fontSize),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: defaultHeight2,
                    ),
                    Text(
                      'Yaş Aralığı:',
                      style: textTema,
                    ),
                    SizedBox(
                      height: defaultHeight1,
                    ),
                    Text(
                      '$yas1 - $yas2',
                      style: TextStyle(fontSize: fontSize),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: defaultHeight2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Ülke:',
                                style: textTema,
                              ),
                              SizedBox(
                                height: defaultHeight1,
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text(
                                    '$ulke2',
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Şehir:',
                                style: textTema,
                              ),
                              SizedBox(
                                height: defaultHeight1,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    '$sehir',
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: defaultHeight2,
                    ),
                    Text(
                      'Gereksinimler:',
                      style: textTema,
                    ),
                    SizedBox(
                      height: defaultHeight1,
                    ),
                    Text(
                      '$gereksinimler',
                      style: TextStyle(fontSize: fontSize),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: defaultHeight2,
                    ),
                    Text(
                      'İletişim Bilgileri:',
                      style: textTema,
                    ),
                    SizedBox(
                      height: defaultHeight1,
                    ),
                    Text(
                      '$iletisimBilgileri',
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
