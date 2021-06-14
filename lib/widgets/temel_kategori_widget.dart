import 'package:flutter/material.dart';

class TemelKategoriWidget extends StatelessWidget {
  final String isim;
  final Function onPress;
  final Color renk;
  final Color outlineRenk;
  final Color textRenk;
  const TemelKategoriWidget(
      {this.isim = 'YAZILIM',
      this.onPress,
      this.outlineRenk = Colors.black45,
      this.renk = Colors.white,
      this.textRenk = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
              color: renk, border: Border.all(color: outlineRenk)),
          height: 50,
          child: Center(
            child: Text(
              isim,
              style: TextStyle(fontSize: 20, color: textRenk),
            ),
          ),
        ),
      ),
    );
  }
}
