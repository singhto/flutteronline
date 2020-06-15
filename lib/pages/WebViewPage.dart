import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
 WebViewPage({Key key}) : super(key: key);

  @override
   WebViewPageState createState() =>  WebViewPageState();
}

class  WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> news = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('${news['name']}')),
      body: WebView(
          initialUrl: '${news['url']}',
          javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}