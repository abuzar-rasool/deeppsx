import 'package:deeppsx/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class GraphTabView extends StatelessWidget {
  final Widget child;
  const GraphTabView({
    Key key,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(child:child,borderRadius: 0);
  }
}