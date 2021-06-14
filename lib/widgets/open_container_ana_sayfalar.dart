import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/widgets/tum_sayfa_list_view_widget.dart';

import 'detay_aciklama_ana_sayfalar_widget.dart';

class OpenContainerAnaSayfalar extends StatelessWidget {
  const OpenContainerAnaSayfalar({
    Key key,
    @required this.documents,
    @required this.index,
    @required this.ulke,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final int index;
  final String ulke;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) => TumSayfaListviewWidget(
        documents: documents,
        index: index,
      ),
      openBuilder: (context, action) {
        return DetayAciklamaAnaSayfalarWidget(
          documents: documents,
          index: index,
          ulke: ulke,
        );
      },
    );
  }
}
