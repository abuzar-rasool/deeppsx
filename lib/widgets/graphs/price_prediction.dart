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
  TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true, animationDuration: 1);
    _trackballBehavior = TrackballBehavior(enable: true);
  }

  List<double> getPredictionRanges(){
    List<double> result =[];
    _stockData.dailyData.getRange(_stockData.dailyData.length-28,_stockData.dailyData.length).toList().forEach((element) {
      result.add(element.predictedPrice);
      result.add(element.originalPrice);
    });
    return result.where((element) => element!=null).toList();
  }

  @override
  Widget build(BuildContext context) {
    _stockData = context.watch<StockDataProvider>().currentStockData;
    return Container(
      child: SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        trackballBehavior: _trackballBehavior,
        zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
        plotAreaBorderColor: Style.textColor,
        primaryXAxis: DateTimeAxis(
          enableAutoIntervalOnZooming: false,
          minimum: _stockData.currentDate.subtract(Duration(days: 7)),
          // zoomFactor: 0.2,
          // zoomPosition: 0.2,
          autoScrollingMode: AutoScrollingMode.end,
          dateFormat: DateFormat('MMM dd'),
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
          majorGridLines: MajorGridLines(color: Style.textColor),
          minorGridLines: MinorGridLines(width: 1, color: Style.textColor.withAlpha(50)),
          interval: 7,
          intervalType: DateTimeIntervalType.days,
        ),
        primaryYAxis: NumericAxis(
            minimum: getPredictionRanges().reduce((curr, next) => curr < next? curr: next)-10,
            maximum: getPredictionRanges().reduce((curr, next) => curr > next? curr: next)+10,
            enableAutoIntervalOnZooming: true,
            desiredIntervals: 5,
            majorGridLines: MajorGridLines(color: Style.textColor),
            minorGridLines: MinorGridLines(width: 0),
            labelFormat: '{value} Rs'),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          textStyle: TextStyle(
            color: Style.headingColor,
          ),
        ),
        series: <ChartSeries>[
          LineSeries<DailyStockData, DateTime>(
            dataSource: _stockData.dailyData.where((element) => element.date.isAfter(_stockData.currentDate.subtract(Duration(days: 14)))).toList(),
            xValueMapper: (DailyStockData data, _) => data.date,
            yValueMapper: (DailyStockData data, _) =>
                data.date.isAfter(_stockData.currentDate)
                    ? null
                    : data.originalPrice,
            pointColorMapper: (DailyStockData data, _) => Style.logoColorBlue,
            enableTooltip: true,
            name: 'Original Price',
              markerSettings: MarkerSettings(
                  isVisible: true
              )
          ),
          LineSeries<DailyStockData, DateTime>(
            dataSource: _stockData.dailyData,
            xValueMapper: (DailyStockData data, _) => data.date,
            yValueMapper: (DailyStockData data, _) =>
                data.date.isAfter(_stockData.currentDate)
                    ? data.predictedPrice
                    : data.date.isAtSameMomentAs(_stockData.currentDate)
                        ? data.originalPrice
                        : null,
            pointColorMapper: (DailyStockData data, _) => Style.logoColorPink,
            enableTooltip: true,
            name: 'Price Prediction',
              markerSettings: MarkerSettings(
                  isVisible: true
              )
          ),
        ],
      ),
    );
  }
}
