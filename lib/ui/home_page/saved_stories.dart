import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/controllers/ui/home_page/bookmark_controller.dart';
import 'package:newsapp/ui/constant/colors.dart';
import 'package:newsapp/ui/general/general_widgets.dart';
import 'package:newsapp/ui/general/web_view.dart';
import 'package:newsapp/ui/home_page/details_page.dart';

class SavedStories extends StatefulWidget {
  const SavedStories({Key? key}) : super(key: key);

  @override
  State<SavedStories> createState() => _SavedStoriesState();
}

class _SavedStoriesState extends State<SavedStories> {
  var box = GetStorage();
  late final bookMarkController;

  @override
  void initState() {
    super.initState();

    bookMarkController = Get.put(BookMarkController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Obx(() => Scaffold(
            backgroundColor: AppColors.scaffoldBackGroundColors,
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: (bookMarkController.bookmark.isEmpty)
                ? const SizedBox()
                : ExpandableFab(
                    child: const Icon(Icons.delete),
                    backgroundColor: const Color(0xffCC0000),
                    collapsedFabSize: ExpandableFabSize.regular,
                    type: ExpandableFabType.up,
                    closeButtonStyle: const ExpandableFabCloseButtonStyle(
                      backgroundColor: Color(0xffCC0000),
                    ),
                    distance: 50,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  GeneralWidgets
                                          .savedStoryRemovePermanentlyDialog(
                                              context: context,
                                              controller:
                                                  bookMarkController.bookmark)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: const Text(
                                  "Clear All",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () {
                                  GeneralWidgets
                                          .savedStoryRemoveOlderThanAWeekDialog(
                                              context: context,
                                              controller: bookMarkController)
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: const Text(
                                  "Older than 1 week",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () => GeneralWidgets
                                        .savedStoryRemoveOlderThanAMonthDialog(
                                      context: context,
                                      controller: bookMarkController,
                                    ),
                                child: const Text(
                                  "Older than 1 month",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
            appBar: AppBar(
              backgroundColor: const Color(0xffCC0000),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                "Saved Stories",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
            body: (bookMarkController.bookmark.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Center(
                        child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(64, 117, 205, 0.08),
                                  blurRadius: 5,
                                  offset: Offset(0.0, 7.0),
                                )
                              ],
                            ),
                            child: Lottie.asset(
                              "assets/image/saved.json",
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Find your bookmarked articles\nhere",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Just tap on Bookmark icon and \nread it on your own time.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ListView.builder(
                        itemCount: bookMarkController.bookmark.length,
                        itemBuilder: (context, index) {
                          return GeneralWidgets().savedStoryCard(
                              context: context,
                              newsData: bookMarkController.bookmark,
                              id: null,
                              index: index,
                              categoryName: bookMarkController.bookmark[index]
                                  ["_embedded"]["wp:term"]?[0][0]["name"],
                          isFromSavedStory: true);
                        }),
                  ),
          )),
    );
  }
}
