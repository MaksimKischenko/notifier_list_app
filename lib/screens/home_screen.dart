
import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifier_list_app/bloc/bloc.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';
import 'package:notifier_list_app/generated/translations.g.dart';
import 'package:notifier_list_app/notifications/notifications.dart';
import 'package:notifier_list_app/styles.dart';
import 'package:notifier_list_app/widgets/widgets.dart';
import 'package:notifier_list_app/utils/utils.dart';

import 'screens.dart';

class HomeScreenOverView extends StatelessWidget {

  static const pageRoute = '/home';
  
  const HomeScreenOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ElementBloc>(
          create: (context) => ElementBloc(elementsRepository: context.read<ElementRepository>())..add(ElementEventInit()),
        ),        
      ], 
      child: const HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _setSystemNavigationBarStyle();
    _setNotificationStreamListener();
    _onElementsInitialize();
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close(); 
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  int elementCount = 0;
  late ElementNote selectedElementNote;
  List<ElementNote> elementNotes = [];
  bool makeAction = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomePageDrawer(
        elements: elementNotes,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              onPressed: _toElementSearch, 
              icon: const Icon(Icons.search, color: Color(0xff2E3647))
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<ElementBloc, ElementState>(
          listener: (context, state) {
            if(state is ElementLoaded) {
              setState(() {
                elementCount = state.elements.length;
              });
            }
          },
          builder: (context, state) {
            Widget body = Container();
            if(state is ElementLoaded) {
              var elements = state.elements;
              body = Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [                  
                     Text(
                      TranslationProvider.of(context).translations.screens.home.header.title, 
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleBlack,
                    ),                  
                    Text(
                      '$elementCount ${elementCount.plural(TranslationProvider.of(context).translations.screens.home.header.count1, TranslationProvider.of(context).translations.screens.home.header.count2, TranslationProvider.of(context).translations.screens.home.header.count3)}', 
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleGrey4,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: elements.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.5,
                          crossAxisCount:  3,
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 6
                        ),                
                        itemBuilder: (context, index) {
                          elementNotes = elements;
                          var elementNote = elements[index];    

                          return Stack(
                            children: [
                              ElementOverView(
                                onTap: () => _toElementEdit(elementNote),
                                onLongPress: () => _onElementSelection(elementNote),
                                elementNote: elementNote,
                              ),
                              makeAction? Positioned(
                                top: 10,
                                left: 10,
                                child: EmptyOrWidget(
                                  checkFlag: selectedElementNote != elementNote,
                                  showWidget: const Icon(Icons.check_circle, color: Color(0xffD7BE7C))
                                )    
                              ) : Container()
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
           }
           return body;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: const Color(0xff2E3647),
        focusColor: const Color(0xff364157),
        onPressed: _onAddElement ,
        child: const Icon(Icons.create_rounded)
      ),
      bottomNavigationBar: makeAction? CurvedNavigationBar(
          backgroundColor: const Color(0xffD7BE7C),
          items: const [
            Icon(Icons.info, size: 24, color:  Color(0xff2E3647)),
            Icon(Icons.delete, size: 24, color:  Color(0xff2E3647)),
            Icon(Icons.star_outline, size: 24, color:  Color(0xff2E3647)),
            Icon(Icons.notification_add, size: 24, color:  Color(0xff2E3647)),
            Icon(Icons.arrow_downward, size: 24, color:  Color(0xff2E3647)),
          ],
          onTap: (index) async {
            ScaffoldMessenger.of(context).clearSnackBars();
            _onBottomBarSelection(index);
          },
        ) : null,
    );
  }

  void _onAddElement() {
    context.read<ElementBloc>().add(ElementEventAdd());
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10))   
        ),
        backgroundColor: const Color(0xff2E3647),        
        elevation: 20,
        content: Text(TranslationProvider.of(context).translations.screens.message.add),
        duration: const Duration(seconds: 1),
    ));   
  }

  void _toElementEdit(ElementNote element) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ElementActionScreenOverView(elementNote: element)));
  }

  void _toElementSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreenOverView()));
  }

  void _onDeleteElement(ElementNote element) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10))   
        ),        
        elevation: 20,
        backgroundColor: const Color(0xff2E3647),
        content: Text('${TranslationProvider.of(context).translations.screens.message.delete}?'),
        duration: const Duration(seconds: 60),
        action: SnackBarAction(
          textColor: const Color(0xffD7BE7C),
          label: TranslationProvider.of(context).translations.screens.message.info.actionTrue,
          onPressed: () => context.read<ElementBloc>().add(ElementEventDelete(id: element.id ?? ''))
        ),
    ));   
  }

  void _onElementSelection(ElementNote elementNote) {
    ScaffoldMessenger.of(context).clearSnackBars();
    setState(() {

      selectedElementNote = elementNote;
      makeAction = true;                              
    });
  }

  void _onBottomBarSelection(int index) async {
    switch (index) {
      case 0:
        _onElementInfo(selectedElementNote);
        break;
      case 1:
        _onDeleteElement(selectedElementNote);
        makeAction = false;   
        break;  
      case 2:
        _onAddElementToFavorites(selectedElementNote);
        break;           
      case 3:
        await _createTimeNotification(selectedElementNote);
        break;                                              
      case 4:
        setState(() {
          makeAction = false;
        });
        break;           
    }    
  }

  void _onElementInfo(ElementNote element) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10))   
        ),
        backgroundColor: const Color(0xff2E3647),
        elevation: 20,
        content:Text('${selectedElementNote.title}\n${selectedElementNote.description?.length} ${selectedElementNote.description?.length.plural(TranslationProvider.of(context).translations.screens.message.info.count1, TranslationProvider.of(context).translations.screens.message.info.count2, TranslationProvider.of(context).translations.screens.message.info.count3)}\n${TranslationProvider.of(context).translations.screens.message.info.creationDate} ${selectedElementNote.creationDate?.toStringFormattedRunOperation()}\n${TranslationProvider.of(context).translations.screens.message.info.editedDate} ${selectedElementNote.lastEditDate?.toStringFormattedRunOperation()}\n${TranslationProvider.of(context).translations.screens.message.info.notificationDate} ${selectedElementNote.notifytDate?.toStringFormattedRunOperation()}'),
        duration: const Duration(seconds: 60),                   
    )); 
  }

  Future<void> _createTimeNotification(ElementNote element) async {
    NotificationWeekAndTime? pickSchedule =  await pickShedule(context);
    if(pickSchedule != null) {
      final DateTime date = DateTime(DateTime.now().year, DateTime.now().month, pickSchedule.dayOfTheWeek, pickSchedule.timeOfDay.hour, pickSchedule.timeOfDay.minute);
      // ignore: use_build_context_synchronously
      context.read<ElementBloc>().add(ElementEventOverviewEdit(element: selectedElementNote.copyWith(notifytDate: date, lastEditDate: DateTime.now())));
      await createNotificationReminder(pickSchedule);
    }
  }

  Future<void> _onAddElementToFavorites(ElementNote element)  async{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight: Radius.circular(10))   
        ),        
        elevation: 20,
        backgroundColor: const Color(0xff2E3647),
        content: Text('${TranslationProvider.of(context).translations.screens.message.favorites}?'),
        duration: const Duration(seconds: 60),
        action: SnackBarAction(
          textColor: const Color(0xffD7BE7C),
          label: TranslationProvider.of(context).translations.screens.message.info.actionTrue,
          onPressed: () => context.read<ElementBloc>().add(ElementEventOverviewEdit(element: selectedElementNote.copyWith(isFavorite: true)))
        ),
    ));   
  }

  void _setSystemNavigationBarStyle() {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xffD7BE7C),
          systemNavigationBarIconBrightness: Brightness.light
        )
      );
    }
  }

  void _setNotificationStreamListener() {
    if(mounted) {
      AwesomeNotifications().actionStream.listen((notification) { 
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => ElementActionScreenOverView(elementNote: selectedElementNote)), (route) => false);
      });
    }
  }


   void _onElementsInitialize() {
    context.read<ElementBloc>().stream.listen((state) {
      if(state is ElementLoaded) {
        elementNotes = state.elements;
      }
    });
  }

  Future<void> _initNotifications() async {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content: const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}