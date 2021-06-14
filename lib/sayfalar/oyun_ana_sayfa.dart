import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/tema.dart';
import 'package:team_finder/widgets/ad_container_widget.dart';
import 'package:team_finder/widgets/open_container_ana_sayfalar.dart';
import 'package:team_finder/widgets/oyun_horizontal.dart';
import 'package:team_finder/widgets/search_bar_widget.dart';

class OyunSayfa extends StatefulWidget {
  final String ulke;

  OyunSayfa({
    @required this.ulke,
  });

  @override
  _OyunSayfaState createState() => _OyunSayfaState();
}

class _OyunSayfaState extends State<OyunSayfa> {
  Color deepOrenge = Tema().temaRenk3;

  final user = FirebaseAuth.instance.currentUser;
  var datas = FirebaseFirestore.instance.collection('datas');

  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int yuklenenKonu = 10;
  int secimOyun = 0;
  String secimData = 'oyun';

  void listViewSonu() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      yuklenenKonu += 10;
      setState(() {});
    }
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _scrollController..addListener(listViewSonu);
    searchController.addListener(_onSearchChanged);
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: searchController.text == ''
          ? datas
              .doc(secimData)
              .collection(widget.ulke)
              .limit(yuklenenKonu)
              .orderBy(
                'siralama',
                descending: true,
              )
              .snapshots()
          : datas
              .doc(secimData)
              .collection(widget.ulke)
              .limit(yuklenenKonu)
              .where(
                'searchBaslik',
                isGreaterThanOrEqualTo: searchController.text.toLowerCase(),
              )
              .snapshots(),
      // ignore: missing_return
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) return Container();
        if (snapshot.data != null) {
          final List<DocumentSnapshot> documents = snapshot.data.docs;
          if (documents.length == 0) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SearchBarWidget(searchController: searchController),
                  SizedBox(
                    height: 10,
                  ),
                  kategorilerColumn(),
                ],
              ),
            );
          }
          return ListView.separated(
            // ignore: missing_return
            separatorBuilder: (context, index) {
              Random random = Random();
              int randomSonuc = random.nextInt(3);

              switch (randomSonuc) {
                case 0:
                  return index % 10 == 0 && index != 0
                      ? AdContainer()
                      : SizedBox(
                          height: 50,
                        );

                  break;
                case 1:
                  return index % 15 == 0 && index != 0
                      ? AdContainer()
                      : SizedBox(
                          height: 50,
                        );

                  break;
                case 2:
                  return index % 20 == 0 && index != 0
                      ? AdContainer()
                      : SizedBox(
                          height: 50,
                        );

                  break;
              }
            },
            itemCount: documents.length,
            shrinkWrap: true,
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    SearchBarWidget(
                      searchController: searchController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    kategorilerColumn(),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: OpenContainerAnaSayfalar(
                        documents: documents,
                        index: index,
                        ulke: widget.ulke,
                      ),
                    ),
                  ],
                );
              }
              return Padding(
                padding: EdgeInsets.all(5),
                child: OpenContainerAnaSayfalar(
                  documents: documents,
                  index: index,
                  ulke: widget.ulke,
                ),
              );
            },
          );
        }
      },
    );
  }

  Column kategorilerColumn() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kategoriler',
                style: TextStyle(fontSize: 20),
              ),
              GestureDetector(
                child: Text(
                  '', //daha fazla yazisi icin
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 0;
                        secimData = 'oyun';
                      },
                    );
                  },
                  isimRenk: secimOyun == 0 ? deepOrenge : null,
                  isimSize: secimOyun == 0 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/oyun.png',
                  isim: 'OYUN',
                ),
                SizedBox(
                  width: 30,
                ),
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 1;
                        secimData = 'fps';
                      },
                    );
                  },
                  isimRenk: secimOyun == 1 ? deepOrenge : null,
                  isimSize: secimOyun == 1 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/fps.png',
                  isim: 'FPS',
                ),
                SizedBox(
                  width: 30,
                ),
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 2;
                        secimData = 'spor';
                      },
                    );
                  },
                  isimRenk: secimOyun == 2 ? deepOrenge : null,
                  isimSize: secimOyun == 2 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/futbol.png',
                  isim: 'SPOR',
                ),
                SizedBox(
                  width: 30,
                ),
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 3;
                        secimData = 'survivor';
                      },
                    );
                  },
                  isimRenk: secimOyun == 3 ? deepOrenge : null,
                  isimSize: secimOyun == 3 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/hayatta_kalma.png',
                  isim: 'SURVİVOR',
                ),
                SizedBox(
                  width: 30,
                ),
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 4;
                        secimData = 'kart';
                      },
                    );
                  },
                  isimRenk: secimOyun == 4 ? deepOrenge : null,
                  isimSize: secimOyun == 4 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/kart_oyunlari.png',
                  isim: 'KART',
                ),
                SizedBox(
                  width: 30,
                ),
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 5;
                        secimData = 'rpg';
                      },
                    );
                  },
                  isimRenk: secimOyun == 5 ? deepOrenge : null,
                  isimSize: secimOyun == 5 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/rpg.png',
                  isim: 'RPG',
                ),
                SizedBox(
                  width: 30,
                ),
                OyunHorizontal(
                  onPress: () {
                    setState(
                      () {
                        secimOyun = 6;
                        secimData = 'yaris';
                      },
                    );
                  },
                  isimRenk: secimOyun == 6 ? deepOrenge : null,
                  isimSize: secimOyun == 6 ? 15 : null,
                  iconKonum: 'assets/oyunresimleri/yaris.png',
                  isim: 'YARIŞ',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
