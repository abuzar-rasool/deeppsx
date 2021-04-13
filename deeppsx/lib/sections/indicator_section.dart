import 'package:deeppsx/sections/sub_sections/indicator_section/indicator.dart';
import 'package:deeppsx/sections/sub_sections/indicator_section/status.dart';
import 'package:deeppsx/style/style.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class IndicatorSection extends StatelessWidget {
  final SizingInformation sizingInformation;
  const IndicatorSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: sizingInformation,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
            children: [
          Status(),
          SizedBox(height: 20,),
          Indicator(),
        ]),
      ),
      desktopWidthFactor: 0.23,
    );
  }
}
