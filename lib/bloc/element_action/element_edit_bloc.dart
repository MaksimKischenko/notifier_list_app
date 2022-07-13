import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:notifier_list_app/data/repository/element_repository.dart';

part 'element_edit_event.dart';
part 'element_edit_state.dart';

class EditElementBloc extends Bloc<EditElementEvent, EditElementState> {
  EditElementBloc({
    required ElementRepository elementsRepository,
    required ElementNote? initialElement,
  })  : _elementsRepository = elementsRepository,
        super(
          EditElementState(
            initialElement: initialElement,
            title: initialElement?.title ?? '',
            description: initialElement?.description ?? '',
          ),
        ) {
    on<EditElemenTitleChanged>(_onTitleChanged);
    on<EditElementDescriptionChanged>(_onDescriptionChanged);
    on<EditElementSubmitted>(_onSubmitted);
  }

  final ElementRepository _elementsRepository;


  void _onTitleChanged(
    EditElemenTitleChanged event,
    Emitter<EditElementState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    EditElementDescriptionChanged event,
    Emitter<EditElementState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    EditElementSubmitted event,
    Emitter<EditElementState> emit,
  ) async {
    emit(state.copyWith(status: EditElementStatus.loading));
    final element = (state.initialElement ?? ElementNote(title: '')).copyWith(
      title: state.title,
      description: state.description,
      lastEditDate: DateTime.now(),
    );

    try {
      await _elementsRepository.saveElement(element);
      emit(state.copyWith(status: EditElementStatus.success));
    } catch (e) {
      emit(state.copyWith(status: EditElementStatus.failure));
    }
  }
}