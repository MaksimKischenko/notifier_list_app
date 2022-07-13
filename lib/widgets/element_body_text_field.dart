

import 'package:flutter/material.dart';

class ElementBodyTextField extends StatefulWidget {

  final bool isEditable;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int maxLines;
  final TextStyle? textStyle;

  const ElementBodyTextField({
    required this.controller,
    this.isEditable = false,
    this.focusNode,
    this.maxLines = 1,
    this.textStyle,
    Key? key,
  }) : super(key: key);


  @override
  State<ElementBodyTextField> createState() => _ElementBodyTextFieldState();
}

class _ElementBodyTextFieldState extends State<ElementBodyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textAlign: TextAlign.start,
      style: widget.textStyle,
      readOnly: !widget.isEditable,
      maxLines: widget.maxLines,
      onSubmitted: (value) {
        widget.focusNode?.nextFocus();
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        //filled: widget.isEditable? true : false,
        //fillColor: Colors.grey.withOpacity(0.15),
        // enabledBorder: OutlineInputBorder(
        //   borderSide:   BorderSide(color: widget.isEditable? Colors.blue : Colors.transparent),
        //   borderRadius: BorderRadius.circular(10)
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide:   BorderSide(color: widget.isEditable? Colors.blue : Colors.transparent),
        //   borderRadius: BorderRadius.circular(10)
        // )                                           
      ),
    );
  }
}