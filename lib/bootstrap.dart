

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:notifier_list_app/bloc/simple_bloc_observer.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';

import 'api/element_api.dart';
import 'app.dart';
import 'generated/translations.g.dart';

void bootstrap({required ElementApi elementsApi}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final elementsRepository = ElementRepository(elementApi: elementsApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          TranslationProvider(
            child: App(elementsRepository: elementsRepository),
          )
        ),
        blocObserver: SimpleBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}