import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/colors.dart';
import 'package:do_an/base/dimen.dart';
import 'package:do_an/base/strings.dart';
import 'package:do_an/base_ui/base_ui_src.dart';
import 'package:do_an/ultis/ultis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../component/item_card.dart';
import '../../../component/util_widget.dart';
import '../controller/transaction_controller.dart';

class TracsactionPage extends BaseSearchAppBarWidget<TransactionController> {
  const TracsactionPage({Key? key}) : super(key: key);
  @override
  TransactionController get controller => Get.put(TransactionController());
  @override
  Widget buildWidgets() {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: baseShimmerLoading(
        () => buildPage(
          hintSearch: "Tìm kiếm theo tên danh mục, mô tả",
          actionExtra: Obx(
            () => Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    const Icon(
                      Icons.filter_alt_outlined,
                      color: kPrimaryColor,
                    ),
                    if (controller.isFilter.value)
                      const Positioned(
                        top: 10,
                        right: -3.0,
                        child: Icon(
                          Icons.check_circle,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      )
                  ],
                ),
                onPressed: controller.showFilterPage,
              ),
            ).paddingOnly(
              left: paddingSmall,
            ),
          ),
          backButton: false,
          showWidgetEmpty: false,
          buildBody: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: controller.isFilter.value
                          ? AutoSizeText(
                              " ${controller.fromDate} -> ${controller.toDate}",
                              style: Get.textTheme.bodyLarge!.copyWith(fontStyle: FontStyle.italic),
                            )
                          : Container(
                              color: Colors.white,
                              height: 50,
                              child: TabBar(
                                tabs: const [
                                  AutoSizeText(AppString.lastMonth),
                                  AutoSizeText(AppString.thisMonth),
                                  AutoSizeText(AppString.future),
                                ],
                                onTap: (value) async => await controller.onTapped(value),
                                labelColor: kPrimaryColor,
                                unselectedLabelColor: kSecondaryColor,
                              ),
                            ),
                    ),
                    Visibility(
                      visible: controller.isFilter.value,
                      child: IconButton(
                          onPressed: () async {
                            controller.isFilter.value = false;
                            await controller.onTapped(controller.indexTabbar.value);
                          },
                          icon: const Icon(Icons.close)),
                    )
                  ],
                ),
              ),
              Container(
                width: Get.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      "Số dư hiện tại",
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.homeController.totalValue.toString().toVND(),
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: UtilWidget.buildSmartRefresher(
                  refreshController: controller.refreshController,
                  onRefresh: controller.onRefresh,
                  onLoadMore: controller.onLoadMore,
                  enablePullUp: true,
                  child: Obx(
                    () => controller.rxList.isEmpty
                        ? Center(
                            child: AutoSizeText(
                              "Không có giao dịch diễn ra trong \nkhoảng thời gian này",
                              textAlign: TextAlign.center,
                            ),
                          )
                        : GroupedListView<dynamic, String>(
                            shrinkWrap: true,
                            elements: controller.rxList,
                            useStickyGroupSeparators: true,
                            controller: controller.scrollControllerUpToTop,
                            groupBy: (dynamic element) => DateFormat('yyyy-MM-dd').format(element.executionTime),
                            groupSeparatorBuilder: (String value) {
                              return Container(
                                color: Color.fromARGB(255, 243, 240, 240),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Text(
                                              DateFormat.d("vi").format(
                                                DateTime.parse(value),
                                              ),
                                              style: Get.textTheme.bodyLarge!.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            child: Column(
                                              children: [
                                                Text(
                                                  DateFormat.EEEE("vi").format(
                                                    DateTime.parse(value),
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat.yM("vi").format(
                                                    DateTime.parse(value),
                                                  ),
                                                  style: TextStyle(color: Color.fromARGB(255, 121, 120, 120)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "+" + (controller.listThu[value] != null ? controller.listThu[value].toString().toVND() : "0 đ"),
                                            style: Get.textTheme.bodyLarge!.copyWith(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            controller.listChi[value] != null ? controller.listChi[value].toString().toVND() : "0 đ",
                                            style: Get.textTheme.bodyLarge!.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            itemBuilder: (context, dynamic element) => Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    flex: 1,
                                    onPressed: (context) {
                                      controller.deleteTransaction(element);
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Xóa',
                                  ),
                                ],
                              ),
                              child: TransactionWidget(element),
                            ),
                            order: GroupedListOrder.DESC,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
