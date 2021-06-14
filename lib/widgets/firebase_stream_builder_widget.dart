import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/widgets/search_bar_widget.dart';

import 'ad_container_widget.dart';
import 'open_container_ana_sayfalar.dart';

class FirebaseStreamBuilderWidget extends StatefulWidget {
  const FirebaseStreamBuilderWidget({
    Key key,
    @required this.datas,
    @required this.dataBase,
    @required this.ulke,
  }) : super(key: key);

  final CollectionReference datas;
  final String dataBase;
  final String ulke;

  @override
  _FirebaseStreamBuilderWidgetState createState() =>
      _FirebaseStreamBuilderWidgetState();
}

class _FirebaseStreamBuilderWidgetState
    extends State<FirebaseStreamBuilderWidget> {
  ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int yuklenenKonu = 10;

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
      stream: widget.datas
          .doc(widget.dataBase)
          .collection(widget.ulke)
          .limit(yuklenenKonu)
          .where(
            'searchBaslik',
            isGreaterThanOrEqualTo: searchController.text.toLowerCase(),
          )
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) return Container();
        if (snapshot.data != null) {
          final List<DocumentSnapshot> documents = snapshot.data.docs;
          if (documents.length == 0) {
            return Column(
              children: [
                SearchBarWidget(searchController: searchController),
              ],
            );
          }
          return ListView.separated(
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
    );
  }
}
