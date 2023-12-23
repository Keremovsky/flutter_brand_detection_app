import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/services/theme_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late bool switchValue;

  @override
  void initState() {
    switchValue = ref.read(themeServiceProvider.notifier).themeMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: ThemeConstants.screenPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Temayı Değiştir",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Switch(
                value: switchValue,
                onChanged: (value) {
                  if (switchValue) {
                    ref
                        .read(themeServiceProvider.notifier)
                        .setTheme(ThemeMode.dark);
                  } else {
                    ref
                        .read(themeServiceProvider.notifier)
                        .setTheme(ThemeMode.light);
                  }

                  setState(() {
                    switchValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
