import 'package:flutter/material.dart';

class EditionPage extends StatefulWidget {
  const EditionPage({Key? key}) : super(key: key);

  @override
  State<EditionPage> createState() => _EditionPageState();
}

class _EditionPageState extends State<EditionPage> {
  String _selectedEdition = 'U.S.';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,

      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const Text(
                "Your edition determines the news programming you receive in the Top News section. ",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'U.S.',
                  groupValue: _selectedEdition,
                  onChanged: (value) {
                    setState(() {
                      _selectedEdition = value!;
                    });
                  },
                ),
                title: const Text('U.S.'),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'international',
                  groupValue: _selectedEdition,
                  onChanged: (value) {
                    setState(() {
                      _selectedEdition = value!;
                    });
                  },
                ),
                title: const Text('International'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
