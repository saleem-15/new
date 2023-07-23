import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/cache/cache.dart';
import 'package:nuntium/features/home/presentation/model/article.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleController extends GetxController {
  late final WebViewController webViewController;
  late Article _article;
  bool isLoading = true;
  bool isError = false;

  final refreshController = RefreshController();

  @override
  void onInit() {
    super.onInit();

    _article = CacheData.getArticle()!;
    initWebController(_article.url!);
  }

  void initWebController(String url) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            log('onPageStarted');
            isLoading = false;
            isError = false;
            update();
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            isLoading = false;
            isError = true;
            update();
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<bool> back() async {
    disposeArticleModule();
    return true;
  }

  Future<void> onRefresh() async {
    isLoading = true;
    isError = false;
    update();
    await webViewController.reload();
    refreshController.loadComplete();
    refreshController.refreshCompleted();
    update();
  }
  
}
