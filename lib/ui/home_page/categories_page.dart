import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/ui/general/general_widgets.dart';

import '../../controllers/ui/home_page/tab_bar_controller.dart';
import '../../repository/api_Service.dart';
import '../constant/colors.dart';

class CategoriesPage extends StatefulWidget {
  String id;

  CategoriesPage({
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

  late final Future getData;

  @override
  void initState() {
    super.initState();
    getData = (widget.id.isEmpty) ? newsData.fetchLatestData() : newsData.fetchData(id: widget.id, page: pageNumber);
  }

  @override
  Widget build(BuildContext context) {
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

                return GeneralWidgets().newsCard(
                  context: context,
                  newsData: snapshot.data ?? [],
                  id: widget.id,
                  index: index,
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
