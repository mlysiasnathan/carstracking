import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../helpers/helpers.dart';
import '../providers/providers.dart';
import './widgets.dart';
import 'theme_mode_switch.dart';

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final authorData = Provider.of<Auth>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 300,
              color: theme.primaryColor,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.surface,
                  radius: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(400),
                    child: Image.asset(authorData.user!.image.toString()),
                  ),
                ),
              ),
            ),
          ).animate().fade(duration: 500.ms).slideY(curve: Curves.ease),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'My Account',
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  SettingItem(
                    title: Text(authorData.user!.name.toString()),
                    leadingIcon: const Icon(Icons.edit),
                  ).animate().fade(duration: 300.ms).slideX(curve: Curves.ease),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Appearance',
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  SettingItem(
                    title: Text(
                      "Themes",
                      style: theme.textTheme.titleMedium,
                    ),
                    leadingIcon: const Icon(CupertinoIcons.paintbrush),
                    children: [
                      const ThemeModeSwitch(
                        styleMode: Style.mode2,
                      )
                          .animate()
                          .fade(duration: 400.ms)
                          .slideY(curve: Curves.easeOut),
                    ],
                  ).animate().fade(duration: 400.ms).slideX(curve: Curves.ease),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      appName,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  const SettingItem(
                    title: Text("Privacy Policy"),
                    leadingIcon: Icon(
                      CupertinoIcons.checkmark_shield,
                    ),
                  ).animate().fade(duration: 500.ms).slideX(curve: Curves.ease),
                  const SettingItem(
                    title: Text("About Us"),
                    leadingIcon: Icon(
                      CupertinoIcons.info,
                    ),
                  ).animate().fade(duration: 600.ms).slideX(curve: Curves.ease),
                  const SettingItem(
                    title: Text("Contact Us"),
                    leadingIcon: Icon(
                      CupertinoIcons.conversation_bubble,
                    ),
                  ).animate().fade(duration: 700.ms).slideX(curve: Curves.ease),
                  const SettingItem(
                    title: Text("Help & Support"),
                    leadingIcon: Icon(
                      CupertinoIcons.sparkles,
                    ),
                  ).animate().fade(duration: 800.ms).slideX(curve: Curves.ease),
                  Center(
                    child: GestureDetector(
                      onTap: () => launchExternalUrl(
                        context: context,
                        usedUrl: nrepUrl,
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'At $appName we respect your privacy, Please visit this link to know more about us on ',
                              style: theme.textTheme.labelSmall,
                            ),
                            TextSpan(
                              text: nrepUrl,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
            child: SizedBox(
              width: deviceSize.width,
              child: ElevatedButton(
                onPressed: () {
                  authorData.logout();
                  // showToast(
                  //   context: context,
                  //   duration: const Duration(seconds: 10),
                  //   message: const Text("Available in future update"),
                  // );
                  Navigator.pop(context);
                },
                child: const Text("LOG OUT"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    // 1rst UI========================================================================
    // path.lineTo(0, h); //move to bottom-left of the container
    // path.quadraticBezierTo(
    //   w / 2,
    //   h - 80,
    //   w,
    //   h,
    // ); //draw a smooth curve from the bottom-left to the bottom-right
    // path.lineTo(w, 0); //draw a straight line to top-right corner
    // 2nd UI=======================================================================
    // path.lineTo(0, h - 50); //move to bottom-left of the container
    // path.quadraticBezierTo(
    //   w / 4,
    //   h,
    //   w / 2,
    //   h - 50,
    // ); //first wave
    // path.quadraticBezierTo(
    //   3 * w / 4,
    //   h - 100,
    //   w,
    //   h - 50,
    // ); //2nd wave
    // path.lineTo(w, 0);
    // 3rd UI===========================================================================
    // path.lineTo(0, h - 100); //bottom-left
    // path.lineTo(w / 2, h); //peak at the middle bottom
    // path.lineTo(w, h - 100); // top-right corner
    // path.lineTo(w, 0);
    // 4th UI==============================================

    path.lineTo(0, h - 100); //bottom-left
    path.quadraticBezierTo(
      w / 2,
      h + 10,
      w,
      h - 100,
    );
    path.lineTo(w, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
