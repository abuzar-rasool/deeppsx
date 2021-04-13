import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveContainer extends StatelessWidget {
  final double desktopWidthFactor;
  final double desktopHeightFactor;
  final double mobileAndTabletWidthFactor;
  final double mobileAndTabletHeightFactor;
  final Widget child;
  final Color color;
  final SizingInformation sizingInformation;
  ResponsiveContainer({
    Key key,
    @required this.sizingInformation,
    @required this.child,
    this.desktopWidthFactor = 1,
    this.desktopHeightFactor = 0.9998,
    this.mobileAndTabletWidthFactor = 1,
    this.mobileAndTabletHeightFactor = 0.9998,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizingInformation.isDesktop
          ? sizingInformation.screenSize.width * desktopWidthFactor
          : sizingInformation.screenSize.width * mobileAndTabletWidthFactor,
      height: sizingInformation.isDesktop
          ? sizingInformation.screenSize.height * desktopHeightFactor
          : sizingInformation.screenSize.height * mobileAndTabletHeightFactor,
      color: color,
      child: child,
    );
  }
}
