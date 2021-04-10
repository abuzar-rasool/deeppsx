import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StockAndLogoSection extends StatelessWidget {
  final SizingInformation sizingInformation;
  const StockAndLogoSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: sizingInformation,
      child: Container(),
      desktopWidthFactor: 0.60,
      color: Colors.blue,
    );
  }
}
