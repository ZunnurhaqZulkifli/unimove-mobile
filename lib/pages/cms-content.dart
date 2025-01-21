import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:unimove/pages/settings/maintainance_mode.dart';

class CmsContentPage extends StatefulWidget {
  final String pageTitle;
  final String url;

  CmsContentPage(this.url, this.pageTitle, {Key? key}) : super(key: key);

  @override
  _CmsContentPageState createState() => _CmsContentPageState();
}

class _CmsContentPageState extends State<CmsContentPage> {
  GlobalKey pageKey = GlobalKey();
  late InAppWebViewController pageController;
  bool isLoading = true;

  InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    useHybridComposition: true,
    allowsInlineMediaPlayback: true,
    useShouldOverrideUrlLoading: false,
    safeBrowsingEnabled: true,
    loadsImagesAutomatically: true,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        bottomOpacity: 0,
        title: Text(
          widget.pageTitle,
          style: themeController.currentTheme.textTheme.displayLarge,
        ),
        actions: isLoading
            ? [
                CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                  strokeWidth: 2,
                ),
                SizedBox(width: 20),
              ]
            : [
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: IconButton(
                //     onPressed: () {
                //       // pageController.evaluateJavascript(source: 'window.closeWindow()');

                //       print(widget.pageTitle);
                //     },
                //     icon: Icon(
                //       UniconsLine.heart,
                //     ),
                //   ),
                // ),
              ],
      ),
      body: Container(
        child: InAppWebView(
          key: pageKey,
          initialUrlRequest: URLRequest(
            url: WebUri(widget.url),
          ),
          initialSettings: settings,
          onWebViewCreated: (controller) {
            pageController = controller;
            controller.addJavaScriptHandler(
              handlerName: 'closeWindow',
              callback: (args) async {
                Navigator.of(context).pop();
              },
            );
          },
          onLoadStart: (controller, url) {
            setState(() {
              isLoading = true;
            });
          },
          onLoadStop: (controller, url) {
            setState(() {
              isLoading = false;
            });
          },
          // ignore: deprecated_member_use
          onLoadError: (controller, url, code, message) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      ),
    );
  }
}
