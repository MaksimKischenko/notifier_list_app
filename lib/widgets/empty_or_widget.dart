

import 'package:flutter/material.dart';

class EmptyOrWidget extends StatelessWidget {
  
  final bool checkFlag;
  final Widget showWidget;

  const EmptyOrWidget({
    Key? key,
    required this.checkFlag,
    required this.showWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => checkFlag? Container(): showWidget;
}
