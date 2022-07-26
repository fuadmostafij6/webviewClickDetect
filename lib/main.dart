import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WebViewExample()
    );
  }
}


class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: 'https://google.com',
        navigationDelegate: (action)async {
          if (action.url.contains('mail.google.com'))  {
            Uri url = Uri.parse("https://github.com/fuadmostafij6/");
            if (await canLaunchUrl(url)){

          await launchUrl(url);
          }
            Navigator.pop(context); // Close current window
            return NavigationDecision.prevent; // Prevent opening url
          } else if (action.url.contains('youtube.com')) {
            print('Trying to open Youtube');
            return NavigationDecision.navigate; // Allow opening url
          } else {
            return NavigationDecision.navigate; // Default decision
          }
        },
      ),
    );
  }
}