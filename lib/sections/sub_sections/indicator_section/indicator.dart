import 'package:deeppsx/models/signal.dart';
import 'package:deeppsx/widgets/custom_container.dart';
import 'package:deeppsx/widgets/indicator_guage.dart';
import 'package:flutter/material.dart';



class Indicator extends StatelessWidget {
  final Signal signal;

  Indicator({Key key, this.signal}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      sectionTitle: 'Indicator',
      child: Column(
        children: [
          RadialGuage(signal: signal,),
        ],
      ),
    );
  }
}

