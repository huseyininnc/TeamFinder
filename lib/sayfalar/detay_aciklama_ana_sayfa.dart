import 'package:flutter/material.dart';
import 'package:team_finder/diger_kullanicilar_profil_sayfasi/diger_kullanicilar_profil_sayfasi.dart';

import '../tema.dart';

class DetayAciklamaAnaSayfa extends StatelessWidget {
  final String ulke;
  final String tarih;
  final String userId;
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
  DetayAciklamaAnaSayfa({
    this.ulke,
    this.tarih,
    this.userId,
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
  //final user = FirebaseAuth.instance.currentUser;
  /*var oyun = FirebaseFirestore.instance.collection('oyun');
  var yazilim = FirebaseFirestore.instance.collection('yazilim');
  var tasarim = FirebaseFirestore.instance.collection('tasarim');
  var datas = FirebaseFirestore.instance.collection('datas');*/
  double fontSize = 15;
  double defaultHeight1 = 5;
  double defaultHeight2 = 20;
  @override
  Widget build(BuildContext context) {
    TextStyle textTema = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    Tema renkPaleti = Tema();
    return Scaffold(
      backgroundColor: renkPaleti.temaRenk1,
      appBar: AppBar(
        backgroundColor: renkPaleti.temaRenk1,
        iconTheme: IconThemeData(color: renkPaleti.temaRenk3),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DigerKullanicilarProfilSayfasi(
                                userId: userId,
                                photoUrl: gonderenProfileUrl,
                                isim: gonderenIsim,
                                ulke: ulke,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                gonderenProfileUrl,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
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
                    children: [
                      Text(tarih),
                    ],
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
