import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FeedbackListScreen extends ConsumerStatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeedbackListScreenState();
}

class _FeedbackListScreenState extends ConsumerState<FeedbackListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Geri Bildirimlerim",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ModelListItem(
              title: "Ferrari",
              onTap: () {
                context.pushNamed(RouterConstants.resultScreenName);
              },
              image: const AssetImage("assets/ferrari.png"),
              model: null,
            );
          },
        ),
      ),
    );
  }
}
