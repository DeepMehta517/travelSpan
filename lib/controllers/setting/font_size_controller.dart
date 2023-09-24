import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FontSizeController extends GetxController {
  var fontSize = 15.obs;
  final getStorage = GetStorage();

  @override
  void onInit() {
     super.onInit();
    fontSize.value = getStorage.read("fontSize") ?? 15;
  }
}
