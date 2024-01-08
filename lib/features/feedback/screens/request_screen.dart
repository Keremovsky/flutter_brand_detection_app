import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/models/request_model.dart';
import 'package:go_router/go_router.dart';

class RequestScreen extends StatelessWidget {
  final RequestModel requestModel;

  const RequestScreen({super.key, required this.requestModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "İstek Fotoğraf",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const _CustomSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageDemonstrator(
                    imageProvider: NetworkImage(
                      SecretConstants.mainUrl + requestModel.image!,
                    ),
                    height: 200,
                    width: 200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                "Şirket ismi: ${requestModel.companyName}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const _CustomSizedBox(),
              Text(
                "Menşei: ${requestModel.country}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const _CustomSizedBox(),
              Text(
                "İnternet sitesi: ${requestModel.website}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const _CustomSizedBox(),
              Text(
                "Twitter: ${requestModel.twitter}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const _CustomSizedBox(),
              Text(
                "Açıklama: ${requestModel.description}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  const _CustomSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 15);
  }
}
