import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newsapp/controllers/setting/font_size_controller.dart';
import 'package:newsapp/ui/constant/colors.dart';
import 'package:newsapp/ui/general/general_widgets.dart';
import 'package:newsapp/ui/settings/feedback.dart';
import 'package:newsapp/ui/settings/login_page.dart';

import '../../controllers/setting/account_setting.dart';
import '../general/web_view.dart';
import 'account_setting.dart';
import 'create_your_account_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _auth = FirebaseAuth.instance;
  var userLoggedIn;
  final settingController = Get.put(SettingAccount());
  final fontSizeController = Get.put(FontSizeController());

  @override
  void initState() {
    super.initState();
    userLoggedIn = _auth.currentUser;
  }

  ///Account Settings
  Widget _accountTiles({required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: ListTile.divideTiles(color: Colors.grey, tiles: [
            (userLoggedIn == null)
                ? Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              )),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryColorRed),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CreateYourAccountPage(),
                              )),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryColorRed),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  )
                : ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AccountSetting(),
                    )),
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text(
                      "Account Settings",
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(userLoggedIn.email.toString()),
                  ),
          ]).toList(),
        ),
      ],
    );
  }

  ///App Preference Settings
  Widget _appPreference({required BuildContext context}) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "APP PREFERENCES",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: ListTile.divideTiles(color: Colors.grey, tiles: [
                // ListTile(
                //   contentPadding: const EdgeInsets.all(0),
                //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => AlertPage(),
                //   )),
                //   title: const Text(
                //     "Alerts",
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => AlertPage(),
                  // )),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Font Size - ${fontSizeController.fontSize.value}",
                        style: TextStyle(
                            fontSize:
                                fontSizeController.fontSize.value.toDouble()),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Font will be changed only for details page",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Slider(
                    max: 50.0,
                    min: 15,
                    activeColor: AppColors.primaryColorRed,
                    inactiveColor: AppColors.greyColor,
                    value: fontSizeController.fontSize.value.toDouble(),
                    onChanged: (value) {
                      fontSizeController.fontSize.value = value.toInt();
                      GetStorage()
                          .write("fontSize", fontSizeController.fontSize.value);
                    },
                  ),
                ),
                ListTile(
                  // onTap: () => AppSettings.openNotificationSettings(),
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    "Android Notification Settings",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SwitchListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 18),
                  ),
                  value: (settingController.isDarkMode.value) ? true : false,
                  onChanged: (value) {
                    settingController.toggleDarkMode();
                    GetStorage()
                        .write("DarkMode", settingController.isDarkMode.value);
                  },
                  activeColor: Colors.red,
                  inactiveTrackColor: Colors.grey,
                ),

                // SwitchListTile(
                //   contentPadding:const EdgeInsets.all(0),
                //   title: const Text(
                //     "Reader Mode",
                //     style: TextStyle(fontSize: 18),
                //   ),
                //   value: false,
                //   onChanged: (value) => settingController.openReaderModeSettings(),
                //   activeColor: Colors.red,
                //   inactiveTrackColor: Colors.grey,
                // ),
                // SwitchListTile(
                //   contentPadding: const EdgeInsets.all(0),
                //   title: const Text(
                //     "Enable \' This is News App\'",
                //     style: TextStyle(fontSize: 18),
                //   ),
                //   subtitle: const Text("A sound effect when you open the app"),
                //   value: false,
                //   onChanged: (value) => null,
                //   activeColor: Colors.red,
                //   inactiveTrackColor: Colors.grey,
                // ),
              ]).toList(),
            ),
            const Divider(),
          ],
        ));
  }

  ///General Settings
  Widget _generalSetting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "GENERAL",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: ListTile.divideTiles(color: Colors.grey, tiles: [
            ListTile(
              onTap: () => Get.to(WebViewPage(
                title: "Privacy Policy",
                url: "https://travelspan.in/privacy-policy/",
              )),
              contentPadding: const EdgeInsets.all(0),
              title: const Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              onTap: () => Get.to(WebViewPage(
                title: "Terms and Conditions",
                url: "https://travelspan.in/terms-conditions/",
              )),
              contentPadding: const EdgeInsets.all(0),
              title: const Text(
                "Terms And Condition",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              onTap: () => Get.to(WebViewPage(
                title: "About Us",
                url: "https://travelspan.in/about-us/",
              )),
              contentPadding: const EdgeInsets.all(0),
              title: const Text(
                "About Us",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              onTap: () => Get.to(WebViewPage(
                title: "Contact Us",
                url: "https://travelspan.in/contact/",
              )),
              contentPadding: const EdgeInsets.all(0),
              title: const Text(
                "Contact Us",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ]).toList(),
        ),
      ],
    );
  }

  ///App
  Widget app() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "APP",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: ListTile.divideTiles(color: Colors.grey, tiles: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              onTap: () => Get.to(FeedBack()),
              title: const Text(
                "Feedback",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              onTap: () => showBottomSheet(
                elevation: 20,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                enableDrag: true,
                context: context,
                builder: (context) {
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              "Ratings: ${settingController.rating.value}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
                          initialRating:
                              settingController.rating.value.toDouble(),
                          minRating: 1,
                          maxRating: 5,
                          glow: false,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (value) =>
                              settingController.rating.value = value.toInt(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.primaryColorRed),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            settingController.rating.value = 0;
                            Get.back();
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
              title: const Text(
                "Rate our app",
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              onTap: () => GeneralWidgets()
                  .shareContent("Check out this awesome Flutter app!"),
              title: const Text(
                "Share our app",
                style: TextStyle(fontSize: 18),
              ),
              trailing: GestureDetector(
                  child: const Icon(
                Icons.share,
              )),
            ),
          ]).toList(),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Text(
            "Version 0.1.0 ",
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColors,
        appBar: AppBar(
          title: const Text(
            "Settings",
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffCC0000),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _accountTiles(context: context),
                const SizedBox(
                  height: 20,
                ),
                _appPreference(context: context),
                const SizedBox(
                  height: 20,
                ),
                _generalSetting(),
                const SizedBox(
                  height: 20,
                ),
                app()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
