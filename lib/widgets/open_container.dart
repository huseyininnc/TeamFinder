import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/widgets/detay_aciklama_profil_sayfa.dart';
import 'package:team_finder/widgets/profil_grid_view_widget.dart';

class OpenContainerProfilWidget extends StatelessWidget {
  OpenContainerProfilWidget({
    @required this.documents,
    @required this.index,
    @required this.user,
    @required this.ulke,
  });

  final List<DocumentSnapshot> documents;
  final int index;
  final User user;
  final String ulke;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) => GridViewWidget(
        documents: documents,
        index: index,
      ),
      openBuilder: (context, action) {
        return DetayAciklamaProfilSayfa(
          documents: documents,
          index: index,
          user: user,
          ulke: ulke,
        );
      },
    );
  }
}
