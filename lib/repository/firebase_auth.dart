import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newsapp/ui/general/general_widgets.dart';
import 'package:newsapp/ui/home_page/home_common_ui.dart';
import 'package:newsapp/ui/settings/login_page.dart';
import 'package:newsapp/ui/splash_Screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(const SplashScreen())
        : Get.offAll(HomeCommonUi());
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      GeneralWidgets.showSnackBar(
          title: "Yuppie!!", messageText: "Account Created");

      firebaseUser.value != null
          ? Get.offAll(() => HomeCommonUi())
          : Get.to(() => const LoginPage());
    } on FirebaseAuthException catch (e) {
      GeneralWidgets.showSnackBar(
          title: e.code.toString(), messageText:"Please SignUp with different Email" );
      throw e.code;
    } catch (_) {
      throw "Error";
    }
    return null;
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      GeneralWidgets.showSnackBar(title: "Yuppie!!", messageText: "Logged In");
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (_) {
      return "Error Login";
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
