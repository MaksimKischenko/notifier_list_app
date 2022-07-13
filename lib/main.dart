import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bootstrap.dart';
import 'data/local/local_storage_element.dart';
import 'generated/translations.g.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocaleSettings.useDeviceLocale();
  final language = await PreferencesHelper.read(PrefsKeys.language);
  LocaleSettings.setLocaleRaw(language!);


  AwesomeNotifications().initialize(
   'resource://drawable/notification_icon',
     [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: '',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,  
        ),
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Notifications',
          channelDescription: '',
          defaultColor: Colors.teal,
          locked: true,
          importance: NotificationImportance.High,
          channelShowBadge: true,  
        ),
     ],
  );

  final elementsApi = LocalStorageElementApi(
    plugin: await SharedPreferences.getInstance(),
  );
  bootstrap(elementsApi: elementsApi);
}