import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newsapp/ui/general/general_widgets.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/ui/home_page/tab_bar_controller.dart';
import '../../repository/api_Service.dart';
import '../constant/colors.dart';

class CategoriesPage extends StatefulWidget {
  final String id;

  const CategoriesPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with AutomaticKeepAliveClientMixin {
  NewsController newsData = Get.put(NewsController());
  String categoriesName = "";
  MyTabs relatedPostData = Get.put(MyTabs());
  int pageNumber = 1;
  ScrollController scrollController = ScrollController();

  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  final String _adUnitId = Platform.isIOS ? 'ca-app-pub-3763158665726358/9573128958' : 'ca-app-pub-3763158665726358/8516032305';

  late final Future getData;

  void loadAd() {
    _nativeAd = NativeAd(
      adUnitId: _adUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          // debugPrint('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          // debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      // Styling
      nativeTemplateStyle: NativeTemplateStyle(
        // Required: Choose a template.
        templateType: TemplateType.medium,
        // Optional: Customize the ad's style.
        // mainBackgroundColor: Colors.purple,
        // cornerRadius: 10.0,
        // callToActionTextStyle:
        //     NativeTemplateTextStyle(textColor: Colors.cyan, backgroundColor: Colors.red, style: NativeTemplateFontStyle.monospace, size: 16.0),
        // primaryTextStyle:
        //     NativeTemplateTextStyle(textColor: Colors.red, backgroundColor: Colors.cyan, style: NativeTemplateFontStyle.italic, size: 16.0),
        // secondaryTextStyle:
        //     NativeTemplateTextStyle(textColor: Colors.green, backgroundColor: Colors.black, style: NativeTemplateFontStyle.bold, size: 16.0),
        // tertiaryTextStyle:
        //     NativeTemplateTextStyle(textColor: Colors.brown, backgroundColor: Colors.amber, style: NativeTemplateFontStyle.normal, size: 16.0),
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    getData = (widget.id.isEmpty) ? newsData.fetchLatestData() : newsData.fetchData(id: widget.id, page: pageNumber);
    loadAd();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Post",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.blackColor),
              ),
            );
          }

          return ListView.builder(
              controller: scrollController,
              itemCount: snapshot.data?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GeneralWidgets().zerothIndexWidget(id: widget.id, context: context, newsData: snapshot.data ?? [], index: index);
                }

                return Column(
                  children: [
                    GeneralWidgets().newsCard(
                      context: context,
                      newsData: snapshot.data ?? [],
                      id: widget.id,
                      index: index,
                    ),
                    if (index == 3 && _nativeAdIsLoaded)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child: Center(child: AdWidget(ad: _nativeAd!)),
                      )
                  ],
                );
              });
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        return const SizedBox(child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
