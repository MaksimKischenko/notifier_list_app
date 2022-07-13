import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notifier_list_app/data/repository/element_repository.dart';
import 'package:notifier_list_app/screens/screens.dart';

import 'navigation.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.elementsRepository}) : super(key: key);

  final ElementRepository elementsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: elementsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {

  const AppView({Key? key}) : super(key: key);

  static const primary = MaterialColor(0xffD7BE7C, {
    50: Color(0xff2B50A1),
    100: Color(0xff2B50A1),
    200: Color(0xff2B50A1),
    300: Color(0xff2B50A1),
    400: Color(0xff2B50A1),
    500: Color(0xff2B50A1),
    600: Color(0xff2B50A1),
    700: Color(0xff2B50A1),
    800: Color(0xff2B50A1),
    900: Color(0xff2B50A1)
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Navigation.navigatorKey,
      useInheritedMediaQuery: true,
      home: const HomeScreenOverView(),
      theme: ThemeData(
        primarySwatch: primary,
      ),
    );
  }
}
