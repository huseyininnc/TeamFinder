import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/widgets/profil_grid_view_widget.dart';

import 'diger_kullanicilar_detay_aciklama_widget.dart';

class DigerKullanicilarProfilStreamBuilder extends StatelessWidget {
  const DigerKullanicilarProfilStreamBuilder({
    Key key,
    @required this.dataBase,
    @required this.userId,
    @required this.ulke,
  }) : super(key: key);

  final CollectionReference dataBase;
  final String userId;
  final String ulke;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: dataBase
              .doc(userId)
              .collection(ulke)
              .orderBy(
                'siralama',
                descending: true,
              )
              .snapshots(),
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) return CircularProgressIndicator();
            if (snapshot.data != null) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return GridView.builder(
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (BuildContext ctx, index) {
                  return OpenContainer(
                    closedBuilder: (context, action) => GridViewWidget(
                      documents: documents,
                      index: index,
                    ),
                    openBuilder: (context, action) =>
                        DigerKullanicilarDetayWidget(
                            documents: documents, index: index),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
