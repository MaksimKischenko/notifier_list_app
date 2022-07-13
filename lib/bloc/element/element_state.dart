part of 'element_bloc.dart';

abstract class ElementState extends Equatable {
  const ElementState();
  
  @override
  List<Object?> get props => [];
}

class ElementInitial extends ElementState {}

class ElementLoaded extends ElementState {

  final List<ElementNote> elements;

  const ElementLoaded({
    required this.elements,
  });

  @override
  List<Object?> get props => [elements];
}
