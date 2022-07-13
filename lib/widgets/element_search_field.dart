
import 'package:flutter/material.dart';
import 'package:notifier_list_app/generated/translations.g.dart';
import 'package:notifier_list_app/styles.dart';

class ElementSearchField extends StatefulWidget {

  final TextEditingController controller;
  final FocusNode? focusNode;
  final int maxLines;
  final TextStyle? textStyle;

  const ElementSearchField({
    required this.controller,
    this.focusNode,
    this.maxLines = 1,
    this.textStyle,
    Key? key,
  }) : super(key: key);


  @override
  State<ElementSearchField> createState() => _ElementSearchFieldState();
}

class _ElementSearchFieldState extends State<ElementSearchField> {

  bool showIcon = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() { 
      setState(() {
        showIcon = widget.controller.text.isNotEmpty;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textAlign: TextAlign.start,     
      style:  widget.textStyle,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        hintText: TranslationProvider.of(context).translations.screens.home.appBarHeaders.header1,
        hintStyle: AppStyles.textStyleBlack2,
        border: InputBorder.none,
        prefixIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.chevron_left, size: 32, color: Color(0xff2E3647)), 
        ),
        suffixIcon: showIcon? IconButton(
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