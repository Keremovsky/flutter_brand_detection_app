import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class SingleResultScreen extends StatefulWidget {
  final ResultModel resultModel;

  const SingleResultScreen({super.key, required this.resultModel});

  @override
  State<SingleResultScreen> createState() => _SingleResultScreenState();
}

class _SingleResultScreenState extends State<SingleResultScreen> {
  late bool isThemeLight;

  Color _getColor() {
    if (isThemeLight) {
      return Palette.softBlue;
    } else {
      return Palette.grey;
    }
  }

  _calculateColor(double per) {
    if (per >= 50) {
      return ColorTween(
        begin: Palette.yellow,
        end: Palette.green,
      ).lerp((per - 50) / 50);
    } else {
      return ColorTween(
        begin: Palette.red,
        end: Palette.yellow,
      ).lerp((per / 50));
    }
  }

  @override
  Widget build(BuildContext context) {
    isThemeLight = isThemeLightFunc(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: "Sonuç ",
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                      text: "${widget.resultModel.similarity.round()}%",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color:
                                _calculateColor(widget.resultModel.similarity),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ImageDemonstrator(
                imageProvider: NetworkImage(
                  SecretConstants.mainUrl + widget.resultModel.image,
                ),
                height: 200,
                width: 200,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 15),
              Material(
                color: _getColor(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.resultModel.name,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Material(
                color: _getColor(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.resultModel.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              Material(
                color: _getColor(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.resultModel.location == ""
                        ? "Şirketin konum bilgisi bulunmamaktadır."
                        : widget.resultModel.location,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      if (widget.resultModel.twitter == null) {
                        giveFeedback(
                          context,
                          "Şirketin twitter sayfası bulunmamakta.",
                        );
                        return;
                      }
                      launchURL(widget.resultModel.twitter!);
                    },
                    height: 50,
                    width: 80,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Palette.xColor,
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/x_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      if (widget.resultModel.web == null) {
                        giveFeedback(
                          context,
                          "Şirketin internet sitesi bulunmamakta.",
                        );
                        return;
                      }
                      launchURL(widget.resultModel.web!);
                    },
                    height: 50,
                    width: 80,
                    borderRadius: BorderRadius.circular(10),
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/google_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  const _CustomSizedBox();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
