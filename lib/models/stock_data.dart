import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class StockData{
  String stockCompanyName;
  String stockCode;
  DateTime currentDate;
  List<DailyStockData> dailyData=[];
  List<DailyStockData> dailyDataWithoutPrediction=[];
  StockData.fromList({this.stockCompanyName,this.stockCode,List<List<dynamic>> dataList}){
    for(int i=0;i<dataList.length-14;i++){
      dailyData.add(DailyStockData.fromList(dataList[i]));
      dailyDataWithoutPrediction.add(DailyStockData.fromList(dataList[i]));
    }
    currentDate = dailyData.last.date;
    for(int i=dataList.length-14;i<dataList.length;i++){
      dailyData.add(DailyStockData.fromPredictionList(dataList[i]));
    }
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
  double open;
  double high;
  double low;
  double close;
  double volume;
  int score;
  int signal;
  DailyStockData();
  DailyStockData.fromPredictionList(List<dynamic> csvList){
    date =  DateFormat("dd/MM/yyyy").parse(csvList[0]);
    predictedPrice = csvList[1];
  }
  DailyStockData.fromList(List<dynamic> csvList){
    date =  DateFormat("dd/MM/yyyy").parse(csvList[0]);
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
     open=csvList[12];
     high=csvList[13];
     low=csvList[14];
     close=csvList[15];
     volume=csvList[16];
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
    currentStockData = StockData.fromList(stockCompanyName: 'Abbot Laboratories (PAKISTAN) LTD',stockCode: 'ABOT',dataList: csvList);
    loading=false;
    notifyListeners();
  }

}
