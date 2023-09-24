import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/ui/constant/colors.dart';
import 'package:newsapp/ui/home_page/home_page.dart';
import 'package:newsapp/ui/home_page/saved_stories.dart';
import 'package:newsapp/ui/search/search_page.dart';
import 'package:newsapp/ui/settings/settings_page.dart';
import '../../controllers/ui/home_page/tab_bar_controller.dart';

class HomeCommonUi extends StatelessWidget {
  final bottomController = Get.put(BottomNavigationController());

  HomeCommonUi({Key? key}) : super(key: key);

  var selectedIndex = 0.obs;
  final screen = [
    const HomePage(),
    SearchPage(),
    const SavedStories(),
    const SettingsPage(),
  ];

  ///Bottom Navigation Bar
  Widget _bottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primaryColorRed,
        selectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        iconSize: 28,
        unselectedItemColor: AppColors.greyColor,
        unselectedIconTheme: const IconThemeData(
          size: 25,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Saved",
            icon: Icon(Icons.bookmark),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.person),
          ),
        ],
        currentIndex: bottomController.selectedIndex.value,
        onTap: bottomController.changeTabIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(),
          body: Obx(() => IndexedStack(
                index: bottomController.selectedIndex.value,
                children: screen,
              )),
        ));
  }
}
