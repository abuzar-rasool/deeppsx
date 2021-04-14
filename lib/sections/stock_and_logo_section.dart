import 'package:deeppsx/sections/sub_sections/stock_and_logo_section/logo_and_stock_details.dart';
import 'package:deeppsx/sections/sub_sections/stock_and_logo_section/stock_graphs.dart';
import 'package:deeppsx/widgets/graph_tab/graph_tab.dart';
import 'package:deeppsx/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StockAndLogoSection extends StatelessWidget {
  final SizingInformation sizingInformation;
  const StockAndLogoSection({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      sizingInformation: sizingInformation,
      child: Column(
        children: [
          LogoAndStockDetails(sizingInformation: sizingInformation,),
          StockGraphs(
            graphTabs: [
              GraphTab(
                tabName: 'Graph1',
                child: Container(),
              ),
              GraphTab(
                tabName: 'Graph2',
                child: Container(),
              ),
              GraphTab(
                tabName: 'Graph3',
                child: Container(),
              ),
            ],
          )
        ],
      ),
      desktopWidthFactor: 0.60,
    );
  }
}


