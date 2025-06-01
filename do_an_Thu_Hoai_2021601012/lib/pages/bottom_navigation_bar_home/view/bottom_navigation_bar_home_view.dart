import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/icons.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/pages/event/view/event_view.dart';
import 'package:do_an/pages/notification/view/notification_view.dart';
import 'package:do_an/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/view/home_view.dart';
import '../../transaction/view/transaction_page.dart';
import '../controller/bottom_navigation_bar_home_controller.dart';

class BottomNavigationBarHomePage extends GetView<BottomNavigationBarHomeController> {
  const BottomNavigationBarHomePage({Key? key}) : super(key: key);
  @override
  BottomNavigationBarHomeController get controller => Get.put(BottomNavigationBarHomeController());

  @override
  Widget build(BuildContext context) {
    final iconList = [
      IconWithTitle(
        iconLink: ImageAsset.icHome,
        title: AppString.overview,
      ),
      IconWithTitle(
        iconLink: ImageAsset.icHistory,
        title: AppString.history,
      ),
      IconWithTitle(
        iconLink: ImageAsset.icNotifi,
        title: AppString.notification,
      ),
      IconWithTitle(
        iconLink: ImageAsset.icAccount,
        title: AppString.event,
      ),
    ];
    const pages = <Widget>[
      HomePage(),
      TracsactionPage(),
      NotificationPage(),
      EventPage(),
    ];
    buildBody(int value) {
      return pages[value];
    }

    return Obx(
      () => Scaffold(
        body: buildBody(controller.indexTab.value),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            Get.toNamed(AppRoutes.createTransaction);
          },
          backgroundColor: kPrimaryColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? kPrimaryColor : kSecondaryColor;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      iconList[index].iconLink,
                      height: 20,
                      fit: BoxFit.cover,
                      color: color,
                    ).paddingAll(5),
                    Obx(
                      () => (controller.numbEvent.value != 0 && index == 2)
                          ? Positioned(
                              top: 1,
                              right: 2,
                              child: AutoSizeText(
                                controller.numbEvent.value.toString(),
                                style: Get.textTheme.bodySmall!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox(
                              width: 1,
                              height: 1,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                AutoSizeText(
                  iconList[index].title,
                  maxLines: 1,
                  style: Get.textTheme.bodySmall!.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          },
          backgroundColor: kPrimaryLightColor,
          activeIndex: controller.indexTab.value,
          splashColor: kPrimaryLightColor,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 8,
          rightCornerRadius: 8,
          onTap: (index) {
            controller.indexTab.value = index;
            controller.onTapped(index);
          },
          shadow: const BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}

class IconWithTitle {
  String iconLink;
  String title;
  IconWithTitle({
    required this.iconLink,
    required this.title,
  });
}
