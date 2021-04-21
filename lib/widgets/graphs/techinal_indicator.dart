import 'package:deeppsx/models/stock_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TechnicalIndicatorGraph extends StatefulWidget {
  @override
  _TechnicalIndicatorGraphState createState() => _TechnicalIndicatorGraphState();
}

class _TechnicalIndicatorGraphState extends State<TechnicalIndicatorGraph> {
  StockData _stockData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockData = context.read<StockDataProvider>().currentStockData;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
    );
  }
}
