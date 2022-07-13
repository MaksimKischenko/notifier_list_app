import 'dart:convert';

import 'package:notifier_list_app/api/element_api.dart';
import 'package:notifier_list_app/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/subjects.dart';


class LocalStorageElementApi extends ElementApi {

  LocalStorageElementApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _elementStreamController = BehaviorSubject<List<ElementNote>>.seeded(const []);

  static const kElementsCollectionKey = '__elements_collection_key__';
  
  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final elementsJson = _getValue(kElementsCollectionKey);
    if (elementsJson != null) {

    final elements = List<dynamic>.from(json.decode(elementsJson) as List)
          .map((jsonMap) => ElementNote.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();

    _elementStreamController.add(elements);
    } else {
      _elementStreamController.add(const []);
    }
  }

  @override
  Stream<List<ElementNote>> getElements() {
    return _elementStreamController.asBroadcastStream();
  }

  @override
  Future<void> saveElement(ElementNote element) {
    final elements = [..._elementStreamController.value];
    final elementIndex = elements.indexWhere((t) => t.id == element.id);

    if (elementIndex >= 0) {
      elements[elementIndex] = element;
    } else {
      elements.insert(0, element);
    }

    _elementStreamController.add(elements);
    return _setValue(kElementsCollectionKey, json.encode(elements));
  }

  @override
  Future<void> deleteElement(String id) {
    final elements = [..._elementStreamController.value];
    final elementIndex = elements.indexWhere((t) => t.id == id);

    if (elementIndex == -1) {
      throw Exception('Not found');
    } else {
      elements.removeAt(elementIndex);
      _elementStreamController.add(elements);
      return _setValue(kElementsCollectionKey, json.encode(elements));
    }
  }
}