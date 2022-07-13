import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifier_list_app/bloc/element/element_bloc.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';
import 'package:notifier_list_app/widgets/widgets.dart';

import 'screens.dart';


class SearchScreenOverView extends StatelessWidget {

  static const pageRoute = '/search';
  
  const SearchScreenOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ElementBloc>(
      create: (context) => ElementBloc(elementsRepository: context.read<ElementRepository>())..add(ElementEventInit()),
      child: const SearchElementScreen(),
    );
  }
}


class SearchElementScreen extends StatefulWidget {

  const SearchElementScreen({Key? key}) : super(key: key);

  @override
  State<SearchElementScreen> createState() => _SearchElementScreenState();
}

class _SearchElementScreenState extends State<SearchElementScreen> {

  TextEditingController searchElementController = TextEditingController();
  late List<ElementNote> elements;
  List<ElementNote> searchedElements = [];

  @override
  void initState() {
    super.initState();
    _onSearchInitialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ElementSearchField(
                controller: searchElementController
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisCount:  3,
                    mainAxisSpacing: 40,
                    crossAxisSpacing: 6
                  ),  
                  itemCount: searchedElements.length,  
                  itemBuilder: (context, index) {                    
                    var elementNote = searchedElements[index];    
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

  void _onSearchInitialize() {
    context.read<ElementBloc>().stream.listen((state) {
      if(state is ElementLoaded) {
        elements = state.elements;
      }
      searchElementController.addListener(() {
        if(searchElementController.text.isNotEmpty) {
          setState(() {
            searchedElements = elements.where((element) => 
              element.title!.contains(searchElementController.text)
            ).toList();          
          });
        } else {
          setState(() {
            searchedElements.clear();
          });
        }
      });
    });
  }

  void _toElementEdit(ElementNote element) {
    setState(() {
      searchElementController.text = '';
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => ElementActionScreenOverView(elementNote: element)));
  }
}