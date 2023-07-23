import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/features/article/presentation/controller/article_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.back,
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            // controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            child: Stack(
              children: [
                GetBuilder<ArticleController>(
                  builder: (controller) {
                    if (controller.isError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              ManagerJson.error_no_internet,
                              width: ManagerWidth.w288,
                              repeat: false,
                            ),
                            rectButton(
                              margin: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w120,
                              ),
                              onPressed: controller.onRefresh,
                              text: 'Refresh',
                            ),
                          ],
                        ),
                      );
                    } else if (controller.isLoading) {
                      return Center(
                        child: Lottie.asset(
                          ManagerJson.loading,
                        ),
                      );
                    }

                    return WebViewWidget(
                      controller: controller.webViewController,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
