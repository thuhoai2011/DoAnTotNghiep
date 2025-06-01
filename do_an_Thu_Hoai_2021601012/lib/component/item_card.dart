import 'package:auto_size_text/auto_size_text.dart';
import 'package:do_an/model/transaction.dart';
import 'package:do_an/ultis/ultis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/colors.dart';
import '../base/icons.dart';
import '../routes/routes.dart';

class ItemCard extends StatelessWidget {
  ItemCard(this.icon, this.content, {Key? key, this.title, this.subTitle, this.color, this.isTreeLine = false, this.colorCard = Colors.white})
      : super(key: key);
  late IconData icon;
  late String content;
  late String? title;
  late String? subTitle;
  late Color? color;
  late bool? isTreeLine;
  late Color colorCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorCard,
      child: ListTile(
        leading: Icon(icon),
        title: AutoSizeText(
          content,
          style: Get.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: title != null
            ? AutoSizeText(
                title ?? "",
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: kSecondaryColor,
                ),
              )
            : null,
        trailing: subTitle != null
            ? AutoSizeText(
                subTitle ?? "",
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
        isThreeLine: isTreeLine ?? false,
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  TransactionWidget(this.transaction, {Key? key}) : super(key: key);
  Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.createTransaction, arguments: transaction),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: const BoxDecoration(color: Colors.white, border: Border.symmetric(horizontal: BorderSide(color: Color(0x22000000), width: .5))),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                "${ImageAsset.linkIconCategory}${transaction.categoryId}.png",
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.categoryName.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "${transaction.fundName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Text((transaction.isIncrease == 1 ? "+" : "") + '${transaction.value.toString().toVND(unit: 'đ')}',
                style: TextStyle(
                  color: transaction.isIncrease == 1 ? Colors.greenAccent : Colors.red,
                  fontSize: 14,
                ))
          ],
        ),
      ),
    );
  }
}
