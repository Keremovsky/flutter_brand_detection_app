import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_brand_detection_app/core/utils/list_item.dart';
import 'package:flutter_brand_detection_app/features/feedback/controller/feedback_controller.dart';
import 'package:flutter_brand_detection_app/models/request_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/secret_constants.dart';

class RequestListScreen extends ConsumerStatefulWidget {
  final int id;

  const RequestListScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestListScreenState();
}

class _RequestListScreenState extends ConsumerState<RequestListScreen> {
  late Future<List<RequestModel>?> requestsFuture;

  @override
  void initState() {
    super.initState();
    requestsFuture =
        ref.read(feedbackControllerProvider.notifier).getAllRequest(
              context,
              widget.id,
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "İsteklerim",
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
        child: FutureBuilder(
          future: requestsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularProgressIndicator(
                size: 50,
                color: Palette.blue,
              );
            }

            final data = snapshot.data;

            if (data == null) {
              return const SizedBox();
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ModelListItem(
                    title: data[index].companyName,
                    onTap: () {},
                    image: NetworkImage(
                      "${SecretConstants.mainUrl}${data[index].image}",
                    ),
                    model: data[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
