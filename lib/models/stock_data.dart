import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class StockData{
  String stockCompanyName;
  String stockCode;
  DateTime currentDate;
  List<DailyStockData> dailyData=[];
  List<DailyStockData> dailyDataWithoutPrediction=[];
  String url;
  StockData.fromURL({this.stockCompanyName,this.stockCode,this.url});
  StockData.fromList({this.stockCompanyName,this.stockCode,List<List<dynamic>> dataList}){
    _parseCSVList(dataList);
  }

  _parseCSVList(List<List<dynamic>> dataList){
    for(int i=0;i<dataList.length-14;i++){
      dailyData.add(DailyStockData.fromList(dataList[i]));
      dailyDataWithoutPrediction.add(DailyStockData.fromList(dataList[i]));
    }
    currentDate = dailyData.last.date;
    for(int i=dataList.length-14;i<dataList.length;i++){
      dailyData.add(DailyStockData.fromPredictionList(dataList[i]));
    }
  }
  getDataFromURL() async {
    List<List<dynamic>> dataList= await CSVHelper.getCSVList(url);
    _parseCSVList(dataList);
  }

  getPriceFromDate(DateTime date){
    double result = 0.0;
    dailyDataWithoutPrediction.forEach((element) {
      if (element.date.difference(date).inDays == 0) {
        result =  element.open;
      }
    });
    return result;
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
  List<StockData> stocks=[];

  StockDataProvider(){
    loading=true;
    initializeStocks();
  }

  setStock(String stockCode) async {
    loading=true;
    currentStockData=stocks.firstWhere((element) => element.stockCode==stockCode);

    await currentStockData.getDataFromURL();

    loading=false;
    notifyListeners();
  }

  initializeStocks() async {
    List<List<dynamic>> csvList = await CSVHelper.getCSVList('https://docs.google.com/spreadsheets/d/e/2PACX-1vSYq-m64kKpE29W4DbydXLnPdy6Kgoj5-YpOkz88K46JxviQ781ie0AS9Vo6z5hAsN7a-ptExZ1qO_j/pub?output=csv');
    for(List<dynamic> row in csvList){
      stocks.add(StockData.fromURL(stockCode: row[0],stockCompanyName: row[1],url: row[2]));
    }
    setStock('ABOT');
  }

}



class CSVHelper{
  static Future<List<List<dynamic>>> getCSVList(String csvURL) async {
    var url = Uri.parse(csvURL);
    String csvString = await http.read(url);
    List<List<dynamic>> csvList = const CsvToListConverter().convert(csvString);
    csvList.removeAt(0);
    return csvList;
  }
}
