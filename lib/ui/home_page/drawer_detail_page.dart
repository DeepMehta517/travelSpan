import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/ui/constant/colors.dart';
import 'package:newsapp/ui/home_page/categories_page.dart';

import '../../repository/api_Service.dart';

class DrawerDetailPage extends StatefulWidget {
  String pageName;
  String id;

  DrawerDetailPage({
    Key? key,
    required this.pageName,
    required this.id,
  }) : super(key: key);

  @override
  State<DrawerDetailPage> createState() => _DrawerDetailPageState();
}

class _DrawerDetailPageState extends State<DrawerDetailPage> {
  NewsController newsData = Get.put(NewsController());

  late final Future getData;

  @override
  void initState() {
    super.initState();
    getData=newsData.fetchData(id: widget.id, page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColorRed,
        title: Text(widget.pageName),
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body:CategoriesPage(
        id: widget.id,
      ),
    );
  }


}
