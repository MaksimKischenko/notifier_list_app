
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notifier_list_app/utils/utils.dart';

Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:'${Emojis.paper_notebook + Emojis.activites_fireworks} Заметка заждалась! Пора ее обновить!',
      body: '',
      //bigPicture: 'asset://assets/app_icon.webp',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<void> createNotificationReminder(NotificationWeekAndTime notificationWeekAndTime) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: '${Emojis.paper_notebook + Emojis.activites_fireworks} Заметка заждалась! Пора ее обновить!',
      body: '',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(key: 'MARK_DONE', label: 'Обновить заметку')
    ],
    schedule: NotificationCalendar(
      day: notificationWeekAndTime.dayOfTheWeek,
      hour: notificationWeekAndTime.timeOfDay.hour,
      minute: notificationWeekAndTime.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true
    )
  );
}




