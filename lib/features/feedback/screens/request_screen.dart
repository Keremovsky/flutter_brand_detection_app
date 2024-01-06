import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/models/request_model.dart';

class RequestScreen extends StatelessWidget {
  final RequestModel requestModel;

  const RequestScreen({super.key, required this.requestModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Text(
              requestModel.companyName,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              requestModel.country,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              requestModel.website,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              requestModel.twitter,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              requestModel.description,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            ImageDemonstrator(
              imageProvider: NetworkImage(
                SecretConstants.mainUrl + requestModel.image!,
              ),
              height: 200,
              width: 200,
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
      ),
    );
  }
}
