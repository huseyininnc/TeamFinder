import 'package:flutter/material.dart';
import 'package:team_finder/tema.dart';

class KucukIsimler extends StatelessWidget {
  final String isim;
  final Color renk;
  final Color isimRenk;
  final Function onPress;
  KucukIsimler(
      {this.isimRenk = Colors.white,
      this.renk = Colors.deepOrange,
      this.isim,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: renk,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            isim,
            style: TextStyle(fontSize: 20, color: isimRenk),
          ),
        ),
      ),
    );
  }
}
