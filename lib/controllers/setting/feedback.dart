import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:newsapp/ui/general/general_widgets.dart';

class FeedbackController extends GetxController {
  final feedbackTitleController = TextEditingController();
  final feedbackDetailController = TextEditingController();
  var selectedItem = 'HIGH'.obs;

  List<String> options = ['HIGH', 'MEDIUM', 'LOW'];

  @override
  void onInit() {
    super.onInit();
    selectedItem.value = "HIGH";
  }

  settingPriority(value) {
    selectedItem.value = value;
  }

  void sendEmail(BuildContext context) async {
    final Email email = Email(
      body: feedbackDetailController.value.text,
      subject:
          '${feedbackTitleController.value.text} -$selectedItem - Travel Span',
      recipients: ['pmnweb11@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      GeneralWidgets.showSnackBar(
          messageText: "Feedback sent successfully", title: "Email Sent!");
    } catch (e) {
      GeneralWidgets.showSnackBar(
          messageText: e.toString(), title: "Email Not Sent!");
    }
  }
}
