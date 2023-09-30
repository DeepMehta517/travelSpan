import 'dart:async';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/ui/general/web_view.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controllers/setting/account_setting.dart';
import '../../controllers/ui/home_page/bookmark_controller.dart';
import '../../repository/api_Service.dart';
import '../constant/colors.dart';
import '../home_page/details_page.dart';
import '../home_page/drawer_detail_page.dart';

class GeneralWidgets {
  NewsController newsData = Get.put(NewsController());
  BookMarkController bookMarkController = Get.put(BookMarkController());
  final SettingAccount settingAccount = Get.put(SettingAccount());

  /// share app
  Future<void> shareContent(String content) async {
    await Share.share(content);
  }

  ///Share

  static Future<void> share({
    required String? linkUrl,
    required String? text,
  }) async {
    await FlutterShare.share(text: text, title: 'Share', linkUrl: linkUrl, chooserTitle: 'Example Chooser Title');
  }

  ///saved Story Remove Permanently Dialog

  static Future savedStoryRemovePermanentlyDialog({required BuildContext context, var controller}) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Remove Articles'),
          content: const Text('Are you sure you want to remove all articles'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text(
                'REMOVE',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                controller.clear();
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static SnackbarController showSnackBar({required String messageText, required String title}) {
    return Get.showSnackbar(GetSnackBar(
      borderRadius: 20,
      title: title,
      messageText: Text(
        messageText,
        style: TextStyle(color: AppColors.whiteColor, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      icon: Icon(
        Icons.cancel_rounded,
        color: AppColors.whiteColor,
      ),
      shouldIconPulse: true,
      backgroundColor: AppColors.primaryColorRed,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 5),
    ));
  }

  ///saved Story Remove Older Than A Week Dialog

  static Future savedStoryRemoveOlderThanAWeekDialog({required BuildContext context, required BookMarkController controller}) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Remove Articles'),
          content: const Text('Are you sure you want to remove articles older than 1 week?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text(
                'REMOVE',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                controller.bookmark.firstWhereOrNull((element) {
                  final apiDateTime = DateTime.parse(element["bookmarkSavedDate"].toString());
                  final difference = DateTime.now().difference(apiDateTime);
                  if ((difference.inDays < 7)) {
                    showSnackBar(title: "Article Date", messageText: "No Article older than a Week");
                  } else {
                    controller.bookmark.removeWhere((element) => difference.inDays > 7);
                  }

                  return true;
                });

                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ///saved Story Remove Older Than A Month Dialog

  static Future savedStoryRemoveOlderThanAMonthDialog({required BuildContext context, required BookMarkController controller}) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Remove Articles'),
          content: const Text('Are you sure you want to remove articles older than 1 week?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(
                'REMOVE',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                controller.bookmark.firstWhereOrNull((element) {
                  final apiDateTime = DateTime.parse(element["bookmarkSavedDate"].toString());
                  final difference = DateTime.now().difference(apiDateTime);
                  if ((difference.inDays < 29) || difference.inDays < 30) {
                    showSnackBar(title: "Article Date", messageText: "No Article older than a Month");
                  } else {
                    controller.bookmark.removeWhere((element) => ((difference.inDays > 29) || difference.inDays > 30));
                  }

                  return true;
                });

                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// delete Account Dialog

  static Future deleteAccountDialog({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
              'You are about to permanently remove\nyour NewsApp account.This will go into \neffect immediately and you will no\nlonger have access to your account\ndata.'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Nevermind',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Account Deleted Dialog

  static Future accountDeletedDialog({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Your account has been deleted'),
          content: const Text('Your account has been  successfully deleted.'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(color: AppColors.primaryColorRed),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  ///Drawer
  static Widget drawer({
    required List mainCategories,
    required List subCategories,
    required bool isLoading,
    required BuildContext context,
  }) {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: SingleChildScrollView(
        child: (isLoading)
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  ListTile(
                    tileColor: AppColors.whiteColor,
                    title: Text(
                      "${mainCategories.length} Categories",
                      style: TextStyle(
                        color: AppColors.primaryColorRed,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: mainCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      List subCategoryData;

                      subCategoryData = subCategories.where((element) => element.parent == mainCategories[index].id).toList();

                      return ExpansionTile(
                          onExpansionChanged: (value) {
                            (subCategoryData.firstWhereOrNull((element) => element.parent == mainCategories[index].id) == null)
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DrawerDetailPage(id: mainCategories[index].id.toString(), pageName: mainCategories[index].name.toString()),
                                  ))
                                : const SizedBox();
                          },
                          iconColor: (subCategoryData.firstWhereOrNull((element) => element.parent == mainCategories[index].id) == null)
                              ? Colors.white
                              : Colors.blue,
                          collapsedIconColor: (subCategoryData.firstWhereOrNull((element) => element.parent == mainCategories[index].id) == null)
                              ? Colors.white
                              : Colors.blue,
                          backgroundColor: Colors.white12,
                          title: Text(
                            mainCategories[index].name.toString().replaceAll("amp;", ""),
                            style: const TextStyle(color: Colors.black),
                          ),
                          children: List.generate(
                              subCategoryData.length,
                              (index) => ListTile(
                                    title: Text(
                                      subCategoryData[index].name.toString().replaceAll("amp;", ""),
                                      style: const TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => DrawerDetailPage(
                                            id: (subCategoryData != null) ? subCategoryData[index].id.toString() : "",
                                            pageName: (subCategoryData != null) ? subCategoryData[index].name : ""),
                                      ));
                                    },
                                  )));
                    },
                  )

                  // ListView.builder(
                  //   physics: const ScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: categories.length,
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   itemBuilder: (context, index) => ListTile(
                  //     contentPadding: EdgeInsets.zero,
                  //     title: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             categories[index].name.toString(),
                  //             style: TextStyle(
                  //               color: AppColors.whiteColor,
                  //               fontSize: 16,
                  //             ),
                  //           ),
                  //         ),
                  //         Divider(
                  //           color: AppColors.whiteColor,
                  //         )
                  //       ],
                  //     ),
                  //     onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => DrawerDetailPage(
                  //             id: categories[index].id.toString(),
                  //             pageName: categories[index].name.toString()),
                  //       ));
                  //     },
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }

  ///Reels button
  static Widget reels() {
    return InkWell(
      onTap: () => Get.to(WebViewPage(url: "https://travelspan.in/reel/", title: "Reels")),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Text(
          "Reels",
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static PreferredSizeWidget appBar({required String title}) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          title,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.primaryColorRed,
      elevation: 0,
      actions: [GeneralWidgets.reels()],
    );
  }

  /// Card
  Widget newsCard({
    required BuildContext context,
    required var newsData,
    required String? id,
    required int index,
    String? categoryName,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(
            id: id,
            index: index,
            newsData: newsData,
            categoryName: (id == null) ? categoryName : "",
          ),
        ));
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: FancyShimmerImage(
                    imageUrl: (newsData[index]["_embedded"]["wp:featuredmedia"] != null)
                        ? newsData[index]["_embedded"]["wp:featuredmedia"][0]["source_url"] ?? ''
                        : "",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      Html(
                        data: newsData[index]["title"]["rendered"],
                        shrinkWrap: true,
                        style: {
                          '#': Style(
                            fontSize: FontSize(15),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        },
                      ),
                      // SizedBox(
                      //   child: Text(
                      //     newsData[index]["title"]["rendered"]
                      //         .toString()
                      //         .replaceAll("#8217;s", "")
                      //         .replaceAll("&#8220;", "")
                      //         .replaceAll("&#8221;", "")
                      //         .replaceAll("&#8216;", "")
                      //         .replaceAll("&#8217;", ""),
                      //     maxLines: 3,
                      //     overflow: TextOverflow.ellipsis,
                      //     softWrap: true,
                      //     style: TextStyle(color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      const Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            timeago
                                .format(
                                    DateTime.parse(
                                      newsData[index]["date"].toString(),
                                    ),
                                    locale: 'en_short')
                                .replaceAll("~", ""),
                            style: TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Text(" ago", style: TextStyle(color: AppColors.greyColor, fontSize: 14)),
                          Text(
                            " | ",
                            style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                          ),
                          () {
                            List<String> categoryNames = [];
                            if (newsData[index]['_embedded']['wp:term'] != null) {
                              for (var category in newsData[index]['_embedded']['wp:term'][0]) {
                                if (newsData[index]['categories'].contains(category['id'])) {
                                  categoryNames.add(category['name']);
                                }
                              }
                            }
                            return Expanded(
                              flex: 4,
                              child: Text(
                                categoryNames[0],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(color: AppColors.primaryColorRed, fontSize: 14),
                              ),
                            );
                          }(),
                          Expanded(child: Container()),
                          Obx(() => () {
                                return InkWell(onTap: () {
                                  if (bookMarkController.isBookmarked(newsData[index])) {
                                    bookMarkController.removeBookmark(newsData[index]);
                                  } else {
                                    newsData[index]["bookmarkSavedDate"] = DateTime.now().toIso8601String();
                                    bookMarkController.addToBookmark(newsData[index]);
                                  }
                                }, child: () {
                                  return Icon(
                                    bookMarkController.isBookmarked(newsData[index]) ? Icons.bookmark : Icons.bookmark_border_outlined,
                                    size: 23,
                                    color: bookMarkController.isBookmarked(newsData[index]) ? AppColors.primaryColorRed : AppColors.blackColor,
                                  );
                                }());
                              }()),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                              onTap: () {
                                GeneralWidgets.share(linkUrl: newsData[index]["link"], text: newsData[index]["title"]["rendered"]);
                              },
                              child: Icon(
                                Icons.share,
                                size: 23,
                                color: AppColors.blackColor,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget zerothIndexWidget({
    required BuildContext context,
    required var newsData,
    required String? id,
    required int index,
    String? categoryName,
  }) {
    // print(newsData[index]["categories"].where((news) => news[0]));
    return InkWell(
      onTap: () {
        Get.to(() => DetailsPage(
              id: id,
              index: 0,
              newsData: newsData,
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        color: Colors.white,
        child: Column(
          children: [
            FancyShimmerImage(
                imageUrl: newsData[index]["_embedded"]["wp:featuredmedia"]?[0]["source_url"] ?? "", width: MediaQuery.of(context).size.width),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Html(
                data: newsData[index]["title"]["rendered"],
                shrinkWrap: true,
                style: {
                  '#': Style(
                    fontSize: FontSize(20),
                  ),
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            //   child: Text(
            //     newsData[index]["title"]["rendered"].toString().replaceAll("#8217;s", ""),
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.blackColor),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Text(
                    timeago
                        .format(
                            DateTime.parse(
                              newsData[index]["date"].toString(),
                            ),
                            locale: 'en_short')
                        .replaceAll("~", ""),
                    style: TextStyle(color: AppColors.greyColor, fontSize: 15),
                  ),
                  Text(" ago", style: TextStyle(color: AppColors.greyColor, fontSize: 14)),
                  Text(
                    " | ",
                    style: TextStyle(color: AppColors.greyColor, fontSize: 15),
                  ),
                  () {
                    List<String> categoryNames = [];
                    if (newsData[index]['_embedded']['wp:term'] != null) {
                      for (var category in newsData[index]['_embedded']['wp:term'][0]) {
                        for (var i in newsData[index]['categories']) {
                          if (newsData[index]['categories'].contains(category['id']) && i == category["id"]) {
                            categoryNames.add(category['name']);
                          }
                        }
                      }
                    }
                    return Expanded(
                      flex: 4,
                      child: Text(
                        categoryNames[0],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: AppColors.primaryColorRed, fontSize: 14),
                      ),
                    );
                  }(),
                  Expanded(child: Container()),
                  Obx(() => () {
                        return InkWell(onTap: () {
                          if (bookMarkController.isBookmarked(newsData[index])) {
                            bookMarkController.removeBookmark(newsData[index]);
                          } else {
                            newsData[index]["bookmarkSavedDate"] = DateTime.now().toString();
                            bookMarkController.addToBookmark(newsData[index]);
                          }
                        }, child: () {
                          return Icon(
                            bookMarkController.isBookmarked(newsData[index]) ? Icons.bookmark : Icons.bookmark_border_outlined,
                            size: 23,
                            color: bookMarkController.isBookmarked(newsData[index]) ? AppColors.primaryColorRed : AppColors.blackColor,
                          );
                        }());
                      }()),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                      onTap: () {
                        GeneralWidgets.share(linkUrl: newsData[index]["link"], text: newsData[index]["title"]["rendered"]);
                      },
                      child: Icon(
                        Icons.share,
                        size: 23,
                        color: AppColors.blackColor,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Saved Story Card
  Widget savedStoryCard({
    required BuildContext context,
    required var newsData,
    required String? id,
    required int index,
    String? categoryName,
    bool? isFromSavedStory,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(
            id: id,
            index: index,
            newsData: newsData,
            categoryName: (id == null) ? categoryName : "",
            isFromSavedStory: isFromSavedStory,
          ),
        ));
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: FancyShimmerImage(
                    imageUrl: newsData[index]["_embedded"]["wp:featuredmedia"][0]["source_url"],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // SizedBox(
                      //   child: Text(
                      //     newsData[index]["title"]["rendered"],
                      //     maxLines: 3,
                      //     overflow: TextOverflow.ellipsis,
                      //     softWrap: true,
                      //     style: TextStyle(color: AppColors.blackColor, fontSize: 14, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      SizedBox(
                        child: Html(
                          data: newsData[index]["title"]["rendered"],
                          style: {
                            '#': Style(
                                fontSize: FontSize(14),
                                maxLines: 3,
                                textOverflow: TextOverflow.ellipsis,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold),
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Saved on ${DateFormat.yMMMd().format(DateTime.parse(bookMarkController.bookmark[index]["bookmarkSavedDate"]))}"),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    bookMarkController.bookmark.remove(bookMarkController.bookmark[index]);
                                    // setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                    size: 22,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  onTap: () => GeneralWidgets.share(
                                      text: bookMarkController.bookmark[index]["title"]["rendered"],
                                      linkUrl: bookMarkController.bookmark[index]["link"]),
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.black,
                                    size: 22,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  ///Bottom Sheet For Choosing photo
  Future chooseFrom() {
    return Get.bottomSheet(
        barrierColor: Colors.black.withOpacity(0.6),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        SizedBox(
          child: Wrap(
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                onTap: () {
                  Get.back();
                  settingAccount.removePhoto();
                },
                title: const Text("Remove Photo"),
              ),
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                onTap: () {
                  Get.back();
                  settingAccount.getFromCamera();
                },
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  settingAccount.getFromGallery();
                },
                title: const Text("Gallery"),
              ),
            ],
          ),
        ));
  }
}
