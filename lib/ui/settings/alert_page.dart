import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  AlertPage({Key? key}) : super(key: key);

  List<String> title = [
    "Breaking News",
    "Top news and analysis",
    "Climate Crisis",
    "Coronavirus",
    "U S Politics",
    "Business and Tech",
    "Cnn Watch Now",
    "Sports",
  ];
  List<String> subTitle = [
    "The latest news on major events",
    "In-depth reporting and context",
    "The science, our impact and how to act",
    "Latest updates on a global pandemic",
    "Congress, policy and fact checks",
    "Global markets, finance, media and innovation",
    "Live video, big interviews and CNN specials",
    "Global sports news and features",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffCC0000),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: const Text("Edition"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Alerts that matter to you",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: title.length,
                itemBuilder: (context, index) => SwitchListTile(
                  title: Text(title[index].toString()),
                  subtitle: Text(subTitle[index].toString()),
                  value: false,
                  onChanged: (value) => setState(() {}),
                  activeColor: Colors.red,
                  inactiveTrackColor: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
