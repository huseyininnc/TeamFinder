import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OyunHorizontal extends StatefulWidget {
  final String iconKonum;
  final String isim;
  final Function onPress;
  final Color isimRenk;
  final double isimSize;
  OyunHorizontal(
      {Key key,
      this.isimSize,
      this.isimRenk = Colors.black,
      this.iconKonum,
      this.isim,
      this.onPress});

  @override
  _OyunHorizontalState createState() => _OyunHorizontalState();
}

class _OyunHorizontalState extends State<OyunHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onPress,
          child: Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(widget.iconKonum)),
              //borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.isim,
          style: TextStyle(color: widget.isimRenk, fontSize: widget.isimSize),
        ),
      ],
    );
  }
}
