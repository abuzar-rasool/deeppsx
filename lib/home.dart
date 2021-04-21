import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/sections/indicator_section.dart';
import 'package:deeppsx/sections/search_section.dart';
import 'package:deeppsx/sections/stock_and_logo_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'style/style.dart';
import 'package:provider/provider.dart';

class DeepPsxHome extends StatefulWidget {
  const DeepPsxHome({Key key}) : super(key: key);

  @override
  _DeepPsxHomeState createState() => _DeepPsxHomeState();
}

class _DeepPsxHomeState extends State<DeepPsxHome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<StockDataProvider>().loading ? Center(child: CircularProgressIndicator(),) :ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Style.primraryColor,
        body: SingleChildScrollView(
          // physics: sizingInformation.isDesktop
          //     ? NeverScrollableScrollPhysics()
          //     : null,
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
