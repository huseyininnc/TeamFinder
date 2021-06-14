import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:team_finder/tema.dart';

class KonuYaz extends StatefulWidget {
  final String ulke;
  KonuYaz({@required this.ulke});
  @override
  _KonuYazState createState() => _KonuYazState();
}

class _KonuYazState extends State<KonuYaz> {
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  String baslik,
      aciklama,
      yas1,
      yas2,
      ulke2,
      sehir,
      gereksinimler,
      iletisimBilgileri;

  final user = FirebaseAuth.instance.currentUser;
  /*
  var oyun = FirebaseFirestore.instance.collection('oyun');
  var yazilim = FirebaseFirestore.instance.collection('yazilim');
  var tasarim = FirebaseFirestore.instance.collection('tasarim');
  var datas = FirebaseFirestore.instance.collection('datas');*/

  String dropdownValue = 'OYUN';
  double defaultPadding = 10.0;
  double defaultRadiusCircular = 25.0;
  double defaultFontSize = 20.0;

  Tema renkPaleti = Tema();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String tarih = dateFormat.format(
      DateTime.now(),
    );
    /*String siralama = dateFormatSiralama.format(
      DateTime.now(),
    );*/
    DateTime siralamaTarih = DateTime.now();
    Timestamp siralama = Timestamp.fromDate(siralamaTarih);
    _displaySnackBarBosAlan(BuildContext context) {
      final snackBar = SnackBar(content: Text('Gönderide boş alanlar var.'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    _displaySnackBarYas(BuildContext context) {
      final snackBar = SnackBar(content: Text('Yaş aralığını uygun seçin.'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    _displaySnackBarEnDusukYas(BuildContext context) {
      final snackBar = SnackBar(content: Text('En düşük yaş 13 olmalıdır'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    Map bilgiler = <String, dynamic>{
      'baslik': baslik,
      'aciklama': aciklama,
      'yas1': yas1,
      'yas2': yas2,
      'ulke': ulke2,
      'sehir': sehir,
      'gereksinimler': gereksinimler,
      'iletisimBilgileri': iletisimBilgileri,
      'profilUrl': user.photoURL,
      'kullaniciAdi': user.displayName,
      'kategori': dropdownValue,
      'tarih': tarih,
      'siralama': siralama,
    };

    return Scaffold(
      backgroundColor: renkPaleti.temaRenk1,
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: renkPaleti.iconTema,
        backgroundColor: renkPaleti.temaRenk1,
        centerTitle: true,
        title: Text(
          'Konu Yaz',
          style: TextStyle(color: renkPaleti.temaRenk4),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (baslik != null &&
                  aciklama != null &&
                  yas1 != null &&
                  yas2 != null &&
                  ulke2 != null &&
                  sehir != null &&
                  gereksinimler != null &&
                  iletisimBilgileri != null) {
                if (int.parse(yas1) >= 13 &&
                    int.parse(yas2) > 13 &&
                    int.parse(yas1) < int.parse(yas2)) {
                  FirebaseFirestore.instance
                      .collection(
                        dropdownValue
                            .toLowerCase()
                            .replaceAll('ı', 'i')
                            .replaceAll('ş', 's')
                            .replaceAll('ü', 'u')
                            .replaceAll(' ', ''),
                      )
                      .doc(user.uid)
                      .collection(widget.ulke)
                      .add(bilgiler);
                  Navigator.pop(context);
                }
              }
              if (yas1 != null && yas2 != null) {
                if (int.parse(yas1) >= int.parse(yas2)) {
                  _displaySnackBarYas(context);
                }
                if (int.parse(yas1) < 13 || int.parse(yas2) < 13) {
                  _displaySnackBarEnDusukYas(context);
                }
              } else {
                _displaySnackBarBosAlan(context);
              }
            },
            icon: Icon(
              FontAwesomeIcons.paperPlane,
              size: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Kategoriler',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            DropdownButton(
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              value: dropdownValue,
              items: <String>[
                'OYUN',
                'FPS',
                'SPOR',
                'SURVİVOR',
                'KART',
                'RPG',
                'YARIŞ',
                'YAZILIM',
                'WEB',
                'MOBİL',
                'MASA ÜSTÜ',
                'YAPAY ZEKA',
                'VERİ TABANI',
                'VERİ ANALİZİ',
                'TASARIM',
                'PHOTO EDİT',
                'VİDEO EDİT',
                'ANİMASYON',
                '3D MODELLEME',
                'KARAKTER',
                'PİXEL',
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Başlık',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextField(
                onChanged: (text) {
                  setState(
                    () {
                      baslik = text;
                    },
                  );
                },
                maxLength: 30,
                inputFormatters: [ModifiedLengthLimitingTextInputFormatter(30)],
                decoration: InputDecoration(
                  hintText: 'Konu Başlığı.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(defaultRadiusCircular),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Ayrıntılar',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextField(
                onChanged: (text) {
                  setState(
                    () {
                      aciklama = text;
                    },
                  );
                },
                minLines: 6,
                maxLines: 15,
                maxLength: 1000,
                inputFormatters: [
                  ModifiedLengthLimitingTextInputFormatter(1000)
                ],
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Konu Ayrıntıları.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(defaultRadiusCircular),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Yaş Sınırı',
                  style: TextStyle(fontSize: defaultFontSize),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        setState(
                          () {
                            yas1 = text;
                          },
                        );
                      },
                      maxLines: 1,
                      maxLength: 2,
                      inputFormatters: [
                        ModifiedLengthLimitingTextInputFormatter(2)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'en az 13',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            new Radius.circular(defaultRadiusCircular),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        setState(
                          () {
                            yas2 = text;
                          },
                        );
                      },
                      maxLines: 1,
                      maxLength: 2,
                      inputFormatters: [
                        ModifiedLengthLimitingTextInputFormatter(2)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'en fazla 99',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            new Radius.circular(defaultRadiusCircular),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Ülke',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextField(
                onChanged: (text) {
                  setState(
                    () {
                      ulke2 = text;
                    },
                  );
                },
                maxLength: 30,
                inputFormatters: [ModifiedLengthLimitingTextInputFormatter(30)],
                decoration: InputDecoration(
                  hintText: 'Herhangi biri veya Ülke/Ülkeler.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(defaultRadiusCircular),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Şehir',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextField(
                onChanged: (text) {
                  setState(
                    () {
                      sehir = text;
                    },
                  );
                },
                maxLength: 30,
                inputFormatters: [ModifiedLengthLimitingTextInputFormatter(30)],
                decoration: InputDecoration(
                  hintText: 'Herhangi biri veya Şehir/Şehirler.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(defaultRadiusCircular),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Gereksinimler',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextField(
                onChanged: (text) {
                  setState(
                    () {
                      gereksinimler = text;
                    },
                  );
                },
                minLines: 4,
                maxLines: 6,
                maxLength: 300,
                inputFormatters: [
                  ModifiedLengthLimitingTextInputFormatter(300)
                ],
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Python orta seviye\nPubg 50 level vb.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(defaultRadiusCircular),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Text(
                  'İletişim Bilgileri',
                  style: TextStyle(fontSize: defaultFontSize),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: TextField(
                onChanged: (text) {
                  setState(
                    () {
                      iletisimBilgileri = text;
                    },
                  );
                },
                minLines: 3,
                maxLines: 5,
                maxLength: 100,
                inputFormatters: [
                  ModifiedLengthLimitingTextInputFormatter(100)
                ],
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'facebook, instagram, mail, vb.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      new Radius.circular(defaultRadiusCircular),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModifiedLengthLimitingTextInputFormatter
    extends LengthLimitingTextInputFormatter {
  final int _maxLength;

  ModifiedLengthLimitingTextInputFormatter(this._maxLength) : super(_maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.composing.isValid) {
      if (maxLength != null &&
          maxLength > 0 &&
          oldValue.text.characters.length == maxLength &&
          !oldValue.composing.isValid) {
        return oldValue;
      } else if (newValue.text.characters.length > maxLength) {
        return oldValue;
      }
      return newValue;
    }
    if (maxLength != null &&
        maxLength > 0 &&
        newValue.text.characters.length > maxLength) {
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    final CharacterRange iterator = CharacterRange(value.text);
    if (value.text.characters.length > maxLength) {
      iterator.expandNext(maxLength);
    }
    final String truncated = iterator.current;
    return TextEditingValue(
      text: truncated,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, truncated.length),
        extentOffset: min(value.selection.end, truncated.length),
      ),
      composing: TextRange.empty,
    );
  }
}
