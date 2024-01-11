import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardBody extends StatelessWidget {
   CardBody({
    super.key,
    required this.item,
     required this.hadleDelete
  });
  // ignore: prefer_typing_uninitialized_variables
  var item;
  final Function hadleDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 74,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xffDFDFDF),
        borderRadius: BorderRadius.circular(12),
      ),
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style:  const TextStyle(
                  fontSize: 20,
                  color: Color(0xff4B4B4B),
                  fontWeight: FontWeight.bold
              ),
            ),
            InkWell(
              onTap:() async {
                if (await confirm(context)) {
                  hadleDelete(item.id);
                }
                return;
              },
              child: const Icon(
                Icons.delete_outline,
                color: Color(0xff4B4B4B),
              ),
            )
          ],
        ),
      ),
    );
  }
}