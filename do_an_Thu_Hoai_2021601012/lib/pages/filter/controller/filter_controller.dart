import 'package:do_an/pages/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../base_controller/base_controller.dart';

class FilterController extends BaseGetxController {
  late RxString fromDateStr;
  late RxString toDateStr;
  TransactionController transactionController = Get.find<TransactionController>();
  @override
  void onInit() {
    fromDateStr = DateFormat("yyyy-MM-dd").format(transactionController.fromDate).obs;
    toDateStr = DateFormat("yyyy-MM-dd").format(transactionController.toDate).obs;
    super.onInit();
  }
}
