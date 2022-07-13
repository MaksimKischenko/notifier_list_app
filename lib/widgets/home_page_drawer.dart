
import 'package:flutter/material.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/generated/translations.g.dart';

import '../screens/screens.dart';
import 'widgets.dart';

class HomePageDrawer extends StatefulWidget {

  final List<ElementNote?> elements;

  const HomePageDrawer({
    Key? key,
    required this.elements,
  }) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) { 

    AppLocale curentLocal = TranslationProvider.of(context).locale;
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight:Radius.circular(10), bottomRight: Radius.circular(10))  
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerElement(
              icon: Icons.language,
              title: TranslationProvider.of(context).translations.screens.home.drawer.element1,
              info: TranslationProvider.of(context).locale.languageTag.toUpperCase(),
              onTap: () {
                if(curentLocal == AppLocale.en) {
                  curentLocal = AppLocale.ru;
                } else {
                  curentLocal = AppLocale.en;
                }                                    
                _onLanguageChanged(curentLocal);
              },
            ),
            const SizedBox(height: 20),
            DrawerElement(
              icon: Icons.notes,
              title: TranslationProvider.of(context).translations.screens.home.drawer.element2,
              info: '${widget.elements.length}',
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            DrawerElement(
              icon: Icons.star_outline,
              title: TranslationProvider.of(context).translations.screens.home.drawer.element3,
              info: '${_favoritesCounter()}',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesElementsScreenOverview()));
              },
            ),                                                   
          ],
        ),
      ),
    );
  }

  int _favoritesCounter() {
    return widget.elements.where((element) => element?.isFavorite == true).length;
  }

  void _onLanguageChanged(AppLocale newLang) async {
    LocaleSettings.setLocale(newLang);
    await PreferencesHelper.write(PrefsKeys.language, newLang.languageTag);
  }
}
