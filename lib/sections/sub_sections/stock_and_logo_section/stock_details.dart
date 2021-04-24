import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              '${context.watch<StockDataProvider>().currentStockData.stockCode}',
              style: Style.headerStockNameTextStyle,
            ),
            Text(
              '${context.watch<StockDataProvider>().currentStockData.stockCompanyName}',
              style: Style.headerCompanyNameTextStyle,)
          ],
        ),
      ),
    );
  }
}
