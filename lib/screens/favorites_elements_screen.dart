import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifier_list_app/bloc/bloc.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';
import 'package:notifier_list_app/generated/translations.g.dart';
import 'package:notifier_list_app/styles.dart';
import 'package:notifier_list_app/widgets/widgets.dart';

import 'element_action_screen.dart';

class FavoritesElementsScreenOverview extends StatelessWidget {

  static const pageRoute = '/favorites';
  
  const FavoritesElementsScreenOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ElementBloc>(
      create: (context) => ElementBloc(elementsRepository: context.read<ElementRepository>())..add(ElementEventInit()),
      child: const FavoritesElementsScreen(),
    );
  }
}


class FavoritesElementsScreen extends StatefulWidget {

  const FavoritesElementsScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesElementsScreen> createState() => _FavoritesElementsScreenState();
}

class _FavoritesElementsScreenState extends State<FavoritesElementsScreen> {

  List<ElementNote> elements = [];
  List<ElementNote> favoritesElements = [];

  @override
  void initState() {
    super.initState();
    _onFvoritesInitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomePageDrawer(
        elements: elements,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(TranslationProvider.of(context).translations.screens.message.favorites, style: AppStyles.textStyleBlack),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisCount:  3,
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 6
                  ),  
                  itemCount: favoritesElements.length,  
                  itemBuilder: (context, index) {                    
                    var elementNote = favoritesElements[index];    
                    return ElementOverView(
                      onTap: () => _toElementEdit(elementNote),
                      elementNote: elementNote,
                    );
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onFvoritesInitialize() {
    context.read<ElementBloc>().stream.listen((state) {
      if(state is ElementLoaded) {
        setState(() {
          elements = state.elements;
        });

      }
      favoritesElements = elements.where((element) => element.isFavorite == true).toList();
    });
  }

  void _toElementEdit(ElementNote element) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ElementActionScreenOverView(elementNote: element)));
  }
}