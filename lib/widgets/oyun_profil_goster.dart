import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OyunProfilGoster extends StatelessWidget {
  const OyunProfilGoster({
    Key key,
    @required this.pubg,
    @required this.user,
  }) : super(key: key);

  final CollectionReference pubg;
  final User user;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // <2> Pass `Stream<QuerySnapshot>` to stream
      stream: pubg.doc(user.uid).collection('konu').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) return CircularProgressIndicator();
        if (snapshot.data != null) {
          final List<DocumentSnapshot> documents = snapshot.data.docs;
          return GridView.builder(
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            shrinkWrap: true,
            itemCount: documents.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                child: Text(documents[index].get('baslik')),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
              );
            },
          );
        }
      },
    );
  }
}
