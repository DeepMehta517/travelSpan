import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newsapp/ui/constant/colors.dart';

import '../../controllers/setting/feedback.dart';

class FeedBack extends StatefulWidget {
  FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final feedback = Get.put(FeedbackController());

  ///Hello feedback Widget
  Widget helloWidget({required BuildContext context}) {
    return Card(
      elevation: 5,
      shadowColor: AppColors.scaffoldBackGroundColors,
      color: AppColors.primaryColorRed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(64, 117, 205, 0.08),
              blurRadius: 5,
              offset: Offset(0.0, 7.0),
            )
          ],
        ),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 50),
        child:const ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Hey There!",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We'd love to get feedback from you on our app. The more details you can provide,the better.!",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xffCC0000),
            onPressed: () {
              feedback.sendEmail(context);
            },
            child: const Icon(Icons.send)),
        appBar: AppBar(
          backgroundColor: const Color(0xffCC0000),
          title: const Text("FeedBack"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              helloWidget(context: context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(
                        controller: feedback.feedbackTitleController,
                        maxLines: 2,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: feedback.feedbackDetailController,
                            minLines: 10,
                            maxLines: 15050,
                            onChanged: (value) {},
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                border: InputBorder.none,
                                hintText: "Details ",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Set priority of  your feedback!!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.greyColor),
                        ),
                        const Expanded(child: SizedBox()),
                        Obx(() => Container(
                          alignment: Alignment.center,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyColor)
                          ),
                          child: DropdownButton(
                            underline:const  SizedBox(),
                                alignment: Alignment.center,
                                borderRadius: BorderRadius.circular(20),
                                value: feedback.selectedItem.value,
                                items: feedback.options.map((String option) {
                                  return DropdownMenuItem(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  feedback.settingPriority(value);
                                },
                              ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
