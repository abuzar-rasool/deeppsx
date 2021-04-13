import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Logo extends StatefulWidget {
  final SizingInformation sizingInformation;
  Logo({
    @required this.sizingInformation,
    Key key,
  }) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  int _calculateFlex() {
    if (widget.sizingInformation.isDesktop || widget.sizingInformation.isTablet) {
      return 1;
    } else {
      return 2;
    }
  }

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: _calculateFlex(),
      child: Container(
        decoration: BoxDecoration(
          color: Style.secodryColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(Style.borderRadiusExtreme)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationController,
              child: new Container(
                child: Image.asset('lib/images/deep-psx-logo.png',width: 50,height: 50,),
              ),
              builder: (BuildContext context, Widget _widget) {
                return new Transform.rotate(
                  angle: animationController.value * 6.3,
                  child: _widget,
                );
              },
            ),
            Text(
              "deeppsx",
              style: Style.logoTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
