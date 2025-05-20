import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../helpers/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                LinearProgressIndicator(
                  minHeight: 2,
                  color: theme.primaryColor,
                  backgroundColor: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                )
                    .animate()
                    .fade(delay: 3000.ms, duration: const Duration(seconds: 1)),
              ],
            ),
            Column(
              children: [
                const Icon(
                  CupertinoIcons.location_solid,
                  size: 50,
                  color: Colors.red,
                ).animate().fade(duration: 1000.ms).slideY(duration: 1000.ms),
                Icon(
                  CupertinoIcons.car_detailed,
                  size: 100,
                  color: theme.primaryColor,
                ),
              ],
            ),

            // Image.asset(
            //   assetImages[1],
            //   width: deviceSize.height * 0.20,
            //   height: deviceSize.height * 0.20,
            //   fit: BoxFit.fitWidth,
            // ),
            Column(
              children: [
                Text(
                  'FROM',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.primaryColor,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  assetImages[0],
                  width: deviceSize.width * 0.35,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
