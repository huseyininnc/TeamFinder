import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/sayfalar/detay_aciklama.dart';

class DetayAciklamaProfilSayfa extends StatelessWidget {
  DetayAciklamaProfilSayfa({
    @required this.index,
    @required this.user,
    @required this.ulke,
    @required this.documents,
  });

  final List<DocumentSnapshot> documents;
  final int index;
  final User user;
  final String ulke;

  @override
  Widget build(BuildContext context) {
    return DetayAciklama(
      ulke: ulke,
      tarih: documents[index].get('tarih'),
      siralama: documents[index].get('siralama'),
      userId: user.uid,
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
