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
          physics: !sizingInformation.isMobile
              ? NeverScrollableScrollPhysics()
              : null,
          child: Row(
            children: [
              Container(
                width: !sizingInformation.isMobile
                    ? sizingInformation.screenSize.width * 0.62
                    : sizingInformation.screenSize.width,
                height: !sizingInformation.isMobile
                    ? sizingInformation.screenSize.height
                    : sizingInformation.screenSize.height * 1.5,
                color: Colors.blue,
              )
            ],
          ),
        ),
      );
    });
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
