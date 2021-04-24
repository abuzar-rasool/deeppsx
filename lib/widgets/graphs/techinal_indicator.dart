import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TechnicalIndicatorGraph extends StatefulWidget {
  @override
  _TechnicalIndicatorGraphState createState() =>
      _TechnicalIndicatorGraphState();
}

class _TechnicalIndicatorGraphState extends State<TechnicalIndicatorGraph> {
  StockData _stockData;
  ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _stockData = context.read<StockDataProvider>().currentStockData;

  }

  List<double> getLowsAndHighs(){
    List<double> result =[];
    _stockData.dailyData.getRange(_stockData.dailyData.length-74,_stockData.dailyData.length-14).forEach((element) {
      result.add(element.low);
      result.add(element.high);
    });
    return result.where((element) => element!=null).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
            enableMouseWheelZooming: true,
            enablePanning: true,
        ),
        tooltipBehavior: TooltipBehavior(enable: true, animationDuration: 1),
        primaryXAxis: DateTimeAxis(
          intervalType: DateTimeIntervalType.days,

          majorGridLines: MajorGridLines(color: Style.textColor),
          minorGridLines: MinorGridLines(width: 0),
          name: 'x-prim'
        ),
        primaryYAxis: NumericAxis(
            //visibleMinimum: getLowsAndHighs().reduce((curr, next) => curr < next? curr: next),
            //visibleMaximum: getLowsAndHighs().reduce((curr, next) => curr > next? curr: next),
            numberFormat: NumberFormat.currency(
          symbol: 'Rs ',
        ),
          name: 'y-prim',

          majorGridLines: MajorGridLines(color: Style.textColor),
          minorGridLines: MinorGridLines(width: 0),
        ),
        indicators: [
          BollingerBandIndicator(isVisible: true,xAxisName: 'x-prim',yAxisName: 'y-prim')
        ],
        series: <ChartSeries>[
          CandleSeries<DailyStockData, dynamic>(
              dataSource: _stockData.dailyDataWithoutPrediction,
              xValueMapper: (DailyStockData data, _) => data.date,
              lowValueMapper: (DailyStockData data, _) => data.low,
              highValueMapper: (DailyStockData data, _) => data.high,
              openValueMapper: (DailyStockData data, _) => data.open,
              closeValueMapper: (DailyStockData data, _) => data.close)
        ],
      ),
    );
  }
}
