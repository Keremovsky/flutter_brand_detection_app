import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/assets_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/feedback/controller/feedback_controller.dart';
import 'package:flutter_brand_detection_app/features/image_picker/controller/image_picker_controller.dart';
import 'package:flutter_brand_detection_app/models/request_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class SendRequestScreen extends ConsumerStatefulWidget {
  const SendRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendRequestScreenState();
}

class _SendRequestScreenState extends ConsumerState<SendRequestScreen> {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ImageDemonstrator? takenImage;
  late bool isThemeLight;
  Map<String, dynamic> inputValues = {
    'id': 0,
    'companyName': null,
    'description': null,
    'country': null,
    'website': null,
    'twitter': null,
  };
  XFile? image;

  @override
  Widget build(BuildContext context) {
    isThemeLight = isThemeLightFunc(context);

    return Scaffold(
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
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "İstekte Bulun",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  maxLength: 50,
                  onSaved: (value) {
                    inputValues["companyName"] = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Şirket ismi",
                    counterText: "",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  maxLength: 50,
                  onSaved: (value) {
                    inputValues["country"] = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: InputDecoration(
                    labelText: "Menşei",
                    counterText: "",
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  maxLength: 100,
                  onSaved: (value) {
                    inputValues["website"] = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "İnternet sitesi",
                    counterText: "",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  maxLength: 100,
                  onSaved: (value) {
                    inputValues["twitter"] = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Twitter sitesi",
                    counterText: "",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  maxLines: 3,
                  maxLength: 250,
                  onSaved: (value) {
                    inputValues["description"] = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Açıklama",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const _CustomSizedBox(),
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
                      child: Text(
                        "İptal",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    CustomButton(
                      onTap: () async {
                        if (takenImage == null) {
                          giveFeedback(context, "Lütfen fotoğraf seçin.");
                          return;
                        }
                        if (formKey.currentState!.validate() && image != null) {
                          // save values
                          formKey.currentState!.save();
                          final requestModel =
                              RequestModel.fromMap(inputValues);

                          final user = ref.read(authControllerProvider)!;
                          // send request to send request
                          await ref
                              .read(feedbackControllerProvider.notifier)
                              .sendRequest(
                                context,
                                requestModel,
                                image!,
                                user.id,
                              );
                        }
                      },
                      height: 50,
                      width: 100,
                      child: Text(
                        "Yolla",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ],
                ),
                const _CustomSizedBox(),
                Center(
                  child: CustomButton(
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
                        image = result;
                        setState(() {});
                      }
                    },
                    height: 180,
                    width: 180,
                    child: takenImage ??
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image(
                                image: isThemeLight
                                    ? const AssetImage(
                                        AssetsConstants.uploadLogoBlack)
                                    : const AssetImage(
                                        AssetsConstants.uploadLogoWhite),
                              ),
                            ),
                            Text(
                              "Resim Yükle",
                              style: Theme.of(context).textTheme.displayLarge,
                            )
                          ],
                        ),
                  ),
                ),
              ],
            ),
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
    return const SizedBox(height: 12);
  }
}
