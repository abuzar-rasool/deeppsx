import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Logo extends StatelessWidget {
  final SizingInformation sizingInformation;
  Logo({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  int _calculateFlex() {
    if (sizingInformation.isDesktop || sizingInformation.isTablet) {
      return 1;
    } else {
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: _calculateFlex(),
      child: Container(
        decoration: BoxDecoration(
          color: Style.secodryColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(Style.borderRadiusExtreme)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/deep-psx-logo.png',
              width: 50,
              height: 50,
            ),
            Text(
              "deeppsx",
              style: Style.logoTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
