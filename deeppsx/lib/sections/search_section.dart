import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchSection extends StatelessWidget {
  final SizingInformation sizingInformation;
  const SearchSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: sizingInformation,
      child: Container(),
      desktopWidthFactor: 0.17,
      color: Colors.green,
    );
  }
}
