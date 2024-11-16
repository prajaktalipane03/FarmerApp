import 'package:get/get.dart';

class CategoryController extends GetxController {
  // Declare reactive variables
  RxString _category = ''.obs;
  RxString _title = ''.obs;

  // Getter for category
  String get categoryValue => _category.value;

  // Setter for category
  set updateCategory(String value) {
    _category.value = value;
  }

  // Getter for title
  String get titleValue => _title.value;

  // Setter for title
  set updateTitle(String value) {
    _title.value = value;
  }
}
