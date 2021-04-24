import 'package:deeppsx/style/style.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  Widget _arrowIndicator(bool decrease) {
    return RotatedBox(
      quarterTurns: decrease ? 2 : 0,
      child: Image.asset('lib/images/arrow.png'),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      sectionTitle: 'Status',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _arrowIndicator(false),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('123 PKR', style: Style.stockStatusPriceTextStyle),
              Text(
                '+0.85 (0.70%)',
                style: Style.stockStatusPriceVariationTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
