import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/ui/general/general_widgets.dart';

import '../../controllers/search/search_bar.dart';
import '../../controllers/setting/account_setting.dart';
import '../../controllers/ui/home_page/tab_bar_controller.dart';
import '../../repository/api_Service.dart';
import '../constant/colors.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController controller;
  final recentSearch = Get.put(SearchBarController());
  final MyTabs tabsController = Get.put(MyTabs());
  NewsController searchController = Get.put(NewsController());
  final settingController = Get.put(SettingAccount());

  List searchData = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  /// App Bar
  PreferredSizeWidget searchBar({
    required BuildContext context,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Center(
              child: Obx(() => TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.greyColor,
                        ),
                        fillColor: settingController.isDarkMode.value
                            ? Colors.black54
                            : AppColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: AppColors.primaryColorRed)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.black))),
                    onFieldSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        recentSearch.searchIsLoading.value = true;
                        recentSearch.searchedAnything.value = true;
                        searchData = await searchController
                            .searchPost(searchTerm: controller.text)
                            .then((value) {
                          recentSearch.recentResearch.value = value;
                          recentSearch.searchIsLoading.value = false;
                          return recentSearch.recentResearch;
                        });
                      } else {
                        GeneralWidgets.showSnackBar(
                            messageText: "Please enter some value!",
                            title: "Can't search empty string!");
                      }
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }

  ///recent Search
  Widget recentSearchRow() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Recent Searches",
            style: TextStyle(fontSize: 16),
          ),
          InkWell(
            onTap: () {
              recentSearch.recentResearch.clear();
              recentSearch.searchedAnything.value = false;
            },
            child: Text(
              "Clear",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.primaryColorRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColors,
          appBar: GeneralWidgets.appBar(title: "Search"),
          drawer: GeneralWidgets.drawer(
              mainCategories: tabsController.mainCategories,
              subCategories: tabsController.subCategories,
              isLoading: tabsController.isLoading.value,
              context: context),
          body: Obx(
            () {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBar(context: context),
                    const SizedBox(
                      height: 10,
                    ),
                    recentSearchRow(),
                    (recentSearch.searchIsLoading.value)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : (recentSearch.recentResearch.isEmpty &&
                                recentSearch.searchedAnything.value)
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Center(
                                  child: Lottie.asset(
                                    "assets/image/search_empty.json",
                                    height:
                                        MediaQuery.of(context).size.height / 1,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: recentSearch.recentResearch.length,
                                itemBuilder: (context, index) {
                                  return GeneralWidgets().newsCard(
                                      index: index,
                                      context: context,
                                      id: null,
                                      newsData: recentSearch.recentResearch,
                                      categoryName:
                                          recentSearch.recentResearch[index]
                                                  ["_embedded"]["wp:term"]?[0]
                                              [0]["name"]);
                                  // return Padding(
                                  //   padding: const EdgeInsets.all(2.0),
                                  //   child: ListTile(
                                  //     contentPadding: const EdgeInsets.all(20),
                                  //     tileColor:
                                  //         AppColors.greyColor.withOpacity(0.3),
                                  //     leading: Icon(
                                  //       Icons.newspaper,
                                  //       size: 30,
                                  //       color: AppColors.primaryColorRed,
                                  //     ),
                                  //     onTap: () => Navigator.of(context)
                                  //         .push(MaterialPageRoute(
                                  //       builder: (context) => SearchDetailsPage(
                                  //         categoriesName: recentSearch.recentResearch[index]
                                  //             .categoriesNames[
                                  //         "${recentSearch.recentResearch[index].categories[0]}"]
                                  //             .name,
                                  //         newsData:
                                  //               recentSearch.recentResearch[index],
                                  //       ),
                                  //     )),
                                  //
                                  //     // Get.to(WebViewPage(
                                  //     // url: recentSearch
                                  //     //     .recentResearch[index].url
                                  //     //     .toString()
                                  //     //     .capitalize
                                  //     //     .toString(),
                                  //     // title: recentSearch
                                  //     //     .recentResearch[index].title
                                  //     //     .toString())),
                                  //     title: Text(
                                  //       recentSearch
                                  //           .recentResearch[index].title.rendered
                                  //           .toString(),
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w600,
                                  //           fontSize: 16,
                                  //           color: AppColors.blackColor),
                                  //     ),
                                  //   ),
                                  // );
                                },
                              )
                  ],
                ),
              );
            },
          )),
    );
  }
}
