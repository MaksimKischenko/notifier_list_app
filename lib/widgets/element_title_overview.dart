

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ElementTitleOverview extends StatelessWidget {

  final String title;
  const ElementTitleOverview({
    Key? key,
    required this.title,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        title,  
        maxLines: 1, 
        style: const TextStyle(fontWeight: FontWeight.w700)
      )
      );
  }
}
