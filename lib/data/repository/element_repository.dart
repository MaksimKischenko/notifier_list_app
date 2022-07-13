import 'package:notifier_list_app/api/element_api.dart';
import 'package:notifier_list_app/data/data.dart';


class ElementRepository {

  const ElementRepository({
    required ElementApi elementApi,
  }) : _elementApi = elementApi;

  final ElementApi _elementApi;

  Stream<List<ElementNote>> getElements() => _elementApi.getElements();

  Future<void> saveElement(ElementNote element) => _elementApi.saveElement(element);

  Future<void> deleteElement(String id) => _elementApi.deleteElement(id);
}