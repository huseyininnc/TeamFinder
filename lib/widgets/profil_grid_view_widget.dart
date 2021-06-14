import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_finder/tema.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key key, @required this.documents, this.index})
      : super(key: key);

  final List<DocumentSnapshot> documents;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Başlık: ${documents[index].get('baslik')}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Açıklama: ${documents[index].get('aciklama')}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        documents[index].get('profilUrl'),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    documents[index].get('kullaniciAdi'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Tema().temaRenk2,
      ),
    );
  }
}
