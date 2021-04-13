import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';

class StockDetails extends StatelessWidget {
  const StockDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AAPL",
              style: Style.headerStockNameTextStyle,
            ),
            Text(
              "Apple Inc",
              style: Style.headerCompanyNameTextStyle,)
          ],
        ),
      ),
    );
  }
}
