import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppStyles {

  ///
  /// Colors Button + Menu + Table
  ///

  static const Color colorBlue = Color(0xff0A457D);
  static const Color colorBlue2 = Color(0xff0261BB);
  static const Color colorBlue3 = Color(0xffEDF6FF);
  
  static const Color colorGold = Color(0xffB19D68);
  static const Color colorGold2 = Color(0xffD7BE7C);
  
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorWhite2 = Color(0xffF1F2F3);
  static const Color colorWhite3 = Color(0xffE8EBED);
  static final Color colorWhite4 = const Color(0xffFFFFFF).withOpacity(0.75);

  static const Color colorBlack = Color(0xff000000);
  static const Color colorBlack2 = Color(0xff222222);

  static const Color colorDark = Color(0xff2E3647);
  static const Color colorDark2 = Color(0xff232B3C);
  static const Color colorDark3 = Color(0xff364157);

  static const Color colorGrey = Color(0xff83868D);
  static const Color colorGrey2 = Color(0xff9FA2AA);
  static const Color colorGrey3 = Color(0xffD8DDE1); 


  ///
  /// TextStyle Button + Menu + Table
  ///
  ///
  ///

  static const TextStyle textStyleWhite = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: colorWhite
  );

  static const TextStyle textStyleWhite2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: colorWhite
  );

  static TextStyle textStyleWhite3 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: colorWhite4
  );

  static const TextStyle textStyleWhite4 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: colorWhite
  );


  static const TextStyle textStyleBlack = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30,
    color: colorDark
  );

  static const TextStyle textStyleBlack2 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: colorDark,
  );


  static const TextStyle textStyleBlack3 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: colorDark,
  );

  static const TextStyle textStyleBlack4 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: colorDark,
  );

  static const TextStyle textStyleBlack5 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    fontStyle: FontStyle.normal,
    color: colorBlack
  );


  static const TextStyle textStyleBlack6 = TextStyle(
    fontSize: 16,
    color: colorBlack
  );


  static const TextStyle textStyleGrey = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: colorGrey,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle textStyleGrey2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: colorGrey,
  );

  static const TextStyle textStyleGrey3 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: colorGrey2,
  );

  static const TextStyle textStyleGrey4 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: colorGrey,
  );

  static const TextStyle textStyleBlue = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: colorBlue2
  );

}