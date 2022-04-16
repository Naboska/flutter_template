import 'package:flutter/material.dart';

class PossibleWidget extends StatelessWidget {
  final bool isRender;
  final Widget Function() child;

  const PossibleWidget({Key? key, required this.isRender, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRender ? child() : Container();
  }
}