import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/base/icons.dart';
import 'package:do_an/ultis/ultis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Enum/input_formatter_enum.dart';
import '../../../base/dimen.dart';
import '../../../base/strings.dart';
import '../../../component/base_appbar.dart';
import '../../../component/base_button.dart';
import '../../../component/base_input_with_label.dart';
import '../../../component/input_text_form_field_model.dart';
import '../../../component/item_card.dart';
import '../controller/create_event_controller.dart';

class CreateEventPage extends GetView<CreateEventController> {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: Get.arguments == null ? AppString.createEvent : AppString.detailEvent,
        menuItem: [
          if (Get.arguments != null)
            TextButton(
              onPressed: () => controller.completeEvent(),
              child: Obx(() => AutoSizeText(
                    controller.event.value.allowNegative == 1 ? AppString.complete : AppString.notComplete,
                    style: Get.textTheme.bodyLarge!.copyWith(
                      color: controller.event.value.allowNegative != 1 ? Colors.red : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          // TextButton(
          //   onPressed: () => controller.createEvent(),
          //   child: AutoSizeText(
          //     Get.arguments == null ? AppString.save : AppString.edit,
          //     style: Get.textTheme.bodyLarge,
          //   ),
          // ).marginOnly(left: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formData,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Card(
                    color: Colors.white,
                    child: BuildInputText(
                      InputTextModel(
                        controller: controller.nameController.value,
                        hintText: AppString.hintNameEvent,
                        iconNextTextInputAction: TextInputAction.done,
                        iconLeading: Icons.event,
                        submitFunc: (v) => {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Không được để trống";
                          }
                          return null;
                        },
                      ),
                    ),
                  ).paddingOnly(top: paddingSmall),
                  Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          ImageAsset.icVND,
                          height: 24,
                          width: 24,
                        ).paddingOnly(left: defaultPadding),
                        Expanded(
                          child: BuildInputText(
                            InputTextModel(
                              controller: controller.valueController,
                              hintText: AppString.hintValue,
                              iconNextTextInputAction: TextInputAction.done,
                              inputFormatters: InputFormatterEnum.currency,
                              textInputType: TextInputType.number,
                              // iconLeading: Icons.attach_money_outlined,
                              submitFunc: (v) => {},
                              validator: (value) {
                                if (value == "0") {
                                  return "Không được để trống";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: paddingSmall),
                  GestureDetector(
                    onTap: () => controller.selectDate(context),
                    child: Card(
                      color: Colors.white,
                      child: Obx(
                        () => ListTile(
                            leading: const Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_down_outlined),
                            title: AutoSizeText(
                              DateFormat.yMMMd().format(controller.selectedDate.value),
                              style: Get.textTheme.bodyMedium,
                            )),
                      ),
                    ),
                  ).paddingOnly(top: paddingSmall),
                  GestureDetector(
                    onTap: () => controller.selectTime(context),
                    child: Card(
                      color: Colors.white,
                      child: Obx(
                        () => ListTile(
                            leading: const Icon(
                              Icons.timer,
                              color: Colors.black,
                            ),
                            trailing: Icon(Icons.keyboard_arrow_down_outlined),
                            title: AutoSizeText(
                              controller.time.value.format(context),
                              style: Get.textTheme.bodyMedium,
                            )),
                      ),
                    ),
                  ).paddingOnly(top: paddingSmall),
                  if (Get.arguments != null)
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AutoSizeText(
                                  "Đã chi tiêu ${(controller.event.value.value.toString().replaceAll('-', "").toVND())}",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                                Visibility(
                                  visible: controller.event.value.value * (-1) > controller.event.value.estimateValue && Get.arguments != null,
                                  child: AutoSizeText(
                                    " vượt mức ${(controller.event.value.value * (-1) - controller.event.value.estimateValue).toString().toVND()}",
                                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(vertical: paddingSmall),
                            AutoSizeText(
                              "Đã thu ${(controller.event.value.receive.toString().toVND())}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ).paddingSymmetric(vertical: paddingSmall),
                            Visibility(
                              visible: controller.listTransaction.isNotEmpty,
                              child: AutoSizeText(
                                "Danh sách các giao dịch của sự kiện '${controller.event.value.name}'",
                              ).paddingOnly(bottom: paddingSmall),
                            ),
                            Visibility(
                              visible: controller.listTransaction.isNotEmpty,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TransactionWidget(
                                    controller.listTransaction[index],
                                  );
                                },
                                itemCount: controller.listTransaction.length,
                              ),
                            ),
                          ],
                        )),
                ]).paddingSymmetric(
                  horizontal: defaultPadding,
                ),
              ),
            ),
          ),
          BaseButton(
            Get.arguments == null ? AppString.save : AppString.edit,
            controller.manageEvent,
          ),
        ],
      ),
    );
  }
}
