## Guidelines
Run the example of connecting to OpenFin and creating applications

1. Clone this repository

2. If pubspec.yaml file drops error with pockets compatibility try write a command: dart pub upgrade --null-safety 

3. Go to release directory and start void main (run)

4. Once the flutter app starts in emulator you will see screens of app

5. In App you can work with notes as in a way of:
    #### create
    #### edit 
    #### delete 
    #### make favorite 
    #### make notification in any time 
    #### change localisation (RU/EN)  
    #### see info about 
    #### search for note  


## Source Code Review

Source code for the example is located in /lib/. 
Start point of app is main.dart

We use Bloc core as main statemanagment instrument in all app

1. To begin with, we will initialize our localization, notification channels and also create an object of SharedPreferences.getInstance(). Let's mark our main method as asynchronous and make special binding for async: WidgetsFlutterBinding.ensureInitialized();

```dart
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
```

2. Then in bootstrap(required ElementApi elementsApi) we continue our initialization and, together with logging, create a repository object and configure BlocObserver 
and TranslationProvider

```dart
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
```
3. Repositiry provider will bi initialized in App Widget

```dart
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
```

4. The element_api will export a generic interface for interacting/managing elements notes. Later we'll implement the ElementApi using shared_preferences. Having an abstraction will make it easy to support other implementations without having to change any other part of our application. For example, we can later add a FirestoreElementApi, which uses cloud_firestore instead of shared_preferences, with minimal code changes to the rest of the application.

```dart
abstract class ElementApi {

  const ElementApi();

  Stream<List<ElementNote>> getElements();

  Future<void> saveElement(ElementNote todo);

  Future<void> deleteElement(String id);

}
```

4. We define our Element model. The model is a Dart representation of the raw Element object that will be stored/retrieved. The Element model uses json_serializable to handle the json (de)serialization. 


```dart
@immutable
@JsonSerializable()
class ElementNote extends Equatable {

  ElementNote({
    String? id,
    required this.title,
    this.description = '',
    this.creationDate,
    this.lastEditDate,
    this.notifytDate,
    this.isFavorite = false
  }) : assert(
    id == null || id.isNotEmpty,
      'id can not be null and should be empty',
  ),
   id = id ?? const Uuid().v4();

  final String? id;

  final bool? isFavorite;

  final String? title;

  final String? description;

  final DateTime? creationDate;

  final DateTime? lastEditDate;

  final DateTime? notifytDate;

  static ElementNote fromJson(JsonMap json) => _$ElementNoteFromJson(json);

  JsonMap toJson() => _$ElementNoteToJson(this);

  @override
  List<Object?> get props => [id, title, description, creationDate, lastEditDate, notifytDate, isFavorite];


  ElementNote copyWith({
    String? id,
    bool? isFavorite,
    String? title,
    String? description,
    DateTime? creationDate,
    DateTime? lastEditDate,
    DateTime? notifytDate,
  }) {
    return ElementNote(
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
      title: title ?? this.title,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      lastEditDate: lastEditDate ?? this.lastEditDate,
      notifytDate: notifytDate ?? this.notifytDate,
    );
  }
}

typedef JsonMap = Map<String, dynamic>;
```

5. In the current implementation, the ElementApi exposes a Stream<List<ElementNote>> via getElements() which will report real-time updates to all subscribers when the list of todos has changed. In addition, elements can be created, deleted, or updated individually. For example, both deleting and saving a element are done with only the element as the argument. It's not necessary to provide the newly updated list of elements each time.


```dart
class LocalStorageElementApi extends ElementApi {

  LocalStorageElementApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _elementStreamController = BehaviorSubject<List<ElementNote>>.seeded(const []);

  static const kElementsCollectionKey = '__elements_collection_key__';
  
  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final elementsJson = _getValue(kElementsCollectionKey);
    if (elementsJson != null) {

    final elements = List<dynamic>.from(json.decode(elementsJson) as List)
          .map((jsonMap) => ElementNote.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();

    _elementStreamController.add(elements);
    } else {
      _elementStreamController.add(const []);
    }
  }

  @override
  Stream<List<ElementNote>> getElements() {
    return _elementStreamController.asBroadcastStream();
  }

  @override
  Future<void> saveElement(ElementNote element) {
    final elements = [..._elementStreamController.value];
    final elementIndex = elements.indexWhere((t) => t.id == element.id);

    if (elementIndex >= 0) {
      elements[elementIndex] = element;
    } else {
      elements.insert(0, element);
    }

    _elementStreamController.add(elements);
    return _setValue(kElementsCollectionKey, json.encode(elements));
  }

  @override
  Future<void> deleteElement(String id) {
    final elements = [..._elementStreamController.value];
    final elementIndex = elements.indexWhere((t) => t.id == id);

    if (elementIndex == -1) {
      throw Exception('Not found');
    } else {
      elements.removeAt(elementIndex);
      _elementStreamController.add(elements);
      return _setValue(kElementsCollectionKey, json.encode(elements));
    }
  }
}
```

6. A repository is part of the business layer. A repository depends on one or more data providers that have no business value, and combines their public API into APIs that provide business value. In addition, having a repository layer helps abstract data acquisition from the rest of the application, allowing us to change where/how data is being stored without affecting other parts of the app.


```dart
class ElementRepository {

  const ElementRepository({
    required ElementApi elementApi,
  }) : _elementApi = elementApi;

  final ElementApi _elementApi;

  Stream<List<ElementNote>> getElements() => _elementApi.getElements();

  Future<void> saveElement(ElementNote element) => _elementApi.saveElement(element);

  Future<void> deleteElement(String id) => _elementApi.deleteElement(id);
}
```

7. I would like to pay special attention to our blocks. In our overview notes logic we use ElementBloc.
With ElementEventInit we Subscribes to the provided [stream] and invokes the [onData] callback when [stream] emits new data and the result is [onData] [forEach] completes when the event handler is canceled or when the provided [stream] ends.

```dart

  void _onElementEventInit (
    ElementEventInit event,
    Emitter<ElementState> emit
  ) async {

    await emit.forEach<List<ElementNote>>(
      _elementsRepository.getElements(), 
      onData: (elements) {
        this.elements = elements;
        return ElementLoaded(
          elements: elements
        );
      }
    );
  }
```
8. Unlike the usual implementations of TODO notebooks, I did not use template options for changing the theme. Instead, the ability to notify the user that our note is waiting for editing was introduced, as well as to change the localization

```dart
  Future<void> _createTimeNotification(ElementNote element) async {
    NotificationWeekAndTime? pickSchedule =  await pickShedule(context);
    if(pickSchedule != null) {
      final DateTime date = DateTime(DateTime.now().year, DateTime.now().month, pickSchedule.dayOfTheWeek, pickSchedule.timeOfDay.hour, pickSchedule.timeOfDay.minute);
      // ignore: use_build_context_synchronously
      context.read<ElementBloc>().add(ElementEventOverviewEdit(element: selectedElementNote.copyWith(notifytDate: date, lastEditDate: DateTime.now())));
      await createNotificationReminder(pickSchedule);
    }
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
```



## More Info
More information and documentation can be found at:

#### https://bloclibrary.dev/#/fluttertodostutorial
#### https://pub.dev/packages/awesome_notifications
#### https://pub.dev/packages/fast_i18n
#### https://pub.dev/packages/shared_preferences








