import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String appName = 'Cars Tracking';

const List<String> assetImages = [
  'assets/images/logo_mini.png',
  'assets/images/logo.png',
  'assets/images/appstore.png',
  'assets/images/logo1.png',
];
const String authUserImage = 'assets/images/dev/user/1.jpg';
const List<String> onBoardingImages = [
  'assets/images/logo.png',
  'assets/images/logo1.png',
];

Future<void> launchExternalUrl(
    {required BuildContext context, required String usedUrl}) async {
  final Uri url = Uri.parse(usedUrl);
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      showToast(message: Text("Could not launch to $url"), context: context);
    }
    throw Exception('Could not launch to $url');
  }
}

String truncateText(String text, int length) {
  return '${text.substring(0, length)}...';
}

void showToast({
  required Text message,
  required BuildContext context,
  Duration duration = const Duration(seconds: 10),
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: message,
      duration: duration,
    ),
  );
}

void showImportantInfo({
  required Text message,
  required Text title,
  required BuildContext context,
  Color backgroundColor = Colors.red,
  bool barrierDismissible = true,
  double? height,
}) {
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: backgroundColor,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      title: title,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: height,
        child: message,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          iconAlignment: IconAlignment.end,
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

const List<String> productImage = [
  'assets/images/dev/products/1.jpg',
  'assets/images/dev/products/2.jpg',
  'assets/images/dev/products/3.jpg',
  'assets/images/dev/products/4.jpg',
  'assets/images/dev/products/5.jpg',
  'assets/images/dev/products/6.jpg',
  'assets/images/dev/products/7.jpg',
];

String timeAgoFormatting({required DateTime time, String lang = 'en'}) {
  Duration difference = DateTime.now().difference(time);
  if (difference.inDays > 365) {
    return lang == 'en'
        ? '${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? 'year' : 'years'} ago'
        : 'Il y a ${(difference.inDays / 365).floor()} ${(difference.inDays / 365).floor() == 1 ? 'an' : 'ans'}';
  }
  if (difference.inDays > 30) {
    return lang == 'en'
        ? '${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? 'month' : 'months'} ago'
        : 'Il y a ${(difference.inDays / 30).floor()} ${(difference.inDays / 30).floor() == 1 ? 'mois' : 'mois'}';
  }
  if (difference.inDays > 7) {
    return lang == 'en'
        ? '${(difference.inDays / 7).floor()} ${(difference.inDays / 7).floor() == 1 ? 'week' : 'weeks'} ago'
        : 'Il y a ${(difference.inDays / 7).floor()} ${(difference.inDays / 7).floor() == 1 ? 'semaine' : 'semaines'}';
  }
  if (difference.inDays > 0) {
    return lang == 'en'
        ? '${(difference.inDays)} ${difference.inDays == 1 ? 'day' : 'days'} ago'
        : 'Il y a ${(difference.inDays)} ${difference.inDays == 1 ? 'jour' : 'jours'}';
  }
  if (difference.inHours > 0) {
    return lang == 'en'
        ? '${(difference.inHours)} ${difference.inHours == 1 ? 'hour' : 'hours'} ago'
        : 'Il y a ${(difference.inHours)} ${difference.inHours == 1 ? 'heure' : 'heures'}';
  }
  if (difference.inMinutes > 0) {
    return lang == 'en'
        ? '${(difference.inMinutes)} ${difference.inMinutes == 1 ? 'min' : 'minutes'} ago'
        : 'Il y a ${(difference.inMinutes)} ${difference.inMinutes == 1 ? 'min' : 'minutes'}';
  }
  return lang == 'en' ? 'Just now' : 'A l\'instant';
}

String htmlRemover(String htmlText) {
  // Remove HTML tags
  final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
  String cleanText = htmlText.replaceAll(exp, '');

  // Remove common HTML entities
  cleanText = cleanText
      .replaceAll('&nbsp;', ' ') // Non-breaking space
      .replaceAll('&amp;', '&') // &
      .replaceAll('&lt;', '<') // <
      .replaceAll('&gt;', '>') // >
      .replaceAll('&quot;', '"') // "
      .replaceAll('&#039;', "'") // '
      .replaceAll('&rsquo;', "'") // ’
      .replaceAll('&ldquo;', '"') // “
      .replaceAll('&rdquo;', '"'); // ”

  return cleanText.trim(); // Remove extra spaces at the beginning and end
}
