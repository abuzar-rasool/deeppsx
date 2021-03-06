import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';

class SearchSection extends StatefulWidget {
  SizingInformation sizingInformation;

  SearchSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  List<StockData> _stockData = [];
  List<StockData> _newDataList = [];
  onItemChanged(String value) {
      _newDataList = _stockData
          .where((StockData data) => data.stockCode.toLowerCase().contains(value.toLowerCase()))
          .toList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stockData = context.read<StockDataProvider>().stocks;
    _newDataList = _stockData;
  }
  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: widget.sizingInformation,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              onChanged:(value){
                setState(() {
                  onItemChanged(value);
                });

              },
              cursorColor: Colors.white,
              minLines: 1,
              maxLength: 10,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  suffixStyle: TextStyle(color: Colors.white70),
                  helperStyle: TextStyle(color: Colors.white70),
                  counterStyle: TextStyle(color: Colors.white70),
                  hintStyle: TextStyle(color: Colors.white70),
                  labelStyle: TextStyle(color: Colors.white),
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  hintText: 'Enter stock code'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: widget.sizingInformation.isDesktop ? widget.sizingInformation.screenSize.height*0.80 : 500,
              child: ListView.builder(
                itemCount: _newDataList.length,
                itemBuilder: (context, item) {
                  return SearchTile(stockCode: _newDataList[item].stockCode);
                },
                shrinkWrap: true,
              ),
            )

          ],
        ),
      ),
      desktopWidthFactor: 0.17,
      color: Style.secondryColor,
    );
  }
}

class SearchTile extends StatelessWidget {
  String stockCode;
  SearchTile({
    this.stockCode,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:8.0),
      child: GestureDetector(
        onTap: (){
          if(context.read<StockDataProvider>().currentStockData.stockCode!=stockCode){
            context.read<StockDataProvider>().setStock(stockCode);
          }
        },
        child: CustomContainer(
          backgroundColor: context.read<StockDataProvider>().currentStockData.stockCode==stockCode ? Style.logoColorPink : Style.primraryColor,
          padding: 0,
          borderRadius: 20,
          child: Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  stockCode.toUpperCase(),
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Style.headerCompanyNameTextStyle,
                ),
              )),
        ),
      ),
    );
  }
}
