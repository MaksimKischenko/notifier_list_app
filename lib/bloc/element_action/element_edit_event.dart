part of 'element_edit_bloc.dart';

abstract class EditElementEvent extends Equatable {
  const EditElementEvent();

  @override
  List<Object> get props => [];
}

class EditElemenTitleChanged extends EditElementEvent {
  const EditElemenTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

class EditElementDescriptionChanged extends EditElementEvent {
  const EditElementDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

class EditElementSubmitted extends EditElementEvent {
  const EditElementSubmitted();
}