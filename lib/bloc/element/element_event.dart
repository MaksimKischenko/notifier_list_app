part of 'element_bloc.dart';

abstract class ElementEvent extends Equatable {
  const ElementEvent();

  @override
  List<Object?> get props => [];
}


class ElementEventInit extends ElementEvent {}

class ElementEventAdd extends ElementEvent {}

class ElementEventOverviewEdit extends ElementEvent {
  final ElementNote element;

  const ElementEventOverviewEdit({
    required this.element,
  });

  @override
  List<Object?> get props => [element];
}


class ElementEventDelete extends ElementEvent {
  final String id;

  const ElementEventDelete({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

