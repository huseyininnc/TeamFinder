import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'open_container.dart';

class ProfilStreamBuilder extends StatelessWidget {
  final String ulke;

  ProfilStreamBuilder({
    @required this.dataBase,
    @required this.user,
    @required this.ulke,
  });

  final CollectionReference dataBase;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: dataBase
              .doc(user.uid)
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
                  childAspectRatio: 1.6,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (BuildContext ctx, index) {
                  return OpenContainerProfilWidget(
                    documents: documents,
                    index: index,
                    user: user,
                    ulke: ulke,
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
