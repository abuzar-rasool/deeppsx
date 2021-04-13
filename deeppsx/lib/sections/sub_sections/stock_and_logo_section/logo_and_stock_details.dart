import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'logo.dart';
import 'stock_details.dart';

class LogoAndStockDetails extends StatelessWidget {
  final SizingInformation sizingInformation;
  const LogoAndStockDetails({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            Logo(sizingInformation: sizingInformation,),
            StockDetails(),
          ],
        ),
      ),
      flex: 1,
    );
  }
}


