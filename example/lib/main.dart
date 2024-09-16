import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const LinkifyExample());

class LinkifyExample extends StatelessWidget {
  const LinkifyExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter_linkify example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_linkify example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Linkify(
                    onOpen: _onOpen,
                    text:
                        "Made by https://cretezy.com\n\nMail: example@gmail.com",
                  ),
                  const SizedBox(height: 64),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    text:
                        "Made by https://cretezy.com\n\nMail: example@gmail.com",
                  ),
                  const SizedBox(height: 64),
                  const Linkify(
                    onOpen: print,
                    // text: "@Cretezy +123456789"
                    text:
                        "Here is some Dart code:\nInline: `void main() => runApp(const LinkifyExample());`\nBlock: \n```dart\nvoid main() => runApp(const LinkifyExample());\n```",
                    // text:
                    //     "Here is some Dart code:\n```dart\nvoid main() => runApp(const LinkifyExample());\n```",
                    // text:
                    // "Here is some Dart code:\nInline: `void main() => runApp(const LinkifyExample());`",

                    linkifiers: [
                      UserTagLinkifier(),
                      PhoneNumberLinkifier(),
                      CodeBlockLinkifier(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw Exception('Could not launch ${link.url}');
    }
  }
}
