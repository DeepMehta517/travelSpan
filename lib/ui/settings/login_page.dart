import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsapp/controllers/ui/settings/signup_controller.dart';
import 'package:newsapp/ui/settings/create_your_account_page.dart';

import '../../controllers/setting/account_setting.dart';
import '../constant/colors.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
  final loginController = SignUpController();
  final _formKey = GlobalKey<FormState>();
  final settingController = Get.put(SettingAccount());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign In",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ).copyWith(
                      top: 30,
                    ),
                    child:  Text(
                      "Welcome Back",
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    child: Text(
                      "Log in to your Travel Span account to access the\nmassive UI components and library.   ",
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field cannot be empty";
                          }

                          return null;
                        },
                        controller: loginController.email,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.all(15),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: loginController.password,
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.all(15),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    loginController.loginUser(
                        email: loginController.email.text.trim(),
                        password: loginController.password.text.trim());
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: const Color(0xffCC0000),
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: const Text(
                    "Log In",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Get.to(const ForgotPassword()),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xffCC0000), fontSize: 16),
                    ),
                  ),
                ],
              ),
              const Expanded(flex: 5, child: SizedBox()),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateYourAccountPage(),
                )),
                child:const Padding(
                  padding:  EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        "New here?  ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Create an account ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    ],
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
