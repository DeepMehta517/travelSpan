import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class SettingAccount extends GetxController {
  RxString imagePath = "".obs;
  final auth = FirebaseAuth.instance;
  late TextEditingController emailController;
  late TextEditingController displayNameController;
  late TextEditingController zipCodeController;
  RxBool isDarkMode = false.obs;
  var rating=0.obs;
  final getStorage = GetStorage();
  MethodChannel channel = const MethodChannel('ReadersMode');

  Future<void> openReaderModeSettings() async {
    try {
      await channel.invokeMethod('openReaderModeSettings');
    } on PlatformException catch (e) {
      print('Error opening reader mode settings: ${e.message}');
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    displayNameController.dispose();
    zipCodeController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
isDarkMode.value=getStorage.read("DarkMode")??false;
    emailController =
        TextEditingController(text: auth.currentUser?.email.toString() ?? "");
    displayNameController = TextEditingController(
        text: auth.currentUser?.email?.split("@")[0].toString() ?? "");
    zipCodeController = TextEditingController(text: "");
    imagePath.value = box.read("image") ?? "";
  }

  bool containsTextAfterAtSymbol(String text) {
    if (text.contains('@')) {
      int atSymbolIndex = text.indexOf('@');
      return atSymbolIndex < text.length - 1;
    }
    return false;
  }

  final box = GetStorage();

  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imagePath.value = pickedFile.path.toString();
      box.write("image", imagePath.value);
    }
  }

  getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imagePath.value = pickedFile.path.toString();
      box.write("image", imagePath.value);
    }
  }

  removePhoto() {
    imagePath.value = "";
    box.write("image", imagePath.value);
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    updateTheme();
  }

  void updateTheme() {
    Get.changeTheme(isDarkMode.value==true ? ThemeData.dark(

    ) : ThemeData.light());
  }
}
