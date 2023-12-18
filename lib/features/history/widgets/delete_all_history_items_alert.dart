import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
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
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Material(
                    color: Palette.mainColor,
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      width: 80,
                      child: Center(
                        child: Text(
                          "Evet",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Material(
                    color: Palette.mainColor,
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      width: 80,
                      child: Center(
                        child: Text(
                          "Hayır",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
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
