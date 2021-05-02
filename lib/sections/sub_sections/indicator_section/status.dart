import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Status extends StatelessWidget {
  StockData _stockData;
  Widget _arrowIndicator(bool decrease) {
    return RotatedBox(
      quarterTurns: decrease ? 2 : 0,
      child: Image.asset('lib/images/arrow.png'),
    );
  }



  @override
  Widget build(BuildContext context) {
    _stockData = context.watch<StockDataProvider>().currentStockData;
    double change = _stockData.dailyDataWithoutPrediction.last.originalPrice-_stockData.dailyDataWithoutPrediction[_stockData.dailyDataWithoutPrediction.length-2].originalPrice;
    double percentage = change/_stockData.dailyDataWithoutPrediction.last.originalPrice*100;
    return CustomContainer(
      sectionTitle: 'Status',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _arrowIndicator(change.isNegative ? true : false),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${_stockData.dailyDataWithoutPrediction.last.originalPrice.toStringAsFixed(2)} PKR', style: Style.stockStatusPriceTextStyle),
              Text(
                '${change > 0 ? '+'+change.toStringAsFixed(2) : change.toStringAsFixed(2)} (${percentage.abs().toStringAsFixed(2)}%)',
                style: Style.stockStatusPriceVariationTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
