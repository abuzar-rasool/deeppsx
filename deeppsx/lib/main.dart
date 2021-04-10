import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Style.primraryColor,
        accentColor: Style.secodryColor,
      ),
      home: DeepPsxHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DeepPsxHome extends StatelessWidget {
  const DeepPsxHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: Style.primraryColor,
        body: SingleChildScrollView(
          physics: sizingInformation.isDesktop
              ? NeverScrollableScrollPhysics()
              : null,
          child: Wrap(
            children: [
              ResponsiveContainer(
                sizingInformation: sizingInformation,
                child: Container(),
                desktopWidthFactor: 0.60,
                color: Colors.blue,
              ),
              ResponsiveContainer(
                sizingInformation: sizingInformation,
                child: Container(),
                desktopWidthFactor: 0.25,
                color: Colors.green,
              ),
              ResponsiveContainer(
                sizingInformation: sizingInformation,
                child: Container(),
                desktopWidthFactor: 0.15,
                color: Colors.red,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ResponsiveContainer extends StatelessWidget {
  final double desktopWidthFactor;
  final double desktopHeightFactor;
  final double mobileAndTabletWidthFactor;
  final double mobileAndTabletHeightFactor;
  final Widget child;
  final Color color;
  final SizingInformation sizingInformation;
  ResponsiveContainer({
    Key key,
    @required this.sizingInformation,
    @required this.child,
    this.desktopWidthFactor = 1,
    this.desktopHeightFactor = 1,
    this.mobileAndTabletWidthFactor = 1,
    this.mobileAndTabletHeightFactor = 1.5,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizingInformation.isDesktop
          ? sizingInformation.screenSize.width * desktopWidthFactor
          : sizingInformation.screenSize.width * mobileAndTabletWidthFactor,
      height: sizingInformation.isDesktop
          ? sizingInformation.screenSize.height * desktopHeightFactor
          : sizingInformation.screenSize.height * mobileAndTabletHeightFactor,
      color: color,
      child: child,
    );
  }
}

class DemoContainer extends StatelessWidget {
  Color colr;
  DemoContainer(this.colr);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colr,
    );
  }
}
