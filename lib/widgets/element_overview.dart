import 'dart:async';

import 'package:notifier_list_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/styles.dart';
import 'package:notifier_list_app/widgets/widgets.dart';

class ElementOverView extends StatefulWidget {

  final ElementNote elementNote;
  final ElementNote? notifiredElementNote;
  final Function() onTap;
  final Function()? onLongPress;

  const ElementOverView({
    Key? key,
    required this.elementNote,
    required this.onTap,
    this.notifiredElementNote,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<ElementOverView> createState() => ElementOverViewState();
}

class ElementOverViewState extends State<ElementOverView> {

  Timer? timer;

  @override
  void initState() {
    super.initState();

    // if(widget.notifiredElementNote?.title != 'fake') {
  
    //   timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => setState(() {
    //     print('1');
    //   }));
   
    // } 
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InkWrapper(
            borderRadius: 10,
            onTap: widget.onTap,
            onLongTap: widget.onLongPress,
            child: Card(
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Color(0xffB19D68)
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))  
              ),
              elevation: 5,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.elementNote.description ?? '', 
                          maxLines: 10, 
                          style: const TextStyle(fontSize: 8)
                        )
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),   
        Text(widget.elementNote.title ?? '', style: AppStyles.textStyleBlack4, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.elementNote.creationDate!.toStringFormatted(), style: AppStyles.textStyleGrey4),
            EmptyOrWidget(
              checkFlag: !(widget.elementNote.isFavorite ?? false), 
              showWidget:const Icon(Icons.star, size: 14, color: Color(0xffB19D68)),
            ),
            EmptyOrWidget(
              checkFlag: (widget.elementNote.notifytDate == null || widget.elementNote.notifytDate!.isBefore(DateTime.now())), 
              showWidget: Icon(Icons.notifications, size: 14, color: Colors.red.shade300),
            )
          ],
        )              
      ],
    );
  }
}
