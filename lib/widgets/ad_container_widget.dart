import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdContainer extends StatelessWidget {
  final _nativeAdContoller = NativeAdmobController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 50,
      ),
      Container(
        height: 300,
        child: NativeAdmob(
          adUnitID: NativeAd.testAdUnitId,
          controller: _nativeAdContoller,
          type: NativeAdmobType.full,
          loading: Center(
            child: CircularProgressIndicator(),
          ),
          error: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.exclamationCircle),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Reklam Yüklenirken Bir Hata Oluştu.'),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 50,
      ),
    ]);
  }
}
