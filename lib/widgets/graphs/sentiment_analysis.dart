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

  }
  @override
  Widget build(BuildContext context) {
    _stockData= context.watch<StockDataProvider>().currentStockData;
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
      tooltipBehavior: TooltipBehavior(enable: true, animationDuration: 1),
      primaryXAxis: DateTimeAxis(
        zoomFactor: 0.5,
        zoomPosition: 1,
        intervalType: DateTimeIntervalType.days,
        desiredIntervals: 9,
        interactiveTooltip: InteractiveTooltip(enable: true,),
        majorGridLines: MajorGridLines(width: 1, color: Style.textColor),
        minorGridLines: MinorGridLines(width: 1, color: Style.textColor),
      ),
      primaryYAxis: NumericAxis(
        interactiveTooltip: InteractiveTooltip(enable: true,),
        desiredIntervals: 2,
        visibleMaximum:1,
        visibleMinimum: -1,
        majorGridLines: MajorGridLines(width: 1, color: Style.textColor),
        minorGridLines: MinorGridLines(width: 1, color: Style.textColor),
      ),
      series : [
        ColumnSeries<DailyStockData, DateTime>(

            dataSource: _stockData.dailyData,
            xValueMapper: (DailyStockData data, _) => data.date.isBefore(_stockData.currentDate) && data.date.isAfter(_stockData.currentDate.subtract(Duration(days: 30))) ? data.date :null,
            yValueMapper: (DailyStockData data, _) => data.date.isBefore(_stockData.currentDate) && data.date.isAfter(_stockData.currentDate.subtract(Duration(days: 30)))  ? data.signal :null,
            pointColorMapper: (DailyStockData data, _) => data.date.isBefore(_stockData.currentDate) && data.date.isAfter(_stockData.currentDate.subtract(Duration(days: 30)))  ? data.signal==1 ? Style.logoColorBlue : Style.logoColorPink :null,
          enableTooltip: true,
        )
      ],
    );
  }
}
