import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/sayfalar/detay_aciklama_ana_sayfa.dart';

class DetayAciklamaAnaSayfalarWidget extends StatelessWidget {
  const DetayAciklamaAnaSayfalarWidget(
      {Key key,
      @required this.documents,
      @required this.index,
      @required this.ulke})
      : super(key: key);

  final List<DocumentSnapshot> documents;
  final int index;
  final String ulke;

  @override
  Widget build(BuildContext context) {
    return DetayAciklamaAnaSayfa(
      ulke: ulke,
      userId: documents[index].get('userId'),
      tarih: documents[index].get('tarih'),
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
