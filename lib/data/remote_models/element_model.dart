import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'element_model.g.dart';

@immutable
@JsonSerializable()
class ElementNote extends Equatable {

  ElementNote({
    String? id,
    required this.title,
    this.description = '',
    this.creationDate,
    this.lastEditDate,
    this.notifytDate,
    this.isFavorite = false
  }) : assert(
    id == null || id.isNotEmpty,
      'id can not be null and should be empty',
  ),
   id = id ?? const Uuid().v4();

  final String? id;

  final bool? isFavorite;

  final String? title;

  final String? description;

  final DateTime? creationDate;

  final DateTime? lastEditDate;

  final DateTime? notifytDate;

  static ElementNote fromJson(JsonMap json) => _$ElementNoteFromJson(json);

  JsonMap toJson() => _$ElementNoteToJson(this);

  @override
  List<Object?> get props => [id, title, description, creationDate, lastEditDate, notifytDate, isFavorite];


  ElementNote copyWith({
    String? id,
    bool? isFavorite,
    String? title,
    String? description,
    DateTime? creationDate,
    DateTime? lastEditDate,
    DateTime? notifytDate,
  }) {
    return ElementNote(
      id: id ?? this.id,
      isFavorite: isFavorite ?? this.isFavorite,
      title: title ?? this.title,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      lastEditDate: lastEditDate ?? this.lastEditDate,
      notifytDate: notifytDate ?? this.notifytDate,
    );
  }
}

typedef JsonMap = Map<String, dynamic>;