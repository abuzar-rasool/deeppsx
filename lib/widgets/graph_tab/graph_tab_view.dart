import 'package:deeppsx/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GraphTabView extends StatelessWidget {
  final Widget child;
  const GraphTabView({
    Key key,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DeviceScreenType deviceType = getDeviceType(MediaQuery.of(context).size);
    return CustomContainer(child:Container(child:child,width: double.infinity,height: deviceType == DeviceScreenType.mobile  ? size.height*0.50 : size.height*0.55,),borderRadius: 0);
  }
}