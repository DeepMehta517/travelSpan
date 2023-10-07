import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../controllers/ui/home_page/web_view.dart';
import '../constant/colors.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController webViewControllers;

  final web = Get.put(Webviews());

  @override
  void initState() {
    super.initState();
    webViewControllers = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          web.progress.value = progress;
          removeHeaderFooter();
        },
        onPageStarted: (String url) {
          web.isLoading.value = true;
        },
        onPageFinished: (String url) {
          web.isLoading.value = false;
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: AppColors.primaryColorRed,
      ),
      body: Obx(() => Stack(
            children: [
              WebViewWidget(
                controller: webViewControllers,
                // initialUrl: url,
                // javascriptMode: JavascriptMode.unrestricted,
                // onWebViewCreated: (WebViewController webViewController) {
                //   webViewControllers = webViewController;
                // },
                // onProgress: (int progress) {
                //   web.progress.value = progress;
                //   removeHeaderFooter();
                // },
                // onPageStarted: (String url) {
                //   web.isLoading.value = true;
                // },
                // onPageFinished: (String url) {
                //   web.isLoading.value = false;
                // },
                // gestureNavigationEnabled: true,
              ),
              if (web.isLoading.value)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "${web.progress.value} %",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: AppColors.primaryColorRed),
                      ),
                    )
                  ],
                )
            ],
          )),
    );
  }

  removeHeaderFooter() async {
    await webViewControllers.runJavaScript('''
      
      var headerElement = document.getElementsByClassName('tdc-header-wrap');
      for (var i = headerElement.length - 1; i >= 0; i--) {
      var headerElement = headerElement[i];
      if (headerElement.parentNode != null) {
        headerElement.parentNode.removeChild(headerElement);
      }
    }
      var footerElement = document.getElementsByClassName('td-footer-wrap ');
      for(var i=footerElement.length-1;i>=0;i--){
      var footerElement=footerElement[i];
       if (footerElement.parentNode != null) {
        footerElement.parentNode.removeChild(footerElement);
      }
      }
    ''');
  }
}
