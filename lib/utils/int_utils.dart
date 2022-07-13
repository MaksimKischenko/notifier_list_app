extension PluralExtension on int {

  /// Plural forms for russian words
  /// [this] count quantity for word
  String plural(String form1, String form2, String form3) {
    final num = this % 100;

    if (num >= 11 && num <= 19) {
      return form3;
    }

    final i = num % 10;

    switch (i) {
      case 1:
        return form1;
      case 2:
      case 3:
      case 4:
        return form2;
      default:
        return form3;
    }
  }
}