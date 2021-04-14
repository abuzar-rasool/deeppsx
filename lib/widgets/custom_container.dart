import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String sectionTitle;
  final double borderRadius;
  final double padding;
  final Color backgroundColor;
  final double titleAndChildGap;
  CustomContainer({
    Key key,
    @required this.child,
    this.sectionTitle = '',
    this.borderRadius = Style.borderRadiusLight,
    this.padding = 20,
    this.backgroundColor = Style.secondryColor,
    this.titleAndChildGap = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionTitle.isNotEmpty)
            Text(
              sectionTitle.toUpperCase(),
              style: Style.customContainerSectionTitleTextStyle,
            ),
          SizedBox(
            height: titleAndChildGap,
          ),
          child
        ],
      ),
    );
  }
}
