import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';
class SentimentAnalysisGraph extends StatefulWidget {
  @override
  _SentimentAnalysisGraphState createState() => _SentimentAnalysisGraphState();
}

class _SentimentAnalysisGraphState extends State<SentimentAnalysisGraph> {
  StockData _stockData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockData = context.read<StockDataProvider>().currentStockData;
  }
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true, animationDuration: 1),
      primaryXAxis: DateTimeAxis(
        enableAutoIntervalOnZooming: true,
        interactiveTooltip: InteractiveTooltip(enable: true,),
        majorGridLines: MajorGridLines(color: Style.textColor),
        minorGridLines: MinorGridLines(width: 1, color: Style.textColor),
      ),
      primaryYAxis: NumericAxis(
        interactiveTooltip: InteractiveTooltip(enable: true,),
        desiredIntervals: 2,
        visibleMaximum:1,
        visibleMinimum: -1,
        majorGridLines: MajorGridLines(color: Style.textColor),
        minorGridLines: MinorGridLines(width: 1, color: Style.textColor),
      ),
      series : [
        ColumnSeries<DailyStockData, DateTime>(
            dataSource: _stockData.dailyData,
            xValueMapper: (DailyStockData data, _) => data.date.isBefore(_stockData.currentDate) && data.date.isAfter(_stockData.currentDate.subtract(Duration(days: 30))) ? data.date :null,
            yValueMapper: (DailyStockData data, _) => data.date.isBefore(_stockData.currentDate) && data.date.isAfter(_stockData.currentDate.subtract(Duration(days: 30)))  ? data.signal :null,
          enableTooltip: true,
        )
      ],
    );
  }
}
