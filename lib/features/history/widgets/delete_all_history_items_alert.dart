import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeleteAllHistoryItemsAlert extends ConsumerWidget {
  const DeleteAllHistoryItemsAlert({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            Text(
              "Emin misiniz?",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 1),
            Text(
              "Bütün geçmiş silinecek.",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onTap: () {
                    context.pop();
                  },
                  height: 40,
                  width: 80,
                  borderRadius: BorderRadius.circular(10),
                  child: Text(
                    "Evet",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                CustomButton(
                  onTap: () {
                    context.pop();
                  },
                  height: 40,
                  width: 80,
                  borderRadius: BorderRadius.circular(10),
                  child: Text(
                    "Hayır",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
