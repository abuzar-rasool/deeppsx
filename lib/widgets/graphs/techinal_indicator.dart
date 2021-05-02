import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/stock_data.dart';
import '../../models/stock_data.dart';
import '../../models/stock_data.dart';

class TechnicalIndicatorGraph extends StatefulWidget {
  @override
  _TechnicalIndicatorGraphState createState() =>
      _TechnicalIndicatorGraphState();
}

class _TechnicalIndicatorGraphState extends State<TechnicalIndicatorGraph> {
  StockData _stockData;
  ZoomPanBehavior _zoomPanBehavior;
  int mainXaxisVisibleDays = 100;
  List<bool> indicatorsVisible = [false, false, false];
  List<String> indicators =['RSI', 'Bollinger Bands', 'MACD'];
  @override
  void initState() {
    super.initState();

    _zoomPanBehavior =  ZoomPanBehavior(
        enableDoubleTapZooming: true,
        enablePanning: true
    );

  }

  List<double> getLowsAndHighs(){
    List<double> highsAndLows =[];

    for (int day = 0; day < mainXaxisVisibleDays; day++) {
      DateTime dateNeeded = _stockData.dailyDataWithoutPrediction.last.date.subtract(Duration(days: (mainXaxisVisibleDays-day)));
      double highLow = _stockData.getPriceFromDate(dateNeeded);
      if (highLow != 0) {
        highsAndLows.add((highLow));
      }
    }
    highsAndLows.sort();
    List<double> result = [highsAndLows[0],highsAndLows[highsAndLows.length-1]];
    return result;
  }
  @override
  Widget build(BuildContext context) {
    _stockData = context.watch<StockDataProvider>().currentStockData;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for(int i=0;i<indicators.length;i++) Row(
                children: [
                  Checkbox( value: indicatorsVisible[i],
                    activeColor: Colors.white,
                    checkColor: Style.primraryColor,
                    onChanged: (bool value) {
                      setState(() {
                        indicatorsVisible[i] = value;
                      });
                    },
                  ),
                  Text(indicators[i],style: TextStyle(color: Colors.white,fontSize: 10),)
                ],
              ),


              TextButton(
                  child: Text('+',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  onPressed: ()
                  {
                    _zoomPanBehavior.zoomIn();
                  }
              ),
              TextButton(
                  child: Text('-',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                  onPressed: ()
                  {
                    _zoomPanBehavior.zoomOut();
                  }
              ),
            ],
          ),
          SfCartesianChart(
            zoomPanBehavior: _zoomPanBehavior,
            tooltipBehavior: TooltipBehavior(enable: true, animationDuration: 1),
            primaryXAxis: DateTimeAxis(
                intervalType: DateTimeIntervalType.days,
                majorGridLines: MajorGridLines(color: Style.textColor),
                minorGridLines: MinorGridLines(width: 0),
                visibleMinimum: _stockData.dailyDataWithoutPrediction.last.date.subtract(Duration(days: mainXaxisVisibleDays)),
                visibleMaximum: _stockData.dailyDataWithoutPrediction.last.date,

                name: 'x-prim'
            ),
            primaryYAxis: NumericAxis(
              //visibleMinimum: getLowsAndHighs().reduce((curr, next) => curr < next? curr: next),
              //visibleMaximum: getLowsAndHighs().reduce((curr, next) => curr > next? curr: next),
              visibleMaximum: getLowsAndHighs()[1] + 20,
              visibleMinimum: getLowsAndHighs()[0] - 20,
              numberFormat: NumberFormat.currency(
                symbol: 'Rs ',
              ),
              name: 'y-prim',
              majorGridLines: MajorGridLines(color: Style.textColor),
              minorGridLines: MinorGridLines(width: 0),
              desiredIntervals: 5
            ),

            axes: [
              NumericAxis(
                name: "macd_yaxis",
                opposedPosition: true,
                labelPosition: ChartDataLabelPosition.outside,
                placeLabelsNearAxisLine: true,
              ),

              NumericAxis(
                name: "rsi_yaxis",
                opposedPosition: true,
                labelPosition: ChartDataLabelPosition.outside,
                placeLabelsNearAxisLine: true,
              )
            ],

            indicators: <TechnicalIndicators<DailyStockData, dynamic>>[
              BollingerBandIndicator<DailyStockData, dynamic>(
                  seriesName: "MainSeries",
                  isVisible: indicatorsVisible[1],
                  lowerLineColor: Colors.red,
                  upperLineColor: Colors.green
              ),
              MacdIndicator<DailyStockData, dynamic>(
                  seriesName: "MainSeries",
                  isVisible: indicatorsVisible[2],
                  yAxisName: "macd_yaxis"
              ),
              RsiIndicator<DailyStockData, dynamic>(
                  seriesName: "MainSeries",
                  isVisible: indicatorsVisible[0],
                  yAxisName: "rsi_yaxis"
              )
            ],
            series: <ChartSeries>[
              CandleSeries<DailyStockData, dynamic>(
                  name: "MainSeries",
                  enableSolidCandles: true,
                  dataSource: _stockData.dailyDataWithoutPrediction,
                  xValueMapper: (DailyStockData data, _) => data.date,
                  lowValueMapper: (DailyStockData data, _) => data.low,
                  highValueMapper: (DailyStockData data, _) => data.high,
                  openValueMapper: (DailyStockData data, _) => data.open,
                  closeValueMapper: (DailyStockData data, _) => data.close)
            ],
          ),
        ],
      ),
    );
  }
}