import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPopUpMenuButton extends ConsumerWidget {
  final String historyId;

  const HistoryPopUpMenuButton({super.key, required this.historyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authControllerProvider)!;

    return MenuAnchor(
      style: const MenuStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(5)),
      ),
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: const Icon(
            Icons.more_vert_outlined,
            size: 24,
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: () async {
            final isHandled = await ref
                .read(historyControllerProvider.notifier)
                .handleSaveHistory(
                  context,
                  user.id,
                  historyId,
                );

            if (isHandled) {
              // update history in app
              await ref
                  .read(historyControllerProvider.notifier)
                  .updateHistory(user.id);
            }
          },
          child: const Text("Kaydet"),
        ),
        MenuItemButton(
          onPressed: () async {
            final isDeleted = await ref
                .read(historyControllerProvider.notifier)
                .deleteHistory(
                  context,
                  user.id,
                  historyId,
                );

            if (isDeleted) {
              // update history in app
              await ref
                  .read(historyControllerProvider.notifier)
                  .updateHistory(user.id);
            }
          },
          child: const Text("Sil"),
        ),
      ],
    );
  }
}
