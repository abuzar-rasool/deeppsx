import 'dart:html';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class StockData{
  String stockCompanyName;
  String stockCode;
  List<DailyStockData> dailyData=[];
  StockData.fromList({this.stockCompanyName,this.stockCode,List<List<dynamic>> dataList}){
    for(int i=0;i<dataList.length;i++)
      dailyData.add(DailyStockData.fromList(dataList[i]));
  }
}

class DailyStockData{
  DateTime date;
  double predictedPrice;
  double originalPrice;
  double sma;
  double rsi;
  double upperBBand;
  double middleBBand;
  double lowerBBand;
  double macd;
  double macdSignal;
  int score;
  int signal;

  DailyStockData.fromList(List<dynamic> csvList){
    date =  DateFormat("MM/dd/yyyy").parse(csvList[0]);
    predictedPrice = csvList[1];
    originalPrice=csvList[2];
     sma=csvList[3];
     rsi=csvList[4];
     upperBBand=csvList[5];
     middleBBand=csvList[6];
    lowerBBand=csvList[7];
     macd=csvList[8];
     macdSignal=csvList[9];
     score=csvList[10];
     signal=csvList[11];
  }

}

class StockDataProvider extends ChangeNotifier{
  bool loading;
  StockData currentStockData;

  StockDataProvider(){
    loading=true;
    loadStock();
  }

  loadStock() async {
    loading=true;
    final csvString = await rootBundle.loadString('lib/sample.csv');
    List<List<dynamic>> csvList = const CsvToListConverter().convert(csvString);
    csvList.removeAt(0);
    currentStockData = StockData.fromList(stockCompanyName: 'Apple',stockCode: 'AAPL',dataList: csvList);
    print(currentStockData.dailyData.last.date.toString());
    loading=false;
    notifyListeners();
  }

}
