import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'diger_kullanicilar_detay_aciklama.dart';

class DigerKullanicilarDetayWidget extends StatelessWidget {
  const DigerKullanicilarDetayWidget({
    Key key,
    @required this.documents,
    @required this.index,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DigerKullanicilarDetayAciklama(
      tarih: documents[index].get('tarih'),
      id: documents[index].id,
      kategori: documents[index].get('kategori'),
      baslik: documents[index].get('baslik'),
      aciklama: documents[index].get('aciklama'),
      yas1: documents[index].get('yas1'),
      yas2: documents[index].get('yas2'),
      ulke2: documents[index].get('ulke'),
      sehir: documents[index].get('sehir'),
      gereksinimler: documents[index].get('gereksinimler'),
      iletisimBilgileri: documents[index].get('iletisimBilgileri'),
      gonderenIsim: documents[index].get('kullaniciAdi'),
      gonderenProfileUrl: documents[index].get('profilUrl'),
    );
  }
}
