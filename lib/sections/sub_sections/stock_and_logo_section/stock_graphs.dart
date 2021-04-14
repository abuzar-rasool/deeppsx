import 'package:deeppsx/models/graphtab_provider.dart';
import 'package:deeppsx/widgets/graph_tab/graph_tab.dart';
import 'package:deeppsx/widgets/graph_tab/graph_tab_bar.dart';
import 'package:deeppsx/widgets/graph_tab/graph_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockGraphs extends StatefulWidget {
  final List<GraphTab> graphTabs;

  const StockGraphs({
    Key key,
    @required this.graphTabs,
  }) : super(key: key);

  @override
  _StockGraphsState createState() => _StockGraphsState(graphTabs);
}

class _StockGraphsState extends State<StockGraphs> {
  List<GraphTab> graphTabs = [];

  _StockGraphsState(this.graphTabs);

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                for (int i = 0; i < graphTabs.length; i++)
                  GraphTabBar(
                    graphTabs[i].tabName,
                    activated:
                        Provider.of<GraphTabProvider>(context, listen: true)
                                    .currentTab ==
                                i
                            ? true
                            : false,
                    tabNumber: i,
                  )
              ],
            ),
            GraphTabView(
                child: graphTabs[
                        Provider.of<GraphTabProvider>(context, listen: true)
                            .currentTab]
                    .child),
          ],
        ),
      ),
      flex: 4,
    );
  }
}
