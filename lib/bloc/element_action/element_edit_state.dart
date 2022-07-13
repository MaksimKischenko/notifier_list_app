part of 'element_edit_bloc.dart';

enum EditElementStatus { initial, loading, success, failure }

extension EditElementStatusX on EditElementStatus {
  bool get isLoadingOrSuccess => [
        EditElementStatus.loading,
        EditElementStatus.success,
      ].contains(this);
}

class EditElementState extends Equatable {
  const EditElementState({
    this.status = EditElementStatus.initial,
    this.initialElement,
    this.title = '',
    this.description = '',
  });

  final EditElementStatus status;
  final ElementNote? initialElement;
  final String title;
  final String description;


  bool get isNewTodo => initialElement == null;

  EditElementState copyWith({
    EditElementStatus? status,
    ElementNote? initialElement,
    String? title,
    String? description,
    DateTime? notificationDate,
  }) {
    return EditElementState(
      status: status ?? this.status,
      initialElement: initialElement ?? this.initialElement,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, initialElement, title, description];
}
