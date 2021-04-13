import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String sectionTitle;
  CustomContainer({
    Key key, @required this.child, @required this.sectionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Style.secodryColor),
      width: double.infinity,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle.toUpperCase(),
            style: Style.customContainerSectionTitleTextStyle,
          ),
          SizedBox(height: 10,),
          child
        ],
      ),
    );
  }
}
