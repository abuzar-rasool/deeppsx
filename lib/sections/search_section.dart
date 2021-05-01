import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:provider/provider.dart';

class SearchSection extends StatelessWidget {
  final SizingInformation sizingInformation;
  const SearchSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: sizingInformation,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
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
            ListView.builder(
              itemCount: context.read<StockDataProvider>().stocks.length,
              itemBuilder: (context, item) {
                return SearchTile(stockCode: context.read<StockDataProvider>().stocks[item].stockCode);
              },
              shrinkWrap: true,
            )
            // Container(
            //   decoration: BoxDecoration(
            //     color: Style.primraryColor,
            //     border: ,
            //   ),
            //   width: double.infinity,
            //   height: 80,
            //
            // )
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
      child: CustomContainer(
        backgroundColor: context.read<StockDataProvider>().currentStockData.stockCode==stockCode ? Style.logoColorBlue : Style.primraryColor,
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
    );
  }
}
