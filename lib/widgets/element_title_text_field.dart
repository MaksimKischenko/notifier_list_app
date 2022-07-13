

import 'package:flutter/material.dart';
import 'package:notifier_list_app/generated/translations.g.dart';
import 'package:notifier_list_app/styles.dart';

class ElementTitleTextField extends StatefulWidget {

  final bool isEditable;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int maxLines;
  final TextStyle? textStyle;
  final Function() onTap;

  const ElementTitleTextField({
    required this.controller,
    required this.onTap,
    this.isEditable = false,
    this.focusNode,
    this.maxLines = 1,
    this.textStyle,
    Key? key,
  }) : super(key: key);


  @override
  State<ElementTitleTextField> createState() => _ElementTitleTextFieldState();
}

class _ElementTitleTextFieldState extends State<ElementTitleTextField> {

  double turns = 0.0;

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
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: TranslationProvider.of(context).translations.screens.home.appBarHeaders.header3,
        hintStyle: AppStyles.textStyleBlack2,
        prefixIcon: AnimatedRotation(
          turns: widget.focusNode!.hasFocus? turns + 0.25: turns,
          duration:  const Duration(milliseconds: 300),
          child: widget.isEditable? IconButton(
            splashRadius: 1,
            onPressed: () {
              if(widget.focusNode!.hasFocus) {

              } else {
                widget.onTap.call();
                Navigator.pop(context);
              }
            }, 
            icon:const Icon(Icons.chevron_left, size: 32, color: Color(0xff2E3647)), 
          ) : null,
        ),
        suffixIcon: widget.isEditable? IconButton(
          splashRadius: 10,
          onPressed: () {
            widget.controller.text = '';
          }, 
          icon: const Icon(Icons.close, color: Color(0xff2E3647))
        ): null,                                                    
      ),    
    );
  }
}