// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'element_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElementNote _$ElementNoteFromJson(Map<String, dynamic> json) {
  return ElementNote(
    id: json['id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    creationDate: json['creationDate'] == null
        ? null
        : DateTime.parse(json['creationDate'] as String),
    lastEditDate: json['lastEditDate'] == null
        ? null
        : DateTime.parse(json['lastEditDate'] as String),
    notifytDate: json['notifytDate'] == null
        ? null
        : DateTime.parse(json['notifytDate'] as String),
    isFavorite: json['isFavorite'] as bool?,
  );
}

Map<String, dynamic> _$ElementNoteToJson(ElementNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isFavorite': instance.isFavorite,
      'title': instance.title,
      'description': instance.description,
      'creationDate': instance.creationDate?.toIso8601String(),
      'lastEditDate': instance.lastEditDate?.toIso8601String(),
      'notifytDate': instance.notifytDate?.toIso8601String(),
    };
