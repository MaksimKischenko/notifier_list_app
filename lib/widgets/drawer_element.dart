

import 'package:flutter/material.dart';
import 'package:notifier_list_app/styles.dart';

class DrawerElement extends StatelessWidget {

  final String title;
  final String info;
  final IconData icon;
  final Function() onTap;

  const DrawerElement({
    Key? key,
    required this.title,
    required this.icon,
    required this.info,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color:const Color(0xff2E3647)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title, style: AppStyles.textStyleBlack3)
            ),
            Text(info, style: AppStyles.textStyleGrey4)
          ],
        ),
      ),
    );
  }
}
