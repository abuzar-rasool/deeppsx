import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class PricePredicationGraph extends StatefulWidget {
  @override
  _PricePredicationGraphState createState() => _PricePredicationGraphState();
}

class _PricePredicationGraphState extends State<PricePredicationGraph> {
  StockData _stockData;
  TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior = TooltipBehavior(
        enable: true,animationDuration: 1);
    _stockData = context.read<StockDataProvider>().currentStockData;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    child: SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(enablePanning: true,enableMouseWheelZooming: true),
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderColor: Style.textColor,
      primaryXAxis: DateTimeAxis(
        zoomFactor: 0.5,
        zoomPosition: 1,
        dateFormat: DateFormat('MMM dd, yy'),
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
        majorGridLines: MajorGridLines(color: Style.textColor),
        minorGridLines: MinorGridLines(width: 0),
        desiredIntervals: 4,
        enableAutoIntervalOnZooming: true,
      ),
      primaryYAxis: NumericAxis(
          autoScrollingMode: AutoScrollingMode.end,
          majorGridLines: MajorGridLines(color: Style.textColor),
          minorGridLines: MinorGridLines(width: 0),
        labelFormat: '{value} Rs'
      ),
      series: <ChartSeries>[
        LineSeries<DailyStockData,DateTime>(dataSource: _stockData.dailyData,
          xValueMapper: (DailyStockData data,_) => data.date,
          yValueMapper: (DailyStockData data,_) => data.predictedPrice,
          enableTooltip: true,
          name: 'Price Prediction',
        )
      ],
    ),
    );
  }
}
