
import 'package:notifier_list_app/data/data.dart';

abstract class ElementApi {

  const ElementApi();

  Stream<List<ElementNote>> getElements();

  Future<void> saveElement(ElementNote todo);

  Future<void> deleteElement(String id);

}

