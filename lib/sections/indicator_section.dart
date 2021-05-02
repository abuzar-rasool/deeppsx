import 'package:deeppsx/models/signal.dart';
import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/sections/sub_sections/indicator_section/indicator.dart';
import 'package:deeppsx/sections/sub_sections/indicator_section/status.dart';
import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';

class IndicatorSection extends StatefulWidget {
  final SizingInformation sizingInformation;

  IndicatorSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  _IndicatorSectionState createState() => _IndicatorSectionState();
}

class _IndicatorSectionState extends State<IndicatorSection> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: widget.sizingInformation,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
            children: [
         Spacer(),
          Status(),
          SizedBox(height: 20,),
          Indicator(),
        ]),
      ),
      desktopWidthFactor: 0.23,
    );
  }
}
