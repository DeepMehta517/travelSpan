import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/ui/settings/signup_controller.dart';
import 'package:newsapp/ui/settings/login_page.dart';

import '../../controllers/setting/account_setting.dart';
import '../constant/colors.dart';

class CreateYourAccountPage extends StatefulWidget {
  const CreateYourAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateYourAccountPage> createState() => _CreateYourAccountPageState();
}

class _CreateYourAccountPageState extends State<CreateYourAccountPage> {
  bool isVisible = false;
  final signupController = Get.put(SignUpController());
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final settingController = Get.put(SettingAccount());


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Sign Up",
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColorRed,
          elevation: 0,
          leading: IconButton(
            iconSize: 22,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18).copyWith(
                      top: 20,
                      bottom: 5,
                    ),
                    child:  Text(
                      "Create Your Account",
                      style: TextStyle(
                        color:(settingController.isDarkMode.value)?Colors.white: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      "Create a free account to get started.",
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: signupController.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field cannot be empty";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: signupController.password,
                        obscureText: isVisible ? true : false,
                        validator: (value) {
                          if (value!.length <= 6) {
                            return "Password should be at least of 6 length";
                          } else if (value.isEmpty) {
                            return "Field cannot be empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: isVisible
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(
                                        Icons.remove_red_eye_outlined)),
                            suffixIconColor: Colors.black,
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: RichText(
                    text:  TextSpan(
                        text:
                            "By clicking Create Account,you confirm that you agree to the ",
                        style: TextStyle(
                          color:(settingController.isDarkMode.value)?Colors.white: Colors.black,
                          fontSize: 16,
                        ),
                        children: [
                      TextSpan(
                        text: " Terms of Use, ",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "and you acknowledge that you have read our ",
                        style: TextStyle(
                          color:(settingController.isDarkMode.value)?Colors.white :Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy. ",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "You further acknowledge that News and ",
                        style: TextStyle(
                          color:(settingController.isDarkMode.value)?Colors.white :Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: " Warner Media affiliates ",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text:
                            "may use your email address for marketing, ads and other offers.",
                        style: TextStyle(
                          color:(settingController.isDarkMode.value)?Colors.white: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ])),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    signupController.registerUser(
                      email: signupController.email.text.trim(),
                      password: signupController.password.text.trim(),
                    );
                    signupController.email.text = "";
                    signupController.password.text = "";
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: const Color(0xffCC0000),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: RichText(
                    text:  TextSpan(
                        text:
                            "To opt-out at any time, see options available in our  ",
                        style: TextStyle(
                          color:(settingController.isDarkMode.value)?Colors.white: Colors.black,
                          fontSize: 16,
                        ),
                        children: const[
                           TextSpan(
                        text: "Privacy Policy. ",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ])),
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                )),
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Expanded(child: SizedBox()),
                        Text(
                          "Already have an account ? ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: (settingController.isDarkMode.value)?Colors.black:Colors.white
                          ),
                        ),
                        const  Text(
                          "Log in",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                        const    Expanded(child: SizedBox()),
                        const   Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.grey,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
