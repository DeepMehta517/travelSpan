import 'dart:convert';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:newsapp/controllers/setting/font_size_controller.dart';
import 'package:newsapp/ui/constant/colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:webview_flutter/webview_flutter.dart';

import '../../controllers/setting/account_setting.dart';
import '../../controllers/ui/home_page/bookmark_controller.dart';
import '../../controllers/ui/home_page/tab_bar_controller.dart';
import '../general/general_widgets.dart';

class DetailsPage extends StatefulWidget {
  var newsData;
  String? id;
  String? categoryName;
  bool? isFromSavedStory;
  int index;

  DetailsPage({
    Key? key,
    required this.newsData,
    required this.index,
    this.categoryName,
    this.isFromSavedStory = false,
    this.id,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final fontSizeController = Get.put(FontSizeController());
  BookMarkController bookMarkController = Get.put(BookMarkController());
  final settingController = Get.put(SettingAccount());

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        "Travel Span",
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColorRed,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: PageView.builder(
          controller: PageController(initialPage: widget.index),
          itemCount: widget.newsData.length,
          itemBuilder: (context, index) => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: FancyShimmerImage(
                      imageUrl: widget.newsData[index]["_embedded"]["wp:featuredmedia"]?[0]["source_url"] ?? "",
                      width: MediaQuery.of(context).size.width,
                      boxFit: BoxFit.cover,
                    )),
                // Container(
                //   margin: const EdgeInsets.only(top: 10),
                //   padding: const EdgeInsets.all(10),
                //   child: Text(
                //     widget.newsData[index]["title"]["rendered"]
                //         .toString()
                //         .replaceAll("#8217;s", ""),
                //     textAlign: TextAlign.start,
                //     style: const TextStyle(
                //         fontSize: 25, fontWeight: FontWeight.bold),
                //   ),
                // ),

                Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    child: Html(
                      data: widget.newsData[index]["title"]["rendered"],
                      style: {
                        '#': Style(fontSize: FontSize(25), fontWeight: FontWeight.bold, textAlign: TextAlign.start),
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        timeago.format(
                            DateTime.parse(
                              widget.newsData[index]["date"].toString(),
                            ),
                            locale: 'en_short'),
                        style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                      Text(" ago", style: TextStyle(color: AppColors.greyColor, fontSize: 14)),
                      Text(
                        " | ",
                        style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                      ),
                      Text(
                        (widget.id == null)
                            ? widget.categoryName
                            : (widget.id!.isEmpty)
                                ? widget.newsData[index]["_embedded"]["wp:term"][0][0]["name"]
                                : widget.newsData[index]["_embedded"]["wp:term"]?[0][0]["name"] ?? "",
                        style: TextStyle(color: AppColors.primaryColorRed, fontSize: 14),
                      ),
                      Expanded(child: Container()),
                      Obx(() => () {
                            return InkWell(onTap: () {
                              if (bookMarkController.isBookmarked(widget.newsData[index])) {
                                if (widget.isFromSavedStory == true) {
                                  Get.back();
                                  bookMarkController.removeBookmark(widget.newsData[index]);
                                }
                                bookMarkController.removeBookmark(widget.newsData[index]);
                              } else {
                                widget.newsData[index]["bookmarkSavedDate"] = DateTime.now().toString();
                                bookMarkController.addToBookmark(widget.newsData[index]);
                              }
                            }, child: () {
                              return Icon(
                                bookMarkController.isBookmarked(widget.newsData[index]) ? Icons.bookmark : Icons.bookmark_border_outlined,
                                size: 23,
                                color: bookMarkController.isBookmarked(widget.newsData[index])
                                    ? AppColors.primaryColorRed
                                    : (settingController.isDarkMode.value)
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                              );
                            }());
                          }()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                            onTap: () {
                              GeneralWidgets.share(linkUrl: widget.newsData[index]["link"], text: widget.newsData[index]["title"]["rendered"]);
                            },
                            child: const Icon(
                              Icons.share,
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/image/devendra-groover.jpg",
                            )),
                      ),
                      const Text(
                        "  Devender Grover",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),

                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 120,
                //   child: WebView(
                //     initialUrl: 'about:blank',
                //     onWebViewCreated: (WebViewController controller) {
                //       controller.loadUrl(Uri.dataFromString(
                //         adScript,
                //         mimeType: 'text/html',
                //         encoding: Encoding.getByName('utf-8'),
                //       ).toString());
                //     },
                //   ),
                // ),
                Obx(() => Container(
                      padding: const EdgeInsets.all(2),
                      child: Html(
                        data: widget.newsData[index]["content"]["rendered"].toString(),
                        style: {
                          "body": Style(
                              fontSize: FontSize(fontSizeController.fontSize.value.toDouble()),
                              margin: Margins.symmetric(horizontal: 15),
                              textAlign: TextAlign.start,
                              lineHeight: LineHeight.number(1.2)),
                        },
                      ),
                    )),
                (widget.newsData.isEmpty)
                    ? const SizedBox()
                    : const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "Related Stories",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                ...List.generate((widget.newsData.length <= 5) ? widget.newsData.length : 6, (indexs) {
                  if (widget.newsData[indexs]["title"]["rendered"] == widget.newsData[index]["title"]["rendered"]) {
                    return const SizedBox();
                  }
                  if (widget.newsData.isEmpty) {
                    return const SizedBox();
                  }

                  return GeneralWidgets().newsCard(
                      context: context,
                      newsData: widget.newsData,
                      id: null,
                      index: indexs,
                      categoryName: (widget.id == null)
                          ? widget.categoryName
                          : (widget.id!.isEmpty)
                              ? widget.newsData[index]["_embedded"]["wp:term"][0][0]["name"]
                              : widget.newsData[index]["_embedded"]["wp:term"]?[0][0]["name"] ?? "");
                }),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Copyright © 2023 Travel Span",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
