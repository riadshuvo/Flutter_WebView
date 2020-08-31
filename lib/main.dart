import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewWebPage(),
    );
  }
}

class WebViewWebPage extends StatefulWidget {
  @override
  _WebViewWebPageState createState() => _WebViewWebPageState();
}

class _WebViewWebPageState extends State<WebViewWebPage> {
  var URL = "https://gopalganjbazar.com";
  double progress = 0;
  InAppWebViewController webView;

  Future<bool> _onBack() async {
    bool goBack;
    var value = await webView.canGoBack(); // check webview can go back

    if (value) {
      webView.goBack(); // perform webview back operation

      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Confirmation ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          content: new Text('Do you want exit app ? '),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },

              child: new Text("YES"), // No
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },

              child: new Text("NO"), // Yes
            ),
          ],
        ),
      );
      if (goBack) Navigator.pop(context); // If user press Yes pop the page
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: SafeArea(
        child: Scaffold(
            body: Container(
                child: Column(
                    children: <Widget>[
          (progress != 1.0)
              ? LinearProgressIndicator(
                  minHeight: 5,
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF00dc7a),
                  ))
              : null, // Should be removed while showing
          Expanded(
            child: Container(
              child: InAppWebView(
                initialUrl: URL,
                initialHeaders: {},
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {},
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          )
        ].where((Object o) => o != null).toList()))),
      ),
    ); //Remove null widgets
  }
}

//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
//void main() => runApp(
//    MaterialApp(debugShowCheckedModeBanner: false, home: WebViewWidget()));
//
//class WebViewWidget extends StatefulWidget {
//  @override
//  _WebViewWidget createState() => _WebViewWidget();
//}
//
//class _WebViewWidget extends State<WebViewWidget> {
//  InAppWebViewController webView;
//  bool isLoading = true;
//  final _key = UniqueKey();
//
//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: () => _willPopCallback(context),
//      child: Scaffold(
//        body: SafeArea(
//          child: Stack(
//            children: <Widget>[
//              WebView(
//                key: _key,
//                initialUrl: "https://gopalganjbazar.com/",
//                javascriptMode: JavascriptMode.unrestricted,
//                onPageFinished: (finish) {
//                  setState(() {
//                    isLoading = false;
//                  });
//                },
//              ),
//              isLoading
//                  ? Center(
//                      child: CircularProgressIndicator(),
//                    )
//                  : Stack(),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
//  Future<bool> _willPopCallback(BuildContext context) async {
//    return showDialog(
//      context: context,
//      builder: (context) => new AlertDialog(
//        title: new Text('Are you sure?'),
//        content: new Text('Do you want to exit this App!'),
//        actions: <Widget>[
//          new Container(
//            padding: EdgeInsets.all(5),
//            child: FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pop(true);
//                },
//                color: Color(0xFF00dc7a),
//                child: Text(
//                  'YES',
//                  style: TextStyle(fontSize: 20, color: Colors.white),
//                )),
//          ),
//          SizedBox(height: 16),
//          new Container(
//            padding: EdgeInsets.all(5),
//            child: FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pop(false);
//                },
//                color: Color(0xFFff0001),
//                child: Text(
//                  'NO',
//                  style: TextStyle(fontSize: 20, color: Colors.white),
//                )),
//          ),
//        ],
//      ),
//    );
//  }
//}
