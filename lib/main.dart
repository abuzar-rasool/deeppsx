import 'package:deeppsx/home.dart';
import 'package:deeppsx/models/graphtab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'style/style.dart';

void main() {
  runApp(DeepPsx());
}

class DeepPsx extends StatefulWidget {
  @override
  _DeepPsxState createState() => _DeepPsxState();
}

class _DeepPsxState extends State<DeepPsx> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GraphTabProvider()),
      ],
      child: MaterialApp(
        title: 'Deep PSX',
        theme: ThemeData(
          primaryColor: Style.primraryColor,
          accentColor: Style.secondryColor,
          fontFamily: "Montserrat",
        ),
        home: DeepPsxHome(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
