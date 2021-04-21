import 'package:deeppsx/models/graphtab_provider.dart';
import 'package:deeppsx/style/style.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphTabBar extends StatelessWidget {
  final String tabTitle;
  final bool activated;
  final int tabNumber;
  GraphTabBar(
    this.tabTitle, {
    Key key,
    this.activated = false,
    this.tabNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<GraphTabProvider>(context, listen: false)
              .changeCurrentTab(tabNumber);
        },
        child: CustomContainer(
          child: Text(
            tabTitle,
            style: TextStyle(
                fontSize: 11,
                color: Style.headingColor,
                fontWeight: Style.getFontWeight('regular')),
          ),
          padding: 13,
          titleAndChildGap: 0,
          borderRadius: 0,
          backgroundColor:
              activated ? Style.secondryColor : Style.primraryColor,
        ));
  }
}
