import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/features/image_picker/controller/image_picker_controller.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RequestScreen extends ConsumerStatefulWidget {
  const RequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequestScreenState();
}

class _RequestScreenState extends ConsumerState<RequestScreen> {
  ImageDemonstrator? takenImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              Text(
                "İstekte Bulun",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(
                maxLines: 7,
                maxLength: 250,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      context.pop();
                    },
                    height: 50,
                    width: 100,
                    backgroundColor: Palette.red,
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      "İptal",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  CustomButton(
                    onTap: () {},
                    height: 50,
                    width: 100,
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      "Yolla",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CustomButton(
                onTap: () async {
                  final result = await ref
                      .read(imagePickerControllerProvider.notifier)
                      .getImageGallery(context);

                  if (result != null) {
                    takenImage = ImageDemonstrator(
                      imageProvider: FileImage(File(result.path)),
                      height: 150,
                      width: 150,
                      borderRadius: BorderRadius.circular(10),
                    );
                    setState(() {});
                  }
                },
                height: 180,
                width: 180,
                borderRadius: BorderRadius.circular(10),
                child: takenImage ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 80,
                          width: 80,
                          child: Image(
                            image: AssetImage("assets/upload_logo.png"),
                          ),
                        ),
                        Text(
                          "Resim Yükle",
                          style: Theme.of(context).textTheme.displayLarge,
                        )
                      ],
                    ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
