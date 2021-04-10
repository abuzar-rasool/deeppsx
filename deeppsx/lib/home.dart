import 'package:deeppsx/sections/indicator_section.dart';
import 'package:deeppsx/sections/search_section.dart';
import 'package:deeppsx/sections/stock_and_logo_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'style/style.dart';

class DeepPsxHome extends StatelessWidget {
  const DeepPsxHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: Style.primraryColor,
        body: SingleChildScrollView(
          physics: sizingInformation.isDesktop
              ? NeverScrollableScrollPhysics()
              : null,
          child: Wrap(
            children: [
              StockAndLogoSection(
                sizingInformation: sizingInformation,
              ),
              IndicatorSection(
                sizingInformation: sizingInformation,
              ),
              SearchSection(
                sizingInformation: sizingInformation,
              ),
            ],
          ),
        ),
      );
    });
  }
}
