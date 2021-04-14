import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GraphTabProvider extends ChangeNotifier{
  int currentTab;
  GraphTabProvider(){
    currentTab=0;
  }
  changeCurrentTab(int newTabValue){
    currentTab=newTabValue;
    notifyListeners();
  }
}