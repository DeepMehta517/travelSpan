import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/ui/home_page/tab_bar_controller.dart';
import 'package:newsapp/ui/constant/colors.dart';
import 'package:newsapp/ui/home_page/categories_page.dart';

import '../../controllers/setting/account_setting.dart';
import '../../repository/api_Service.dart';
import '../general/general_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  MyTabs tabsController = Get.put(MyTabs());
  final settingController = Get.put(SettingAccount());
  NewsController newsData = Get.put(NewsController());

  ///Tab Bar
  Widget _tabBar() {
    return Material(
      elevation: 2,
      child: TabBar(
        onTap: (index) {
          tabsController.currentIndex.value = index;
        },
        isScrollable: true,
        physics: const ScrollPhysics(),
        tabs: tabsController.tabBarCategories.entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Obx(() => Text(
                        e.key,
                        style: TextStyle(
                            fontSize: 18,
                            color: (settingController.isDarkMode.value)
                                ? Colors.white
                                : Colors.black),
                      )),
                ))
            .toList(),
        indicatorColor: AppColors.primaryColorRed,
        indicatorSize: TabBarIndicatorSize.label,
        automaticIndicatorColorAdjustment: true,
        labelStyle: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
        labelColor: AppColors.blackColor,
        unselectedLabelColor: AppColors.blackColor,
        unselectedLabelStyle: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DefaultTabController(
        length: tabsController.tabBarCategories.entries.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: GeneralWidgets.appBar(title: "Travel Span"),
          drawer: GeneralWidgets.drawer(
              mainCategories: tabsController.mainCategories,
              subCategories: tabsController.subCategories,
              isLoading: tabsController.isLoading.value,
              context: context),
          backgroundColor: AppColors.scaffoldBackGroundColors,
          body: Column(
            children: [
              _tabBar(),
              Expanded(
                child: TabBarView(
                    children: tabsController.tabBarCategories.entries.map((e) {
                  return CategoriesPage(
                    id: e.value.toString(),
                  );
                }).toList()),
              ),
            ],
          ),
        ),
      );
    });
  }
}
