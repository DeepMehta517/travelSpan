import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/ui/general/general_widgets.dart';
import '../../controllers/setting/account_setting.dart';
import '../../controllers/ui/settings/signup_controller.dart';
import '../../repository/firebase_auth.dart';

class AccountSetting extends StatelessWidget {
  AccountSetting({Key? key}) : super(key: key);

  final auth = FirebaseAuth.instance;
  final SettingAccount settingAccount = Get.put(SettingAccount());
  final AuthenticationRepository authenticationRepository =
      Get.put(AuthenticationRepository());

  ///Select profile pic Widget

  Widget _selectProfilePhoto({required BuildContext context}) {
    return Obx(() => GestureDetector(
          onTap: () => GeneralWidgets().chooseFrom(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: (settingAccount.imagePath.isEmpty)
                  ? Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.account_circle_rounded,
                            color: Colors.grey,
                            size: 110,
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 5,
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                )))
                      ],
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          FileImage(File(settingAccount.imagePath.toString())),
                    ),
            ),
          ),
        ));
  }

  ///Personal information

  Widget personalInfo(
      {required String titleText, TextEditingController? controller}) {
    return ListTile(
      tileColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          titleText,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
      title: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: const Color(0xffCC0000),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              if (auth.currentUser != null) {
                if (auth.currentUser!.email.toString() !=
                        settingAccount.emailController.text ||
                    settingAccount.displayNameController.text !=
                        auth.currentUser?.email?.split("@")[0].toString()) {
                  if (settingAccount.emailController.text.isNotEmpty &&
                      settingAccount.emailController.text.contains("@") &&
                      settingAccount.containsTextAfterAtSymbol(
                              settingAccount.emailController.text) ==
                          true) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: auth.currentUser?.email ?? "",
                            password: "testing")
                        .then((value) {
                      auth.currentUser
                          ?.updateEmail(settingAccount.emailController.text);

                      FirebaseDatabase.instance
                          .ref().child(auth.currentUser!.uid)
                          .child(settingAccount.emailController.text)
                          .push()
                          .set({
                        "email": settingAccount.emailController.text,
                        "name": settingAccount.displayNameController.text,
                        "zipCode": settingAccount.zipCodeController.text,
                      });
                      GeneralWidgets.showSnackBar(
                          messageText: "Information Updated Successfully!!",
                          title: "Yuppie!!");
                    });
                  } else {
                    GeneralWidgets.showSnackBar(
                        messageText: "Please Enter Proper Email Address!!",
                        title: "Can't Update !!");
                  }
                } else {
                  GeneralWidgets.showSnackBar(
                      messageText: "These email already Exist",
                      title: "Can't Update !!");
                }
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Text(
                "Save",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          )
        ],
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _selectProfilePhoto(context: context),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Text(
                  "MANAGE YOUR PERSONAL INFORMATION",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              personalInfo(
                  titleText: "Display Name",
                  controller: settingAccount.displayNameController),
              personalInfo(
                  titleText: "Email",
                  controller: settingAccount.emailController),
              personalInfo(
                  titleText: "Zip Code",
                  controller: settingAccount.zipCodeController),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                child: Text(
                  "ACCOUNT MANAGEMENT",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              ListTile(
                onTap: () => SignUpController().signOut(),
                tileColor: Colors.white,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Log Out",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              ListTile(
                onTap: () =>
                    GeneralWidgets.deleteAccountDialog(context: context),
                tileColor: Colors.white,
                leading: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Delete My Account",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xffCC0000),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(10).copyWith(bottom: 20),
                child: const Text(
                  "This will permanently delete you NewsApp account and you will no longer have access to your account data",
                  style: TextStyle(color: Colors.black54),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
