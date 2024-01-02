import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void giveFeedback(
  BuildContext context,
  String text, {
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
      duration: duration,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void launchURL(String url) async {
  final uri = Uri.parse(url);

  final canLaunch = await canLaunchUrl(uri);
  if (canLaunch) {
    await launchUrl(uri);
  }
}

bool isThemeLightFunc(BuildContext context) {
  return Brightness.light == Theme.of(context).brightness;
}

String? validate(String? value) {
  if (value == null || value.isEmpty) {
    return "Lütfen bu alanı doldurunuz.";
  }

  return null;
}

bool passwordValidator(String password) {
  // at least one lowercase char, one uppercase char, one special char and one digit
  RegExp regex = RegExp(
      r'^(?=.*\d)(?=.*[#&+.])(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,12}$');

  return !regex.hasMatch(password);
}

bool emailValidator(String email) {
  RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  return !regex.hasMatch(email);
}
