import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';

part 'element_event.dart';
part 'element_state.dart';

class ElementBloc extends Bloc<ElementEvent, ElementState> {
  ElementBloc({
    required ElementRepository elementsRepository,
  }) : _elementsRepository = elementsRepository,
     super(ElementInitial()) {
      on<ElementEvent>(_onEvent);
     }

   final ElementRepository _elementsRepository;  
   List<ElementNote> elements  = [];


   void _onEvent(
    ElementEvent event,
    Emitter<ElementState> emit,
  ) {
    if (event is ElementEventInit) return _onElementEventInit(event, emit);
    if (event is ElementEventAdd) return _onElementEventAdd(event, emit);
    if (event is ElementEventOverviewEdit) return _onElementEventOverviewEdit(event, emit);
    if (event is ElementEventDelete) return _onElementEventDelete(event, emit);
  }

  void _onElementEventInit (
    ElementEventInit event,
    Emitter<ElementState> emit
  ) async {

    //Подписывается на предоставленный [поток] и вызывает обратный вызов [onData], 
    //когда [поток] выдает новые данные и выдается результат [onData].
    //[forEach] завершается, когда обработчик события отменяется или когда предоставленный [поток] заканчивается.
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

  void _onElementEventAdd (
    ElementEventAdd event,
    Emitter<ElementState> emit
  ) async {
    _elementsRepository.saveElement(ElementNote(
      title: '',
      description: '',
      creationDate: DateTime.now(),
      lastEditDate: DateTime.now()
    ));
  }

  void _onElementEventOverviewEdit (
    ElementEventOverviewEdit event,
    Emitter<ElementState> emit
  ) async {
    _elementsRepository.saveElement(event.element.copyWith(
      notifytDate: event.element.notifytDate,
      isFavorite: event.element.isFavorite
    ));
  }


  void _onElementEventDelete (
    ElementEventDelete event,
    Emitter<ElementState> emit
  ) async {
    _elementsRepository.deleteElement(event.id);
  }
}
