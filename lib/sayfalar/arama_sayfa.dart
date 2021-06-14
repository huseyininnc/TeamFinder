import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/widgets/ad_container_widget.dart';
import 'package:team_finder/widgets/open_container_ana_sayfalar.dart';
import 'package:team_finder/widgets/search_bar_widget.dart';

class AramaSayfa extends StatefulWidget {
  final String ulke;
  @override
  AramaSayfa({
    @required this.ulke,
  });
  _AramaSayfaState createState() => _AramaSayfaState();
}

class _AramaSayfaState extends State<AramaSayfa> {
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  var datas = FirebaseFirestore.instance.collection('datas');

  int yuklenenKonu = 5;

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

  void _onSearchChanged() {
    setState(() {});
  }

  void listViewSonu() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      yuklenenKonu += 5;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: StreamBuilder<QuerySnapshot>(
            stream: datas
                .doc('arama')
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
                return ListView.separated(
                  // ignore: missing_return
                  separatorBuilder: (context, index) {
                    Random random = Random();
                    int randomSonuc = random.nextInt(3);
                    if (searchController.text == '') {
                      switch (randomSonuc) {
                        case 0:
                          return index % 10 == 0
                              ? AdContainer()
                              : SizedBox(
                                  height: 50,
                                );

                          break;
                        case 1:
                          return index % 15 == 0
                              ? AdContainer()
                              : SizedBox(
                                  height: 50,
                                );

                          break;
                        case 2:
                          return index % 20 == 0
                              ? AdContainer()
                              : SizedBox(
                                  height: 50,
                                );

                          break;
                      }
                    } else {
                      return SizedBox(
                        height: 50,
                      );
                    }
                  },
                  itemCount: documents.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          SearchBarWidget(
                            searchController: searchController,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          OpenContainerAnaSayfalar(
                            documents: documents,
                            index: index,
                            ulke: widget.ulke,
                          ),
                        ],
                      );
                    }
                    return OpenContainerAnaSayfalar(
                      documents: documents,
                      index: index,
                      ulke: widget.ulke,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
