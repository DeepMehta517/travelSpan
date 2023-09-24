import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:newsapp/repository/firebase_auth.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  void registerUser({required String email, required String password}) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }

  void loginUser({required String email, required String password}) {
    AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);
  }

  void signOut() {
    AuthenticationRepository.instance.logout();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.onClose();
  }
}
