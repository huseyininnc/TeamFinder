import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/tema.dart';

class TumSayfaListviewWidget extends StatelessWidget {
  const TumSayfaListviewWidget({Key key, @required this.documents, this.index})
      : super(key: key);

  final List<DocumentSnapshot> documents;
  final int index;

  @override
  Widget build(BuildContext context) {
    TextStyle textTema = Theme.of(context).textTheme.headline4;
    Tema renkPaleti = Tema();

    return Container(
      //height: 300,
      decoration: BoxDecoration(
        color: renkPaleti.temaRenk2,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Başlık',
                  style: textTema,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  documents[index].get('baslik'),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Ayrıntılar',
                  style: textTema,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  documents[index].get('aciklama'),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: false,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              documents[index].get('profilUrl'),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      documents[index].get('kullaniciAdi'),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [Text(documents[index].get('tarih'))],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
