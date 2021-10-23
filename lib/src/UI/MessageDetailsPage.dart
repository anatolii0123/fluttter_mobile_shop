import 'dart:convert';

import 'package:cms_manhattan_project/src/Models/ModelMessage.dart';
import 'package:cms_manhattan_project/src/UI/ChatPage.dart';
import 'package:cms_manhattan_project/src/Utils/RestDatasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class MessageDetailsPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MessageDetailsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? list;
  bool isLoading = false;
  late RestDatasource api;
  WebViewController? _controller;
  _PageState() {
    api = new RestDatasource();
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('lib/mail.html');
    _controller?.loadUrl(
      Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: WebView(
          initialUrl: 'about:blank',
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _loadHtmlFromAssets();
          },
          navigationDelegate: (request) async {
            print(request.url);
            if (request.url == 'http://goback/') {
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }
            await canLaunch(request.url) ? await launch(request.url) : print('Could not launch url: ' + request.url);
            return NavigationDecision.prevent;
          },
        ),
      ),
    );
  }
}
