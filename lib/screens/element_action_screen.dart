import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notifier_list_app/bloc/bloc.dart';
import 'package:notifier_list_app/config.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';
import 'package:notifier_list_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElementActionScreenOverView extends StatelessWidget {

  final ElementNote elementNote;

  const ElementActionScreenOverView({
    Key? key,
    required this.elementNote,
  }) : super(key: key);


  static const pageRoute = '/edit';
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditElementBloc>(
      create: (context) => EditElementBloc(
        initialElement: elementNote,
        elementsRepository: context.read<ElementRepository>()
      ),
      child:  ElementActionScreen(
        elementNote: elementNote,
      ),
    );
  }
}


class ElementActionScreen extends StatefulWidget {

  final ElementNote elementNote;

  const ElementActionScreen({
    Key? key,
    required this.elementNote,
  }) : super(key: key);
  
  

  @override
  State<ElementActionScreen> createState() => _ElementActionScreenState();
}

class _ElementActionScreenState extends State<ElementActionScreen> {

  String? elementName;
  double sizeText = 14;
  List<String> saveWords = [];
  bool isEditable = true;

  final FocusNode _elementNameFocusNode = FocusNode();
  final FocusNode _elementBodyFocusNode = FocusNode();
  final TextEditingController _elementNameController = TextEditingController();
  final TextEditingController _elementBodyController = TextEditingController();


  @override
  void initState() {
    super.initState();
    initTextSize();
    _elementNameController.text = widget.elementNote.title ?? '';
    _elementBodyController.text = widget.elementNote.description ?? '';
  }

  @override
  void dispose() {
    _elementNameFocusNode.dispose();
    _elementBodyFocusNode.dispose();
    _elementNameController.dispose();
    _elementBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditable = true;
                      FocusScope.of(context).requestFocus(_elementBodyFocusNode);
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    elevation: isEditable? 4 : 2,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xffB19D68)
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))  
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EmptyOrWidget(
                          checkFlag: isEditable,
                          showWidget: const Icon(Icons.attach_file, size: 40, color: Color(0xff2E3647)),
                          ),
                           ElementTitleTextField(
                              controller: _elementNameController,
                              onTap: _onEditElementDone,
                              focusNode: _elementNameFocusNode,
                              isEditable: isEditable,                            
                              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, overflow: TextOverflow.clip),
                            ),    
                          const SizedBox(height: 4),
                          Expanded(
                            child: ElementBodyTextField(
                              controller: _elementBodyController,
                              focusNode: _elementBodyFocusNode,
                              isEditable: isEditable,
                              maxLines: 20,
                              textStyle: TextStyle(fontSize: sizeText, fontWeight: FontWeight.w300),
                            )
                          ),
                        ]
                      ),
                    ), 
                  ),
                ),
              ),
            ],
          )
        ),
      ),
      bottomNavigationBar: isEditable? CurvedNavigationBar(
          backgroundColor: const Color(0xffD7BE7C),
          items:  [
            Text(sizeText.toInt().toString()),
            const Icon(Icons.preview, size: 24, color:  Color(0xff2E3647)),   
            const Icon(Icons.check_box_outline_blank, size: 24, color: Color(0xff2E3647)),           
            const Icon(Icons.undo, size: 24, color:  Color(0xff2E3647)),
            const Icon(Icons.redo, size: 24, color:  Color(0xff2E3647)),
          ],
          onTap: _onTap
        ) : null,
    );
  }

  Future<void> initTextSize() async{
    final _plugin = await SharedPreferences.getInstance();
    sizeText = _plugin.getDouble('_sezedKey') ?? 0;
        // ignore: use_build_context_synchronously
    FocusScope.of(context).requestFocus(_elementBodyFocusNode);
  }


  void _onTap(int index) {
    _onBottomBarSelection(index);
  }

  void _onBottomBarSelection(int index) async {
    
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final left = offset.dx;
    final top = offset.dy + renderBox.size.height - 350;
    final right = left + renderBox.size.width;      

    switch (index) {
      case 0:
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, right, 0),
          items: AppConfig.fontSize.map<PopupMenuItem<int>>((e) => 
          PopupMenuItem<int>(
            child: Text(e.toString()),
            onTap: () {
              setState(() {
                sizeText = e;
                final _plugin =  SharedPreferences.getInstance();
                _plugin.then((value) => value.setDouble('_sezedKey', sizeText));
              });
            },
          )).toList()
        );
        break;
      case 1:
        setState(() {
          isEditable = false;
        });    
        break;    
      case 2:
        _onAddSymbol();
        break;  
      case 3:
        _onUndoText();
        break;           
      case 4:
        _onRedoText();
        break;                                                     
    }    
  }

 void _onUndoText() {
  if(_elementBodyController.text != widget.elementNote.description) {
      var words =  _elementBodyController.text.split(' ');
      var word = words.removeLast();
      saveWords.add(word); 
      saveWords = saveWords.reversed.toList();
    _elementBodyController.text = words.join(' ');
    _elementBodyController.selection = TextSelection.fromPosition(TextPosition(offset: _elementBodyController.text.length));     
  } else {
    FocusScope.of(context).requestFocus(_elementBodyFocusNode);
    _elementBodyController.selection = TextSelection.fromPosition(TextPosition(offset: _elementBodyController.text.length));    
  }
 }

  void _onRedoText() {
    if(saveWords.isNotEmpty) {
      _elementBodyController.text = '${_elementBodyController.text} ${saveWords.join(' ')}';
      saveWords.clear();
      _elementBodyController.selection = TextSelection.fromPosition(TextPosition(offset: _elementBodyController.text.length));
    }
 }

 void _onAddSymbol() {
  _elementBodyController.text = '${_elementBodyController.text} \n\u2B1C ';
  _elementBodyController.selection = TextSelection.fromPosition(TextPosition(offset: _elementBodyController.text.length));
 } 

 void _onEditElementDone() {
    isEditable = false;
    context.read<EditElementBloc>().add(EditElemenTitleChanged(_elementNameController.text));
    context.read<EditElementBloc>().add(EditElementDescriptionChanged(_elementBodyController.text));
    context.read<EditElementBloc>().add(const EditElementSubmitted());
 }
}