import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/api_Service.dart';

class MyTabs extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;
  NewsController newsData = Get.put(NewsController());
  List mainCategories = [].obs;
  List subCategories = [].obs;
  var isLoading = false.obs;
  Rx<int> currentIndex = 0.obs;

  Map tabBarCategories = {
    "Top News": "",
    "Airports": 407,
    "Appointments": 217,
    "Associations": 29,
    "Aviation": 226,
    "Business Travel": 9,
    "Cruise": 228,
    "Destination": 494,
    "Events": 230,
    "Golf": 2327,
    "Hospitality": 7,
    "India": 224,
    "International": 225,
    "Latest Articles": 529,
    "Other News": 2440,
    "Railways": 2442,
    "Spa & Wellness": 196,
    "Space Travel": 861,
    "Statistics": 2441,
    "Technology": 409,
    "Travel Trade": 410,
    "Trends": 222,
    "Visas and Passports": 509,
  };

  @override
  onInit() {
    super.onInit();
    fetchCategories();
  }

  fetchCategories() async {
    isLoading.value = true;
    await newsData.fetchCategories().then((category) {
      mainCategories =
          category.where((element) => element.parent == 0).toList();

      // for (final x in mainCategories) {
      //   subCategories[x.id] =
      //       category.where((element) => element.parent == x.id).toList();
      // }

      for (final x in category) {
        mainCategories.firstWhereOrNull((element) {
          if (element.id == x.parent) {
            subCategories.add(x);
          }
          return element.id == x.parent;
        });
      }
    }).then((value) async {
      isLoading.value = false;
    });
  }
}

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
