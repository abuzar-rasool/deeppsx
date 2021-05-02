import 'package:deeppsx/models/signal.dart';
import 'package:deeppsx/models/stock_data.dart';
import 'package:deeppsx/style/style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:provider/provider.dart';

class RadialGuage extends StatefulWidget {

  RadialGuage({Key key}) : super(key: key);

  @override
  _RadialGuageState createState() => _RadialGuageState();
}

class _RadialGuageState extends State<RadialGuage> {
  Signal signal;
  String _signalString;
  int _finalValue;
  int _signalInt;

  _RadialGuageState();

  Signal _getSignal(int signalInt){
    if(signalInt==0){
      return Signal.Hold;
    }else if (signalInt==1){
      return Signal.Buy;
    }else if (signalInt==-1){
      return Signal.Sell;
    }
  }
  _getFinalValue(){
    switch(signal){
      case Signal.Sell:{
        _finalValue=25;
      }
      break;
      case Signal.Hold:{
        _finalValue=50;
      }
      break;
      case Signal.Buy:{
        _finalValue=75;
      }
      break;
      default: {
        _finalValue=100;
      }

    }
  }
  _getSignalString() {
    switch (signal) {
      case Signal.Sell:
        {
          _signalString = 'Sell';
        }
        break;
      case Signal.Buy:
        {
          _signalString = 'Buy';
        }
        break;
      case Signal.Hold:
        {
          _signalString = 'Hold';
        }
        break;
      default:
        {
          _signalString = 'Strong Buy';
        }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signalInt = context.read<StockDataProvider>().currentStockData.dailyDataWithoutPrediction.last.score;
    signal=_getSignal(_signalInt);
    _getFinalValue();
    _getSignalString();
  }

  @override
  Widget build(BuildContext context) {
      _signalInt = context.watch<StockDataProvider>().currentStockData.dailyDataWithoutPrediction.last.signal;
      signal=_getSignal(_signalInt);
      setState(() {
        _getFinalValue();
        _getSignalString();
      });
    return _buildRadialNonLinearLabel();
  }
  /// Returns the non-linear axis label gauge
  SfRadialGauge _buildRadialNonLinearLabel() {
    return SfRadialGauge(
      backgroundColor: Colors.transparent,
      enableLoadingAnimation: true,
      key: null,
      animationDuration: 2500,
      axes: <RadialAxis>[
        RadialAxis(
            labelOffset: 0,
            axisLineStyle: AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.10,color: Style.primraryColor),
            radiusFactor: 0.8,
            minimum: 0,
            showTicks: false,
            maximum: 100,
            // Added custom axis renderer that extended from RadialAxisRenderer
            onCreateAxisRenderer: handleCreateAxisRenderer,
            showAxisLine: true,
            pointers: <GaugePointer>[
              NeedlePointer(
                  enableAnimation: true,
                  gradient: const LinearGradient(colors: <Color>[
                    Color.fromRGBO(203, 126, 223, 0),
                    Color(0xFFCB7EDF)
                  ], stops: <double>[
                    0.25,
                    0.75
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  animationType: AnimationType.easeOutBack,
                  value: _finalValue.toDouble(),
                  lengthUnit: GaugeSizeUnit.factor,
                  animationDuration: 1300,
                  needleStartWidth: 3,
                  needleEndWidth: 6,
                  needleLength: 0.8,
                  knobStyle: KnobStyle(
                    knobRadius: 0,
                  )),
              RangePointer(
                  value: _finalValue.toDouble(),
                  width: 0.15,
                  sizeUnit: GaugeSizeUnit.factor,
                  color: _pointerColor,
                  animationDuration: 1300,
                  animationType: AnimationType.easeOutBack,
                  gradient: const SweepGradient(
                      colors: <Color>[Color(0xff4390EA),Color(0xffE63487)],
                      stops: <double>[0.25, 0.75]),
                  enableAnimation: true)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  axisValue: 8,
                  positionFactor: 1.1,
                  widget: Text(_signalString,
                      style: TextStyle(
                          fontSize:16,
                          fontWeight: Style.getFontWeight('regular'),
                          color: Colors.white
                      ))
              )
            ],
        )
      ],
    );
  }

  GaugeAxisRenderer handleCreateAxisRenderer() {
    final _CustomAxisRenderer _customAxisRenderer = _CustomAxisRenderer();
    return _customAxisRenderer;
  }

  final Color _pointerColor = const Color(0xFF494CA2);
}

class _CustomAxisRenderer extends RadialAxisRenderer {
  _CustomAxisRenderer() : super();

  /// Generated the 9 non-linear interval labels from 0 to 150
  /// instead of actual generated labels.
  @override
  List<CircularAxisLabel> generateVisibleLabels() {
    final List<CircularAxisLabel> _visibleLabels = <CircularAxisLabel>[];
    return _visibleLabels;
  }
}
